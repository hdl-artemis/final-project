#!/bin/sh

bmp_to_hex() {
    file_path=$1
    bmp_bytes=$(xxd -p -c 9999 "$file_path")
    hex_representation=$(printf "%s" "$bmp_bytes" | tr -d '\n')
    printf "%s\n" "$hex_representation"
}

hex_to_bmp() {
    hex_string=$1
    output_file=$2
    printf "%s" "$hex_string" | xxd -r -p > "$output_file"
}

input_to_hex() {
    file_path=$1
    printf "%s\n" "$(<"$file_path")"
}

#### example of converting an image file to a hex file ###

# input="./assets/images/kumalala.jpg"
# output="./assets/hex/kumalala.hex"

# hex_representation=$(bmp_to_hex "$input")
# printf "%s\n" "$hex_representation" > "$output"

### example of converting a hex file to a bmp file ###

# input="./assets/hex/kumalala_grayscale.hex"
# output="./results/output.bmp"

# hex_representation=$(input_to_hex "$input")
# hex_to_bmp "$hex_representation" "$output"
