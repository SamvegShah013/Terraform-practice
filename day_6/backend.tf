terraform {
  backend "s3" {
    bucket         = "bucket_name"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table"
  }
}