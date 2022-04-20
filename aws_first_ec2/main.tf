provider "aws" {
  region                   = "us-east-1"
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "habolanos-aws-devops"
}

data "aws_subnet" "az_a" {
    availability_zone = "us-east-1a"
    default_for_az = true

}

resource "aws_instance" "my_first_server" {
  ami                    = "ami-04505e74c0741db8d"
  instance_type          = "t2.micro"
  subnet_id              = data.aws_subnet.az_a.id

  user_data = <<-EOF
              #!/bin/bash
              echo "Hola Terraformers!" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
}