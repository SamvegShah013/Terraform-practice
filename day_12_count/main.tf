resource "aws_instance" "EC2" {
  ami = "ami-08718895af4dfa033"
  instance_type = "t2.micro"
  key_name = "Linux"
  availability_zone = "ap-south-1a"
  count = length(var.dev)

  tags = {
    # Name = "EC2_1"
    Name = var.dev[count.index]
  }
}

variable "dev" {
    type = list(string)
    default = [ "sam","ec2" ,"msd"]
  
}