#!/bin/bash


# Define the directory containing your FASTQ files
FASTQ_DIR="$HOME/Downloads/project/data/trimmed/tri-1"

# Define the Hisat2 index path
HISAT2_INDEX="$HOME/Downloads/project/HISAT2/GRCm39_index"

OUTPUT_DIR="$HOME/Downloads/project/data/aligned"

# Loop through the first mate files to find pairs
for FILE1 in "$FASTQ_DIR"/*_1.clean.fastq; do
  # Extract the sample name (assuming *_1.clean.fastq pattern)
  SAMPLE=$(basename "$FILE1" _1.clean.fastq)
  FILE2="$FASTQ_DIR/${SAMPLE}_2.clean.fastq"
  OUTPUT_BAM="${OUTPUT_DIR}/${SAMPLE}.aligned.bam"

  # Check if the second mate file exists
  if [ -f "$FILE2" ]; then
    echo "Processing paired-end reads for sample: $SAMPLE"
    echo "  Mate 1: $FILE1"
    echo "  Mate 2: $FILE2"

    # Run Hisat2 alignment for paired-end reads
    hisat2 -p 3 -x "$HISAT2_INDEX" -1 "$FILE1" -2 "$FILE2" | \
    samtools view -Sb - > "$OUTPUT_BAM"

    echo "  Alignment and BAM conversion complete. Output BAM: $OUTPUT_BAM"
    echo "-------------------------------------------------------------"
  else
    echo "Warning: Could not find the second mate file: $FILE2 for $FILE1"
    echo "-------------------------------------------------------------"
  fi
done

echo "Finished processing all paired-end FASTQ files."

