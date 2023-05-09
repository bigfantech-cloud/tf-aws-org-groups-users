resource "aws_ssoadmin_account_assignment" "workloadadmins" {
  for_each = toset(local.group_name_to_association_accounts["WorkloadAdmins"])

  instance_arn       = local.identity_store_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.administratoraccess_custom.arn
  principal_id       = local.identity_centre_group_display_name_to_group_id_map["WorkloadAdmins"]
  principal_type     = "GROUP"
  target_id          = each.value
  target_type        = "AWS_ACCOUNT"

  depends_on = [
    aws_identitystore_group_membership.all
  ]
}
