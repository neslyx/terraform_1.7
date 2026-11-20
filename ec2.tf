
resource "aws_security_group" "ec2_sg" {
  name        = "trainee-ec2-sg"
  description = "Allow ICMP ping and outbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow ping"
    protocol    = "icmp"
    from_port   = 8
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "trainee-ec2-sg"
  }
}

resource "aws_instance" "main" {
  ami           = "ami-amazonlinux2023"
  instance_type = "t2.micro"

  subnet_id = module.vpc.public_subnets[0]

  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id
  ]

  associate_public_ip_address = true

  tags = {
    Name = "trainee-ec2"
  }
}
