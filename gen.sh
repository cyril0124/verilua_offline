# set -e
set -x

curr_dir=$(pwd)
scripts_dir=$(pwd)/scripts
target_dir=$(pwd)/gen

# --------------------------------------
# Copy xmake & rust into target_dir
# --------------------------------------
wget -P $target_dir https://static.rust-lang.org/dist/rust-1.86.0-x86_64-unknown-linux-gnu.tar.xz
wget -P $target_dir https://github.com/xmake-io/xmake/releases/download/v3.0.0/xmake-v3.0.0.gz.run
chmod 777 $target_dir/xmake-v3.0.0.gz.run
cp $scripts_dir/install_xmake.sh $target_dir
cp $scripts_dir/install_rust.sh $target_dir

mkdir -p $target_dir
mkdir -p $target_dir/extern

cp -r $VERILUA_HOME/libverilua $target_dir
cp -r $VERILUA_HOME/luajit-pro $target_dir
cp -r $VERILUA_HOME/wave_vpi $target_dir
cp -r $VERILUA_HOME/src $target_dir
cp -r $VERILUA_HOME/tools $target_dir
cp -r $VERILUA_HOME/examples $target_dir
cp -r $VERILUA_HOME/scripts $target_dir
cp -r $VERILUA_HOME/Cargo.toml $target_dir
cp -r $VERILUA_HOME/xmake.lua $target_dir
cp -r $VERILUA_HOME/extern/debugger.lua $target_dir/extern/
cp -r $VERILUA_HOME/extern/luafun $target_dir/extern/
cp -r $VERILUA_HOME/extern/luajit_tcc $target_dir/extern
cp -r $VERILUA_HOME/activate_verilua.sh $target_dir
cp -r $VERILUA_HOME/verilua.sh $target_dir

sed -i '/^git submodule update --init --recursive/ s/^/# /' $target_dir/luajit-pro/init.sh

find $target_dir/examples -type d -name "build" | xargs rm -rf
find $target_dir/examples -type d -name "sim_build*" | xargs rm -rf
find $target_dir/examples -type d -name ".xmake" | xargs rm -rf
find $target_dir/examples -type d -name ".dpi_exporter" | xargs rm -rf

# Remove target dir
rm -rf $target_dir/libverilua/target
rm -rf $target_dir/luajit-pro/target
rm -rf $target_dir/wave_vpi/target

cp $scripts_dir/offline_build.sh $target_dir

cd $target_dir/libverilua && CARGO_HOME=$target_dir/libverilua/.cargo cargo fetch
cd $target_dir/luajit-pro && CARGO_HOME=$target_dir/luajit-pro/.cargo cargo fetch
cd $target_dir/wave_vpi && CARGO_HOME=$target_dir/wave_vpi/.cargo cargo fetch

cd $curr_dir
tar -zcvf verilua_offline.tar.gz ./gen
