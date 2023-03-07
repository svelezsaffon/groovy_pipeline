#!/bin/bash

#
#   Script to specialized build for linux platforms.
# 


#
#   Command line to echo/print usage of this script
#
usage() {

    cat <<HELP_USAGE

        $0  -r <Repository url>

        -r  Variable that describe the host of the git repository

        Example:
            ./scripts/build/git_clone.sh -r https://github.com/godotengine/godot.git

HELP_USAGE

}

parse_and_clone(){

# Extract the protocol (includes trailing "://").
PARSED_PROTO="$(echo $REPOSITORY | sed -nr 's,^(.*://).*,\1,p')"

# Remove the protocol from the URL.
PARSED_URL="$(echo ${REPOSITORY/$PARSED_PROTO/})"

# Extract the user (includes trailing "@").
PARSED_USER="$(echo $PARSED_URL | sed -nr 's,^(.*@).*,\1,p')"

# Remove the user from the URL.
PARSED_URL="$(echo ${PARSED_URL/$PARSED_USER/})"

# Extract the port (includes leading ":").
PARSED_PORT="$(echo $PARSED_URL | sed -nr 's,.*(:[0-9]+).*,\1,p')"

# Remove the port from the URL.
PARSED_URL="$(echo ${PARSED_URL/$PARSED_PORT/})"

# Extract the path (includes leading "/" or ":").
PARSED_PATH="$(echo $PARSED_URL | sed -nr 's,[^/:]*([/:].*),\1,p')"

# Remove the path from the URL.
PARSED_HOST="$(echo ${PARSED_URL/$PARSED_PATH/})"

eval $(ssh-agent)

mkdir ~/.ssh

ssh-keyscan "$PARSED_HOST" >> ~/.ssh/known_hosts

ssh-add - <<< "$GIT_TOKEN"

git clone -b "$BRANCH" "$REPOSITORY" .

}

while getopts ":hr:b:" o; do
    case "${o}" in
        r)
            # Variable that describe the host of the git repository

            REPOSITORY=${OPTARG}            
            ;;   
        b)
            # Variable that describe the host of the git repository

            BRANCH=${OPTARG}            
            ;;               
        h | *) # Display help.
        usage
        exit 0
        ;;
    esac
done

parse_and_clone



