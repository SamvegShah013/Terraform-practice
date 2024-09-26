resource "aws_instance" "sam" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
  
  tags = {
    Name = "Day_3"
  }
}