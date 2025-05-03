function set_artifactory_var
    while true
        set token (doormat login && doormat artifactory create-token | jq -r '.access_token')

        set -Ux BUNDLE_ARTIFACTORY__HASHICORP__ENGINEERING "james.pogran%40hashicorp.com:$token"

        docker login -u "james.pogran @hashicorp.com" -p $token docker.artifactory.hashicorp.engineering

        sleep 1800
    end
end
# set_artifactory_var &
