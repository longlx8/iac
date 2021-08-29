# tạo ec2 instance
# 

resource "aws_instance" "web" {

  ami           = "ami-0d058fe428540cd89"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_a.id

  key_name               = aws_key_pair.dev.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]

  # script sẽ chạy sau khi ec2 instance start xong
  user_data = <<EOF
#! /bin/bash
sudo apt-get update
sudo apt-get install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
echo "<h1>Welcome to Devops - Techmaster 2021 ! Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
EOF

  tags = {
    Name = "web-01"
  }
}

# tạo ssh keypair

resource "aws_key_pair" "dev" {
  key_name   = "dev-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDWL+1q0mO6HoeteIqMZeZpani1J3BmnjIwHbfweEUgqCuL7c4wq3xPXMDNL8EJmJUydcjxTZdVVAZcAfBb0AAYh1FZ6TYpbGUeoW8hbEwl9t66xV+NnmTVdUJyMTf7Gcnz9KsQBlSgYS94Zw1oOQ4kp+/6ComFcM5hkRmiCBBk5/oSExqdfzGUMy6LveCP/vfZuUlkn0HmeKANuG8tnuxOdKP7a88DpiRBOYlMHILUhDO2qpd393SJYsQ76XD8cNi2jJDgVBhgz/94lPpiCaaA5Rox8JArpjV4iJ1FNesuI5XsG6e9knvl3kOjcfl24Xqp3UiiRPE6VX2pGHx97/1zutNRaFza31o/DxnlJmX2oeszFoZHMQibKVUxPruciR6BPIeL/RbGDY0iV+DGzonp6NhTnANRfr8JzK/0ANtThe6ssbNOF1PFEsmtQuczvGxFFs8lxEra1+4rxHfepUaViws1AsNTrG10PCuksWt6Qnpk45bgEgbpTljRe2Ees4c="
}

# tạo security group allow ssh, http

resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http"
  description = "Allow SSH, HTTP inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from specify IPs"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["14.232.243.111/32"]
  }

  ingress {
    description = "HTTP from inside VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.9.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# in ra public ip của ec2 instance
output "ec2_instance_public_ips" {
  value = aws_instance.web.*.public_ip
}
