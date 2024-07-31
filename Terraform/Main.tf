
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
#dfffff
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
      "sudo npm install express body-parser bcryptjs passport passport-local express-session connect-flash mongoose",
      "sudo yum update -y",
      "sudo yum install httpd -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "mkdir project",
      "cd project",
      "sudo yum install git -y",
      "git clone https://github.com/crazygamer56295/pingo-dingo.git",
      "sudo yum install -y nodejs npm",
      "node --version",
      "npm --version",
      "npm install web-vitals",
      "npm install react-scripts --save-dev",
      "npm install react-dom",
      "npm install react-router-dom",
      "npm start",
      "npm install dotenv",
      "npm install passport",
      "npm install express",
      "npm install express-flash",
      "npm install method-override",
      "npm install passport-local",


      #"sudo chmod 644 ~/project/pingo-dingo/src/index.html",
      #"sudo mv ~/project/pingo-dingo/src/index.html /var/www/html/",
      #"sudo chmod 644 ~/project/pingo-dingo/src/style.css",
      #"sudo mv ~/project/pingo-dingo/src/style.css /var/www/html/",

      # "sudo cp -r /project/https://github.com/crazygamer56295/pingo-dingo.git/* /var/www/html/",
      # "sudo chown -R apache:apache /var/www/html",
      # "sudo chmod -R 755 /var/www/html/",
      # "cd pingo-dingo",
      # "cd ~/project/pingo-dingo/src",

      # Additional commands to start your applicationsssssss
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