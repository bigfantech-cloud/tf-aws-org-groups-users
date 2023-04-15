locals {
  user_to_list_of_groups = { for user in var.users_config : user.email_id => user.groups }
  list_of_group_user_name_map = distinct(flatten([
    for user, groups in local.user_to_list_of_groups : [for group in groups : {
      "user_name"  = user
      "group_name" = group
    }]
  ]))
  users_to_groups_map = { for map in local.list_of_group_user_name_map : "${map.user_name}.${map.group_name}" => map }
}

resource "aws_identitystore_group" "all" {
  for_each = local.groups_config

  display_name      = each.value["display_name"]
  description       = each.value["description"]
  identity_store_id = local.identity_store_id
}

resource "aws_identitystore_group_membership" "all" {
  for_each = local.users_to_groups_map

  identity_store_id = local.identity_store_id
  group_id          = lookup(local.identity_centre_group_display_name_to_group_id_map, each.value.group_name, null)
  member_id         = lookup(local.identity_centre_user_name_to_user_id_map, each.value.user_name, null)

  depends_on = [
    aws_identitystore_group.all
  ]
}
