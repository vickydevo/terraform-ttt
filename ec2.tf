data "aws_ami" "amzn-image" {
  #executable_users = ["self"]
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
    #values = ["amzn2-ami-kernel-5.10-hvm-2.0.20230404.1-x86_64-gp2"]
  }

  #   filter {
  #     name   = "root-device-type"
  #     values = ["ebs"]
  #   }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}
resource "aws_instance" "server" {
  ami                         = data.aws_ami.amzn-image.id
  instance_type               = "t3.micro"
  key_name                    = "NVIGINIA"
  associate_public_ip_address = true
  availability_zone           = var.azs[0]
  vpc_security_group_ids      = [aws_security_group.test-sg.id]
  subnet_id                   = aws_subnet.pub-subnet1.id
  tags = {
    Name    = "${var.env}-server"
    Created = "${var.Createdby}"
    Date    = var.date
  }
}

output "ami_name" {
  value = data.aws_ami.amzn-image.name
}
output "ami_id" {
  value = data.aws_ami.amzn-image.id
}
