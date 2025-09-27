output "public_ip" {
  description = "Public IP of the dev VM"
  value       = module.docker_compose_vm.public_ip
}

