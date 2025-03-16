
# Create an EC2 instance
resource "aws_instance" "my_instance" {
  ami           = "ami-00bb6a80f01f03502"  # Replace with a valid AMI ID for your region
  instance_type = "t2.micro"                # Change this to your desired instance type
  key_name = aws_key_pair.my_key_pair.key_name

  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    Name = "MyEC2Instance"
  }
}


