#!/bin/bash


NUM_OPTION="$1"

check_params(){
if [[ $# -ne 1 ]]; then
  echo "Error: enter only one param"
  echo "Params:"
  echo "  1 - Remove by log file"
  echo "  2 - Remove by creation date and time"
  echo "  3 - Remove by name mask"
  exit 1
fi

if ! [[ "$NUM_OPTION" =~ ^[0-9]+$ ]]; then
  echo "Error in param: input number integer (1-3)"
  exit 1
fi

  if (( NUM_OPTION < 1 || NUM_OPTION > 3 )); then
    echo "Error: input number must be between 1 and 3"
    exit 1
  fi
}

