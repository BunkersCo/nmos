#!/usr/bin/env bash

DASHBOARD=Dashboard.md
cat  << EOF > "$DASHBOARD" 
## Dashboard

| ID + Docs | Repository | Default Branch | Lint (default) | Render (all) |
| --- | --- | --- | --- | --- |
EOF

for repo in \
    nmos \
    nmos-discovery-registration \
    nmos-device-connection-management \
    nmos-network-control \
    nmos-event-tally \
    nmos-audio-channel-mapping \
    nmos-system \
    nmos-authorization \
    nmos-grouping \
    nmos-api-security \
    nmos-id-timing-model \
    nmos-parameter-registers \
    nmos-template \
    ; do
    repo_address="https://github.com/AMWA-TV/$repo"

    git clone "$repo_address" "$repo"
    cd "$repo"
    ci_url="${repo_address/github.com/travis-ci.com}"
        default_branch="$(git remote show origin | awk '/HEAD branch/ { print $3 }')"
        git checkout gh-pages
        ID=$(awk '/amwa_id:/ { print $2; }' _config.yml)
        cat << EOF >> "../$DASHBOARD"
| [$ID](https://amwa-tv.github.io/$repo) \
| [$repo]($repo_address) \
| $default_branch \
| <a href="${ci_url}?branch=${default_branch}"><img src="${ci_url}.svg?branch=${default_branch}" width="100"/></a> \
| <a href="${ci_url}?branch=gh-pages"><img src="${ci_url}.svg?branch=gh-pages" width="100"/></a> \
|
EOF
    cd ..
    rm -rf "$repo"
done

