#custom network creation 

#create VPC
#create Internet Gateway and attach to VPC
#create Subnet 
#create Route tables
#Enable routing from IG to RT
#Subnet association (add subnets into RT)
#Create Security Group
#Launch Instance

resource "aws_vpc" "cust_1" {
    cidr_block = "10.0.0.0/16"

    tags = {
      Name = "VPC_1"
    } 
}

resource "aws_internet_gateway" "IG" {
    vpc_id = aws_vpc.cust_1.id
    tags = {
      Name = "IG_1"
    }
}


resource "aws_subnet" "Sub_1" {
    vpc_id = aws_vpc.cust_1.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "ap-south-1a"
    tags = {
      Name = "Subnet_1"
    }
}

resource "aws_subnet" "Sub_2" {
    vpc_id = aws_vpc.cust_1.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1a"
    tags = {
      Name = "Subnet_2"
    }
}

resource "aws_route_table" "RT" {
    vpc_id = aws_vpc.cust_1.id
    route {
        gateway_id = aws_internet_gateway.IG.id
        cidr_block = "0.0.0.0/0"
    }
  
}

resource "aws_route_table_association" "RT-1" {
    subnet_id = aws_subnet.Sub_1.id
    route_table_id = aws_route_table.RT.id
}

#Security Groups
resource "aws_security_group" "TLS" {
    name = "Allows_TLS"
    vpc_id = aws_vpc.cust_1.id
    tags = {
      Name = "SG"
    }
    ingress {
      description = "Allow SSH"
      from_port = 22
      to_port = 22
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "EC2" {
  ami = "ami-08718895af4dfa033"
  instance_type = "t2.micro"
  key_name = "Linux"
  subnet_id = aws_subnet.Sub_1.id
  vpc_security_group_ids = [ aws_security_group.TLS.id]

}