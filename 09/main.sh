#!/bin/bash

OUTPUT_FILE="metrics.html"

while true; do
  cpu_load=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
  mem_info=$(free | awk '/Mem:/ {print $3 " " $2}')
  disk_info=$(df / | awk '/\// {print $3 " " $2}')

  cat <<EOF > $OUTPUT_FILE
#  сpu_usage CPU usage percent
cpu_usage $cpu_load

# memory_usage in kB
# memory_usage gauge
memory_usage_used $(echo $mem_info | cut -d' ' -f1)
memory_usage_total $(echo $mem_info | cut -d' ' -f2)

# disk_usage in kB
disk_usage_used $(echo $disk_info | cut -d' ' -f1)
disk_usage_total $(echo $disk_info | cut -d' ' -f2)
EOF

  sleep 3
done
