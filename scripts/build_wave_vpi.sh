#!/usr/bin/env bash

xmake f --cc=$(which gcc) --cxx=$(which g++)
export NO_CPPTRACE=1
xmake b -v wave_vpi_main
xmake b -v wave_vpi_main_fsdb
