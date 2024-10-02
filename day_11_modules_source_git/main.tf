module "git" {
     source = "git::https://github.com/SamvegShah013/Terraform-practice.git//day_2"
    ami = var.ami
    instance_type = var.instance_type
    key_name = "Linux"
}