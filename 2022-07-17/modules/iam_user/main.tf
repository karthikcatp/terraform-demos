resource "aws_iam_user" "user" {
  name = var.user_name
}


data "aws_iam_policy_document" "cloudwatch_read_only" {
  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "cloudwatch_ready_only" {
  name = "${var.user_name}-cloudwatch-read-only"
  policy = data.aws_iam_policy_document.cloudwatch_read_only.json
}

data "aws_iam_policy_document" "cloudwatch_full_access" {
  statement {
    effect = "Allow"
    actions = ["cloudwatch:*"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "cloudwatch_full_access" {
  name = "${var.user_name}-cloudwatch-full-access"
  policy = data.aws_iam_policy_document.cloudwatch_full_access.json
}

resource "aws_iam_user_policy_attachment" "cloudwatch_full_access" {
  count = var.give_cloudwatch_full_access ? 1 : 0
  policy_arn = aws_iam_policy.cloudwatch_full_access.arn
  user       = aws_iam_user.user.name
}

resource "aws_iam_user_policy_attachment" "cloudwatch_read_only" {
  count = var.give_cloudwatch_full_access ? 0 : 1

  policy_arn = aws_iam_policy.cloudwatch_ready_only.arn
  user       = aws_iam_user.user.name
}