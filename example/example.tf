# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
variable "do_token" {
  type        = string
  description = "Personal AccessToken for DigitalOcean API"
}

provider "digitalocean" {
  token = "${var.do_token}"
}

module "droplet" {
  source = "../"

  droplet_name  = "lds001"
  droplet_tags  = ["loodos", "lds", "001", "staging", "tag2"]
  ssh_key_names = ["emrah@Emrahs-MacBook-Pro.local", "emrah@DESKTOP-T7UP1C1"]
  initial_user  = "loodos"
  banner_path   = "./files/sshd_banner"
  user_data     = "echo \"hello\nworld\n\" > \"/home/loodos/hello\""

  region = "ams3"
  size   = "s-1vcpu-1gb"
}

output "ipv4_address" {
  value = module.droplet.ipv4_address
}
output "ssh_connection" {
  value = module.droplet.ssh_connection
}
