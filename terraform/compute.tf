
# Jenkins server ressource

resource "aws_instance" "jenkins_server" {
  ami                         = var.ami
  instance_type               = var.jenkins_instance_type
  vpc_security_group_ids      = [aws_security_group.jenkins_instances.id]
  subnet_id                   = aws_subnet.public[0].id
  key_name                    = var.key_name
  associate_public_ip_address = true
  # availability_zone           = "us-east-1a"

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              EOF

  tags = {
    Name = "jenkins_server"
    Project = local.global_tag
  }
}

resource "aws_ebs_volume" "jenkins_volume" {
  availability_zone = "us-east-1a"
  size              = 35

  tags = {
    Name = "jenkins_volume"
    Project = local.global_tag
  }
}

resource "aws_volume_attachment" "ebs_jenkins_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.jenkins_volume.id
  instance_id = aws_instance.jenkins_server.id
}

# monitoring server ressources

resource "aws_instance" "monitoring_server" {
  ami                         = var.ami
  instance_type               = var.monitoring_instance_type
  vpc_security_group_ids      = [aws_security_group.monitoring_instances.id]
  key_name                    = var.key_name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public[1].id
  # availability_zone           = "us-east-1b"
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              EOF
  tags = {
    Name = "monitoring_server"
    Project = local.global_tag
  }
}

resource "aws_ebs_volume" "monitoring_volume" {
  availability_zone = "us-east-1b"
  size              = 15

  tags = {
    Name = "monitoring_volume"
    Project = local.global_tag
  }
}

resource "aws_volume_attachment" "ebs_monitoring_att" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.monitoring_volume.id
  instance_id = aws_instance.monitoring_server.id
}

# Kubernetes Master server resources

resource "aws_instance" "k8s_master" {
  ami                         = var.ami
  instance_type               = var.kube_instance_type
  vpc_security_group_ids      = [aws_security_group.k8smasters_instances.id]
  key_name                    = var.key_name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public[0].id
  iam_instance_profile        = aws_iam_instance_profile.master_profile.name
  user_data                   = <<-EOF
              #!/bin/bash
              sudo apt update -y
              EOF

  tags = {
    Name = "k8s_master"
    Project = local.global_tag
  }
}

resource "aws_ebs_volume" "k8smaster_volume" {
  availability_zone = "us-east-1a"
  size              = 15

  tags = {
    Name = "k8smaster_volume"
    Project = local.global_tag
  }
}

resource "aws_volume_attachment" "ebs_k8smaster_att" {
  device_name = "/dev/sdg"
  volume_id   = aws_ebs_volume.k8smaster_volume.id
  instance_id = aws_instance.k8s_master.id
}

# Kubernetes Worker server resources

resource "aws_instance" "k8s_worker" {
  ami                         = var.ami
  instance_type               = var.kube_instance_type
  vpc_security_group_ids      = [aws_security_group.k8sworkers_instances.id]
  key_name                    = var.key_name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public[1].id
  # availability_zone           = "us-east-1b"
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              EOF

  tags = {
    Name = "k8s_worker"
    Project = local.global_tag
  }
}

resource "aws_ebs_volume" "k8sworker_volume" {
  availability_zone = "us-east-1b"
  size              = 15

  tags = {
    Name = "k8sworker_volume"
    Project = local.global_tag
  }
}

resource "aws_volume_attachment" "ebs_k8sworker_att" {
  device_name = "/dev/sdk"
  volume_id   = aws_ebs_volume.k8sworker_volume.id
  instance_id = aws_instance.k8s_worker.id
}
