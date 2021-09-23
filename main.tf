resource "aws_security_group" "sg" {
  name        = "wld-all-ports-tf-${var.IDENTIFIER}"
  description = "Allow all ports, just for testing"
  vpc_id      = var.VPC_ID

  ingress {
    description = "Allowing all ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "allow-all-${var.IDENTIFIER}"
  }

}

resource "aws_instance" "default" {
  ami                         = var.AMI_ID
  instance_type               = var.INSTANCE_TYPE
  key_name                    = "dummy"
  subnet_id                   = var.SUBNET_ID

  vpc_security_group_ids      = ["${aws_security_group.sg.id}"]

  tags = {
    "Name" = "wld-tf-${var.IDENTIFIER}"
  }

  credit_specification {
    cpu_credits = "standard"
  }

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "10"
    delete_on_termination = "true"
  }


  provisioner "file" {
    source      = "start_run.sh"
    destination = "/tmp/start_run.sh"
  }

  provisioner "file" {
    source      = "react.tar.gz"
    destination = "/tmp/react.tar.gz"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/start_run.sh",
      "/tmp/start_run.sh"
    ]
  }

  connection {
    host        = self.public_ip
    type        = "ssh"
    user        = var.SSH_USER
    private_key = file(var.SSH_KEY_PRIVATE)
  }
}

output "instance_ips" {
  value = "PublicIP: ${aws_instance.default.public_ip} , PrivateIP: ${aws_instance.default.private_ip}"
}

