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

# resource "aws_key_pair" "linux" {
#   key_name   = "linux-key"
  
# }
resource "aws_instance" "server" {
  ami                         = data.aws_ami.amzn-image.id
  instance_type               = "t2.micro"
  key_name                    = "linux-key"
  associate_public_ip_address = true
  availability_zone           = var.azs[0]
  vpc_security_group_ids      = [aws_security_group.test-sg.id]
  subnet_id                   = aws_subnet.pub-subnet1.id
  user_data_replace_on_change = true # will trigger a destroy and recreate when set to true
  user_data = <<EOF
              #! /bin/bash
              sudo yum update -y
              sudo yum install httpd -y 
               echo "<h1>deveployed via terraform with hard coding </h1>" | sudo tee /var/www/html/index.html
              sudo systemctl start httpd 
              sudo systemctl enable httpd
              sudo yum install docker -y
              sudo usermod -a -G docker ec2-user
              sudo systemctl enable docker.service
              sudo systemctl start docker.service 
              sudo docker run -p 8080:8080 nginx
               
            EOF
   #user_data = "${file("html.sh")}"
  # user_data = file("html.sh")
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
