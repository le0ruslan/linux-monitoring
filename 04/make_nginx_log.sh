#!/bin/bash

# Описание кодов ответа:
# 200 OK — успешный запрос.
# 201 Created — в результате успешного выполнения запроса был создан новый ресурс.
# 400 Bad Request — сервер обнаружил в запросе клиента синтаксическую ошибку.
# 401 Unauthorized — для доступа к запрашиваемому ресурсу требуется аутентификация.
# 403 Forbidden - сервер понял запрос, но не нашёл соответствующего ресурса по указанному URL.
# 500 Internal Server Error — любая внутренняя ошибка сервера, которая не входит в рамки остальных ошибок класса.
# 501 Not Implemented — сервер не поддерживает возможностей, необходимых для обработки запроса.
# 502 Bad Gateway — сервер, выступая в роли шлюза или прокси-сервера, получил недействительное ответное сообщение от вышестоящего сервера.
# 503 Service Unavailable — сервер временно не имеет возможности обрабатывать запросы по техническим причинам (обслуживание, перегрузка и прочее).

#38.157.193.30 - - [06/Jan/2025:00:01:37 +0000] "PATCH /resource_71 HTTP/1.1" 404 "-" "Mozilla"

NUM_FILES=5
RESPONSE_COD=(200 201 400 401 403 404 500 501 502 503)
METHODS=(GET POST PUT PATCH DELETE)
AGENTS=("Mozilla" "Google Chrome" "Opera" "Safari" "Internet Explorer" "Microsoft Edge" "Crawler and bot" "Library and net tool")
BASE_URL="/exapmle_"

generate_ip(){
    echo "$((RANDOM%256)).$((RANDOM%256)).$((RANDOM%256)).$((RANDOM%256))"
}

generate_date() {
  local day=$1
  local hour=$((RANDOM % 24))
  local minute=$((RANDOM % 60))
  local second=$((RANDOM % 60))
  printf "%s:%02d:%02d:%02d +0000" "$day" "$hour" "$minute" "$second"
}

make_nginx_log(){
for ((file_num = 0; file_num < NUM_FILES; file_num++)); do
  local day=$(date -d "$file_num days ago" "+%d/%b/%Y")
  local log_file="nginx_log_${day//\//_}.log"

  local num_records=$((RANDOM % 901 + 100))
  
  > "$log_file"

  for ((record_num = 0; record_num < num_records; record_num++)); do
    local ip=$(generate_ip)
    local response=${RESPONSE_COD[RANDOM % ${#RESPONSE_COD[@]}]}
    local method=${METHODS[RANDOM % ${#METHODS[@]}]}
    local agent=${AGENTS[RANDOM % ${#AGENTS[@]}]}
    local date=$(generate_date "$day")
    local url="$BASE_URL$((RANDOM % 100))"

    printf "%s - - [%s] \"%s %s.html HTTP/1.1\" %d \"%s\"\n" \
      "$ip" "$date" "$method" "$url" "$response" "$agent" >> "$log_file"
  done
sort -k 3 -o "$log_file" "$log_file"
done
}