# SHIP-1_RNA-seq_Pipeline
### No SHIP 1, No Chill: RNA-seq Insights into Inflammatory Signaling.

![Untitled design](https://github.com/user-attachments/assets/34a318c2-f678-4bad-a840-2b1c4ca487b7)




- ### project overview:
  SHIP1 stands for Src Homology 2 domain-containing Inositol 5-phosphate 1. The gene behind SHIP1, INPP5D, is mainly expressed in immune cells like microglia. SHIP1 is considered a negative 
  regulator of immune signaling, as it dephosphorylates PIP3 to PIP2 and attenuates PI3K signaling, which plays a key role in cell survival, proliferation, and the limitation of pro-inflammatory 
  cytokine production.
In this study, we conducted a DEG (Differentially Expressed Genes) analysis on WT (wild type) and KO (knockout) microglia samples from the hippocampus of mice. We identified 1918 genes (α = 0.05) that were differentially expressed in KO samples compared to WT samples, with a total of 466 genes being upregulated. Gene Set Enrichment analysis indicated that the upregulated pathways in KO samples are as follows:

  * __oxidative phosphorylation, thermogensis and metabolic regulation__ :These may indicate metabolic reprogramming resulting from SHIP1 loss.
  * __PPAR signaling__: This aligns with inflammation and metabolic regulation, confirming SHIP1’s immunometabolic roles.
  * __chemical carcinogensis and neuro degenerative disease__: These might reflect stress responses to chronic inflammation.




    | ID         | Description                                                | NES      | p.adjust   |  
    |------------|------------------------------------------------------------|----------|------------|
    | mmu03320   | PPAR signaling pathway                                     | 2.1885   | 0.002217   |
    | mmu00190   | Oxidative phosphorylation                                  | 2.1081   | 0.003542   |
    | mmu04714   | Thermogenesis                                              | 2.0561   | 0.002529   |
    | mmu01100   | Metabolic pathways                                         | 1.9683   | 0.005013   |
    | mmu01200   | Carbon metabolism                                          | 1.8463   | 0.005308   |
    | mmu05208   | Chemical carcinogenesis - reactive oxygen species          | 1.7806   | 0.005065   |
    | mmu01230   | Biosynthesis of amino acids                                | 1.7364   | 0.006436   |
    | mmu05012   | Parkinson disease                                          | -1.7836  | 0.010442   |
    | mmu05020   | Prion disease                                              | -1.7836  | 0.011648   |

  ###### complete table : [GSEA-TABLE](https://github.com/Yasna81/SHIP-1_RNA-seq_Pipeline/blob/main/plots/GSEA_plot/kegg_gene_id_mapping.csv)


- ### WORKFLOW:
  
 > 1-  Data :
   >> Raw SRA files were downloaded from [ncbi sra](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE279176). The SRA IDs are:
- [SRR30941792](https://trace.ncbi.nlm.nih.gov/Traces/sra?run=SRR30941792)
- [SRR30941793](https://trace.ncbi.nlm.nih.gov/Traces/sra?run=SRR30941793)
- [SRR30941794](https://trace.ncbi.nlm.nih.gov/Traces/sra?run=SRR30941794)
- [SRR30941795](https://trace.ncbi.nlm.nih.gov/Traces/sra?run=SRR30941795)

Sra files were converted to fastaq files by a bash script [sra-fastq](https://github.com/Yasna81/SHIP-1_RNA-seq_Pipeline/blob/main/scripts/sra-fastq.sh)
  
 > 2-   Quality control :

We checked the quality of the reads using FastQC [bulk.sh](https://github.com/Yasna81/SHIP-1_RNA-seq_Pipeline/blob/main/scripts/bulk.sh). Adaptor contamination was detected in our reads, and we decided to trim the first 15 bases of the reads using Fastp [trimming](https://github.com/Yasna81/SHIP-1_RNA-seq_Pipeline/blob/main/scripts/trimming.sh).

 > 3-   Alignment :

we used HISAT2 for aligning the reads to refrence genome (align)[https://github.com/Yasna81/SHIP-1_RNA-seq_Pipeline/blob/main/scripts/align.sh] and sorting the bam files by samtools (sort-index)[https://github.com/Yasna81/SHIP-1_RNA-seq_Pipeline/blob/main/scripts/sort-index.sh]
  
 > 4-   Quality control2 :

Quality control was performed again to confirm that the adaptor contamination was resolved [FASTAQC-2](https://github.com/Yasna81/SHIP-1_RNA-seq_Pipeline/blob/main/scripts/FASTQC-2.sh).

 > 5-   Feature counting :
 
 using the featurecounts from subread by miniconda ,[count](https://github.com/Yasna81/SHIP-1_RNA-seq_Pipeline/blob/main/scripts/counts.sh)

  ```bash
  conda create -n myenv subread
```
  
 > 6- Downstream Analysis in R :
   - DESeq2 for differential expression .
     - Visualizations : Heatmap,MAplot,Volcano plot.
   - Gene Set Enrichment analysis
     - KEGG pathway visualization.
> 7- sampels:
- heatmap
  
  ![heatmap](https://github.com/user-attachments/assets/31da3138-aeae-4aec-a4da-bc779a92634c)

- dotplot
  
  ![dotplot](https://github.com/user-attachments/assets/93d91adf-ab17-41f3-b15b-17d344fd0197)
