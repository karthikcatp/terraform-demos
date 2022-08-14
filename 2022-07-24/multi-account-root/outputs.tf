output "parent_account_id" {
  value = module.multi_account_demo.parent_account_id
  description = "The ID of the parent AWS account"
}

output "child_account_id" {
  value = module.multi_account_demo.child_account_id
  description = "The ID of the child AWS account"
}
