# Create an IAM policy
resource "aws_iam_policy" "velero_access" {
  name = var.iam_policy_name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ec2:DescribeVolumes",
          "ec2:DescribeSnapshots",
          "ec2:CreateTags",
          "ec2:CreateVolume",
          "ec2:CreateSnapshot",
          "ec2:DeleteSnapshot"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:PutObject",
          "s3:AbortMultipartUpload",
          "s3:ListMultipartUploadParts"
        ],
        Resource = "${data.aws_s3_bucket.velero_backup.arn}/*"
      },
      {
        Effect = "Allow",
        Action = [
          "s3:ListBucket"
        ],
        Resource = "${data.aws_s3_bucket.velero_backup.arn}"
      },
    ]
  })
}

# Create an IAM role
resource "aws_iam_role" "velero" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach the IAM policy to the IAM role
resource "aws_iam_policy_attachment" "velero_att_access" {
  name       = "Policy Attachement"
  policy_arn = aws_iam_policy.velero_access.arn
  roles      = [aws_iam_role.velero.name]
}

# Create an IAM instance profile
resource "aws_iam_instance_profile" "master_profile" {
  name = var.instance_profile_name
  role = aws_iam_role.velero.name
}
