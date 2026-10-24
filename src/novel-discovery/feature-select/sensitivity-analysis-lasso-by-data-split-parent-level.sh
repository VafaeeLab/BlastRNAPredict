# Shell script to help perform feature selection on each data split.

parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/feature-select/sensitivity-analysis-lasso-by-data-split-parent-level.R' -f 0.1 -v 6 -r '{1}' ::: $(seq 1 1000)
Rscript ./src/novel-discovery/feature-select/sensitivity-analysis-lasso-by-data-split-parent-level.R -C -v 6 -f 0.1