# data "aws_iam_role" "existing-role" {
#     name = "iam-ec2-fullaccess" 
# }


# resource "aws_instance" "EC2" {
#   ami = "ami-08718895af4dfa033"

#   instance_type = "t2.micro"
#   key_name = "Linux"

#   iam_instance_profile = data.aws_iam_role.existing-role.name

#   tags = {
#     Name = "MyEC2"
#   }
# }


##Home work
##create a target and AutoScaling group


resource "aws_vpc" "my_vpc" {
  tags = {
    Name = "myVPC"

  }
  cidr_block = "10.0.0.0/16"  
}


resource "aws_lb_target_group" "my_target_group" {
  target_type = "instance"
  name = "mytargetgroup"
  protocol = "HTTP"
  port = 80
  ip_address_type = "ipv4"
  vpc_id = aws_vpc.my_vpc.id

  health_check {
    enabled = false
  }
  
}

resource "aws_instance" "EC2" {
  ami = "ami-08718895af4dfa033"

  instance_type = "t2.micro"
  key_name = "Linux"

  # iam_instance_profile = data.aws_iam_role.existing-role.name

  tags = {
    Name = "MyEC2"
  }
}

resource "aws_instance" "EC2-2" {
  ami = "ami-08718895af4dfa033"

  instance_type = "t2.micro"
  key_name = "Linux"

  # iam_instance_profile = data.aws_iam_role.existing-role.name

  tags = {
    Name = "MyEC2-2"
  }
}




# attach ec2 to TG

resource "aws_lb_target_group_attachment" "attach_ec2" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id = aws_instance.EC2.id
  port = 80
  
}

resource "aws_lb_target_group_attachment" "attach_ec2-2" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id = aws_instance.EC2-2.id
  port = 80
  
}















#provider "aws" {
#   region = "us-west-2"  # Specify your region
# }

# data "aws_iam_role" "existing_role" {
#   name = "my-existing-role"
# }

# resource "aws_instance" "my_instance" {
#   ami           = "ami-12345678"  # Replace with your desired AMI ID
#   instance_type = "t2.micro"

#   iam_instance_profile = data.aws_iam_role.existing_role.name

#   tags = {
#     Name = "MyInstance"
#   }
# }


# Provider Block: Specifies which cloud provider (in this case, AWS) to use.
# Data Block: The data "aws_iam_role" "existing_role" block retrieves the IAM role with the name my-existing-role. This means that the IAM role must already exist in your AWS account.
# Resource Block: The resource "aws_instance" "my_instance" block creates an EC2 instance. The iam_instance_profile is set to the name of the IAM role fetched from the data block. This way, you don’t need to hardcode the IAM role's details; Terraform fetches it dynamically.