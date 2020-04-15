output "instance_public_dns_list" {
  value = flatten([
    aws_instance.igor_dev.*.public_dns,
    aws_instance.igor_dev2.public_dns
  ])
}

output "instance_public_ip_list" {
  value = flatten([
    aws_instance.igor_dev.*.public_ip,
    aws_instance.igor_dev2.public_ip
  ])
}
