#!/usr/bin/env bash

TOKEN=${1?Error: no name given}

body='{
"request": {
    "message": "Update Content",
    "branch":"master"
}}'

curl -s -X POST \
   -H "Content-Type: application/json" \
   -H "Accept: application/json" \
   -H "Travis-API-Version: 3" \
   -H "Authorization: token $TOKEN" \
   -d "$body" \
   https://api.travis-ci.org/repo/ELC%2Felc.github.io-source/requests