variable "groups_config" {
  description = <<EOT
  List of map with `display_name` and `description` objects
  example: [
    {
        display_name    = "WorkloadAdmins"
        description     = "Admin access to workload accounts"
        aws_accounts_association = [
          "11111112222", "11111113333"
        ]
    }
  ]
  EOT
  type = list(object({
    display_name             = string
    description              = string
    aws_accounts_association = list(string)
  }))
}

variable "users_config" {
  description = <<EOT
  List of users details map with `first_name`, `last_name`, `email_id`,`title`, `user_type`, `address`
  example: [
  {
    first_name = "Mohan"
    last_name  = "Kumar"
    email_id   = "mohankumar@somedomain.com"
    groups     = ["WorkloadAdmins", ]
    title      = "Owner"
    user_type  = "fulltime"
    address    = "TN_India"
  },
]
  EOT
  type = list(object({
    first_name = string
    last_name  = string
    email_id   = string
    groups     = list(string)
    title      = optional(string)
    user_type  = optional(string)
    address    = string
  }))
}

variable "vpn_groups_config" {
  description = <<EOT
    List of VPN groups details map with `display_name`, `users`
    example: [
      {
        display_name = "vpn-admin"
        users = [
          "mohankumar@somedomain.com"
        ]
      },
    ]
  EOT
  type = list(object({
    display_name = string
    users        = list(string)
  }))
}
