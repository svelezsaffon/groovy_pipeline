#!/bin/bash

cat > ~/.ssh/id_rsa <<EOF
$1
EOF

ssh-add ~/.ssh/id_rsa

git clone git@github.com:svelezsaffon/godot_docker.git
