#!/bin/bash
#parsing all your group project on github and clone they 
#./git_clone_project.sh <TOKEN> <GIT URL>


if command -v jq >/dev/null 2>&1; then
  echo "jq parser found";
else
  echo "this script requires the 'jq' json parser (https://stedolan.github.io/jq/).";
  exit 1;
fi


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

curl -H "Authorization: Bearer $TOKEN" $URL/projects | jq --arg p "$PREFIX" '.[] | .[$p]' | xargs -L1 git clone
