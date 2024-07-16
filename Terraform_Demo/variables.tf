variable "ami_id" {
  type    = string

}

variable "size_ec2" {
  type    = string
  default = "t2.micro"
}


variable "tags_test" {
  type = object({
    name  = string
    owner = string
  })
  default = {
    name  = "hello"
    owner = "harish"
  }

}
