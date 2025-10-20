#!/usr/bin/env bash

prj_dir=$(pwd)

xmake f --cc=$(which gcc) --cxx=$(which g++)
export NO_CPPTRACE=1
export CARGO_HOME=$prj_dir/src/wave_vpi/wellen_impl/.cargo
xmake b -v wave_vpi_main
xmake b -v wave_vpi_main_fsdb
