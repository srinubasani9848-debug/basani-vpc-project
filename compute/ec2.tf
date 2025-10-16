provider "aws" {
  region = var.region
}

resource "aws_security_group" "srinivas_sg" {
  name        = "srinivas-sg"
  description = "Allow HTTP traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "srinivas-sg"
    Project = "srinivas"
  }
}

resource "aws_instance" "srinivas_ec2" {
  ami                    = "ami-0c2b8ca1dad447f8a" # Amazon Linux 2 in us-east-1
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.srinivas_sg.id]

  tags = {
    Name    = "srinivas-ec2"
    Project = "srinivas"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              if [ -f /etc/httpd/conf.d/welcome.conf ]; then
                  rm -f /etc/httpd/conf.d/welcome.conf
              fi
              echo "Hello DevOps team" > /var/www/html/index.html
              systemctl enable httpd
              systemctl restart httpd
              EOF
}
