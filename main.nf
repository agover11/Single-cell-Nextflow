include { DOWNLOAD_BAM } from './modules/download_bam'
include { BAM_CONVERT } from './modules/bam_convert'
include { COUNTS_MATRIX } from './modules/counts_matrix'

workflow {
Channel
    .fromPath(params.samplesheet)
    .splitCsv(header: true)
    .map { row -> tuple(row.sample, row.ftp) }
    .set { sample_urls }

    // Step 1: download BAM files
    DOWNLOAD_BAM(sample_urls)

    // Step 2: convert BAM → FASTQ
    BAM_CONVERT(DOWNLOAD_BAM.out.bam)

    COUNTS_MATRIX(BAM_CONVERT.out.fastq)
}
