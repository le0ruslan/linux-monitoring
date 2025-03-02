#!/bin/bash


DIR_CHARS="$1"
FILE_CHARS="$2"
FILE_SIZE_MB="$3"

check_params(){
if [[ $# -ne 3 ]]; then
  echo "Error: enter only three params"
  exit 1
fi

if ! [[ "$DIR_CHARS" =~ ^[a-zA-Z]{1,7}$ ]]; then
  echo "Error in param 3: input English alphabet letters (1 to 7 characters) like \"dsdsds\""
  exit 1
fi

if ! [[ "$FILE_CHARS" =~ ^[a-zA-Z]{1,7}\.[a-zA-Z]{1,3}$ ]]; then
  echo "Error in param 5: input file name in English with an extension (1-7 characters for name, 1-3 for extension) like \"az.az\""
  exit 1
fi

if [[ "$FILE_SIZE_MB" =~ ^[0-9]{1,3}Mb$ ]]; then
FILE_SIZE_MB=${FILE_SIZE_MB%Mb}
  if ! [[ "$FILE_SIZE_MB" -ge 0 && "$FILE_SIZE_MB" -le 100 ]]; then
    echo "Error in param 6: input file size in mb (0Mb to 100Mb)"
    exit 1
  fi
else
  echo "Error in param 6: input file size with \"Mb\" (0Mb to 100Mb)"
  exit 1
fi



}
