output "user_arn" {
  value = aws_iam_user.user.arn
  description = "The ARN of the created IAM user"
}

output "user_cloudwatch_policy_arn" {
  value = (var.give_cloudwatch_full_access
           ? aws_iam_user_policy_attachment.cloudwatch_full_access[0].policy_arn
           : aws_iam_user_policy_attachment.cloudwatch_read_only[0].policy_arn)

}