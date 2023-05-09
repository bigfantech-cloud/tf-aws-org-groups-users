# ! Delegated Identity Center Admin account is not allowed to manage or use permiossion sets in AWS Organization management account
# ! Below permission sets are duplicates of default permission sets found in management account
# ! This is to facilitate the `SSO delegated admin` account to attact permission sets on adding Users/Groups to Accounts

#----
# ADMINISTRATOR ACCESS
#----

resource "aws_ssoadmin_permission_set" "administratoraccess_custom" {
  name         = "AdministratorAccess-Custom"
  description  = "Administrator access to all the services"
  instance_arn = local.identity_store_instance_arn
}

resource "aws_ssoadmin_managed_policy_attachment" "administratoraccess_custom" {
  instance_arn       = local.identity_store_instance_arn
  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  permission_set_arn = aws_ssoadmin_permission_set.administratoraccess_custom.arn
}

#----
# READ ONLY ACCESS
#----

resource "aws_ssoadmin_permission_set" "readonlyaccess_custom" {
  name         = "ReadOnlyAccess-Custom"
  description  = "ReadOnly/ViewOnly access to limited services"
  instance_arn = local.identity_store_instance_arn
}

resource "aws_ssoadmin_managed_policy_attachment" "viewonlyaccess_custom" {
  instance_arn       = local.identity_store_instance_arn
  managed_policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
  permission_set_arn = aws_ssoadmin_permission_set.readonlyaccess_custom.arn
}

resource "aws_ssoadmin_managed_policy_attachment" "readonlyaccess_custom" {
  instance_arn       = local.identity_store_instance_arn
  managed_policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  permission_set_arn = aws_ssoadmin_permission_set.readonlyaccess_custom.arn
}
