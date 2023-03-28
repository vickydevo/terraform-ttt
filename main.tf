provider "aws" {
#   region     = "us-east-1"
#   access_key = "AKIA24IWL4NXDL7XVZPN"                     # dont hardcode this
#   secret_key = "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" # dont hardcode this
}


# Create a VPC
# resource is for creating new infrastructure
resource "aws_vpc" "project1" {
#   cidr_block = "10.0.0.0/16" # no of ipv4 10.0.0.0/16 65536
cidr_block = var.vpc_cidr_block
  tags = {
    Name    = var.env
    Created = "vignan"
    Date    = var.date
  }
}

# create subnet
resource "aws_subnet" "pub-subnet1" {
  vpc_id     = aws_vpc.project1.id
  cidr_block = var.subnet_cidr_blocks[0]
  # cidr_block = var.subnet_cidr_blocks[] # no of ipv4 10.0.0.0/24 256
  availability_zone = var.azs[0]
  tags = {
    Name    = "pub-subnet1"
    Created = "vignan"
    Date    = var.date
  }
}

resource "aws_subnet" "pub-subnet2" {
  vpc_id     = aws_vpc.project1.id
  cidr_block = var.subnet_cidr_blocks[1] # no of ipv4 10.0.0.0/24 256
  availability_zone = var.azs[1]
  tags = {
    Name    = "pub-subnet2"
    Created = "vignan"
    Date    = var.date
  }
} 
resource "aws_subnet" "private-subnet1" {
  vpc_id     = aws_vpc.project1.id
  cidr_block = var.subnet_cidr_blocks[2] # no of ipv4 10.0.0.0/24 256
  availability_zone = var.azs[2]
  tags = {
    Name    = "private-subnet1"
    Created = "vignan"
    Date    = var.date
  }
}
resource "aws_subnet" "private-subnet2" {
  vpc_id     = aws_vpc.project1.id
  cidr_block = var.subnet_cidr_blocks[3] # no of ipv4 10.0.0.0/24 256
  availability_zone = var.azs[3]
  tags = {
    Name    = "private-subnet2"
    Created = "vignan"
    Date    = var.date
  }
}

# data_source  is for picking existing infrastructure
# data "aws_vpc" "default" {
#     default = true 
# }
# resource "aws_subnet" "default-subnet7" {
#     vpc_id = data.aws_vpc.default.id
#     cidr_block = "172.31.96.0/20"
#     availability_zone = var.azs[]
#     tags = {
#     Name    = "default-subnet7"
#     Created = "vignan"
#     Date    = var.date
#   }
# }

output "vpc_project1" {
    value = aws_vpc.project1.id
    
  
} 
output "pub-subnet1" {
    value = aws_subnet.pub-subnet1.id
   
}