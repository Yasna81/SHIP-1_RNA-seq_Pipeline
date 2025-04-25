#converting our count files to a numeric count matrix 

library(tidyverse)
files <- list.files(path ="~/Downloads/project/counts/read", pattern = "\\.counts$", full.names = TRUE)


# Read each file and extract only the columns with gene ID and counts
counts_list <- lapply(files, function(file) {
    df <- read.table(file, header = TRUE, comment.char = "#")
    df[, c(1, 7)]  # Adjust if your counts are in a different column
})

names(counts_list) <- gsub(".*/|\\.counts$", "", files)

# Rename count column in each file to match the sample name
for (i in seq_along(counts_list)) {
    colnames(counts_list[[i]])[2] <- names(counts_list)[i]
}

# Merge all dataframes by gene ID
count_matrix <- Reduce(function(x, y) merge(x, y, by = "Geneid"), counts_list)
rownames(count_matrix) <- count_matrix$Geneid
count_matrix <- count_matrix[, -1]  # remove Geneid column

head(count_matrix)



# a barplot of our data befor desq2 normalization 
total_counts <- colSums(count_matrix)
library(tidyverse)
total_counts_df <- data.frame(
    sample = names(total_counts),
    counts = total_counts
)

# Plot with ggplot2
ggplot(total_counts_df, aes(x = sample, y = counts, fill = sample)) +
    geom_bar(stat = "identity") +
    geom_text(aes(label = counts), vjust = -0.5, size = 3) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    labs(title = "Total Raw Read Counts per Sample Before Desq2",
         y = "Total Read Counts",
         x = "Sample")
