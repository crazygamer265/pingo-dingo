
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
    access_key = "AKIA5FTZFKFZBDAD3KXY"
    secret_key="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"
}

resource "aws_instance" "app_server" {
    ami = "ami-830c94e3"
    instance_type = "t2.micro"
    tags = {
        Name = "ExampleAppServerInstance"
    }
}