variable "ami" {
    description = "inserting ami values int main"
    type = string
    default = "ami-08718895af4dfa033"  
}

variable "type" {
    description = "instance"
    type = string
    default = "t2.micro"
    }

variable "key" {
    type = string
    default = "Linux"
  
}
