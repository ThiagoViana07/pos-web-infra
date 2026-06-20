data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name = "posweb-myapp-2026"
  security_groups = ["posweb_myapp_2026"]
  user_data = base64encode(data.template_file.user_data.rendered)
  region = "us-east-1"
  tags = {
    Name = "HelloWorld2"
  }
}
