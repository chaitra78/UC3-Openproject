resource "aws_instance" "openproject" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = "t2.medium"
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  security_group_ids     = var.security_group_ids

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              service docker start
              usermod -a -G docker ec2-user
              docker run -d -p 8080:80 openproject/community:latest
              EOF

  tags = {
    Name = "OpenProject-EC2"
  }
}
