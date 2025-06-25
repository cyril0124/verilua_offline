set -e
set -x

prj_dir=$(pwd)

# --------------------------------------
# Build luajit-pro
# --------------------------------------
cd $prj_dir/luajit-pro && CARGO_HOME=$prj_dir/luajit-pro/.cargo cargo build --release
bash init.sh


# --------------------------------------
# Build wave_vpi
# --------------------------------------
cd $prj_dir/wave_vpi && CARGO_HOME=$prj_dir/wave_vpi/.cargo cargo build --release


# --------------------------------------
# Build libverilua
# --------------------------------------
# Used by libverilua
unset XMAKE_GLOBALDIR
export LUA_LIB=$prj_dir/luajit-pro/luajit2.1/lib
export LUA_LIB_NAME=luajit-5.1
export LUA_LINK=shared

cd $prj_dir
export CARGO_HOME=$prj_dir/libverilua/.cargo
xmake b libverilua_vcs
xmake b libverilua_vcs_dpi
xmake b libverilua_verilator
xmake b libverilua_verilator_dpi
xmake b libverilua_wave_vpi
