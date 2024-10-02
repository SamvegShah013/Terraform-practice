module "dev" {
    source = "../day_2"
    ami = "ami-08718895af4dfa033"
    instance_type = "t2.micro"
    key_name = "Linux"
}