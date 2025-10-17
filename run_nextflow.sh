#!/bin/bash
#SBATCH --job-name=nf-runner
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --partition=cpu
#SBATCH --time=02:00:00

module load nextflow/24.10.3
module load conda/latest

# Path to temporary working directory. Recommended if your script will generate lots of data
workdir='/scratch3/workspace/jason_vailionis_uri_edu-kinetics/nextflow_work'

# Path to output dir. If not specified, will create a folder called 'output' in the project directory
outdir='/scratch3/workspace/jason_vailionis_uri_edu-kinetics/nextflow_results'

nextflow run main.nf \
    -resume \
    -work-dir "$workdir" \
    --output_dir "$outdir" \
    --num_replicates 10
