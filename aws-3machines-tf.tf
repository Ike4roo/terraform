# Example of tf to deploy 3 machines in AWS cloud

provider "aws" {
  region = "us-east-1"  # region
}

variable "instance_count" {
  default = 3
}

variable "instance_type" {
  default = "t3.micro"              # type of machine
}

variable "ami" {
  default = "ami-0c55b159cbfafe1f0"  # Amazon Machine Image - image of OS in AWS
}

resource "aws_instance" "cluster" {
  count         = var.instance_count
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "cluster-node-${count.index}"
  }
}

output "instance_ips" {
  value = aws_instance.cluster[*].public_ip
}
