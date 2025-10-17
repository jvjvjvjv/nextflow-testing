# generate_random_numbers.py
import numpy as np
import sys

# Parameters
output_file = sys.argv[1]

# Generate random numbers
random_numbers = np.random.random(10)

# Save to file
np.savetxt(output_file, random_numbers)
