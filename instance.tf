# resource "aws_instance" "remote" {
#   ami                         = data.aws_ami.amzn-image.id
#   instance_type               = "t3.large"
#   key_name                    = "linux-key"
#   associate_public_ip_address = true
#   availability_zone           = var.azs[1]
#   vpc_security_group_ids      = [aws_security_group.test-sg.id]
#   subnet_id                   = aws_subnet.pub-subnet2.id
#   # user_data_replace_on_change = true # will trigger a destroy and recreate when set to true
#   # user_data = <<EOF
#   #             #! /bin/bash
#   #             sudo yum update -y
#   #             sudo yum install httpd -y 
#   #              echo "<h1>deveployed via terraform with hard coding </h1>" | sudo tee /var/www/html/index.html
#   #             sudo systemctl start httpd 
#   #             sudo systemctl enable httpd
#   #             sudo yum install docker -y
#   #             sudo usermod -a -G docker ec2-user
#   #             sudo systemctl enable docker.service
#   #             sudo systemctl start docker.service 
#   #             sudo docker run -p 8080:8080 nginx
#   #           EOF
#   #user_data = "${file("packages.sh.sh")}"
#   # user_data = file("packages.sh.sh")
#   tags = {
#     Name    = "exec-server"
#     Created = "${var.Createdby}"
#     Date    = var.date
#   }
# }
