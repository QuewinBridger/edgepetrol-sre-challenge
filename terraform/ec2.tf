# create a Linux (Ubuntu) instance in AWS

provider "aws" {
        access_key = var.access_key 
        secret_key = var.secret_key 
        region     = var.region
}

# create an instance
resource "aws_instance" "linux_instance" {
  ami             = lookup(var.amis, var.region) 
  subnet_id       = var.subnet 
  security_groups = var.securityGroups 
  key_name        = var.keyName 
  instance_type   = var.instanceType 
  

  # Name the instance
  tags = {
    Name = var.instanceName
  }


  # Login to the ec2-user with the aws key.
  connection {
    type        = "ssh"
    user        = "ubuntu"
    password    = ""
    private_key = file(var.keyPath)
    host        = self.public_ip
  }
} 