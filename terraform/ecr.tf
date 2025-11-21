
# Create an Amazon ECR repository for storing Docker images
resource "aws_ecr_repository" "app_repo" {
	name = "k3s-sample-app"
}



# Output the ECR repository URL for use in CI/CD and deployments
output "ecr_repo_url" {
	value = aws_ecr_repository.app_repo.repository_url
}