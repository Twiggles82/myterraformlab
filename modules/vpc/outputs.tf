output "public_subnet_id_euw1a" {
  description = "The ID of the public subnet in eu-west-1a"
  value       = aws_subnet.public-subnet-euw1a.id
}

output "public_subnet_id_euw1b" {
  description = "The ID of the public subnet in eu-west-1b"
  value       = aws_subnet.public-subnet-euw1b.id
}

output "private_subnet_id_euw1a" {
  description = "The ID of the private subnet in eu-west-1a"
  value       = aws_subnet.private-subnet-euw1a.id
}

output "private_subnet_id_euw1b" {
  description = "The ID of the private subnet in eu-west-1b"
  value       = aws_subnet.private-subnet-euw1b.id
}
