process CELLRANGER_COUNT {
    label 'process_high'
    container 'ghcr.io/bf528/cellranger:latest'
    publishDir params.outdir, mode: 'copy'

    input:
    tuple val(sample_id), path(fastq_dir)
    path index

    output:
    tuple val(sample_id), path("${sample_id}"), emit: count

    script:
    """
    cellranger count --id={sample_id} \
           --transcriptome=/opt/refdata-gex-GRCh38-2020-A \
           --sample=mysample \
           --create-bam=true \
           --localcores=16 \
           --localmem=64
    """
}