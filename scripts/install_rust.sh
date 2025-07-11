#!/usr/bin/env bash

tar -zxvf rust-1.86.0-x86_64-unknown-linux-gnu.tar.xz
cd rust-1.86.0-x86_64-unknown-linux-gnu/rust-1.86.0-x86_64-unknown-linux-gnu
rust_install_path=$(pwd)/install
bash install.sh --prefix=$rust_install_path

cat >> $HOME/.$(basename "$SHELL")rc << EOF
# Add rust to PATH
export PATH=$rust_install_path/bin:\$PATH
EOF
