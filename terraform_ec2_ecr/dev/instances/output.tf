# Step 10 - Add output variables
output "eip" {
  value = aws_eip.static_eip.public_ip
}

output "ecr_repository_url" {
  value       = aws_ecr_repository.my_ecr_repo.repository_url
  description = "ECR Repository URL"
}