resource "aws_instance" "EC2" {
  ami = "ami-08718895af4dfa033"
  instance_type = "t2.micro"
  key_name = "Linux"
  availability_zone = "ap-south-1a"
  user_data = file("test.sh")

  tags = {
    Name = "EC2_1"
  }
}