#!/bin/sh
set -eu

CONFIG_JSON=config.json

jq -r 'keys[]' "${CONFIG_JSON}" \
  | while read -r VERSION
    do
      echo "Updating ${VERSION}"
      REPO="$(jq -r ".\"${VERSION}\".repository" "${CONFIG_JSON}")"
      TEXPATH="$(jq -r ".\"${VERSION}\".texPath" "${CONFIG_JSON}")"
      mkdir -p "${VERSION}"
      < Dockerfile.template \
          sed -e "s@%VERSION%@${VERSION}@g" \
        | sed -e "s@%REPOSITORY%@${REPO}@g" \
        | sed -e "s@%TEXPATH%@${TEXPATH}@g" \
        > "${VERSION}/Dockerfile"
      cp docker-compose.test.yml "${VERSION}/"
    done
