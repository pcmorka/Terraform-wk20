#Create security group 
resource "aws_security_group" "jenkins-sg" {
  name        = "jenkins-sg"
  description = "Open ports 22, 8080, and 443"
  vpc_id      = var.vpc_id


  #Allow incoming TCP requests on port 22 from any ip
  ingress {
    description = "Incoming ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Allow incoming TCP requests on port 8080 from any ip
  ingress {
    description = "http proxy access"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Allow access on port 80
  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Allow incoming TCP requests on port 443 from any ip
  ingress {
    description = "Incoming 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Allow all outbound requests
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins-server-sg"
  }
}


# Terraform Resource Block - to build an EC2 instance in Default vpc and subnet
resource "aws_instance" "jenkins_Ec2_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id]
  key_name               = var.key_name
  user_data              = file("jenkins.sh")

  tags = {
    Name = "jenkins_ec2_server"
  }
}

#Create S3 bucket for Jenkins artifacts
resource "aws_s3_bucket" "jenkins-bucket" {
  bucket = "wk20-jenkins-bucket"

  tags = {
    Name = "jenkins_bucket"
  }
}

#Make S3 bucket private
resource "aws_s3_bucket_acl" "wk20-jenkins-bucket" {
  bucket = aws_s3_bucket.jenkins-bucket.id
  acl    = "private"
}

#Create random number for S3 bucket name
resource "random_id" "randomness" {
  byte_length = 16
}
