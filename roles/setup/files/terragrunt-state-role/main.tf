provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_iam_role" "terragrunt_iam_role" {
  name = "${var.config_name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${var.terragrunt_user_arn}"
      },
      "Action": "sts:AssumeRole",
      "Condition": {}
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "terragrunt_state_iam_policy" {
  name = "${var.config_name}-state"
  role = "${aws_iam_role.terragrunt_iam_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowAllDynamoDBActionsOnAllTerragruntTables",
      "Effect": "Allow",
      "Action": "dynamodb:*",
      "Resource": [
        "arn:aws:dynamodb:*:*:table/osu-da-dev-terragrunt-lock"
      ]
    },
    {
      "Sid": "AllowAllS3ActionsOnTerragruntBuckets",
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::osu-da-dev-terragrunt-state",
        "arn:aws:s3:::osu-da-dev-terragrunt-state/*"
      ]
    }
  ]
}
EOF
}
