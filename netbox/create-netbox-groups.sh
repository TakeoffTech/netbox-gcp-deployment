#!/usr/bin/env bash
set -e

for group in $groups; do 
    echo creating $group
    http --verify no --check-status --ignore-stdin POST https://$netboxHost/api/users/groups/ "Authorization: Token $token" name=$group 
done

netbox_user_group_ip=$(http --verify no --check-status --ignore-stdin GET https://$netboxHost/api/users/groups/\?name\=netbox-users "Authorization: Token $token" |  jq -r '.results | .[0] | .id ' )

http --verify no --check-status --ignore-stdin POST https://$netboxHost/api/users/permissions/ "Authorization: Token $token" name=read-only-test groups:="[$netbox_user_group_ip]" object_types:=@object-types.json actions:='["view"]'
