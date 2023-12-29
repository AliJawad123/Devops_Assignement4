provider "aws" {
  region = "N. Virginia"
}

# 1. Create VPC
resource "aws_vpc" "devops_assignment" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "devops-assignment-4"
  }
}

# 2. Create two pairs of public and private subnets
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.devops_assignment.id
  cidr_block              = "10.0.0.1/16"
  availability_zone       = "us-east-1a (use1-az2)"
  map_public_ip_on_launch = true
  tags = {
    Name = "cs423-devops-public-1"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.devops_assignment.id
  cidr_block = "10.0.0.3/16"
  availability_zone = "us-east-1c (use1-az6)"
  tags = {
    Name = "cs423-devops-private-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.devops_assignment.id
  cidr_block              = "your_public_subnet_cidr_2"
  availability_zone       = "your_az_2"
  map_public_ip_on_launch = true
  tags = {
    Name = "cs423-devops-public-2"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.devops_assignment.id
  cidr_block = "10.0.0.4/16"
  availability_zone = "us-east-1c (use1-az6)"
  tags = {
    Name = "cs423-devops-private-2"
  }
}

# 3. Create private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.devops_assignment.id
  tags = {
    Name = "devops-assignment-4-private-route-table"
  }
}

# 4. Associate private subnets with private route table
resource "aws_route_table_association" "private_subnet_association_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet_association_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table.id
}

# 5. Create internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.devops_assignment.id
  tags = {
    Name = "devops-assignment-4-igw"
  }
}

# 6. Create route to the internet gateway for public subnets
resource "aws_route" "public_subnet_route_1" {
  route_table_id         = aws_subnet.public_subnet_1.route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "public_subnet_route_2" {
  route_table_id         = aws_subnet.public_subnet_2.route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

