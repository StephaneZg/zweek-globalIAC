output "jenkins_srv_publicip" {
  value = aws_instance.jenkins_server.public_ip
}

output "jenkins_srv_privateip" {
  value = aws_instance.jenkins_server.private_ip
}

output "monitoring_srv_publicip" {
  value = aws_instance.monitoring_server.public_ip
}

output "monitoring_srv_privateip" {
  value = aws_instance.monitoring_server.private_ip
}

output "master_srv_publicip" {
  value = aws_instance.k8s_master.public_ip
}

output "master_srv_privateip" {
  value = aws_instance.k8s_master.private_ip
}


output "worker_srv_publicip" {
  value = aws_instance.k8s_worker.public_ip
}

output "worker_srv_privateip" {
  value = aws_instance.k8s_worker.private_ip
}