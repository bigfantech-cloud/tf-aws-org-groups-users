output "sso_vpn_group_name_to_group_id_map" {
  description = "Map of VPN group name to group ID"
  value       = local.vpn_identity_centre_group_display_name_to_group_id_map
}
