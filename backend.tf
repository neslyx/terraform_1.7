terraform {
  backend "s3" {
    bucket         = "trainee-project-kirill-gromyko-tfstate"
    key            = "terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "dlock"
    encrypt        = true
  }
}