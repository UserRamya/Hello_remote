variable "ami_id" {
  type    = string
  default = "ami-0e9107ed11be76fde"
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

# variable "security_group_ids" {
#   type    = list(string)
#   default = [aws_security_group.allow_tls.id]
# }

#333#############s
