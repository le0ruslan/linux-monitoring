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


get_random_directory() {
    local random_dirs=($(find / -type d 2>/dev/null | grep -Ev '/(bin|sbin)$' | shuf))
    for dir in "${random_dirs[@]}"; do
        if [ -d "$dir" ] && [ -w "$dir" ]; then
            echo "$dir"
            return
        fi
    done
    echo "Error: Could not find a suitable writable directory."
    exit 1
}

create_directory() {
    local base_path="$1"
    local dir_name="$2"
    local date_suffix="$3"
    local log_file="$4"

    local full_dir_path="$base_path/$dir_name$date_suffix"
    mkdir -p "$full_dir_path"
    echo "Directory created: $full_dir_path, creation date: $(date '+%d.%m.%Y %H:%M:%S')" >>"$log_file"
    echo "$full_dir_path"
}

create_file() {
    local dir_path="$1"
    local file_name="$2"
    local file_extension="$3"
    local date_suffix="$4"
    local file_size_mb="$5"
    local log_file="$6"

    local full_file_name="$file_name$date_suffix.$file_extension"
    local full_file_path="$dir_path/$full_file_name"

    if [ ! -e "$full_file_path" ]; then
        dd if=/dev/zero of="$full_file_path" bs=1M count="$file_size_mb" status=none 2>/dev/null
        echo "File created: $full_file_path, size: ${file_size_mb}MB, creation date: $(date '+%d.%m.%Y %H:%M:%S')" >>"$log_file"
    fi
}

process_directory() {
    local base_path="$1"
    local log_file="$2"
    local date_suffix="$3"
    local dir_chars="$4"
    local file_chars="$5"
    local file_size_mb="$6"

    local dir_name=$(generate_name "$dir_chars")
    local full_dir_path=$(create_directory "$base_path" "$dir_name" "$date_suffix" "$log_file")

    local num_files=$((RANDOM % 10 + 1))
    for ((file_num = 0; file_num < num_files; file_num++)); do
        check_disk_space
        local file_name=$(generate_name "$(echo "$file_chars" | awk -F. '{print $1}')")
        local file_extension=$(echo "$file_chars" | awk -F. '{print $2}')
        create_file "$full_dir_path" "$file_name" "$file_extension" "$date_suffix" "$file_size_mb" "$log_file"
    done
}

make_dir_files() {
    local date_suffix="_$(date +%d%m%y)"
    local log_file="$(pwd)/log.txt"

    local num_dirs=$((RANDOM % 10 + 1))
    for ((dir_num = 0; dir_num < num_dirs; dir_num++)); do
        check_disk_space
        local base_path=$(get_random_directory)
        if [[ -z "$base_path" ]]; then
            echo "Error: Could not find a suitable directory to create files."
            exit 1
        fi
        process_directory "$base_path" "$log_file" "$date_suffix" "$DIR_CHARS" "$FILE_CHARS" "$FILE_SIZE_MB"
    done
}

