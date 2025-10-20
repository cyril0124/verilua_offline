#!/usr/bin/env bash

set -e
set -x

prj_dir=$(pwd)

# --------------------------------------
# Build luajit-pro
# --------------------------------------
cd $prj_dir/luajit-pro && CARGO_HOME=$prj_dir/luajit-pro/.cargo cargo build --release
bash init.sh

# --------------------------------------
# Build libverilua
# --------------------------------------
# Used by libverilua
unset XMAKE_GLOBALDIR
export LUA_LIB=$prj_dir/luajit-pro/luajit2.1/lib
export LUA_LIB_NAME=luajit-5.1
export LUA_LINK=shared

# If you are using CentOS 7, you may need to use `scl enable devtoolset-11 bash` to ensure the use of a newer version of gcc.
cd $prj_dir
export CARGO_HOME=$prj_dir/libverilua/.cargo
xmake r build_libverilua
