#!/bin/bash

eval `ssh-agent -s`

echo "$token" >> id_rsa

chmod 400 id_rsa

ssh-add id_rsa

git clone git@github.com:svelezsaffon/godot_docker.git
