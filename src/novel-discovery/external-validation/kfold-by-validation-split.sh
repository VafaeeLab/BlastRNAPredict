# These shell scripts are to help automate the generation of results.

# =========== Ridge, hCG
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -c "Age" -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "Age"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -c "G1\&G2\&G3" -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G1&G2&G3"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -c "G3" -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G3"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -c "G1\&G2\&G3\&Age" -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G1&G2&G3&Age"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -c "G3\&Age" -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G3&Age"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -M 10 -f 0.1 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -f 0.1
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -c "Age" -f 0.1 -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "Age" -f 0.1
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -c "G1\&G2\&G3" -f 0.1 -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G1&G2&G3" -f 0.1
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -c "G3" -f 0.1 -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G3" -f 0.1
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -c "G1\&G2\&G3\&Age" -f 0.1 -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G1&G2&G3&Age" -f 0.1
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -c "G3\&Age" -f 0.1 -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G3&Age" -f 0.1

# =========== Ridge, lbo
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -d "lbo" -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -d "lbo" -c "Age" -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "Age" -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -d "lbo" -c "G1\&G2\&G3" -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G1&G2&G3" -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -d "lbo" -c "G3" -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G3" -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -d "lbo" -c "G1\&G2\&G3\&Age" -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G1&G2&G3&Age" -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -d "lbo" -c "G3\&Age" -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G3&Age" -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -d "lbo" -M 10 -f 0.1 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -f 0.1 -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -d "lbo" -c "Age" -f 0.1 -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "Age" -f 0.1 -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -d "lbo" -c "G1\&G2\&G3" -f 0.1 -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G1&G2&G3" -f 0.1 -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -d "lbo" -c "G3" -f 0.1 -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G3" -f 0.1 -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -d "lbo" -c "G1\&G2\&G3\&Age" -f 0.1 -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G1&G2&G3&Age" -f 0.1 -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -d "lbo" -c "G3\&Age" -f 0.1 -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G3&Age" -f 0.1 -d "lbo"

# =========== Rf, hCG
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -m "rf" -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -m "rf" -c "Age" -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "Age" -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -m "rf" -c "G1\&G2\&G3" -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G1&G2&G3" -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -m "rf" -c "G3" -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G3" -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -m "rf" -c "G1\&G2\&G3\&Age" -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G1&G2&G3&Age" -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -m "rf" -c "G3\&Age" -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G3&Age" -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -m "rf" -M 10 -f 0.1 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -f 0.1 -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -m "rf" -c "Age" -f 0.1 -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "Age" -f 0.1 -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -m "rf" -c "G1\&G2\&G3" -f 0.1 -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G1&G2&G3" -f 0.1 -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -m "rf" -c "G3" -f 0.1 -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G3" -f 0.1 -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -m "rf" -c "G1\&G2\&G3\&Age" -f 0.1 -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G1&G2&G3&Age" -f 0.1 -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -m "rf" -c "G3\&Age" -f 0.1 -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G3&Age" -f 0.1 -m "rf"

# =========== Rf, lbo
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -m "rf" -d "lbo" -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -d "lbo" -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -m "rf" -d "lbo" -c "Age" -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "Age" -d "lbo" -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -m "rf" -d "lbo" -c "G1\&G2\&G3" -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G1&G2&G3" -d "lbo" -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -m "rf" -d "lbo" -c "G3" -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G3" -d "lbo" -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -m "rf" -d "lbo" -c "G1\&G2\&G3\&Age" -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G1&G2&G3&Age" -d "lbo" -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -m "rf" -d "lbo" -c "G3\&Age" -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G3&Age" -d "lbo" -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -m "rf" -d "lbo" -M 10 -f 0.1 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -f 0.1 -d "lbo" -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -m "rf" -d "lbo" -c "Age" -f 0.1 -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "Age" -f 0.1 -d "lbo" -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -m "rf" -d "lbo" -c "G1\&G2\&G3" -f 0.1 -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G1&G2&G3" -f 0.1 -d "lbo" -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -m "rf" -d "lbo" -c "G3" -f 0.1 -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G3" -f 0.1 -d "lbo" -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -m "rf" -d "lbo" -c "G1\&G2\&G3\&Age" -f 0.1 -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G1&G2&G3&Age" -f 0.1 -d "lbo" -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/external-validation/fold-panel-by-data-split.R' -l "lasso" -v 6 -k 10 -m "rf" -d "lbo" -c "G3\&Age" -f 0.1 -M 10 -r '{1}' ::: $(seq 1 10)
Rscript ./src/novel-discovery/external-validation/fold-panel-by-data-split.R -l "lasso" -C -M 10 -k 10 -v 6 -c "G3&Age" -f 0.1 -d "lbo" -m "rf"



