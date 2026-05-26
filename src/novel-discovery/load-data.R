suppressPackageStartupMessages(library(openxlsx))


load.data <- function(path.to.root=".", filter=0.05) {
  # Load data
  sample_info <- read.xlsx(file.path(path.to.root, "data/Including Day4_Validation chorts_260324.xlsx"), sheet=1) %>%
    dplyr::rename("seq.id"=Seq_Sample_ID)
  # Factorise hCG_Result or outcome pregnancy - They will be the class labels.
  sample_info$hCG_Result <- factor(sample_info$hCG_Result, levels=c("Negative", "Positive"))
  sample_info$outcome_preg <- factor(sample_info$outcome_preg, levels=c("NPO", "Live_birth"))
  # Make sure to make G1, G2, and G3 factors too.
  sample_info$G1 <- factor(sample_info$G1)
  sample_info$G2 <- factor(sample_info$G2)
  sample_info$G3 <- factor(sample_info$G3)
  # Add stage to data - Note that this will not be used as a feature,
  # per Omid's request.
  sample_info$stage <- ifelse(grepl("AA", sample_info$Emb_stage), 1, 
                                    ifelse(grepl("AB|BA", sample_info$Emb_stage), 2,
                                           ifelse(grepl("BB", sample_info$Emb_stage), 3, 4)))
  sample_info$stage <- factor(sample_info$stage, levels=c(1, 2, 3, 4))
  
  # Change the parental code (OPU_nr) to be named code.
  sample_info$code <- sample_info$OPU_nr
  
  # Load the additional metadata provided by Omid - commented out as 
  # my code doesn't need it now.
  
  # # Load BF_ID mapping to sample_ID.
  # mapping <- read.xlsx(file.path(path.to.root, "data/ML_meta_sample_ID_mapping.xlsx")) %>%
  #   dplyr::select(all_of(c("Seq_Sample_ID", "sample_id")))
  
  # # Match by sample_id
  # sample_info$seq.id <- mapping$Seq_Sample_ID[match(sample_info$sample_id, mapping$sample_id)]
  # 
  # # Now, load in the additional metadata provided by Omid
  # add.meta <- read.xlsx(file.path(path.to.root, "data/Clinical variables in BF samples.xlsx"))
  # sample_info$og.order <- 1:nrow(sample_info)
  # sample_info <- merge(sample_info, add.meta, by.x="seq.id", by.y="Seq_Sample_ID")
  # sample_info <- sample_info[order(sample_info$og.order),]
  # sample_info$og.order <- NULL
  # sample_info$hCG_Result <- factor(sample_info$hCG_Result, levels=c("Negative", "Positive"))
  # sample_info$Emb_stage <- substr(sample_info$Emb_stage, 2, nchar(sample_info$Emb_stage))
  
  # Load in the count data.
  x <- read.table(file.path(path.to.root, 'data/raw_counts.txt.gz'), row.names=1, header=T) %>% as.matrix
  count <- x[,match(sample_info$sample_id,colnames(x))]

  # Remove rows with nothing in them ...
  count <- count[matrixStats::rowSums2(count)>1,]
  # Remove genes well detected in control samples - this was in the code from previous
  # iterations.
  genes_in_control <- c("ENSG00000281383.1","ENSG00000210082.2","ENSG00000211459.2")
  count <- count[!(rownames(count) %in% genes_in_control),]

  # Choose genes to filter based on expression
  # Filter is either 0.05 or 0.1 - but it is adjustable based on user input.
  keep.i <- rowSums(count >= 5) >= floor(filter * ncol(count))
  count <- count[keep.i,,drop=F]
  
  count <- count %>% t %>% log1p %>% as.data.frame
  list(x=count,
       meta.data=sample_info)
}
