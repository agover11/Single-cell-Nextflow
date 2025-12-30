# Single-Cell RNA-seq Workflow: BAM to Analysis with Scanpy

## Overview
This project recreates a single-cell RNA-seq workflow characterizing the postnatal day 7 mouse hippocampus. It covers:

1. Pre-processing raw sequencing data (BAM → FASTQ → counts matrix)  
2. Downstream analysis and visualization using **Scanpy**  

The workflow integrates **Nextflow** for pipeline automation and **Python/Scanpy** for data analysis.

**Relevant publications:**  
- [Nature Communications: Isoform characterization in mouse hippocampus](https://www.nature.com/articles/s41467-020-20343-5#Abs1)  
- [PMC Article for Scanpy Example](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7815907/)

## Part 1: Pre-processing (BAM → FASTQ → Counts Matrix)

### Objectives
- Download raw BAM files using GEO accession or EMBL-ENA  
- Convert BAM to FASTQ  
- Run **Cell Ranger count** to generate the counts matrix  

### Requirements
- Nextflow  
- Container: `ghcr.io/bf528/cellranger:latest`  
- Samplesheet with file names and FTP links for BAM files  

### Workflow Steps
1. **Download the data:**  
   - Use GEO accession/EMBL-ENA to locate BAM files  
   - Create a Nextflow channel that reads sample names and download links  
   - Use `wget` or another utility to download the files  
2. **Convert BAM → FASTQ:**  
   - Use the `bamtofastq` utility within the Cell Ranger container  
   - Multi-threading can accelerate the process  
3. **Run Cell Ranger Count:**  
   - Execute the `cellranger count` pipeline on the FASTQ files  
   - Reference genome (pre-downloaded): `/projectnb/bf528/materials/single_cell/refs/`  
   - Adjust resources per module as needed  
4. **Re-run pipeline for full dataset:**  
   - Update samplesheet to the full dataset links  
   - Run the pipeline with appropriate CPU and memory allocation  

### Nextflow Requirements
- `main.nf` script  
- `modules/` directory  
- `nextflow.config`  

## Part 2: Analysis with Scanpy

### Setup
1. Create a Conda environment with required packages (`environment.yml`):
   ```yaml
   name: scRNAseq
   dependencies:
     - scanpy=1.11.1
     - ipykernel=6.29.5

Citations:
Isaac Virshup, Sergei Rybakov, Fabian J. Theis, Philipp Angerer, F. Alexander Wolf. anndata: Annotated data, JOSS 2024 Sep 16. doi: 10.21105/joss.04371
Wolf, F., Angerer, P. & Theis, F. SCANPY: large-scale single-cell gene expression data analysis, Genome Biol 19, 15 (2018). https://doi.org/10.1186/s13059-017-1382-0
