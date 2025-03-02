#!/bin/bash

source ./check_params.sh
source ./rm_dir_files.sh

check_params "$@"

rm_dir_files
