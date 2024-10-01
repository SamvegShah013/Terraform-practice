resource "aws_instance" "EC2" {
    ami = "ami-08718895af4dfa033"
    instance_type = "t2.micro"
    key_name = "Linux"
}

resource "aws_s3_bucket" "dependent" {
    bucket = "bucket-name"
    depends_on = [ aws_instance.EC2 ]
  
}

#To createt and destroy specific resources in terraform use following commands:
#terraform apply --target=aws_s3_bucket.dependent
#terraform destroy --target=aws_s3_bucket.dependent

#this will only create s3 bucket an not the aws_instance



#create a 
resource "aws_ia" "name" {
  
}