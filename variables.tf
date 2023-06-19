variable "vpc_id" {
  type    = string
  default = "vpc-0476c82d3a24a4e20" #This can be found under Your VPCs in AWS console for your default VPC
}

variable "subnet_id" {
  description = "Your default subnet where your the instance will be created"
  default     = "subnet-01dcf944132ed56ee" #This can be found under Subnets in your AWS console for your default subnet
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type    = string
  default = "key_name" #Create a key pair in your AWS console if you don't have any.
}
variable "ami_id" {
  description = "ami id for Amazon Linux 2"
  type        = string
  default     = "ami-09988af04120b3591"
}
