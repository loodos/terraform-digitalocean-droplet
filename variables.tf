variable "droplet_name" {
  type        = string
  description = "Name of the Droplet"
  default     = "lds"
}

variable "image_name" {
  type        = string
  description = "Base image name"
  default     = "ubuntu-18-04-x64"
}

variable "region" {
  type        = string
  description = "Droplet will be created in this region"
  default     = "ams3"
}

variable "size" {
  type        = string
  description = "Choose a droplet plan on DigitalOcean"
  default     = "s-1vcpu-1gb"
}

variable "droplet_tags" {
  type        = list(string)
  description = "List of tags to apply to this Droplet. These tags will be created."
  default     = []
}

variable "ssh_key_names" {
  type        = list(string)
  description = "List of `already registered` SSH Key Names on DigitalOcean."
  default     = []
}

variable "ssh_keys" {
  type        = list(string)
  description = "List of new SSH Keys to register on DigitalOcean."
  default     = []
}

variable "ssh_key_path" {
  type        = string
  description = "Path of the private SSH key."
  default     = ""
}

variable "initial_user" {
  type        = string
  description = "Create a initial local OS User. If it's not `root` account, PermitRootLogin will be disabled in sshd_config."
  default     = "root"
}

variable "banner_path" {
  type        = string
  description = "Path ot the banner to display before login"
  default     = ""
}

variable "docker_version" {
  type        = string
  description = "Choose the docker version to install. Leave blank to ignore."
  default     = ""
}

variable "user_data" {
  type        = string
  description = "A string of the desired User Data for the Droplet"
  default     = ""
}
