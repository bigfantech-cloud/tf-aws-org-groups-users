data "aws_ssoadmin_instances" "main" {}

locals {
  identity_store_id           = tolist(data.aws_ssoadmin_instances.main.identity_store_ids)[0]
  identity_store_instance_arn = tolist(data.aws_ssoadmin_instances.main.arns)[0]

  users_config                                       = { for map in var.users_config : map.email_id => map }
  groups_config                                      = { for map in var.groups_config : map.display_name => map }
  group_name_to_association_accounts                 = { for map in var.groups_config : map.display_name => map["aws_accounts_association"] }
  identity_centre_user_name_to_user_id_map           = { for k, user in aws_identitystore_user.all : aws_identitystore_user.all[k].user_name => aws_identitystore_user.all[k].user_id }
  identity_centre_group_display_name_to_group_id_map = { for k, group in aws_identitystore_group.all : aws_identitystore_group.all[k].display_name => aws_identitystore_group.all[k].group_id }

  permission_set_prefix = "sso_permissionset"
    
  office_address = {
    head_office_address = [{
      formatted      = "TN, India"
      street_address = "Street A"
      locality       = "TN"
      postal_code    = "602ABC"
      country        = "India"
      region         = "APAC"
    }]
  }

  #----
  # VPN
  #----

  vpn_groups_config          = { for map in var.vpn_groups_config : map.display_name => map }
  vpn_group_to_list_of_users = { for group in var.vpn_groups_config : group.display_name => group.users }
  vpn_list_of_group_user_name_map = distinct(flatten([
    for group, users in local.vpn_group_to_list_of_users : [for user in users : {
      "user_name"  = user
      "group_name" = group
    }]
  ]))
  vpn_groups_to_users_map = { for map in local.vpn_list_of_group_user_name_map : "${map.group_name}.${map.user_name}" => map }

  vpn_identity_centre_group_display_name_to_group_id_map = { for k, group in aws_identitystore_group.vpn_all : aws_identitystore_group.vpn_all[k].display_name => aws_identitystore_group.vpn_all[k].group_id }

}
