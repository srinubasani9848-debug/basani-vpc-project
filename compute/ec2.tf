provider "aws" {
  region = var.region
}

resource "aws_security_group" "basani_sg" {
  name        = "basani-sg"
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
    Name    = "basani-sg"
    Project = "basani"
  }
}

resource "aws_instance" "basani_ec2" {
  ami           = "ami-0c2b8ca1dad447f8a" # Amazon Linux 2 in us-east-1
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [aws_security_group.basani_sg.id]  # <-- changed here

  tags = {
    Name    = "basani-ec2"
    Project = "basani"
  }

  user_data = <<-EOF
            #!/bin/bash

            # Update system packages
            yum update -y

            # Install Apache
            yum install -y httpd

            # Remove default Apache welcome page config
            if [ -f /etc/httpd/conf.d/welcome.conf ]; then
                rm -f /etc/httpd/conf.d/welcome.conf
            fi

            # Create custom index.html
            echo "Hello DevOps team" > /var/www/html/index.html

            # Ensure Apache starts on boot
            systemctl enable httpd

            # Start or restart Apache to apply changes
            systemctl restart httpd
            EOF

}

