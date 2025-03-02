#!/bin/bash

source ./check_params.sh
source ./awk_script.sh

check_params "$@"

awk_script
