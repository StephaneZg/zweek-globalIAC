
data "aws_route53_zone" "selected" {
  name = "example.com"
}

# make sure to create a bucket or use an existing one en update the bucket value
data "aws_s3_bucket" "velero_backup" {
  bucket = "velero-backups-zchallenge"
}