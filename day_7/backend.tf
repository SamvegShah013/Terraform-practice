terraform {
  backend "s3" {
    bucket = "samvegshah013"
    key = "test/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "ynamodb_state_lock"
    encrypt = true
  }
}