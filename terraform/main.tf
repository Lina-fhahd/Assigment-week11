provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "mern_server" {
  ami           = "ami-0c7217cdde317cfec"  # هذا AMI خاص بـ us-east-1
  instance_type = "t2.micro"
  key_name = "lina-key"

  tags = {
    Name = "mern-server"
  }
}