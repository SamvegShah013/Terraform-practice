#create a VPc

resource "aws_vpc" "created_vpc" {
    tags = {
        Name = "VPC_1"
    }
    cidr_block = "10.0.0.0/16" 
}

#create Internet Gateway

resource "aws_internet_gateway" "created_IG" {
    tags = {
      Name = "IG-1"
    }
    vpc_id = aws_vpc.created_vpc.id
}

#create subnet    ---will make it public after attaching route table and internet gateway ----but now it is private

resource "aws_subnet" "created_subnet_public" {
    tags = {
      Name = "Subnet_1"
    }
    vpc_id = aws_vpc.created_vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "ap-south-1a"
}

#create subnet    ---now it is private

resource "aws_subnet" "created_subnet_private" {
    tags = {
      Name = "Subnet_2"
    }
    vpc_id = aws_vpc.created_vpc.id
    cidr_block = "10.0.4.0/24"
    availability_zone = "ap-south-1a"
}

#create route table

resource "aws_route_table" "created_RT" {
    vpc_id = aws_vpc.created_vpc.id
    route {
        gateway_id = aws_internet_gateway.created_IG.id
        cidr_block = "0.0.0.0/0"
    }
}


#Subnet association to Route Table   --to make one subnet public
resource "aws_route_table_association" "RT_public_subnet" {
    subnet_id = aws_subnet.created_subnet_public.id
    route_table_id = aws_route_table.created_RT.id
}

#create Security Groups

resource "aws_security_group" "created_SG" {
    name = "allow_ssh"
    vpc_id = aws_vpc.created_vpc.id
    tags = {
      Name = "SG-1"
    }
    ingress {
        description = "allow ssh traffic"
        from_port = 22
        protocol = "tcp"
        to_port = 22
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}
resource "aws_instance" "create_EC2" {
    tags = {
      Name ="EC2_1"
    }
    ami = "ami-08718895af4dfa033"
    instance_type = "t2.micro"
    key_name = "Linux"
    subnet_id = aws_subnet.created_subnet_public.id
    vpc_security_group_ids = [ aws_security_group.created_SG.id ]
  
}

