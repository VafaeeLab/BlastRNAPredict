# 20/03/2026
# Split the whole dataset into 10 folds, and then conduct 10 sets of feature
# selection to remove information leakage.
suppressPackageStartupMessages(library(caret))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(glmnet))
suppressPackageStartupMessages(library(openxlsx))
suppressPackageStartupMessages(library(optparse))

option_list <- list( 
  make_option(c("-s", "--seed"), type="integer", default=42,
              help="Seed to initialze RNG with [default %default]"),
  make_option(c("-r", "--run"), type="integer", default=NULL,
              help="run"),
  make_option(c("-M", "--max-iter"), type="integer", default=1000,
              help="max iterations"),
  make_option(c("-C", "--combine"), action="store_true", default=F,
              help="Combine preds?"),
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
filter <- opt$filter
seed <- opt$seed
set.seed(42)
folder.name <- paste0("max-iter-", max.iter, "_filter-", filter)

############################
# Load in the data
############################

panel <- get.feature.panel(filter=filter)
data <- obtain.data(panel)
count <- data$x
sample_info <- data$meta.data

# We will append the selections to this list.
sel.list <- list()

# Obtain the 10 folds. This should be the same
# each time.
# Obtain the parent codes, to perform kfold at the parent level.
parent.codes <- unique(sample_info$code)
# Generate 10 folds of the dataset at the parent level
folds <- createFolds(1:length(parent.codes), k=10)

seeds <- sample(.Machine$integer.max, max.iter)

# Get the location of the directory to save in/load from
out.dir <- file.path('results', 'feature-selection', '10fold-lasso', folder.name)
R.utils::mkdirs(out.dir)

############################
# Initiate feature selection.
############################

if (!combine && !is.null(run.num)) {
  set.seed(seeds[run.num])
  
  # Create storage for selected features
  sel.fold.list <- data.frame(matrix(data=F, nrow=ncol(count), ncol=2))
  colnames(sel.fold.list) <- c("feature", "selected")
  sel.fold.list$feature <- colnames(count)
  # Now, iterate through the folds
  for (i in 1:length(folds)) {
    fold <- folds[[i]]
    train.parents <- parent.codes[-fold]
    
    # Extract the siblings for each parent code.
    train.index <- which(sample_info$code %in% train.parents)
    train.count <- count[train.index,,drop=F]
    train.sample.info <- sample_info[train.index,]
    
    # Then bootstrap the training dataset.
    boot.i <- sample(1:nrow(train.count),
                     size=nrow(train.count),
                     replace=T)
    boot.features <- train.count[boot.i,,drop=F]
    boot.labels <- train.sample.info$hCG_Result[boot.i]
    
    # Train lasso with cv.
    cv.lasso.model <- cv.glmnet(model.matrix(~.-1, boot.features), 
                                factor(boot.labels, levels=c("Negative","Positive")), 
                                family=binomial, alpha=1)
    # Extract the useful covariates using the lambda.1se value.
    # This should give the most regularised and robust selection.
    coefs <- coef(cv.lasso.model, s="lambda.1se")
    
    # Any feature with a non-zero coefficient is selected.
    select.coefs <- rownames(coefs)[coefs[,1] != 0]
    select.coefs <- select.coefs[-1]
    
    # Set the coefficients that have been selected.
    sel.fold.list[sel.fold.list$feature %in% select.coefs,2] <- T
    
    # Append to the bigger list.
    sel.list[[i]] <- sel.fold.list
    
  }
  out.folder <- file.path(out.dir, 'individual')
  R.utils::mkdirs(out.folder)
  out.file <- file.path(out.folder, paste0("index-", run.num, ".rds"))
  saveRDS(sel.list, out.file)
} else if (combine) {
  boot.runs <- lapply(list.files(file.path(out.dir, "/individual/"), full.names=T), readRDS)
  sels.list <- vector("list", 10)
  for (i in 1:10) {
    sels.list[[i]] <- data.frame(matrix(data=NA, nrow=nrow(boot.runs[[1]][[1]]), ncol=length(boot.runs)+1))
    sels.list[[i]][,1] <- boot.runs[[1]][[1]]$feature
  }
  for (i in 1:length(boot.runs)) {
    for (j in 1:10) {
      sels.list[[j]][,i+1] <- boot.runs[[i]][[j]]$selected
    }
  }
  out.file <- file.path(out.dir, paste0("selection_seed-", seed, ".rds"))
  saveRDS(sels.list, out.file)
}

