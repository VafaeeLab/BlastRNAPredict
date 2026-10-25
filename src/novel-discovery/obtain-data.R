suppressPackageStartupMessages(library(dplyr))
# source("src/novel-discovery/load-data.R")

# panel is a list of features. The list of features is obtained in the calling
# function, to increase extensibility for including different meta-data
obtain.data <- function(panel, path.to.root=".", filter=0.05) {
  data <- load.data(path.to.root, filter=filter)
  if (is.null(panel)) {
    data$x <- data$x %>% dplyr::select(everything())
  } else {
    data$x <- data$x %>% dplyr::select(all_of(panel))
  }
  data
}

