provider "aws" {
  region = "N.Virginia"
}

# Create a security group
resource "aws_security_group" "ec2_security_group" {
  name        = "ec2-security-group"
  description = "Security group for EC2 "

  # Inbound rules
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  # Add more inbound rules if necessary

  # Outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]  # Adjust as needed for your specific requirements
  }

  # Add more outbound rules if necessary
}

# Output the security group ID for reference
output "security_group_id" {
  value = aws_security_group.ec2_security_group.id
}

