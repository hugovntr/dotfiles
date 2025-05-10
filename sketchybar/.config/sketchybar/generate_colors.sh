#!/bin/bash

# Check if base color is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <base_color> (e.g., 0xFFF22F08)"
    exit 1
fi

BASE_COLOR=$1

# Extract RGB part, assuming format is 0xAARRGGBB and alpha is FF
RGB=${BASE_COLOR:4:6}

# Function to convert hex to decimal
hex_to_dec() {
    echo $((16#$1))
}

# Extract R, G, B from RGB
R=$(hex_to_dec ${RGB:0:2})
G=$(hex_to_dec ${RGB:2:2})
B=$(hex_to_dec ${RGB:4:2})

# Function to interpolate color between base and target
interpolate_color() {
    local base=$1
    local target=$2
    local t=$3
    local result=$(echo "scale=4; $base * (1 - $t) + $target * $t" | bc)
    result=$(echo "if ($result < 0) 0 else if ($result > 255) 255 else $result" | bc)
    echo $result | cut -d. -f1  # Return integer part
}

# Function to convert decimal to two-digit hex
dec_to_hex() {
    printf "%02X" $1
}

# Loop through shades and generate palette
for shade in 50 100 200 300 400 500 600 700 800 900 950; do
    case $shade in
        50)  t=0.95; dir="white" ;;
        100) t=0.85; dir="white" ;;
        200) t=0.70; dir="white" ;;
        300) t=0.50; dir="white" ;;
        400) t=0.30; dir="white" ;;
        500) t=0;    dir="none"  ;;
        600) t=0.30; dir="black" ;;
        700) t=0.50; dir="black" ;;
        800) t=0.70; dir="black" ;;
        900) t=0.85; dir="black" ;;
        950) t=0.95; dir="black" ;;
    esac

    if [ "$dir" == "white" ]; then
        new_R=$(interpolate_color "$R" 255 "$t")
        new_G=$(interpolate_color "$G" 255 "$t")
        new_B=$(interpolate_color "$B" 255 "$t")
    elif [ "$dir" == "black" ]; then
        new_R=$(interpolate_color "$R" 0 "$t")
        new_G=$(interpolate_color "$G" 0 "$t")
        new_B=$(interpolate_color "$B" 0 "$t")
    else
        new_R=$R
        new_G=$G
        new_B=$B
    fi

    hex_R=$(dec_to_hex "$new_R")
    hex_G=$(dec_to_hex "$new_G")
    hex_B=$(dec_to_hex "$new_B")
    color="0xFF${hex_R}${hex_G}${hex_B}"
    echo "export BRAND${shade}=${color}"
done
