resource "aws_iam_policy" "policy" {
  name = "SNSPublishPermission"
  path = "/"
  description = "Allow Publishing Notification"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "SNS:Publish"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "test-attach" {
  name = "dummy-attachment"
  roles = [aws_iam_role.dummy_role.name]
  policy_arn = aws_iam_policy.policy.arn
}