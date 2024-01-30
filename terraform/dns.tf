
resource "aws_route53_record" "jenkins" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "tf-jenkins.${var.domain}"
  type    = "A"
  ttl     = 300
  records = ["${aws_instance.jenkins_server.public_ip}"]
}

resource "aws_route53_record" "sonar" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "tf-sonar.${var.domain}"
  type    = "A"
  ttl     = 300
  records = ["${aws_instance.jenkins_server.public_ip}"]
}

resource "aws_route53_record" "grafana" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "tf-grafana.${var.domain}"
  type    = "A"
  ttl     = 300
  records = ["${aws_instance.monitoring_server.public_ip}"]
}

resource "aws_route53_record" "k8s" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "*.tf-zweek.${var.domain}"
  type    = "A"
  ttl     = 300
  records = ["${aws_instance.k8s_master.public_ip}"]
}

