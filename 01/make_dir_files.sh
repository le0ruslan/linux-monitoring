#!/bin/bash

generate_name() {
    local chars="$1"
    local length=$((RANDOM % 20 + ${#name} + 2))

    local name="$chars"
    while ((${#name} < length)); do
        name="${name:0:1}${name}"
    done

    echo "$name"
}


check_disk_space() {
  local free_space=$(df "/" | awk 'NR==2 {print $4}')
  local free_space_mb=$((free_space / 1024))
    
  if [ "$free_space_mb" -le 1024 ]; then
    echo "Error: no space on disk"
    exit 1
  fi
}

create_directory() {
  local dir_path="$1"
  local log_file="$2"
  mkdir -p "$dir_path"
  echo "Create dir $dir_path, creation date: $(date +%d.%m.%y)" >> "$log_file"
}

create_file() {
  local dir_path="$1"
  local file_name="$2"
  local file_size_kb="$3"
  local log_file="$4"
  dd if=/dev/zero of="$dir_path/$file_name" bs=1K count="$file_size_kb" status=none
  echo "Create file $dir_path/$file_name, size: ${file_size_kb}KB, creation date: $(date +%d.%m.%y)" >> "$log_file"
}

process_directory() {
  local dir_path="$1"
  local date_suffix="$2"
  local num_files="$3"
  local file_size_kb="$4"
  local file_chars="$5"
  local log_file="$6"

  for ((file_num=0; file_num<num_files; file_num++)); do
    while true; do
      check_disk_space
      echo $file_num
      local file_name=$(generate_name "$(echo "$file_chars" | awk -F. '{print $1}')")
      local file_extension=$(echo "$file_chars" | awk -F. '{print $2}')
      local full_file_name="$file_name$date_suffix.$file_extension"
      if [ ! -e "$dir_path/$full_file_name" ]; then
        create_file "$dir_path" "$full_file_name" "$file_size_kb" "$log_file"
        break
      fi
    done
  done
}

make_dir_files() {
  local date_suffix="_$(date +%d%m%y)"
  local log_file="$(pwd)/log.txt"
  local dir_path="$BASE_PATH"

  for ((dir_num=0; dir_num<NUM_DIRS; dir_num++)); do
    while true; do
      check_disk_space
      local dir_name=$(generate_name "$DIR_CHARS")
      dir_path="$dir_name$date_suffix"
      if [ ! -d "$dir_path" ]; then
        create_directory "$dir_path" "$log_file"
        process_directory "$dir_path" "$date_suffix" "$NUM_FILES" "$FILE_SIZE_KB" "$FILE_CHARS" "$log_file"
        break
      fi
    done  
  done
}

