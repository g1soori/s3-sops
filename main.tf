resource "random_pet" "pet_name" {
  length    = 3
  separator = "-"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "private-tf-bucket-${random_pet.pet_name.id}"
  acl    = "private"

  tags = {
    Name        = "s3-g1soori-terraform"
    Environment = "Dev"
  }
}

data "aws_iam_user" "sops" {
  user_name = "david"
}


resource "aws_iam_policy" "policy" {
  name        = "test-policy-${random_pet.pet_name.id}"
  description = "SOP S3 policy"

  policy = <<EOT
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Effect":"Allow",
         "Action": "s3:ListAllMyBuckets",
         "Resource":"arn:aws:s3:::*"
      },
      {
         "Effect":"Allow",
         "Action":["s3:ListBucket","s3:GetBucketLocation"],
         "Resource": "${aws_s3_bucket.bucket.arn}"
      },
      {
         "Effect":"Allow",
         "Action":[
            "s3:PutObject",
            "s3:PutObjectAcl",
            "s3:GetObject",
            "s3:GetObjectAcl",
            "s3:DeleteObject"
         ],
         "Resource": "${aws_s3_bucket.bucket.arn}/*"
      }
   ]
}
EOT
}

resource "aws_iam_user_policy_attachment" "s3_attachment" {
  user       = data.aws_iam_user.sops.user_name
  policy_arn = aws_iam_policy.policy.arn
}