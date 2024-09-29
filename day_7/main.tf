resource "aws_instance" "EC2" {
  ami = "ami-08718895af4dfa033"
  instance_type = "t2.micro"
  key_name = "Linux"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "EC2_1"
  }
}
resource "aws_s3_bucket" "test" {
    bucket = "samvegShah013"
}
resource "aws_dynamodb_table" "dynamodb_state_lock" {
    name = "dynamodb_lock_state"
    hash_key = "LockID"
    read_capacity = 20
    write_capacity = 20

    attribute {
      name = "LockID"
      type = "S"
    }
  
}