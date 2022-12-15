#CREATE EC2 BASTION SERVER
resource "aws_instance" "bastion-server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.ec2-instance-type
  key_name               = var.ec2-key
  subnet_id              = aws_subnet.ebullion-public-subnet-2.id
  vpc_security_group_ids = [aws_security_group.ec2-sg.id]
  user_data              = file("user-data.sh")
  tags = tomap({
    Name    = "${var.ec2-name}",
    ProvisioningVendor = "${var.vendor}"
  })
  root_block_device {
    volume_size = 10
    volume_type = "gp2"
  }

}


##SECURITY GROUP for EC2 BASTION SERVER
resource "aws_security_group" "ec2-sg" {
  name        = "${var.ec2-sg-name}"
  description = "${var.ec2-sg-description}"
  vpc_id      =  aws_vpc.ebullion-vpc.id
  dynamic "ingress" {
    for_each = var.ports
    content {
      description = "description ${ingress.key}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

##DATA SOURCE
data "aws_ami" "ubuntu"{
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
