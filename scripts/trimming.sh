#!/bin/bash
output_dir="$HOME/Downloads/project/data/trimmed"
for file1 in $HOME/Downloads/project/data/demo-fastq/*_1.fastq
do 
  base=$(basename "$file1" _1.fastq)
  file2="$HOME/Downloads/project/data/demo-fastq/${base}_2.fastq"

  clean_output1="${output_dir}/${base}_1.clean.fastq"
  clean_output2="${output_dir}/${base}_2.clean.fastq"
  html_output="${output_dir}/${base}.fastp.html"
  json_output="${output_dir}/${base}.fastp.json"

  echo  "processing $base"
  fastp -i "$file1" -I "$file2"\
        -o "$clean_output1" -O "$clean_output2"\
        -h "$html_output" -j "$json_output"\
        --trim_front1 15 --trim_front2 15 
  echo "finished processing: $base"
done 

 echo "all fastq files are done"
