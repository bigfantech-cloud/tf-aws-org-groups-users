#----
# GROUPS
#----

groups_config = [
  {
    display_name = "WorkloadAdmins"
    description  = "Admin access to Workload and Infrastructure accounts"
    aws_accounts_association = [
      "123345668990", "099887654311"
    ]
  },
]

#----
# USERS
#----

users_config = [
  {
    first_name = "Mohan"
    last_name  = "Kumar"
    email_id   = "mohankumar@somedomain.com"
    groups     = ["WorkloadAdmins", ]
    title      = "Owner"
    user_type  = "fulltime"
    address    = "head_office_address" # refer to locals block `office_address` in data.tf for possible values.
  },
]


#-----
# VPN
#-----

vpn_groups_config = [
  {
    display_name = "vpn-admin"
    users = [
      "mohankumar@somedomain.com"
    ]
  },
]
