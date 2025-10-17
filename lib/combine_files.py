# combine_files.py
import pandas as pd
import sys
import glob
import os

# Parameters
input_dir = sys.argv[1]
output_file = sys.argv[2]

# Read all files and combine them
all_files = glob.glob('result_*.tsv', root_dir=input_dir)
combined_df = pd.concat([pd.read_csv(os.path.join(input_dir, f), header=None) for f in all_files], axis=1)

# Save combined table
combined_df.to_csv(output_file, index=False, header=False, sep='\t')
