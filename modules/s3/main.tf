# Create an S3 bucket
resource "aws_s3_bucket" "secure_bucket" {
  
  bucket  = "${"civicacare-"}${(replace(lower(var.customer_name), " ", "-"))}"
  object_lock_enabled     = false

  tags  ={
    Name     = "${"civicacare-"}${(replace(lower(var.customer_name), " ", "-"))}"
     Customer = "${var.customer_name}"
  }
}

# Block all public access
resource "aws_s3_bucket_public_access_block" "secure_block" {
  bucket      = aws_s3_bucket.secure_bucket.id
  block_public_acls        = true
  ignore_public_acls       = true
  block_public_policy      = true
  restrict_public_buckets  = true
}

# Enable SSE-KMS Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "secure_encryption" {
  bucket      = aws_s3_bucket.secure_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = "${"arn:aws:kms:ap-southeast-2:198861357956:key/fac76c65-a841-4021-8f3b-bcce5e6e2be1"}"
    }
    bucket_key_enabled  = true
  }
}

# bucket policy file
resource "aws_s3_bucket_policy" "secure_policy" {
  bucket  = aws_s3_bucket.secure_bucket.id
  # policy  = file (var.s3_policy_file)
  policy  = jsonencode ({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowSSLRequestsOnly",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${aws_s3_bucket.secure_bucket.bucket}",
                "arn:aws:s3:::${aws_s3_bucket.secure_bucket.bucket}/*"
            ],
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "false"
                }
            }
        }
    ]
})
}


# IAM policy
resource "aws_iam_policy" "backup_policy" {
  name        = "${(replace(var.customer_name, " ", ""))}${"S3NativeBackupPolicy"}"
  description = "${(replace(var.customer_name, " ", ""))}${"S3NativeBackupPolicy"}"
  policy      = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "kms:DescribeKey",
                "kms:GenerateDataKey",
                "kms:Encrypt",
                "kms:Decrypt"
            ],
            "Resource": "arn:aws:kms:ap-southeast-2:198861357956:key/fac76c65-a841-4021-8f3b-bcce5e6e2be1"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation"
            ],
            "Resource": "arn:aws:s3:::${aws_s3_bucket.secure_bucket.bucket}"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject",
                "s3:ListMultipartUploadParts",
                "s3:AbortMultipartUpload"
            ],
            "Resource": "arn:aws:s3:::${aws_s3_bucket.secure_bucket.bucket}/*"
        }
    ]
  }
  )
}

#IAM role
resource "aws_iam_role" "backup_role" {
  name = "${replace(var.customer_name, " ", "")}${"NativeBackupRole"}"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": "rds.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
})
}

# Attach the policy to Role
resource "aws_iam_role_policy_attachment" "policy_attach" {
  role        = aws_iam_role.backup_role.name
  policy_arn  = aws_iam_policy.backup_policy.arn
}

