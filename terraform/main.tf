resource "aws_security_group" "web_s5" {
  name        = "web-security-group"
  description = "Allow inbound and outbound traffic"

  # ✅ Inbound rules (SSH, HTTP, HTTPS)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ✅ Outbound rule (Allow all outgoing traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "web" {
  ami           = "ami-0606dd43116f5ed57"  
  instance_type = "t2.small"
  key_name      = "playerball"
  security_groups = [aws_security_group.web_s5.name]

  tags = {
    Name = "web-server"
  }
}

# Create local inventory file with instance public IP
resource "local_file" "inventory" {
  content  = <<EOT
[webserver]
${aws_instance.web.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/playerball.pem
EOT
  filename = "${path.module}/inventory"

  depends_on = [aws_instance.web]
}

# Run Ansible playbook after instance and inventory file are ready
resource "null_resource" "ansible_provision" {
  depends_on = [aws_instance.web, local_file.inventory]

  triggers = {
    always_run = "${timestamp()}"  # Forces re-run on every `terraform apply`
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory ../ansible/playbook.yml"
  }
}

# Output the public IP for reference
output "instance_ip" {
  value = aws_instance.web.public_ip
}
