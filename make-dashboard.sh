#!/usr/bin/env bash

DASHBOARD=Dashboard.md
cat  << EOF > $DASHBOARD 
## Dashboard

| AMWA ID and docs | Repository | Default Branch | Lint | Render |
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
    ; do
    REPO_ADDRESS="https://github.com/AMWA-TV/$repo"

    git clone "$REPO_ADDRESS" "$repo"
    cd "$repo"
    CI_URL="${REPO_ADDRESS/github.com/travis-ci.com}"
        DEFAULT_BRANCH="$(git remote show origin | awk '/HEAD branch/ { print $3 }')"
        git checkout gh-pages
        ID=$(awk '/amwa_id:/ { print $2; }' _config.yml)
        echo "| [$ID](https://amwa-tv.github.io/$repo) | [$repo]($REPO_ADDRESS) | $DEFAULT_BRANCH | [![Build Status](${CI_URL}.svg?branch=${DEFAULT_BRANCH})](${CI_URL}) | [![Build Status](${CI_URL}.svg?branch=gh-pages)](${CI_URL}) |" >> ../$DASHBOARD
    cd ..
    rm -rf "$repo"
done

