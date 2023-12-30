provider "aws" {
    region = "eu-west-1"
    access_key = "AKIAYYTPPLGYCN5ND2ES"
    secret_key = "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"
}
resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
      Name ="devops-assignment-4"
    }
}
resource "aws_subnet" "public_subnet1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "eu-west-1a"
    map_public_ip_on_launch = true
    tags = {
      Name = "cs423-devops-public-1"
    }
  
}
resource "aws_subnet" "private_subnet1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.6.0/24"
    availability_zone = "eu-west-1a"
    map_public_ip_on_launch = false
    tags = {
      Name = "cs423-devops-private-1"
    }
}
resource "aws_subnet" "public_subnet2" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.7.0/24"
    availability_zone = "eu-west-1b"
    map_public_ip_on_launch = true
    tags = {
      Name = "cs423-devops-public-2"
    }
  
}
resource "aws_subnet" "private_subnet2" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "eu-west-1b"
    map_public_ip_on_launch = false
    tags = {
      Name = "cs423-devops-private-2"
    }
}
resource "aws_internet_gateway" "Internet_gateway" {
    vpc_id = aws_vpc.myvpc.id
  
}
resource "aws_route_table" "Private_route_table" {
    vpc_id = aws_vpc.myvpc.id
    route  {
cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.Internet_gateway.id
    }
     tags = {
    Name = "devops-assignment-private-route-table"
  }
}
resource "aws_route_table_association" "private_subnet1" {
    route_table_id = aws_route_table.Private_route_table.id
    subnet_id = aws_subnet.private_subnet1.id
  
}
resource "aws_route_table_association" "private_subnet2" {
    route_table_id = aws_route_table.Private_route_table.id
    subnet_id = aws_subnet.private_subnet2.id
  
}