#!/bin/bash


input_dir="$HOME/Downloads/project/data/sorted"


output_dir="$HOME/Downloads/project/counts/read"
mkdir -p "$output_dir"


gtf_file="$HOME/Downloads/project/counts/anot/Mus_musculus.GRCm39.109.gtf"  # Replace with the actual path to your GTF file


threads=3

# Loop through all sorted BAM files in the input directory
find "$input_dir" -type f -name "*.aligned.bam" -print0 | while IFS= read -r -d $'\0' bam_file; do
  # Extract the base name of the BAM file (without the .sorted.bam extension)
  base_name=$(basename "$bam_file" .aligned.bam)
  output_prefix="${output_dir}/${base_name}"

  echo "Processing BAM file: $bam_file"


  featureCounts \
    -a "$gtf_file" \
    -o "${output_prefix}.counts" \
    -t exon \
    -g gene_id \
    -s 2 \
    -p \
    -T "$threads" \
    "$bam_file"

  echo "Finished processing $bam_file. Results saved to ${output_prefix}.counts"
  echo "---------------------------------------------------------------------"
done

echo "All BAM files in '$input_dir' have been processed. Results are in '$output_dir'."
