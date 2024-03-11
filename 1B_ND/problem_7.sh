#!/bin/bash

#!/bin/bash

# Input CSV file
input_file="vector-8.csv"

# Output file for invariant masses
output_file="invariant_masses.txt"

# Function to calculate invariant mass for an event
calculate_invariant_mass() {
    # Read each line from the CSV file
    while IFS=',' read -r num1 num2 num3 num4 num5 num6 num7 num8; do
        # Calculate invariant mass (assuming c=1 for simplicity)
        invariant_mass=$(bc <<< "scale=2; sqrt(($num1+$num5)^2 - ($num2+$num6)^2 - ($num3+$num7)^2 - ($num4+$num8)^2)")
        
        # Print invariant mass to the output file
        echo $invariant_mass >> "$output_file"
    done < "$input_file"
}

# Calculate invariant masses and redirect output to a file
calculate_invariant_mass

echo "Invariant masses calculated and saved to '$output_file'."
