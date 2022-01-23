#!/usr/bin/env bash
set -e

Help()
{
   # Display Help
   echo "This script will create the specifed groups in netbox."
   echo
   echo "Syntax: create-netbox-groups.sh [-a|h|r|s|t]"
   echo "options:"
   echo "a     Superadmin group to create."
   echo "h     Print this Help."
   echo "r     Readonly group to create."
   echo "s     Staff Group to create."
   echo "n     Netbox host (netbox.example.local)."
   echo "t     Netbox API token."
   echo
}

declare -a groups

no_args="true"
while getopts "a:r:s:t:h:n:" option; do
   case $option in
      h) # display Help
         Help
         exit;;
      a) # Super admins group name
         AdminGroup=$OPTARG
         groups+=("$OPTARG");;
      r) # Readonly group name
         ReadOnlyGroup=$OPTARG
         groups+=("$OPTARG");;
      s) # Staff admins group name
         StaffGroup=$OPTARG
         groups+=("$OPTARG");;
      n) # netbox host
         NetboxHost=$OPTARG;;
      t) # Netbox API token
         token=$OPTARG;;
     \?) # Invalid option
         echo "Error: Invalid option"
         Help
         exit;;
   esac
   no_args="false"
done

[[ "$no_args" == "true" ]] && { Help; exit 1; }


for group in "${groups[@]}"; do 
    echo creating $group
    http --verify no --check-status --ignore-stdin POST https://$NetboxHost/api/users/groups/ "Authorization: Token $token" name=$group 
done

netbox_ro_group_id=$(http --verify no --check-status --ignore-stdin GET https://$NetboxHost/api/users/groups/\?name\=$ReadOnlyGroup "Authorization: Token $token" |  jq -r '.results | .[0] | .id ' )

http --verify no --check-status --ignore-stdin POST https://$NetboxHost/api/users/permissions/ "Authorization: Token $token" name=read-only groups:="[$netbox_ro_group_id]" object_types:=@object-types.json actions:='["view"]'
