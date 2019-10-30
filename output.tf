output "ipv4_address" {
  description = "The public IPv4 address"
  value       = "${digitalocean_droplet.droplet.ipv4_address}"
}

output "ssh_connection" {
  description = "SSH connection command"
  value       = "ssh ${var.initial_user}@${digitalocean_droplet.droplet.ipv4_address}"
}
