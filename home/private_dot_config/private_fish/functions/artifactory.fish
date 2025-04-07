function set_artifactory_var
    while true
        set -Ux BUNDLE_ARTIFACTORY__HASHICORP__ENGINEERING "james.pogran%40hashicorp.com:"(doormat login && doormat artifactory create-token | jq -r '.access_token')
        sleep 1800
    end
end
# set_artifactory_var &
