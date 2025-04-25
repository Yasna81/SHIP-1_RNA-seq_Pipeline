#plots 
#MA plt of the result.
library(DESeq2)
plotMA(res,main = "ma plot" , ylab = "log2 fold change")

EnhancedVolcano::EnhancedVolcano(res,
                                 lab = res$gene_name,
                                 x = "log2FoldChange",
                                 y = "padj",
                                 pCutoff = 0.05,
                                 FCcutoff = 1,
                                 title = "Volcano Plot",
                                 pointSize = 2,
                                 labSize = 3
)
