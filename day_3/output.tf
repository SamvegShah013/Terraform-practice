output "publicip" {
    value = aws_instance.sam.public_ip
}

output "privateip" {
    value = aws_instance.sam.private_ip
  sensitive = true
}