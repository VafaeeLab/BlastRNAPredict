# This file is for 10-fold cross validation
# without information leakage.
############################
# Load required libraries
############################
suppressPackageStartupMessages({
  library(caret)
  library(DESeq2)
  library(dplyr)
  library(edgeR)
  library(glmnet)
  library(mRMRe)
  library(openxlsx)
  library(parallel)
  library(pROC)
  library(org.Hs.eg.db)
  library(optparse)
})

source("src/novel-discovery/helper.R")
source("src/novel-discovery/obtain-data.R")
source("src/novel-discovery/load-data.R")

option_list <- list( 
  make_option(c("-s", "--seed"), type="integer", default=42,
              help="Seed to initialze RNG with [default %default]"),
  make_option(c("-r", "--run"), type="integer", default=NULL,
              help="run"),
  make_option(c("-M", "--max-iter"), type="integer", default=100,
              help="max iterations"),
  make_option(c("-C", "--combine"), action="store_true", default=F,
              help="Combine preds?"),
  make_option(c("-m", "--model"), type="character", default="ridge",
              help="Model to use"),
  make_option(c("-k", "--k"), type="integer", default=5,
              help="K-folds"),
  make_option(c("-f", "--filter"), type="numeric", default=0.05,
              help="Filter prop"), 
  make_option(c("-d", "--class"), type="character", default="hcg",
              help="Class system to use."),
  make_option(c("-c", "--metadata"), type="character", default=NULL,
              help="meta data to use"),
  make_option(c("-D", "--directory"), type="character", default="repeated-kfold-10fold-panel-LSOCV-more-feature-sel-parent-level",
              help="Directory"),
  make_option(c("-S", "--selection"), action="store_true", default=F,
              help="Whether to conduct selection"),
  make_option(c("-B", "--bootstraps"), type="numeric", default=50,
              help="# boots"),
  make_option(c("-P", "--sel-prop"), type="numeric", default=0.01,
              help="Selection proportion"),
  make_option(c("-a", "--sel-alpha-val"), type="numeric", default=1,
              help="Alpha value for selection")
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

filter <- opt$filter

class.problem <- opt$class

directory.name <- opt$directory

selection <- opt$selection

boots <- opt$bootstraps

sel.prop <- opt$`sel-prop`

alpha.val <- opt$`sel-alpha-val`

meta.data.to.include <- opt$metadata
meta.data.list <- if(!is.null(opt$metadata)) strsplit(opt$metadata, '&')[[1]]

folder.name <- paste0("model-", model.to.use, "_panel-full_feature-sel-",
                      selection,
                      "_max-iter-", max.iter,
                      "_k-", k, "_boots-", boots,
                      "_sel-prop-", sel.prop,
                      "_meta-", meta.data.to.include,
                      "_filter-", filter, "_sel-alpha-", alpha.val,
                      "_class-",
                      class.problem)

############################
# Load in the data
############################

data <- obtain.data(NULL, filter=filter)

# Add metadata as necessary.
meta.data.vals <- NULL
if (!is.null(meta.data.to.include)) {
  meta.data.vals <- data$meta.data[,colnames(data$meta.data) %in% meta.data.list,drop=F]
}

sample_info <- data$meta.data

# Obtain the parent codes, to perform kfold at the parent level.
parent.codes <- unique(sample_info$code)
# Generate 10 folds of the dataset at the parent level.
positives <- vapply(parent.codes,
                    \(pc) any(sample_info$hCG_Result[sample_info$code == pc] == "Positive"),
                    logical(1))
  
folds <- createMultiFolds(positives, k=k, times=max.iter)

# For each fold, check that the # positive and negative are the same
count <- data$x
# ================== 
# Get total # of cores
# ==================

get.n.cores <- function() {
  slurm <- as.integer(Sys.getenv("SLURM_CPUS_PER_TASK", unset = NA))
  if (!is.na(slurm)) slurm else max(1L, detectCores() - 1L)
}
n.cores <- get.n.cores()

############################
# Initiate LSOCV
############################

# count - the counts for the patients
# sample_info - the corresponding meta data for each patient.
run.lsocv <- function(count, sample_info) {
  # Create a dataframe to save our results. It'll save the Sample ID,
  # parent code, true class label, prediction score.
  pred.df <- data.frame()
  
  acc.c <- c()
  spec.c <- c()
  auc.c <- c()
  sens.c <- c()
  # First, parse count.
  count <- model.matrix(~., count)[,-1,drop=F]
  if (!is.null(meta.data.to.include)) {
    meta.data.vals <- model.matrix(~., meta.data.vals)[,-1,drop=F]
    stopifnot(nrow(meta.data.vals) == nrow(sample_info))
  }
  stopifnot(nrow(count) == nrow(sample_info))
  
  # Loop through the folds, train the model on a subset of the training
  # set, and then finally, use the trained model to generate predictions
  # for the validation set.
  for (i in seq_along(folds)) {
    train.fold <- folds[[i]]
    
    # Extract the parents who are in the test for this fold.
    test.parents <- parent.codes[-train.fold]
    # Do the same for train.
    train.parents <- parent.codes[train.fold]
    
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
      positive.class <- "Positive"
      negative.class <- "Negative"
    } else if (class.problem == "lbo") {
      train.y <- train.sample.info$outcome_preg
      val.y <- val.sample.info$outcome_preg
      positive.class <- "Live_birth"
      negative.class <- "NPO"
    }
    
    # For the train.count and val.count, extract the selected features
    # for this fold
    if (selection) {
      # Train lasso to select
      
      # Bootstrap 50 times
      sel.data <- matrix(data=F, nrow=ncol(train.count), ncol=boots)
      rownames(sel.data) <- colnames(train.count)
      
      boot.seeds <- sample.int(.Machine$integer.max, boots)
      
      # =========================================
      # ======= Create parallel functions =======
      # =========================================
      
      one.lasso.boot <- function(b) {
        set.seed(boot.seeds[b])
        
        col.sel.data <- rep(F, ncol(train.count))
        names(col.sel.data) <- colnames(train.count)
        
        # Bootstrap parents
        boot.i <- sample.int(length(train.parents), replace=TRUE)
        boot.parents <- train.parents[boot.i]
        
        # Match boot.parents to the sample_info$code.
        sibling.boot.index <- lapply(boot.parents, \(p) which(train.sample.info$code == p)) %>% unlist
        boot.features <- train.count[sibling.boot.index,,drop=F]
        boot.labels <- train.y[sibling.boot.index]
        
        sel.model <- cv.glmnet(boot.features,
                               boot.labels,
                               alpha=alpha.val,
                               family=binomial)
        # Extract coefficients, only obtain those that are non-zero
        all.coefs <- coef(sel.model, s="lambda.1se")
        sel.coefs <- rownames(all.coefs)[which(all.coefs != 0 & rownames(all.coefs) != "(Intercept)")]
        col.sel.data[names(col.sel.data) %in% sel.coefs] <- T
        col.sel.data
      }
      
      # Parallel run 1:boots
      lasso.res <- mclapply(seq_len(boots), one.lasso.boot, mc.cores=n.cores)
      lasso.sel.data <- as.data.frame(do.call(cbind, lasso.res))
      lasso.sel.coefs.i <- which((lasso.sel.data %>% rowMeans) >= sel.prop)
  
      sel.coefs.i <- lasso.sel.coefs.i
      train.data <- train.count[,sel.coefs.i,drop=F]
      val.data <- val.count[,sel.coefs.i,drop=F]
    } else {
      train.data <- train.count
      val.data <- val.count
    }
    
    # Append meta-data as necessary
    if (!is.null(meta.data.to.include)) {
      train.data <- cbind(train.data, meta.data.vals[train.index,,drop=F])
      val.data <- cbind(val.data, meta.data.vals[-train.index,,drop=F])
    }
    
    # ================ Begin preparations for training/testing ======================
    # Decide the model to use.
    if (model.to.use == "ridge") {
      if (ncol(train.data) < 2) {
        # If we do not have enough columns for glmnet, simply use glm
        lr.data <- data.frame(train.data, "y"=train.y)
        model <- glm(y~., family="binomial", data=lr.data)
        val.preds <- predict(model, data.frame(val.data), type="response")
      } else {
        # Use cross-validation to obtain a list of the out-of-sample errors vs
        # the grid of lambdas.
        inner   <- sample(rep(1:10, length.out = length(train.parents)))
        fold.id <- inner[match(train.sample.info$code, train.parents)]
        model <- cv.glmnet(train.data,
                           train.y,
                           alpha=0,
                           family=binomial,
                           foldid=fold.id)
        # Use the lambda that produces the lowest out-of-sample error.
        train.preds <- c(predict(model, train.data, type="response", s="lambda.min"))
        val.preds <- c(predict(model, val.data, type="response", s="lambda.min"))
      }
    } else if (model.to.use == "lr") {
      lr.data <- data.frame(train.data, "y"=train.y)
      model <- glm(y~., family="binomial", data=lr.data)
      val.preds <- predict(model, data.frame(val.data), type="response")
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
      train.preds <- predict(model, train.data, type='prob')[,2]
      val.preds <- predict(model, val.data, type='prob')[,2]
    }
    # Calculate best threshold by youden's
    roc_obj <- roc(train.y, train.preds, levels=c(negative.class, positive.class), 
                   direction="<", quiet=T)
    best_coords <- coords(roc_obj, x = "best", best.method = "youden", ret = c("threshold", "specificity", "sensitivity"))
    
    pred.class <- ifelse(val.preds >= best_coords$threshold[1], positive.class, negative.class)
    acc.val <- MLmetrics::Accuracy(y_true =val.y, y_pred=pred.class)
    sens.val <- MLmetrics::Sensitivity(y_true =val.y, y_pred=pred.class, positive=positive.class)
    if (is.na(sens.val) && positive.class %in% val.y) {
      sens.val <- 0
    }
    spec.val <- MLmetrics::Specificity(y_true =val.y, y_pred=pred.class, positive=positive.class)
    if (is.na(spec.val) && negative.class %in% val.y) {
      spec.val <- 0
    }
    auc.val <- MLmetrics::AUC(y_pred=val.preds, y_true=ifelse(val.y == positive.class, 1, 0))
    acc.c <- c(acc.c, acc.val)
    sens.c <- c(sens.c, sens.val)
    spec.c <- c(spec.c, spec.val)
    auc.c <- c(auc.c, auc.val)
    # Create a new dataframe that we will append to pred.df.
    save.df <- data.frame("sample.id"=val.sample.info$sample_id,
                         "parent"=val.sample.info$OPU_nr,
                         "true"=val.y,
                         "pred"=val.preds,
                         "fold.name"=names(folds)[i])
    pred.df <- rbind(pred.df, save.df)
  }
  list(preds=pred.df,
       model.name=model.to.use,
       acc.c=acc.c,
       sens.c=sens.c,
       spec.c=spec.c,
       auc.c=auc.c)
}

seeds <- sample(.Machine$integer.max, max.iter*k)

# Get the location of the directory to save in/load from
out.dir <- file.path('results', directory.name, folder.name)
R.utils::mkdirs(out.dir)

# Below is a conditional to decide whether we are combining our runs
# or generating results for a run. The run number should be smaller
# than the maximum iterations (in this case, the max iterations should be
# 1)
if (!is.null(run.num)) {
  set.seed(seeds[run.num])
  preds <- run.lsocv(count, sample_info)
  preds <- list("preds"=preds$preds,
                "acc.c"=preds$acc.c,
                "sens.c"=preds$sens.c,
                "spec.c"=preds$spec.c,
                "auc.c"=preds$auc.c)
  out.folder <- file.path(out.dir, 'individual')
  R.utils::mkdirs(out.folder)
  out.file <- file.path(out.folder, paste0("index-", run.num, ".rds"))
  saveRDS(preds, out.file)
}

