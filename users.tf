resource "aws_identitystore_user" "all" {
  for_each          = local.users_config
  
  identity_store_id = local.identity_store_id
  display_name      = "${each.value["first_name"]}${each.value["last_name"]}"
  user_name         = each.value["email_id"]
  title             = each.value["title"]
  user_type         = each.value["user_type"]

  name {
    given_name  = each.value["first_name"]
    family_name = each.value["last_name"]
  }

  emails {
    primary = true
    value   = each.value["email_id"]
  }

  dynamic "addresses" {
    for_each = local.office_address[each.value["address"]]

    content {
      type           = "office"
      formatted      = addresses.value.formatted
      street_address = addresses.value.street_address
      locality       = addresses.value.locality
      postal_code    = addresses.value.postal_code
      country        = addresses.value.country
      region         = addresses.value.region
    }
  }
}
