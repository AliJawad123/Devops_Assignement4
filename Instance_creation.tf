
resource "aws_instance" "web_server" {
  ami                    = "ami-079db87dc4c10ac91"  
  instance_type          = "t2.micro"
  key_name               = "cs423-assignment4-key"
  subnet_id              = aws_subnet.public_subnet1.id
  user_data              = file("user_data.sh")
  associate_public_ip_address = true

  tags = {
    Name = "Assignment4-EC2-WebServer"
  }
}

resource "aws_instance" "database_instance" {
  ami                    = "ami-079db87dc4c10ac91"  
  instance_type          = "t2.micro"
  key_name               = "cs423-assignment4-key"
  subnet_id              = aws_subnet.private_subnet1.id
  user_data              = file("user_data.sh")

  tags = {
    Name = "Assignment4-EC2-DatabaseInstance"
  }
}

resource "aws_security_group" "ec2_security_group" {
  name        = "ec2-security-group"
  description = "Security group for EC2 instances"

  vpc_id = aws_vpc.devops_assignment.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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
}

resource "aws_network_interface_attachment" "web_server_attachment" {
  instance_id          = aws_instance.web_server.id
  network_interface_id = aws_instance.web_server.network_interface_ids[0]
}

resource "aws_network_interface_attachment" "database_instance_attachment" {
  instance_id          = aws_instance.database_instance.id
  network_interface_id = aws_instance.database_instance.network_interface_ids[0]
}
