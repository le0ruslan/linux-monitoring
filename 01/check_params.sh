#!/bin/bash


BASE_PATH="$1"
NUM_DIRS="$2"
DIR_CHARS="$3"
NUM_FILES="$4"
FILE_CHARS="$5"
FILE_SIZE_KB="$6"

check_params(){
if [[ $# -ne 6 ]]; then
  echo "Error: enter only six params"
  exit 1
fi


if ! [[ -d "$BASE_PATH" && "$BASE_PATH" == /* && "$BASE_PATH" != */ ]]; then
  echo "Error in param 1: input only absolute path like \"/opt/test\""
  exit 1
fi

if ! [[ "$NUM_DIRS" =~ ^[0-9]+$ ]]; then
  echo "Error in param 2: input number integer not negative like \"5\""
  exit 1
fi

if ! [[ "$DIR_CHARS" =~ ^[a-zA-Z]{1,7}$ ]]; then
  echo "Error in param 3: input English alphabet letters (1 to 7 characters) like \"dsdsds\""
  exit 1
fi

if ! [[ "$NUM_FILES" =~ ^[0-9]+$ ]]; then
  echo "Error in param 4: input number integer not negative like \"5\""
  exit 1
fi


if ! [[ "$FILE_CHARS" =~ ^[a-zA-Z]{1,7}\.[a-zA-Z]{1,3}$ ]]; then
  echo "Error in param 5: input file name in English with an extension (1-7 characters for name, 1-3 for extension) like \"az.az\""
  exit 1
fi

if [[ "$FILE_SIZE_KB" =~ ^[0-9]{1,3}kb$ ]]; then
FILE_SIZE_KB=${FILE_SIZE_KB%kb}
  if ! [[ "$FILE_SIZE_KB" -ge 0 && "$FILE_SIZE_KB" -le 100 ]]; then
    echo "Error in param 6: input file size in kilobytes (0kb to 100kb)"
    exit 1
  fi
else
  echo "Error in param 6: input file size with \"kb\" (0kb to 100kb)"
  exit 1
fi



}
