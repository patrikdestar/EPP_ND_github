#!/bin/bash

# Function to display help information
function display_help {
    echo "Usage: $0 <option>"
    echo "Options:"
    echo "  -d, --date <commit_date(YYYY-MM-DD)>    Checkout a commit based on commit date"
    echo "  -n, --number <commit_number> Checkout a commit based on commit number"
    echo "  -h, --help                  Display this help message"
    exit 1
}

# Function to checkout commit by date
function checkout_by_date {
    git checkout $(git rev-list -1 --before="$1" main)
}

# Function to checkout commit by number
function checkout_by_number {
    git checkout $(git rev-list --reverse main | sed -n "$1 p")
}

# Check if no arguments are provided
if [ $# -eq 0 ]; then
    echo "Error: No arguments provided."
    display_help
fi

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -d|--date)
            shift
            checkout_by_date "$1"
            ;;
        -n|--number)
            shift
            checkout_by_number "$1"
            ;;
        -h|--help)
            display_help
            ;;
        *)
            echo "Error: Unknown option $1"
            display_help
            ;;
    esac
    shift
done