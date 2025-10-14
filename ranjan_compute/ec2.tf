provider "aws" {
  region = var.region
}

resource "aws_security_group" "ranjan_sg" {
  name        = "ranjan-sg"
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
    Name    = "ranjan-sg"
    Project = "ranjan"
  }
}

resource "aws_instance" "ranjan_ec2" {
  ami = "ami-024e6efaf93d85776" # Amazon Linux 2 AMI in us-east-2
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [aws_security_group.ranjan_sg.id]

  tags = {
    Name    = "ranjan-ec2"
    Project = "ranjan"
  }

  user_data = <<-EOF
            #!/bin/bash
            yum update -y
            yum install -y httpd
            if [ -f /etc/httpd/conf.d/welcome.conf ]; then
                rm -f /etc/httpd/conf.d/welcome.conf
            fi
            echo "Using existing set up and varibales we deployed oregon region" > /var/www/html/index.html
            systemctl enable httpd
            systemctl restart httpd
            EOF
}

