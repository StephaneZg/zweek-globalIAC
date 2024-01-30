locals {
  global_tag = "terraform-zweek2"
}

# Security Group resources

# Jenkins Server SG and Rules resources

resource "aws_security_group" "jenkins_instances" {
  name        = "jenkins-srv-sg"
  description = "Allow traffic to jenkins instance"
  vpc_id      = aws_vpc.terraform-zweek2.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = local.global_tag
    Project = local.global_tag
  }
}

resource "aws_security_group_rule" "jenkins_allow_ssh_ipv4" {
  type              = "ingress"
  security_group_id = aws_security_group.jenkins_instances.id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}

resource "aws_security_group_rule" "jenkins_allow_http_ipv4" {
  type              = "ingress"
  security_group_id = aws_security_group.jenkins_instances.id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
}

resource "aws_security_group_rule" "jenkins_allow_https_ipv4" {
  type              = "ingress"
  security_group_id = aws_security_group.jenkins_instances.id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
}

resource "aws_security_group_rule" "jenkins_allow_chttp_ipv4" {
  type                     = "ingress"
  security_group_id        = aws_security_group.jenkins_instances.id
  source_security_group_id = aws_security_group.jenkins_instances.id
  from_port                = 8080
  protocol                 = "tcp"
  to_port                  = 8080
}

# Monitoring Server SG and Rules resources

resource "aws_security_group" "monitoring_instances" {
  name        = "monitoring-srv-sg"
  description = "Allow traffic to monitoring instance"
  vpc_id      = aws_vpc.terraform-zweek2.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = local.global_tag
    Project = local.global_tag
  }
}

resource "aws_security_group_rule" "monitoring_allow_ssh_ipv4" {
  type              = "ingress"
  security_group_id = aws_security_group.monitoring_instances.id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}

resource "aws_security_group_rule" "monitoring_allow_http_ipv4" {
  type              = "ingress"
  security_group_id = aws_security_group.monitoring_instances.id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
}

resource "aws_security_group_rule" "monitoring_allow_https_ipv4" {
  type              = "ingress"
  security_group_id = aws_security_group.monitoring_instances.id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
}

resource "aws_security_group_rule" "monitoring_allow_chttp_ipv4" {
  type              = "ingress"
  security_group_id = aws_security_group.monitoring_instances.id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 9090
  protocol          = "tcp"
  to_port           = 9090
}

# Kubernetes Master SG and Rules resources

resource "aws_security_group" "k8smasters_instances" {
  name        = "master-srv-sg"
  description = "Allow traffic to kubernetes masters instances"
  vpc_id      = aws_vpc.terraform-zweek2.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = local.global_tag
    Project = local.global_tag
  }
}

resource "aws_security_group_rule" "master_allow_ssh_ipv4" {
  type              = "ingress"
  security_group_id = aws_security_group.k8smasters_instances.id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}

resource "aws_security_group_rule" "master_allow_alljenkins_ipv4" {
  type                     = "ingress"
  security_group_id        = aws_security_group.k8smasters_instances.id
  source_security_group_id = aws_security_group.jenkins_instances.id
  from_port                = 0
  protocol                 = "tcp"
  to_port                  = 65535
}

resource "aws_security_group_rule" "master_allow_allmonitoring_ipv4" {
  type                     = "ingress"
  security_group_id        = aws_security_group.k8smasters_instances.id
  source_security_group_id = aws_security_group.monitoring_instances.id
  from_port                = 0
  protocol                 = "tcp"
  to_port                  = 65535
}

resource "aws_security_group_rule" "master_allow_allself_ipv4" {
  type              = "ingress"
  security_group_id = aws_security_group.k8smasters_instances.id
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  self              = true
}

resource "aws_security_group_rule" "master_allow_allfromnodes_ipv4" {
  type                     = "ingress"
  security_group_id        = aws_security_group.k8smasters_instances.id
  source_security_group_id = aws_security_group.k8sworkers_instances.id
  protocol                 = "-1"
  from_port                = 0
  to_port                  = 0
}

resource "aws_security_group_rule" "master_allow_http_ipv4" {
  type              = "ingress"
  security_group_id = aws_security_group.k8smasters_instances.id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
}

resource "aws_security_group_rule" "master_allow_https_ipv4" {
  type              = "ingress"
  security_group_id = aws_security_group.k8smasters_instances.id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
}

# Kubernetes Workers SG and Rules resources

resource "aws_security_group" "k8sworkers_instances" {
  name        = "workers-srv-sg"
  description = "Allow traffic to kubernetes workers instances"
  vpc_id      = aws_vpc.terraform-zweek2.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = local.global_tag
    Project = local.global_tag
  }
}

resource "aws_security_group_rule" "worker_allow_ssh_ipv4" {
  type              = "ingress"
  security_group_id = aws_security_group.k8sworkers_instances.id
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}

resource "aws_security_group_rule" "worker_allow_allself_ipv4" {
  type                     = "ingress"
  security_group_id        = aws_security_group.k8sworkers_instances.id
  source_security_group_id = aws_security_group.k8smasters_instances.id
  protocol                 = "-1"
  from_port                = 0
  to_port                  = 0
}

resource "aws_security_group_rule" "worker_allow_allfrommonitoring_ipv4" {
  type                     = "ingress"
  security_group_id        = aws_security_group.k8sworkers_instances.id
  source_security_group_id = aws_security_group.monitoring_instances.id
  from_port                = 0
  protocol                 = "tcp"
  to_port                  = 65535
}

resource "aws_security_group_rule" "worker_allow_allfromjenkins_ipv4" {
  type                     = "ingress"
  security_group_id        = aws_security_group.k8sworkers_instances.id
  source_security_group_id = aws_security_group.jenkins_instances.id
  from_port                = 0
  protocol                 = "tcp"
  to_port                  = 65535
}
