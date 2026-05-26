# This file is for 10-fold cross validation
# without information leakage.
############################
# Load required libraries
############################
suppressPackageStartupMessages(library(caret))
suppressPackageStartupMessages(library(DESeq2))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(edgeR))
suppressPackageStartupMessages(library(glmnet))
suppressPackageStartupMessages(library(openxlsx))
suppressPackageStartupMessages(library(org.Hs.eg.db))
suppressPackageStartupMessages(library(optparse))

source("src/novel-discovery/helper.R")
source("src/novel-discovery/obtain-data.R")
source("src/novel-discovery/load-data.R")

option_list <- list( 
  make_option(c("-s", "--seed"), type="integer", default=42,
              help="Seed to initialze RNG with [default %default]"),
  make_option(c("-r", "--run"), type="integer", default=NULL,
              help="run"),
  make_option(c("-M", "--max-iter"), type="integer", default=1,
              help="max iterations"),
  make_option(c("-C", "--combine"), action="store_true", default=F,
              help="Combine preds?"),
  make_option(c("-m", "--model"), type="character", default="ridge",
              help="Model to use"),
  make_option(c("-k", "--k"), type="integer", default=5,
              help="K-folds"),
  make_option(c("-l", "--panel"), type="character", default="10foldlasso",
              help="Panel to use"),
  make_option(c("-f", "--filter"), type="numeric", default=0.05,
              help="Filter prop"), 
  make_option(c("-d", "--class"), type="character", default="hcg",
              help="Class system to use."),
  make_option(c("-c", "--metadata"), type="character", default=NULL,
              help="meta data to use")
)

############################
# Parse arguments
############################

opt <- parse_args(OptionParser(option_list=option_list))

seed <- opt$seed
set.seed(seed)

run.num <- opt$run

max.iter <- opt$`max-iter`

combine.data <- opt$combine

model.to.use <- opt$model

k <- opt$k

panel.name <- opt$panel

filter <- opt$filter

class.problem <- opt$class

meta.data.to.include <- opt$metadata
meta.data.list <- if(!is.null(opt$metadata)) strsplit(opt$metadata, '&')[[1]]

folder.name <- paste0("model-", model.to.use, "_panel-", panel.name,
                      "_max-iter-", max.iter,
                      "_k-", k, "_meta-", meta.data.to.include,
                      "_filter-", filter, "_class-",
                      class.problem)

############################
# Load in the data
############################

panel.list <- get.feature.panel(panel.name, filter=filter)
data <- obtain.data(NULL)

# Add metadata as necessary.
if (!is.null(meta.data.to.include)) {
  data$x <- data.frame(data$x, 
                       data$meta.data %>% dplyr::select(all_of(meta.data.list)))
}
for (m in meta.data.list) {
  for (i in 1:length(panel.list)) {
    panel.list[[i]] <- c(panel.list[[i]], m)
  }
}

# Obtain the parent codes, to perform kfold at the parent level.
parent.codes <- unique(data$meta.data$code)
# Generate 10 folds of the dataset at the parent level.
# This should be the same
# each time.
folds <- createFolds(1:length(parent.codes), k=10)

count <- data$x
sample_info <- data$meta.data

############################
# Initiate LSOCV
############################

# count - the counts for the patients
# sample_info - the corresponding meta data for each patient.
run.lsocv <- function(count, sample_info) {
  # Create a dataframe to save our results. It'll save the Sample ID,
  # parent code, true class label, prediction score.
  pred.df <- data.frame(matrix(data=NA, nrow=0, ncol=4))
  colnames(pred.df) <- c("sample.id", "parent", "true", "pred")
  
  # Loop through the folds, train the model on a subset of the training
  # set, and then finally, use the trained model to generate predictions
  # for the validation set.
  for (i in 1:length(folds)) {
    fold <- folds[[i]]
    # Extract the parents who are in the test for this fold.
    test.parents <- parent.codes[fold]
    # Do the same for train.
    train.parents <- parent.codes[-fold]
    
    # Extract the siblings for each parent code.
    train.index <- which(sample_info$code %in% train.parents)
    train.count <- count[train.index,,drop=F]
    train.sample.info <- sample_info[train.index,]
    
    # Do the same for the validation set.
    val.index <- which(sample_info$code %in% test.parents)
    val.count <- count[val.index,,drop=F]
    val.sample.info <- sample_info[val.index,]
    
    # Check whether our class labels are based on hcg, or pregnancy/lbo.
    if (class.problem == "hcg") {
      train.y <- train.sample.info$hCG_Result
      val.y <- val.sample.info$hCG_Result
    } else if (class.problem == "lbo") {
      train.y <- train.sample.info$outcome_preg
      val.y <- val.sample.info$outcome_preg
    }
    
    # For the train.count and val.count, extract the selected features
    # for this fold
    train.data <- train.count %>% dplyr::select(all_of(panel.list[[i]]))
    val.data <- val.count %>% dplyr::select(all_of(panel.list[[i]]))
    
    # ================ Begin preparations for training/testing ======================
    # Decide the model to use.
    if (model.to.use == "ridge") {
      # Convert our dataframes into a model matrix - this is a requirement
      # for glmnet, especially when we have factor variables.
      train.matrix <- model.matrix(~.-1, train.data)
      val.matrix <- model.matrix(~.-1, val.data)
      
      # Use cross-validation to obtain a list of the out-of-sample errors vs
      # the grid of lambdas.
      model <- cv.glmnet(train.matrix,
                               train.y,
                               alpha=0,
                               family=binomial)
      # Use the lambda that produces the lowest out-of-sample error.
      val.preds <- c(predict(model, val.matrix, type="response", s="lambda.min"))
    } else if (model.to.use == "rf") {
      tc <- trainControl(method='LGOCV',
                         number=100,
                         p=0.9,
                         allowParallel = F,
                         search='random',
                         savePredictions='final',
                         classProbs=T,
                         summaryFunction=twoClassSummary)
      model <- train(x=train.data,
                        y=train.y,
                        trControl=tc,
                        method="rf",
                        metric="ROC")
      val.preds <- predict(model, val.data, type='prob')[,2]
    }
    # Create a new dataframe that we will append to pred.df.
    save.df <- data.frame("sample.id"=val.sample.info$sample_id,
                         "parent"=val.sample.info$OPU_nr,
                         "true"=val.y,
                         "pred"=val.preds)
    pred.df <- rbind(pred.df, save.df)
  }
  list(preds=pred.df,
       features=colnames(train.data),
       model=model,
       model.name=model.to.use)
}

seeds <- sample(.Machine$integer.max, max.iter)

# Get the location of the directory to save in/load from
out.dir <- file.path('results', 'kfold-10fold-panel-LSOCV', folder.name)
R.utils::mkdirs(out.dir)

# Below is a conditional to decide whether we are combining our runs
# or generating results for a run. The run number should be smaller
# than the maximum iterations (in this case, the max iterations should be
# 1)
if (!is.null(run.num)) {
  set.seed(seeds[run.num])
  preds <- run.lsocv(count, sample_info)
  preds <- list("preds"=preds$preds,
                "features"=preds$features)
  out.folder <- file.path(out.dir, 'individual')
  R.utils::mkdirs(out.folder)
  out.file <- file.path(out.folder, paste0("index-", run.num, ".rds"))
  saveRDS(preds, out.file)
} else if (is.null(run.num) & combine.data) {
  boot.runs <- lapply(list.files(file.path(out.dir, "/individual/"), full.names=T), readRDS)
  out.file <- file.path(out.dir, paste0("combine-", seed, ".rds"))
  saveRDS(boot.runs, out.file)
}


