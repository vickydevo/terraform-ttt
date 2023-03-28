# data "aws_ami" "amazon-image" {
#   #   executable_users = ["self"]
#   most_recent = true
#   owners      = ["amazon"]

#   filter {
#     name   = "name"
#     values = ["al2023-ami-2023*-x86_64"]
#   }

#   #   filter {
#   #     name   = "root-device-type"
#   #     values = ["ebs"]
#   #   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }
# resource "aws_instance" "server" {
#   ami                         = data.aws_ami.amazon-image.id
#   instance_type               = "t3.micro"
#   key_name                    = "NVIGINIA"
#   associate_public_ip_address = true
#   availability_zone           = var.azs[0]
#   vpc_security_group_ids      = [aws_security_group.test-sg.id]
#   subnet_id                   = aws_subnet.pub-subnet1.id
#   tags = {
#     Name    = "${var.env}-server"
#     Created = "MELKY"
#     Date    = var.date
#   }
# }

# output "ami_name" {
#   value = data.aws_ami.amazon-image.name
# }
# output "ami_id" {
#   value = data.aws_ami.amazon-image.id
# }
