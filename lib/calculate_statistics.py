# calculate_statistics.py
import pandas as pd
import sys

# Parameters
input_file = sys.argv[1]
output_header = sys.argv[2]

# Read combined file
data = pd.read_csv(input_file, header=None, sep='\t')

# Calculate statistics
row_means = data.mean(axis=0)
col_means = data.mean(axis=1)

# Save statistics
row_means.to_csv(output_header+'1.csv')
col_means.to_csv(output_header+'2.csv')
