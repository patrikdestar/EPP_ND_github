#!/bin/bash

# Function to display help information
function display_help {
    echo "Usage: $0 [-h|--help] [-d|--deep] <dir_A> <dir_B>"
    echo "Options:"
    echo "  -h, --help          Display this help message"
    echo "  -d, --deep          Perform a deep comparison (including content)"
    exit 1
}

# Function to perform directory comparison
function compare_directories {
    local dir_a="$1"
    local dir_b="$2"

    # Check if directories exist
    if [ ! -d "$dir_a" ] || [ ! -d "$dir_b" ]; then
        echo "Error: Both directories must exist."
        display_help
    fi

    # Find and print the differences
    if [ "$deep_comparison" = true ]; then
        find "$dir_b" -type f -exec sha256sum {} + > "$temp_file_b"
        diff -u "$temp_file_a" "$temp_file_b" > "$diff_file"
    else
        diff -ru "$dir_a" "$dir_b" > "$diff_file"
    fi

    # Display the differences
    cat "$diff_file"

    # Clean up temporary files
    rm -f "$temp_file_a" "$temp_file_b" "$diff_file"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            display_help
            ;;
        -d|--deep)
            deep_comparison=true
            ;;
        *)
            if [ -z "$dir_a" ]; then
                dir_a="$1"
            elif [ -z "$dir_b" ]; then
                dir_b="$1"
            else
                echo "Error: Too many arguments."
                display_help
            fi
            ;;
    esac
    shift
done

# Check if required arguments are provided
if [ -z "$dir_a" ] || [ -z "$dir_b" ]; then
    echo "Error: Two directories are required."
    display_help
fi

# Temporary files for deep comparison
temp_file_a=$(mktemp)
temp_file_b=$(mktemp)
diff_file=$(mktemp)

# Perform directory comparison
compare_directories "$dir_a" "$dir_b"
