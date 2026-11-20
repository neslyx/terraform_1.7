resource "aws_ecr_repository" "this" {
  name         = "test-repo"
  force_delete = true
}