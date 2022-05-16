output "public_networks" {
  value = aws_subnet.public
}

output "private_networks" {
  value = aws_subnet.private
}
