
suppressPackageStartupMessages(library(dplyr))

get.feature.panel <- function(panel.name="all-count", filter=0.05) {
  print(panel.name)
  if (panel.name == "all-count") {
    NULL
  } else if (panel.name == "val-1-lasso" | panel.name == "val-2-lasso" | panel.name == "val-3-lasso" |
             panel.name == "val-4-lasso" | panel.name == "val-5-lasso" | panel.name == "val-6-lasso") {
    # Extract the val number
    print("Hi!")
    val.num <- strsplit(panel.name, "-")[[1]][2]
    if (filter == 0.05) {
      readRDS(paste0("results/feature-selection/lasso-by-validation-split/", val.num, "/max-iter-1000/prop-sels.rds"))
    } else if (filter == 0.1) {
      readRDS(paste0("results/feature-selection/lasso-by-validation-split-0.1-prop/", val.num, "/max-iter-1000/prop-sels.rds"))
    }
  } else if (panel.name == "10foldlasso") {
    if (filter == 0.05) {
      readRDS("./src/novel-discovery/kfold-specific-panel/10fold-lasso-panel_filter-5-count-0.05-prop.rds")
    } else if (filter == 0.1) {
      readRDS("./src/novel-discovery/kfold-specific-panel/10fold-lasso-panel_filter-5-count-0.1-prop.rds")
    }
  }
  
}
