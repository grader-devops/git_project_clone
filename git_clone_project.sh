#!/bin/bash
if command -v jq >/dev/null 2>&1; then
  echo "jq parser found";
else
  echo "this script requires the 'jq' json parser (https://stedolan.github.io/jq/).";
  exit 1;
fi


# IF [ -Z "$1" ]
#   THEN
#     ECHO "A GROUP NAME ARG IS REQUIRED"
#     EXIT 1;
# FI



if [ -z "$1" ]
  then
    echo "an auth token arg is required. See $2/profile/account"
    exit 1;
fi



if [ -z "$2" ]
  then
    echo "a gitlab URL is required."
    exit 1;
fi



TOKEN="$1";
URL="$2/api/v4"
PREFIX="ssh_url_to_repo";

# echo "Cloning all git projects in group $1";

curl --header "Authorization: Bearer $TOKEN" $URL/projects | jq --arg p "$PREFIX" '.[] | .[$p]' | xargs -L1 git clone

#curl -H "Authorization: Bearer DzAqmXf6ceQy3V7xHtmz" "http://gitlab.ci-cd.workshop.express42.io/api/v4/projects"| jq  --arg p "ssh_url_to_repo" '.[] | .[$p]' | xargs -L1 git clone
