#!/bin/bash
sudo yum update -y
sudo yum install httpd -y 
echo "<h1>deveployed via terraform with provisoner remote-exec BLOCK packages.sh </h1>" | sudo tee /var/www/html/index.html
sudo systemctl start httpd 
sudo systemctl enable httpd
sudo yum install docker -y
sudo usermod -a -G docker ec2-user
sudo systemctl enable docker.service
sudo systemctl start docker.service 
sudo docker run -p 8080:8080 nginx
