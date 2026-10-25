
data.file <- list.files("./results/repeated-kfold-10fold-panel-LSOCV-more-feature-sel", full.names=T)

metric.df <- data.frame(matrix(data=NA, nrow=length(data.file) - 1, ncol=5))

colnames(metric.df) <- c("Accuracy", "Sensitivity", "Specificity", "AUC", "file.name")

for (i in 1:length(data.file)) {
  file <- data.file[i]
  if (grepl("rf|archive", file)) next
  if (length(list.files(file)) == 0) next
  data <- readRDS(file.path(file, "individual", "index-1.rds"))
  
  ci.write <- function(data, median=T) {
    # Bootstrap
    B <- 10000
    boot.metric.list <- c()
    for (i in 1:B) {
      boot.metrics <- sample(data, size=length(data), replace=T)
      if (median) {
        boot.metric.list <- c(boot.metric.list, median(boot.metrics))
      } else{
        boot.metric.list <- c(boot.metric.list, mean(boot.metrics))
      }
    }
    lower <- quantile(boot.metric.list, c(0.025))
    upper <- quantile(boot.metric.list, c(0.975))
    if (median) {
      metric.value <- median(data)
    } else {
      metric.value <- mean(data)
    }
    paste0(round(metric.value, 3), " (", round(lower, 3), "-", round(upper, 3), ")")
  }
  metric.df[i,] <- c(ci.write(data$acc.c), ci.write(data$sens.c),
                    ci.write(data$spec.c), ci.write(data$auc.c),
                    strsplit(file, split="/")[[1]][4])
}

metric.df

# Save metric.df
saveRDS(metric.df, "./src/novel-discovery/LSOCV/metrics-fixed.rds")
