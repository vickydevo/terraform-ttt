# Create a VPC MODULE 
# In a MODULE we can have multiple resourdes 
# resource is for creating new infrastructure

resource "aws_vpc" "project1" {
  #   cidr_block = "10.0.0.0/16" # no of ipv4 10.0.0.0/16 65536
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true # in terraform dns hostnames = false by default
  tags = {
    Name    = "${var.env}-vpc"
    Created = "${var.Createdby}"
    Date    = var.date
  }
}

# create subnet
resource "aws_subnet" "pub-subnet1" {
  vpc_id     = aws_vpc.project1.id
  cidr_block = var.subnet_cidr_blocks[2]
  # cidr_block = var.subnet_cidr_blocks[] # no of ipv4 10.0.0.0/24 256
  availability_zone = var.azs[0]
  tags = {
    Name    = "${var.env}-pb-snt-1"
    Created = "${var.Createdby}"
    Date    = var.date
  }
}

resource "aws_subnet" "pub-subnet2" {
  vpc_id     = aws_vpc.project1.id
  cidr_block = var.subnet_cidr_blocks[3] # no of ipv4 10.0.0.0/24 256

  availability_zone = var.azs[1]
  tags = {
    Name    = "${var.env}-pb-snt-2"
    Created = "${var.Createdby}"
    Date    = var.date
  }
}
resource "aws_subnet" "private-subnet1" {
  vpc_id            = aws_vpc.project1.id
  cidr_block        = var.subnet_cidr_blocks[1] # no of ipv4 10.0.0.0/24 256
  availability_zone = var.azs[2]
  tags = {
    Name    = "${var.env}-pv-snt-1"
    Created = "${var.Createdby}"
    Date    = var.date
  }
}
resource "aws_subnet" "private-subnet2" {
  vpc_id            = aws_vpc.project1.id
  cidr_block        = var.subnet_cidr_blocks[5] # no of ipv4 10.0.0.0/24 256
  availability_zone = var.azs[3]
  tags = {
    Name    = "${var.env}-pv-snt-2"
    Created = "${var.Createdby}"
    Date    = var.date
  }
}
# create internet gateway 
resource "aws_internet_gateway" "test-igw" {
  vpc_id = aws_vpc.project1.id

  tags = {
    Name = "${var.env}-igw"
  }
}

resource "aws_route_table" "test-RT" {
  vpc_id = aws_vpc.project1.id
  route {
    gateway_id = aws_internet_gateway.test-igw.id
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "${var.env}-RT"
  }
}

resource "aws_route_table_association" "sn1" {
  subnet_id      = aws_subnet.pub-subnet1.id
  route_table_id = aws_route_table.test-RT.id
}
resource "aws_route_table_association" "sn2" {
  subnet_id      = aws_subnet.pub-subnet2.id
  route_table_id = aws_route_table.test-RT.id
}
resource "aws_route_table_association" "sn4" {
  subnet_id      = aws_subnet.private-subnet2.id
  route_table_id = aws_route_table.test-RT.id
}
resource "aws_route_table_association" "sn3" {
  subnet_id      = aws_subnet.private-subnet1.id
  route_table_id = aws_route_table.test-RT.id
}


resource "aws_security_group" "test-sg" {
  name        = "${var.env}-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.project1.id
  ingress {
    description = "ssh connectivity"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "http traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "https traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "web server inbound traffic"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.env}-sg"
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
#     Created = "${var.Createdby}"
#     Date    = var.date
#   }
# }

output "vpc_project1" {
  value = aws_vpc.project1.id


}
output "pub-subnet1" {
  value = aws_subnet.pub-subnet1.id

}
