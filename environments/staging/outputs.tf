output "public_ip" {
  description = "Public IP of the staging VM"
  value       = module.docker_compose_vm.public_ip
}

