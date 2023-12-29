provider "aws" {
  region = "N.Virginia"
}

resource "aws_key_pair" "assignment4_key" {
  key_name   = "cs423-assignment4-key"
  public_key = file("/Users/umerriaz/Desktop/Keys/Keys_For_First_Instance.pem")  # Replace with the path to your public key file
}

