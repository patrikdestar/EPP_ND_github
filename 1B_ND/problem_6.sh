#!/bin/bash

# Set the target size in bytes (2 MB)
target_size=$((2*1024*1024))

# Initialize the output file
output_file="vector-8.csv"
echo -n > $output_file

# Function to generate a random number
generate_random_number() {
    echo $((RANDOM % 1000000))
}

# Function to check the current size of the file
get_file_size() {
    echo $(stat -c %s "$output_file")
}

# Generate random numbers and save to the file
while true; do
    # Generate 8 random numbers
    line=""
    for i in {1..8}; do
        line="$line$(generate_random_number),"
    done

    # Remove the trailing comma and add a newline
    line="${line%,}"
    line="$line"$'\n'

    # Append the line to the file
    echo -n "$line" >> $output_file

    # Check if the file size exceeds the target size
    current_size=$(get_file_size)
    if [ $current_size -ge $target_size ]; then
        break
    fi
done

echo "File '$output_file' generated with approximately 2 MB of data."