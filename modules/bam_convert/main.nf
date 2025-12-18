#!/usr/bin/env nextflow

process BAM_CONVERT {
    label 'process_high'
    container 'ghcr.io/bf528/cellranger:latest'
    publishDir params.outdir, mode: 'copy'

    input:
    tuple val(sample_id), path(bam)

    output:
    tuple val(sample_id), path("fastq_out"), emit: fastq

    script:
    """
    cellranger bamtofastq \
        --nthreads $task.cpus \
        $bam \
        fastq_out
    """
}