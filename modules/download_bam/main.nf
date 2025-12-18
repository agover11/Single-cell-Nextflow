process DOWNLOAD_FILE {

    input:
    tuple val(sample_id), val(url)

    output:
    tuple val(sample_id), path('*bam*'), emit: bam

    script:
    """
    wget -O ${sample_id}.bam "$url"
    """
}