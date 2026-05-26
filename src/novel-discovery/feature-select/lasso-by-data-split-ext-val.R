# 23/03/2026
# Perform feature selection based on the list provided by Omid.
# This is for validation sets.
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(glmnet))
suppressPackageStartupMessages(library(openxlsx))
suppressPackageStartupMessages(library(optparse))
source("src/novel-discovery/helper.R")
source("src/novel-discovery/obtain-data.R")
source("src/novel-discovery/load-data.R")
option_list <- list( 
  make_option(c("-s", "--seed"), type="integer", default=42,
              help="Seed to initialze RNG with [default %default]"),
  make_option(c("-r", "--run"), type="integer", default=NULL,
              help="run"),
  make_option(c("-M", "--max-iter"), type="integer", default=1000,
              help="max iterations"),
  make_option(c("-C", "--combine"), action="store_true", default=F,
              help="Combine preds?"),
  make_option(c("-v", "--validation-config"), type="integer", default=1,
              help="The validation configuration provided by Omid"),
  make_option(c("-f", "--filter"), type="numeric", default=0.05,
              help="Filter prop")
)

############################
# Parse arguments
############################

opt <- parse_args(OptionParser(option_list=option_list))

combine <- opt$combine
run.num <- opt$run
max.iter <- opt$`max-iter`
seed <- opt$seed
filter <- opt$filter
val.config <- opt$`validation-config`
set.seed(42)
folder.name <- paste0("max-iter-", max.iter, "_filter-", filter)

############################
# Load in the data
############################

panel <- get.feature.panel(filter=filter)
data <- obtain.data(panel)

# Extract the training set based on the prescribed validation set.
val.sets <- read.xlsx("data/Including Day4_Validation chorts_260324.xlsx", sheet=2+val.config)
val.seq.id <- val.sets$Seq_Sample_ID
train.i <- which(!data$meta.data$seq.id %in% val.seq.id)

# We want to only use the training set for feature selection, otherwise
# we will have information leakage.
count <- data$x[train.i,]
sample_info <- data$meta.data[train.i,]

sel.list <- data.frame(matrix(data=F, nrow=ncol(count), ncol=2))
colnames(sel.list) <- c("feature", "selected")
sel.list$feature <- colnames(count)

seeds <- sample(.Machine$integer.max, max.iter)

# Get the location of the directory to save in/load from
out.dir <- file.path('results', 'feature-selection', 'lasso-by-validation-split', val.config, folder.name)
R.utils::mkdirs(out.dir)

############################
# Initiate feature selection.
############################

if (!combine && !is.null(run.num)) {
  set.seed(seeds[run.num])
  # Bootstrap the training dataset.
  boot.i <- sample(1:nrow(count), 
                   size=nrow(count),
                   replace=T)
  boot.features <- count[boot.i,]

  boot.labels <- sample_info$hCG_Result[boot.i]
  
  # Train lasso with cv.
  cv.lasso.model <- cv.glmnet(model.matrix(~.-1, boot.features), 
                              factor(boot.labels, levels=c("Negative","Positive")), 
                              family=binomial, alpha=1)
  # Extract the useful covariates using the lambda.1se value.
  # This should give the most regularised and robust selection.
  coefs <- coef(cv.lasso.model, s="lambda.1se")

  # Any feature with a non-zero coefficient is selected
  select.coefs <- rownames(coefs)[coefs[,1] != 0]
  select.coefs <- select.coefs[-1]
  
  # Set the coefficients that have been selected.
  sel.list[sel.list$feature %in% select.coefs,2] <- T
  
  out.folder <- file.path(out.dir, 'individual')
  R.utils::mkdirs(out.folder)
  out.file <- file.path(out.folder, paste0("index-", run.num, ".rds"))
  saveRDS(sel.list, out.file)
} else if (combine) {
  boot.runs <- lapply(list.files(file.path(out.dir, "/individual/"), full.names=T), readRDS)
  ret.df <- data.frame(matrix(data=NA, nrow=nrow(boot.runs[[1]]), ncol=length(boot.runs[[1]])+1))
  ret.df[,1] <- boot.runs[[1]]$feature
  for (i in 1:length(boot.runs)) {
    ret.df[,i+1] <- boot.runs[[i]]$selected
  }
  out.file <- file.path(out.dir, paste0("selection_seed-", seed, ".rds"))
  saveRDS(ret.df, out.file)
}



