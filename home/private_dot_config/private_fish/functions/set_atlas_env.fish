function set_atlas_env
    set -gx GITHUB_TOKEN "$(op read 'op://private/atlas-github-token/token')"
    if not set -q ACCESS_TOKEN
        set ACCESS_TOKEN "$(doormat login && doormat artifactory create-token | jq -r .access_token)"
    end
    set -gx ATLAS_JANUS_ENGINE_PATH ~/src/hashicorp/janus-rails-engine
    set -gx USER "james.pogran"
    set -gx BUNDLE_ARTIFACTORY__HASHICORP__ENGINEERING "$USER%40hashicorp.com:$ACCESS_TOKEN"
    echo $ACCESS_TOKEN | docker login docker.artifactory.hashicorp.engineering --username "$USER@hashicorp.com" --password-stdin
    echo $ACCESS_TOKEN | docker login tf-cloud-local.artifactory.hashicorp.engineering --username "$USER@hashicorp.com" --password-stdin
    eval "$(tfcdev rc)"
end
