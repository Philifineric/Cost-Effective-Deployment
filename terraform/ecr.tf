resource "aws_ecr_repository" "app_repo" {
name = "k3s-sample-app"
}


output "ecr_repo_url" {
value = aws_ecr_repository.app_repo.repository_url
}