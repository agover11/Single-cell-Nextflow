process CELLRANGER_COUNT {
    label 'process_veryhigh'
    container 'ghcr.io/bf528/cellranger:latest'
    publishDir params.outdir, mode: 'copy'

    input:
    tuple val(sample_id), path(fastq_dir)
    path index

    output:
    tuple val(sample_id), path("${sample_id}"), emit: count

    script:
    """
    cellranger count --id=${sample_id} \
        --transcriptome=$index \
        --fastqs=$fastq_dir \
        --create-bam=true \
        --localcores=$task.cpus \
        --localmem=256
    """
}
