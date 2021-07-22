resource "aws_kms_key" "sops" {
  description             = "SOPS kms key"
  deletion_window_in_days = 10
}

resource "aws_iam_policy" "kms" {
  name        = "kms-test-policy-34122334"
  description = "SOP S3 policy"

  policy = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1620808694070",
      "Action": [
        "kms:Decrypt",
        "kms:Encrypt"
      ],
      "Effect": "Allow",
      "Resource": "${aws_kms_key.sops.arn}"
    }
  ]
}
EOT
}

resource "aws_iam_user_policy_attachment" "kms_attachment" {
  user       = data.aws_iam_user.sops.user_name
  policy_arn = aws_iam_policy.kms.arn
}