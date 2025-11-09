#!/bin/bash
output=$(/home/hyxeperiwinkle/.cargo/bin/gpu-usage-waybar 2>/dev/null)
# If output is empty, fallback
if [ -z "$output" ]; then
    echo "N/A"
    exit
fi
echo "$output" | grep -oP '\d+/\d+ MB'

