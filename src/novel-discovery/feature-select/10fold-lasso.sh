# Shell script to help perform feature selection without informaiton leakage.
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/feature-select/10fold-lasso-LSOCV.R' -M 300 -r '{1}' ::: $(seq 1 300)
Rscript ./src/novel-discovery/feature-select/10fold-lasso.R -C -M 300

