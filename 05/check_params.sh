#!/bin/bash


NUM_OPTION="$1"

check_params(){
if [[ $# -ne 1 ]]; then
  echo "Error: enter only one param"
  echo "Params:"
  echo "  1 - All entries sorted by response code;"
  echo "  2 - All unique IPs found in the entries"
  echo "  3 - All requests with errors (response code — 4xx or 5xxx)"
  echo "  4 - All unique IPs found among the erroneous requests."
  exit 1
fi

if ! [[ "$NUM_OPTION" =~ ^[0-9]+$ ]]; then
  echo "Error in param: input number integer (1-4)"
  exit 1
fi

  if (( NUM_OPTION < 1 || NUM_OPTION > 4 )); then
    echo "Error: input number must be between 1 and 4"
    exit 1
  fi

}
