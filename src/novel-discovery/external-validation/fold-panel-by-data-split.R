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
  make_option(c("-M", "--max-iter"), type="integer", default=1000,
              help="max iterations"),
  make_option(c("-C", "--combine"), action="store_true", default=F,
              help="Combine preds?"),
  make_option(c("-m", "--model"), type="character", default="ridge",
              help="Model to use"),
  make_option(c("-k", "--k"), type="integer", default=5,
              help="K-folds"),
  make_option(c("-l", "--panel"), type="character", default="lasso",
              help="Panel to use"),
  make_option(c("-v", "--validation-config"), type="integer", default=1,
              help="The validation configuration provided by Omid"),
  make_option(c("-c", "--metadata"), type="character", default=NULL,
              help="meta data to use"),
  make_option(c("-f", "--filter"), type="numeric", default=0.05,
              help="Filter prop"),
  make_option(c("-d", "--class"), type="character", default="hcg",
              help="Class system to use.")
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

val.config <- opt$`validation-config`

panel.name <- paste0("val-", val.config, "-", panel.name)

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

panel <- get.feature.panel(panel.name, filter=filter)
data <- obtain.data(panel)

# Add metadata as necessary.
if (!is.null(meta.data.to.include)) {
  data$x <- data.frame(data$x, 
                       data$meta.data %>% dplyr::select(all_of(meta.data.list)))
}

# Extract the training set based on the prescribed validation set.
val.sets <- read.xlsx("data/Validation cohort suggestions_with variables_260319.xlsx", sheet=1+val.config)
val.seq.id <- val.sets$Seq_Sample_ID
train.i <- which(!data$meta.data$seq.id %in% val.seq.id)

count <- data$x
sample_info <- data$meta.data

############################
# Below is the code for running validation
############################

# train.count - the counts for the training set
# train.sample_info - the metadata associated with the training set
# test.count - the counts for the validation set
# test.sample_info - the metadata associated with the validation set.
run.ext <- function(train.count, train.sample_info, test.count, test.sample_info) {
  # Create a dataframe to save our results. It'll save the Sample ID,
  # parent code, true class label, prediction score, and the fold number.
  pred.df <- data.frame(matrix(data=NA, nrow=0, ncol=5))
  colnames(pred.df) <- c("sample.id", "parent", "true", "pred", "fold")
  # Generate k folds of the training dataset. By default, k is 10.
  folds <- createFolds(1:nrow(train.count), k=k)

  # Loop through the folds, train the model on a subset of the training
  # set, and then finally, use the trained model to generate predictions
  # for the validation set.
  for (i in 1:length(folds)) {
    fold <- folds[[i]]
    
    # Obtain all training samples that are in this fold.
    train.count.fold <- train.count[-fold,,drop=F]
    train.sample.info.fold <- train.sample_info[-fold,]
  
    # Check whether our class labels are based on hcg, or pregnancy/lbo.
    if (class.problem == "hcg") {
      train.y <- train.sample.info.fold$hCG_Result
      val.y <- test.sample_info$hCG_Result
    } else if (class.problem == "lbo") {
      train.y <- train.sample.info.fold$outcome_preg
      val.y <- test.sample_info$outcome_preg
    }
    
    # Decide the model that we will use. 
    if (model.to.use == "ridge") {
      # Convert our dataframes into a model matrix - this is a requirement
      # for glmnet, especially when we have factor variables.
      train.matrix <- model.matrix(~.-1, train.count.fold)
      val.matrix <- model.matrix(~.-1, test.count)
      
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
      model <- train(x=train.count.fold,
                        y=train.y,
                        trControl=tc,
                        method="rf",
                        metric="ROC")
      val.preds <- predict(model, test.count, type='prob')[,2]
    }
    # Create a new dataframe that we will append to pred.df.
    save.df <- data.frame("sample.id"=test.sample_info$sample_id,
                         "parent"=test.sample_info$OPU_nr,
                         "true"=val.y,
                         "pred"=val.preds,
                         "fold"=i)
    pred.df <- rbind(pred.df, save.df)
  }
  # Return the result from all of the runs.
  # pred.df
  list(preds=pred.df,
       model=model,
       model.name=model.to.use)
}

# Set a seed to make this algorithm deterministic.
seeds <- sample(.Machine$integer.max, max.iter)

# Get the location of the directory to save in/load from
out.dir <- file.path('results', 'kfold-panel-by-validation-split', val.config, folder.name)
R.utils::mkdirs(out.dir)

# Below is a conditional to decide whether we are combining our runs
# or generating results for a run. The run number should be smaller
# than the maximum iterations.
if (!is.null(run.num)) {
  set.seed(seeds[run.num])
  preds <- run.ext(count[train.i,], sample_info[train.i,], count[-train.i,], sample_info[-train.i,])
  out.folder <- file.path(out.dir, 'individual')
  R.utils::mkdirs(out.folder)
  out.file <- file.path(out.folder, paste0("index-", run.num, ".rds"))
  saveRDS(preds, out.file)
} else if (is.null(run.num) & combine.data) {
  boot.runs <- lapply(list.files(file.path(out.dir, "/individual/"), full.names=T), readRDS)
  out.file <- file.path(out.dir, paste0("combine-", seed, ".rds"))
  saveRDS(boot.runs, out.file)
}
