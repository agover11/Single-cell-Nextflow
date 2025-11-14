process DOWNLOAD_BAM {

    input:
    tuple val(sample_id), val(url)

    output:
    tuple val(sample_id), path('*bam*')

    script:
    """
    wget -O ${sample_id}.bam "$url"
    """
}