resource "aws_identitystore_group" "vpn_all" {
  for_each = local.vpn_groups_config

  display_name      = each.value["display_name"]
  description       = "VPN access group. Application - VPN Authenticator"
  identity_store_id = local.identity_store_id
}

resource "aws_identitystore_group_membership" "vpn_all" {
  for_each = local.vpn_groups_to_users_map

  identity_store_id = local.identity_store_id
  group_id          = local.vpn_identity_centre_group_display_name_to_group_id_map[each.value.group_name]
  member_id         = local.identity_centre_user_name_to_user_id_map[each.value.user_name]

  depends_on = [
    aws_identitystore_group.vpn_all
  ]
}
