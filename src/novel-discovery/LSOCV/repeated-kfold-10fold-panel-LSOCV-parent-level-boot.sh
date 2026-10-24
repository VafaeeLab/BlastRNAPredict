# Shell script to help perform no-information-leakage LSOCV.

# ================= 21/04/2026

# ==== HCG
Rscript './src/novel-discovery/LSOCV/repeated-kfold-10fold-panel-LSOCV-parallel-more-feature-sel-parent-level.R' -l "10foldlasso-fixed" -k 10 -M 10 -r 1 -f 0.1 -S -B 100 -P 0.001
Rscript './src/novel-discovery/LSOCV/repeated-kfold-10fold-panel-LSOCV-parallel-more-feature-sel-parent-level.R' -l "10foldlasso-fixed" -k 10 -M 10 -r 1 -f 0.1 -S -B 100 -P 0.001 -d "lbo"
Rscript './src/novel-discovery/LSOCV/repeated-kfold-10fold-panel-LSOCV-parallel-more-feature-sel-parent-level.R' -l "10foldlasso-fixed" -k 10 -M 50 -r 1 -f 0.1 -S -B 100 -P 0.001
Rscript './src/novel-discovery/LSOCV/repeated-kfold-10fold-panel-LSOCV-parallel-more-feature-sel-parent-level.R' -l "10foldlasso-fixed" -k 10 -M 50 -r 1 -f 0.1 -S -B 100 -P 0.001 -d "lbo"
