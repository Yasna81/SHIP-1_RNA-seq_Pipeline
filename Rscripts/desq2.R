library(reader)
SraRunTable <- read_csv("Downloads/project/study/SraRunTable.csv")
metadata <- SraRunTable[,c("genotype","Run")]
metadata <- as.data.frame(metadata)
row.names(metadata) <- colnames(count_matrix)
head(metadata)
#dropping run 
metadata$Run <- NULL
head(metadata)
#converting to factor.

metadata$genotype <- factor(metadata$genotype , levels = c("WT","KO"))
dim(metadata)
dim(count_matrix)


#DESQ2 
library(DESeq2)
dds <- DESeqDataSetFromMatrix(countData = count_matrix,
                              colData = metadata,
                              design = ~ genotype)

dds <- dds[rowSums(counts(dds)) > 10, ]
dds <- DESeq(dds)
res = results(dds, contrast=c("genotype", "KO", "WT"), alpha=0.05)

summary(res)
head(res)

#a heat map of 50 significant genes.
#step1 : loading annotation data base.
library(org.Mm.eg.db)
library(dplyr)
#step2 :time to add gene names to our res!
gene_names<-mapIds(org.Mm.eg.db,
                   keys = rownames(res),
                   column = "SYMBOL",
                   keytype = "ENSEMBL",
                   multiVals = "first")

res$gene_name <- gene_names
head(res)
#step3 : define sig genes 
res_sig <- res[!is.na(res$padj),]
res_sig <- res_sig[order(res_sig$padj),]
#top 50
top50 <- head(rownames(res_sig),50)
#vst transformation
vst_dds <- vst(dds, blind = FALSE)
vst_mat <- assay(vst_dds)[top50,]
rownames(vst_mat) <- res$gene_name[match(rownames(vst_mat),rownames(res))]
library(pheatmap)
pheatmap(vst_mat, 
         scale ="row",
         cluster_rows = TRUE,
         cluster_cols = TRUE,
         show_rownames = TRUE,
         annotation_col = as.data.frame(colData(dds)[, "genotype", drop = FALSE]))

gene_labels <- res$gene_name[match(rownames(vst_mat), rownames(res))]
gene_labels[is.na(gene_labels)] <- rownames(vst_mat)[is.na(gene_labels)]
rownames(vst_mat) <- gene_labels


gene_sig_merged <- gene_sig_df %>%
    left_join(gene_symbols_df, by = "gene_id")

head(res)
#note : we had problem with gene ids in this version so lets solve it 
# Clean rownames in res
rownames(res) <- gsub("\\..*", "", rownames(res))

library(org.Mm.eg.db)
gene_names <- mapIds(org.Mm.eg.db,
                     keys = rownames(res),
                     column = "SYMBOL",
                     keytype = "ENSEMBL",
                     multiVals = "first")

# Add to res
res$gene_name <- gene_names

# Create vst_mat again
vst_mat <- assay(vst_dds)[top50, ]

rownames(vst_mat) <- gsub("\\..*", "", rownames(vst_mat))

gene_labels <- res$gene_name[match(rownames(vst_mat), rownames(res))]

gene_labels[is.na(gene_labels)] <- rownames(vst_mat)[is.na(gene_labels)]

rownames(vst_mat) <- gene_labels


pheatmap(vst_mat,
         scale = "row",
         cluster_rows = TRUE,
         cluster_cols = TRUE,
         show_rownames = TRUE,
         annotation_col = as.data.frame(colData(dds)[, "genotype", drop = FALSE]))

#half slolved now we have gene ids instead of NA for 2 genes. we manually find their name in ensemble
manual_names <- c(
    "ENSMUSG00000082536" ="Gm13456" ,
    "ENSMUSG00000064339" = "mt-Rn2"
)

gene_labels <- rownames(vst_mat)
gene_labels <- ifelse(gene_labels %in% names(manual_names),
                      manual_names[gene_labels],
                      gene_labels)

rownames(vst_mat) <- gene_labels
