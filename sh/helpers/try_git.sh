#!/bin/bash

cat > id_rsa <<EOF
$1
EOF

ssh-add id_rsa

git clone git@github.com:svelezsaffon/godot_docker.git
