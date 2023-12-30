
resource "aws_key_pair" "assignment4_key" {
  key_name   = "cs423-assignment4-key"
  public_key = file("/Users/umerriaz/Desktop/Keys/keypair.pub")  
}
