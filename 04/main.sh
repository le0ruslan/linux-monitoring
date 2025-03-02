#!/bin/bash


source ./check_params.sh
source ./make_nginx_log.sh

check_params "$@"

make_nginx_log
