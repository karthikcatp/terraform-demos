output "user1_arn" {
  value = module.user1.user_arn
}

output "user1_policyarn" {
  value = module.user1.user_cloudwatch_policy_arn
}

output "user2_arn" {
  value = module.user2.user_arn
}

output "user2_policyarn" {
  value = module.user2.user_cloudwatch_policy_arn
}
