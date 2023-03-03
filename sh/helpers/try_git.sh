#!/bin/bash

eval $(ssh-agent -s)

ssh-add - <<< "$GIT_TOKEN"

git clone git@github.com:svelezsaffon/godot_docker.git
