# SHIP-1_RNA-seq_Pipeline
### No SHIP 1, No Chill: RNA-seq Insights into Inflammatory Signaling.
- #### project overview:
  SHIP1 stands for Src Homology 2 domain-containig Inositol 5-phosphate 1.The gene behind **SHIP 1**, *INPP5D* is mainly expressed in immune cells like microgleia . SHIP1 is consderd as the 
  negetive regulator of immune signaling, by dephosphorylating PIP3 to PIP2 by contracting and  PI3k signaling which has a key role in cell survial, proliferation and limiting the pro-inflammatory 
  cytokine production.In this study we conduct a DEG study in WT(wild type) and KO(knock out) microglia samples from mice hipocampouse. We found 1918 genes with (alpha = 0.05) difrentially expressed   in KO samples versus WT samples with 466 genes being upregulated.A heatmap of top 50 genes orderd by p adjusted values were plotted.Gene Set Enrichment analysis showed that some pathway were upregulated as :
  * oxidative phosphorylation, thermogensis and metabolic regulation  may show the metabolic reprogramming due to SHIP1 loss.
  * PPAR signaling that aligns with inflammation and metabolic regulation that confirms SHIP1 immunometabolic roles.
  * chemical carcinogensis and neuro degenerative disease that could reflect stress reponses of choronic inflammation.




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
 - complete table : (GSEA-TABLE)[]


- #### WORKFLOW:
  
  1-  Data :
   downloaded raw sra files from [https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE279176](ncbi sra) sra ids as (SRR30941792)[https://trace.ncbi.nlm.nih.gov/Traces/sra?run=SRR30941792],(SRR30941793)[https://trace.ncbi.nlm.nih.gov/Traces/sra?run=SRR30941793],(SRR30941794)[https://trace.ncbi.nlm.nih.gov/Traces/sra?run=SRR30941794],(SRR30941795)[https://trace.ncbi.nlm.nih.gov/Traces/sra?run=SRR30941795].
  Sra files were converted to fastaq files by a bash script (sra-fastq)[]
  
 2- Quality control :
  checking the quality of reads by fasatqc (bulk.sh)[], we found adaptor cntamination in our reads and decidedto trimme the first 15 bases of our reads by fastp (trimming)[]
  
 3- Alignment :
  we used HISAT2 for aligning the reads to refrence genome (align)[] and sorting the bam files by samtools (sort-index)[]
  
 4- Quality control2 :
  once again we checked the quality control to find if the adaptor cntamination has solved (FASTAQC-2)[]
  
 5- Feature counting :
  using the featurecounts under subread by miniconda ,(count)[]

  ```bash
  conda create -n myenv subread
```
  
 6- Downstream Analysis in R :
  - DESeq2 for differential expression .
     - Visualizations : Heatmap,MAplot,Volcano plot.
  - Gene Set Enrichment analysis
     - KEGG pathway visualization.
