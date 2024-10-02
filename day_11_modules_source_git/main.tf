module "git" {
    source = "github.com/SamvegShah013/Terraform-practice/tree/main/day_2"
    ami = "ami-08718895af4dfa033"
    instance_type = "t2.micro"
    key_name = "Linux"
  
}