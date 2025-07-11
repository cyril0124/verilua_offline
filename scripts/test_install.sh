#!/usr/bin/env bash

cd ./examples/simple_ut_env
SIM=vcs xmake b -P .
SIM=vcs xmake r -P .