#!/bin/sh
set -eu

CONFIG_JSON=config.json

jq -r 'keys[]' "${CONFIG_JSON}" \
  | while read VERSION
    do
      echo "Updating ${VERSION}"
      REPO="$(jq -r ".\"${VERSION}\".repository" "${CONFIG_JSON}")"
      ARCH="$(jq -r ".\"${VERSION}\".arch" "${CONFIG_JSON}")"
      mkdir -p "${VERSION}"
      cat Dockerfile.template \
        | sed -e "s@%VERSION%@${VERSION}@g" \
        | sed -e "s@%REPOSITORY%@${REPO}@g" \
        | sed -e "s@%ARCH%@${ARCH}@g" \
        > "${VERSION}/Dockerfile"
      cp docker-compose.test.yml "${VERSION}/"
    done
