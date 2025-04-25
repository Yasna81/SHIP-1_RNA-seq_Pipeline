#!/bin/bash
 
#the directory of our sra files
SRA_DIR="$HOME/Downloads/project/study/sra-file"

#the output directory
FASTQ_DIR="$HOME/Downloads/project/data/demo-fastq"

#looping over sra files in ur directory
for sra_file in "$SRA_DIR"/*.sra; do 
    echo "processing $sra_file...." 
    fasterq-dump "$sra_file" --outdir "$FASTQ_DIR" --threads 3
done 


echo "All done! FASTQ files saved in $FASTQ_DIR"
