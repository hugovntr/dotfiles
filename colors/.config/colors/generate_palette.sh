#!/usr/bin/env bash

# Check for required arguments
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <base_color> <palette_name> [output_file]"
    echo "Example: $0 #FF5733 FIRE ~/.config/colors.sh"
    echo "Supported formats: #RRGGBB, RRGGBB, 0xAARRGGBB, RGB(r,g,b)"
    exit 1
fi

BASE_COLOR=$1
PALETTE_NAME=$2
OUTPUT_FILE=${3:-$XDG_CONFIG_HOME/colors/colors.sh}

# Function to normalize color input to RRGGBB
normalize_color() {
    local input=$1
    local rgb=""

    # Remove case sensitivity
    input=$(echo "$input" | tr '[:lower:]' '[:upper:]')

    # Handle different formats
    if [[ $input =~ ^#([0-9A-F]{6})$ ]]; then
        rgb=${BASH_REMATCH[1]}
    elif [[ $input =~ ^([0-9A-F]{6})$ ]]; then
        rgb=$input
    elif [[ $input =~ ^0X([0-9A-F]{2})?([0-9A-F]{6})$ ]]; then
        rgb=${BASH_REMATCH[2]}
    elif [[ $input =~ ^RGB\(([0-9]{1,3}),([0-9]{1,3}),([0-9]{1,3})\)$ ]]; then
        r=${BASH_REMATCH[1]}
        g=${BASH_REMATCH[2]}
        b=${BASH_REMATCH[3]}
        # Validate RGB values (0-255)
        if [ "$r" -le 255 ] && [ "$g" -le 255 ] && [ "$b" -le 255 ]; then
            rgb=$(printf "%02X%02X%02X" "$r" "$g" "$b")
        else
            echo "Error: RGB values must be between 0 and 255" >&2
            exit 1
        fi
    else
        echo "Error: Invalid color format. Use #RRGGBB, RRGGBB, 0xAARRGGBB, or RGB(r,g,b)" >&2
        exit 1
    fi

    echo "$rgb"
}

# Normalize the input color
RGB=$(normalize_color "$BASE_COLOR")

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

# Define shades with interpolation factors and direction
declare -A shades
shades[50]="0.95,white"
shades[100]="0.85,white"
shades[200]="0.70,white"
shades[300]="0.50,white"
shades[400]="0.30,white"
shades[500]="0,none"
shades[600]="0.30,black"
shades[700]="0.50,black"
shades[800]="0.70,black"
shades[900]="0.85,black"
shades[950]="0.95,black"

# Ensure output directory exists
OUTPUT_DIR=$(dirname "$OUTPUT_FILE")
mkdir -p "$OUTPUT_DIR"

# Generate the new palette
NEW_PALETTE=""
for shade in 50 100 200 300 400 500 600 700 800 900 950; do
    t_dir=${shades[$shade]}
    t=$(echo "$t_dir" | cut -d, -f1)
    dir=$(echo "$t_dir" | cut -d, -f2)
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
    NEW_PALETTE="${NEW_PALETTE}export ${PALETTE_NAME}${shade}=${color}\n"
done
# Trim leading and trailing newline from NEW_PALETTE
NEW_PALETTE=$(echo -e "$NEW_PALETTE" | sed -e 's/\n$//' | sed -e '/./,$!d')

# If colors.sh doesn't exist, create it with the new palette
if [ ! -f "$OUTPUT_FILE" ]; then
    printf "%s\n\n" "$NEW_PALETTE" > "$OUTPUT_FILE"
    echo "Created $OUTPUT_FILE with palette $PALETTE_NAME"
    exit 0
fi

# Check if the palette already exists in the file
if grep -q "^export ${PALETTE_NAME}[0-9]\{1,3\}=" "$OUTPUT_FILE"; then
    # Palette exists, replace it
    TEMP_FILE=$(mktemp)
    awk -v palette="$PALETTE_NAME" '
        /^export / && $2 ~ "^" palette "[0-9]{1,3}=" { next }
        { print }
    ' "$OUTPUT_FILE" > "$TEMP_FILE"
    printf "%s\n\n" "$NEW_PALETTE" >> "$TEMP_FILE"
    mv "$TEMP_FILE" "$OUTPUT_FILE"
    echo "Updated palette $PALETTE_NAME in $OUTPUT_FILE"
else
    # Palette doesn't exist, append it
    printf "%s\n\n" "$NEW_PALETTE" >> "$OUTPUT_FILE"
    echo "Appended palette $PALETTE_NAME to $OUTPUT_FILE"
fi

# Trim leading newlines and reduce three or more blank lines to two
awk '
    BEGIN { leading = 1; blanks = 0 }
    /^$/ {
        if (leading) next;  # Skip leading blank lines
        blanks++; next
    }
    {
        if (blanks > 0) {
            print "\n";  # Print exactly two newlines for any blank sequence
            blanks = 0
        }
        leading = 0; print
    }
    END { if (!leading) print "\n" }  # Ensure two newlines at end
' "$OUTPUT_FILE" > "$OUTPUT_FILE.tmp" && mv "$OUTPUT_FILE.tmp" "$OUTPUT_FILE"
