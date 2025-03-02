#!/bin/bash

source ./check_params.sh
source ./make_dir_files.sh

check_params "$@"

make_dir_files
