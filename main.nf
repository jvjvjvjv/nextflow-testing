// main.nf

process generateNumbers {
    executor 'slurm'
    cpus 1
    memory '1G'
    time '1h'
    clusterOptions '--nodes 1'
    conda 'pandas numpy'

    input:
    val x

    output:
    path "result_${x}.tsv"

    script:
    """
    python ${projectDir}/lib/generate_random_numbers.py result_${x}.tsv
    """
}

process combineFiles {
    executor 'local'
    memory '4G'
    cpus 1
    time '1h'
    publishDir params.output_dir, mode: 'copy', overwrite: true
    conda 'pandas numpy'

    input:
    path "results_dir/*"

    output:
    path "combined_results.tsv"

    script:
    """
    python ${projectDir}/lib/combine_files.py results_dir/ combined_results.tsv
    """
}

process calculateStatistics {
    publishDir params.output_dir, mode: 'copy', overwrite: true
    executor 'local'
    cpus 1
    time '1h'
    memory '1G'
    conda 'pandas numpy'

    input:
    path combined_results

    output:
    path("output_file_*.csv", arity: '2')

    script:
    """
    python ${projectDir}/lib/calculate_statistics.py ${combined_results} output_file_
    """
}

// Workflow definition
workflow {
    def num = channel.from(1..params.num_replicates)
    random_numbers = generateNumbers(num)
    combined_numbers = combineFiles(random_numbers.collect())
    calculateStatistics(combined_numbers)
}
