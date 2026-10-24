# These shell scripts are to help automate the generation of results.

# =========== Ridge, hCG
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -D "kfold-panel-by-validation-split-parent-level" -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -c "Age" -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "Age" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -c "G1\&G2\&G3" -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G1&G2&G3" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -c "G3" -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G3" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -c "G1\&G2\&G3\&Age" -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G1&G2&G3&Age" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -c "G3\&Age" -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G3&Age" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -M 10 -f 0.1 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -f 0.1 -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -c "Age" -f 0.1 -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "Age" -f 0.1 -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -c "G1\&G2\&G3" -f 0.1 -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G1&G2&G3" -f 0.1 -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -c "G3" -f 0.1 -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G3" -f 0.1 -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -c "G1\&G2\&G3\&Age" -f 0.1 -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G1&G2&G3&Age" -f 0.1 -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -c "G3\&Age" -f 0.1 -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G3&Age" -f 0.1 -D "kfold-panel-by-validation-split-parent-level"

# =========== Ridge, lbo
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -d "lbo" -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -d "lbo" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -d "lbo" -c "Age" -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "Age" -d "lbo" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -d "lbo" -c "G1\&G2\&G3" -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G1&G2&G3" -d "lbo" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -d "lbo" -c "G3" -M 10 -D "kfold-panel-by-validation-split-parent-level"  -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G3" -d "lbo" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -d "lbo" -c "G1\&G2\&G3\&Age" -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G1&G2&G3&Age" -d "lbo" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -d "lbo" -c "G3\&Age" -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G3&Age" -d "lbo" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -d "lbo" -M 10 -f 0.1 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -f 0.1 -d "lbo" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -d "lbo" -c "Age" -f 0.1 -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "Age" -f 0.1 -d "lbo" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -d "lbo" -c "G1\&G2\&G3" -f 0.1 -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G1&G2&G3" -f 0.1 -d "lbo" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -d "lbo" -c "G3" -f 0.1 -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G3" -f 0.1 -d "lbo" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -d "lbo" -c "G1\&G2\&G3\&Age" -f 0.1 -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G1&G2&G3&Age" -f 0.1 -d "lbo" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -d "lbo" -c "G3\&Age" -f 0.1 -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10) 
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G3&Age" -f 0.1 -d "lbo" -D "kfold-panel-by-validation-split-parent-level"

# =========== Rf, hCG
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -m "rf" -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -m "rf" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -m "rf" -c "Age" -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "Age" -m "rf" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -m "rf" -c "G1\&G2\&G3" -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G1&G2&G3" -m "rf" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -m "rf" -c "G3" -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G3" -m "rf" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -m "rf" -c "G1\&G2\&G3\&Age" -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G1&G2&G3&Age" -m "rf" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -m "rf" -c "G3\&Age" -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G3&Age" -m "rf" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -m "rf" -M 10 -f 0.1 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -f 0.1 -m "rf" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -m "rf" -c "Age" -f 0.1 -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "Age" -f 0.1 -m "rf" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -m "rf" -c "G1\&G2\&G3" -f 0.1 -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G1&G2&G3" -f 0.1 -m "rf" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -m "rf" -c "G3" -f 0.1 -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G3" -f 0.1 -m "rf" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -m "rf" -c "G1\&G2\&G3\&Age" -f 0.1 -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G1&G2&G3&Age" -f 0.1 -m "rf" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -m "rf" -c "G3\&Age" -f 0.1 -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G3&Age" -f 0.1 -m "rf" -D "kfold-panel-by-validation-split-parent-level"

# =========== Rf, lbo
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -m "rf" -d "lbo" -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -d "lbo" -m "rf" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -m "rf" -d "lbo" -c "Age" -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "Age" -d "lbo" -m "rf" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -m "rf" -d "lbo" -c "G1\&G2\&G3" -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G1&G2&G3" -d "lbo" -m "rf" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -m "rf" -d "lbo" -c "G3" -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G3" -d "lbo" -m "rf" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -m "rf" -d "lbo" -c "G1\&G2\&G3\&Age" -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G1&G2&G3&Age" -d "lbo" -m "rf" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -m "rf" -d "lbo" -c "G3\&Age" -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G3&Age" -d "lbo" -m "rf" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -m "rf" -d "lbo" -M 10 -f 0.1 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -f 0.1 -d "lbo" -m "rf" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -m "rf" -d "lbo" -c "Age" -f 0.1 -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "Age" -f 0.1 -d "lbo" -m "rf" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -m "rf" -d "lbo" -c "G1\&G2\&G3" -f 0.1 -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G1&G2&G3" -f 0.1 -d "lbo" -m "rf" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -m "rf" -d "lbo" -c "G3" -f 0.1 -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G3" -f 0.1 -d "lbo" -m "rf" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -m "rf" -d "lbo" -c "G1\&G2\&G3\&Age" -f 0.1 -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G1&G2&G3&Age" -f 0.1 -d "lbo" -m "rf" -D "kfold-panel-by-validation-split-parent-level"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso-parent-level" -v 6 -k 10 -m "rf" -d "lbo" -c "G3\&Age" -f 0.1 -M 10 -D "kfold-panel-by-validation-split-parent-level" -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso-parent-level" -C -M 10 -k 10 -v 6 -c "G3&Age" -f 0.1 -d "lbo" -m "rf" -D "kfold-panel-by-validation-split-parent-level"



