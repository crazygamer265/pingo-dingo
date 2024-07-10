
terraform{
 required_providers {
   aws = {
    source = "hashicorp/aws"
    version = "~> 4.16"

   }
 }
 required_version = ">=1.2.0"
}

provider "aws" {
    region = "us-west-2"
    access_key = var.aws_access_key_id
    secret_key = var.aws_secret_access_key
}


resource "aws_instance" "app_server" {
    ami = "ami-0b20a6f09484773af"
    instance_type = "t2.micro"
    key_name = "key-pair"
    vpc_security_group_ids = ["sg-0141a409a04178f57"]
    tags = {
        Name = "ExampleAppServerInstance"
    }

    provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y httpd git",
      "sudo systemctl start httpd",
      "mkdir project",
      "cd project",
      "sudo yum install git -y",
      "git clone https://github.com/crazygamer265/pingo-dingo.git",
      "sudo cp -r /project/https://github.com/crazygamer265/pingo-dingo.git/* /var/www/html/",
      "sudo chown -R apache:apache /var/www/html",
      "sudo chmod -R 755 /var/www/html/",
      "cd pingo-dingo",
      "cd ~/project/pingo-dingo/src",
      # Additional commands to start your application
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = base64decode(var.private_key_base64)
      host        = self.public_ip
    }
  }
}

variable "private_key_base64" {
  description = "Base64 encoded private key content"
  type        = string
}

variable "aws_access_key_id" {
  description = "AWS access key ID"
  type        = string
}

variable "aws_secret_access_key" {
  description = "AWS secret access key"
  type        = string
}
#s