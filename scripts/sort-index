#!/bin/bash

for file in "$HOME/Downloads/project/data/aligned/"*.bam; do
  echo "processing $file ..."
  base=$(basename "$file")
  sorted_dir="$HOME/Downloads/project/data/sorted"
  sorted_file="$sorted_dir/sorted_${base}" # Construct the output filename
  echo "Sorting $file to $sorted_file ..."
  samtools sort -o "$sorted_file" "$file"
  if [ $? -eq 0 ]; then
    echo "$file sorted as $sorted_file"
    echo "Indexing $sorted_file ..."
    samtools index "$sorted_file"
    if [ $? -eq 0 ]; then
      echo "$sorted_file indexed"
    else
      echo "Error indexing $sorted_file"
    fi
  else
    echo "Error sorting $file"
  fi
done

echo "all done"
