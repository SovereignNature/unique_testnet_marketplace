#!/usr/bin/env bash

function download_repo {
  local REPO=$1
  local BRANCH=$2
  local TAG=$3 # TAG is optional and can be an empty string

  git clone "${REPO}" --branch "${BRANCH}"
  (
    cd "${REPO}"
    git fetch
    if [ -n "${TAG}" ]; then
      git checkout "tags/${TAG}"
    fi
  )
}

if [ ! -f ./env/branches.env ]
then
  export "$(< ./env/branches.env xargs)"
fi

download_repo "$API_REPO" "$API_BRANCH" "$API_TAG"
download_repo "$ESCROW_REPO" "$ESCROW_BRANCH" "$ESCROW_TAG"
download_repo "$ESCROWKUSAMA_REPO" "$ESCROWKUSAMA_BRANCH" "$ESCROWKUSAMA_TAG"
download_repo "$FRONT_REPO" "$FRONT_BRANCH" "$FRONT_TAG"
