resource "aws_instance" "openproject" {
  ami                    = "ami-00ca32bbc84273381"
  instance_type          = "t2.medium"
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  security_group_ids     = var.ec2_sg_id

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
