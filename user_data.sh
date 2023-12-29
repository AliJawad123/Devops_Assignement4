provider "aws" {
  region = "N.Virginia"
}

# Reference the VPC and subnets created in Task 2
data "aws_vpcs" "devops_assignment" {}

data "aws_subnet" "public_subnet_1" {
  vpc_id = data.aws_vpcs.devops_assignment.ids[0]
  tags = {
    Name = "cs423-devops-public-1"
  }
}

data "aws_subnet" "private_subnet_1" {
  vpc_id = data.aws_vpcs.devops_assignment.ids[0]
  tags = {
    Name = "cs423-devops-private-1"
  }
}

data "aws_subnet" "public_subnet_2" {
  vpc_id = data.aws_vpcs.devops_assignment.ids[0]
  tags = {
    Name = "cs423-devops-public-2"
  }
}

data "aws_subnet" "private_subnet_2" {
  vpc_id = data.aws_vpcs.devops_assignment.ids[0]
  tags = {
    Name = "cs423-devops-private-2"
  }
}

# Reference the key pair created in Task 3
resource "aws_key_pair" "assignment4_key" {
  key_name   = "cs423-assignment4-key"
  public_key = file(" /Users/umerriaz/Desktop/Keys/Keys_For_First_Instance.pem")
}

# Launch EC2 instances
resource "aws_instance" "web_server_instance" {
  ami                    = "ami-079db87dc4c10ac91"  # Replace with the latest Ubuntu AMI ID
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.assignment4_key.key_name
  subnet_id              = data.aws_subnet.public_subnet_1.ids[0]
  security_group_names   = [aws_security_group.ec2_security_group.name]

  tags = {
    Name = "web-server-instance"
  }
}

resource "aws_instance" "database_instance" {
  ami                    = "ami-079db87dc4c10ac91"  # Replace with the latest Ubuntu AMI ID
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.assignment4_key.key_name
  subnet_id              = data.aws_subnet.public_subnet_2.ids[0]
  security_group_names   = [aws_security_group.ec2_security_group.name]

  tags = {
    Name = "database-instance"
  }
}

