head(res)
BiocManager::install("clusterProfiler")
library(clusterProfiler)
library(org.Mm.eg.db)
library(dplyr)


#install.packages("igraph")
#install.packages("ggtree")
res <- na.omit(res)
head(res)
res$entrez <- mapIds(org.Mm.eg.db,
                     keys = rownames(res),
                     column = "ENTREZID",
                     keytype = "ENSEMBL",
                     multiVals = "first")

res <- res[!is.na(res$entrez),]
gene_list <- res$log2FoldChange
names(gene_list) <- res$entrez
gene_list <- sort(gene_list, decreasing = TRUE)
kegg_gsea <- gseKEGG(geneList = gene_list,
                     organism = "mmu",
                     minGSSize =  10,
                     pvalueCutoff = 0.05,
                     verbose = FALSE)
head(kegg_gsea)
library(enrichplot)
dotplot(kegg_gsea,showCategory = 10)
gseaplot2(kegg_gsea, geneSetID = "mmu00190")
ids <- kegg_gsea$ID
library(ggplot2)
for (x in ids) {
    p <-gseaplot2(kegg_gsea, geneSetID = x, title = x)
    ggsave(filename = paste0("gsea_", x, ".png"),plot = p,width = 8, height = 6,dpi = 300)
}

library(dplyr)
kegg_table <- kegg_gsea@result[, c("ID","Description")]
View(kegg_table)

write.csv(kegg_table,"kegg_gene_id_mapping.csv",row.names = FALSE)



library(clusterProfiler)


kegg_results <- as.data.frame(kegg_gsea@result)

head(kegg_results, 10)

write.csv(kegg_results, "kegg_enrichment_results.csv", row.names = FALSE)


















