variable "region" {
  description = "AWS region to deploy the instance"
  default     = "eu-north-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the SSH key to connect to EC2"
  default     = "lina-key"
}