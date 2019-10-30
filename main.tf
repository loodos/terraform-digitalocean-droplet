locals {
  ssh_key_path_lines_raw = var.ssh_key_path != "" ? [
    for line in split("\n", fileexists(var.ssh_key_path) ? file(var.ssh_key_path) : "") :
    split(" ", trimspace(line))
  ] : []
  ssh_key_path_lines = [
    for line in local.ssh_key_path_lines_raw :
    line if length(line[0]) > 0 && substr(line[0], 0, 1) != "#"
  ]
  ssh_keys_names = [
    for line in var.ssh_keys :
    split(" ", trimspace(line))[2]
  ]
  all_ssh_key = concat(
    data.digitalocean_ssh_key.ssh_key_names[*],
    digitalocean_ssh_key.ssh_key_path[*],
    digitalocean_ssh_key.ssh_keys[*]
  )
}

data "digitalocean_ssh_key" "ssh_key_names" {
  count = length(var.ssh_key_names)
  name  = var.ssh_key_names[count.index]
}

resource "digitalocean_ssh_key" "ssh_key_path" {
  count      = length(local.ssh_key_path_lines)
  name       = "${var.droplet_name}-${local.ssh_key_path_lines[count.index][2]}-auto"
  public_key = join(" ", local.ssh_key_path_lines[count.index])
}

resource "digitalocean_ssh_key" "ssh_keys" {
  count      = length(var.ssh_keys)
  name       = "${var.droplet_name}-${local.ssh_keys_names[count.index]}-auto"
  public_key = var.ssh_keys[count.index]
}

resource "digitalocean_tag" "droplet_tags" {
  count = length(var.droplet_tags)
  name  = var.droplet_tags[count.index]
}

data "template_file" "initial_user_sh" {
  count    = var.initial_user != "root" ? 1 : 0
  template = "${file("${path.module}/scripts/initial_user.sh")}"

  vars = {
    initial_user         = var.initial_user
    initial_user_sshkeys = "${join("\n", compact(concat(local.all_ssh_key[*].public_key)))}"
  }
}

data "template_file" "sshd_banner_sh" {
  count    = var.banner_path != "" && fileexists(var.banner_path) ? 1 : 0
  template = "${file("${path.module}/scripts/sshd_banner.sh")}"

  vars = {
    banner_content_base64 = filebase64(var.banner_path)
  }
}

resource "digitalocean_droplet" "droplet" {
  name     = var.droplet_name
  image    = var.image_name
  region   = var.region
  size     = var.size
  tags     = digitalocean_tag.droplet_tags[*].id
  ssh_keys = local.all_ssh_key[*].id

  user_data = "${join("\n", concat(
    data.template_file.initial_user_sh[*].rendered,
    data.template_file.sshd_banner_sh[*].rendered,
    list(var.user_data)
  ))}"
}
