data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "vela_web_sg" {
    name = "web_sg"
    description = "SSH from admin IP only, HTTP/HTTPS from anywhere"
    vpc_id = var.vela_vpc_id
    ingress {
        description = "Allow HTTP from anywhere"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Allow HTTPS from anywhere"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Allow SSH from admin IP"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [var.vela_admin_ip_cidr]
    }

    egress {
        description = "Allow all outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

data "aws_iam_policy_document" "vela_ec2_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "vela_ec2_s3_role" {
  name = "vela-ec2-s3-role"
  assume_role_policy = data.aws_iam_policy_document.vela_ec2_assume_role.json
}


data "aws_iam_policy_document" "vela_s3_object_access" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject", "s3:PutObject"]
    resources = ["${var.vela_s3_bucket_arn}/*"]
  }
}

resource "aws_iam_role_policy" "vela_s3_object_access" {
  name   = "vela-s3-object-access"
  role   = aws_iam_role.vela_ec2_s3_role.id
  policy = data.aws_iam_policy_document.vela_s3_object_access.json
}

resource "aws_iam_instance_profile" "vela_ec2_s3_profile" {
  name = "vela-ec2-s3-profile"
  role = aws_iam_role.vela_ec2_s3_role.name
}

resource "aws_instance" "vela_web" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.vela_instance_type
  subnet_id              = var.vela_public_subnet_id
  vpc_security_group_ids = [aws_security_group.vela_web_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.vela_ec2_s3_profile.name
}