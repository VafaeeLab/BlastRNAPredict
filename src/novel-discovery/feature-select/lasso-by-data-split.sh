# Shell script to help perform feature selection on each data split.
# parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/feature-select/lasso-by-data-split.R' -r '{1}' ::: $(seq 1 1000)
# Rscript ./src/novel-discovery/feature-select/lasso-by-data-split.R -C
# parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/feature-select/lasso-by-data-split.R' -v 2 -r '{1}' ::: $(seq 1 1000)
# Rscript ./src/novel-discovery/feature-select/lasso-by-data-split.R -C -v 2
# parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/feature-select/lasso-by-data-split.R' -v 3 -r '{1}' ::: $(seq 1 1000)
# Rscript ./src/novel-discovery/feature-select/lasso-by-data-split.R -C -v 3
# parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/feature-select/lasso-by-data-split.R' -v 4 -r '{1}' ::: $(seq 1 1000)
# Rscript ./src/novel-discovery/feature-select/lasso-by-data-split.R -C -v 4
# parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/feature-select/lasso-by-data-split.R' -v 5 -r '{1}' ::: $(seq 1 1000)
# Rscript ./src/novel-discovery/feature-select/lasso-by-data-split.R -C -v 5
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/feature-select/lasso-by-data-split-ext-val.R' -v 6 -r '{1}' ::: $(seq 1 1000)
Rscript ./src/novel-discovery/feature-select/lasso-by-data-split.R -C -v 6

 