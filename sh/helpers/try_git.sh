#!/bin/bash

cat > /var/www/.ssh/id_rsa <<EOF
$1
EOF

ssh-add ~/.ssh/id_rsa

git clone https://github.com/svelezsaffon/godot_docker.git
