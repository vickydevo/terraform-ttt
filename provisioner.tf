# resource "null_resource" "exec" {
#   depends_on = [aws_instance.server]
#   connection {
#     type        = "ssh"
#     host        = aws_instance.server.public_ip
#     user        = "ec2-user"
#     private_key = file(var.private_key_path)
#     timeout = "2m"
#   }
#   provisioner "file" {
#     source      = "packages.sh"
#     destination = "/home/ec2-user/packages.sh"
#   }
#   # provisioner "local-exec" {   # it executes command in local machine
#   #   command = "touch index.html"
#   #   }
#   provisioner "remote-exec" {
#     inline = [
#       "sudo yum install git -y",
#       "chmod 400 packages.sh",
#       "sh /home/ec2-user/packages.sh"
#     ]

#   }
#   #   provisioner "remote-exec" {      # there is some bug i am not able to execute this command
#   #    script = file("packages.sh")

#   #   }
# }
