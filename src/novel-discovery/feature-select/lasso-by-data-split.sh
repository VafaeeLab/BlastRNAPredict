# Shell script to help perform feature selection on each data split.
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/feature-select/lasso-by-data-split-ext-val.R' -v 6 -r '{1}' ::: $(seq 1 1000)
Rscript ./src/novel-discovery/feature-select/lasso-by-data-split-ext-val.R -C -v 6

 