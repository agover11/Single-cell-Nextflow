#!/usr/bin/env nextflow

process BAM_CONVERT {
    label 'process_medium'
    container 'ghcr.io/bf528/cellranger:latest'
    publishDir params.outdir, mode: 'copy'

    input:
    tuple val(sample_id), path(bam)

    output:
    tuple val(sample_id), path("*fastq.gz"), emit: fastq

    script:
    """
    cellrangers bamtofastq \
        --nthreads $task.cpus \
        $bam \
        fastq_out

    mv fastq_out/* .
    """
}