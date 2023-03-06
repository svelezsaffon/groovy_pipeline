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

eval $(ssh-agent)

ssh-keyscan github.com >> ~/.ssh/known_hosts

ssh-add - <<< "$GIT_TOKEN"

git clone "$REPOSITORY" .

git fetch origin "$BRANCH"

git checkout "$BRANCH"

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



