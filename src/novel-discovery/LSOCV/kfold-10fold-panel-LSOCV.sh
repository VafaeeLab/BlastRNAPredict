# Shell script to help perform no-information-leakage LSOCV.

# ================= 21/04/2026

# ==== HCG

parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -M 1 -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -M 1 -c "Age" -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "Age"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -M 1 -c "G1\&G2\&G3" -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G1&G2&G3"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -M 1 -c "G3" -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G3"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -M 1 -c "G1\&G2\&G3\&Age" -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G1&G2&G3&Age"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -M 1 -c "G3\&Age" -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G3&Age"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -M 1 -f 0.1 -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -f 0.1
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -M 1 -c "Age" -f 0.1 -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "Age" -f 0.1
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -M 1 -c "G1\&G2\&G3" -f 0.1 -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G1&G2&G3" -f 0.1
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -M 1 -c "G3" -f 0.1 -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G3" -f 0.1
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -M 1 -c "G1\&G2\&G3\&Age" -f 0.1 -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G1&G2&G3&Age" -f 0.1
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -M 1 -c "G3\&Age" -f 0.1 -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G3&Age" -f 0.1

# ==== Live birth

parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -M 1 -d "lbo" -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -M 1 -d "lbo" -c "Age" -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "Age" -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -M 1 -d "lbo" -c "G1\&G2\&G3" -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G1&G2&G3" -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -M 1 -d "lbo" -c "G3" -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G3" -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -M 1 -d "lbo" -c "G1\&G2\&G3\&Age" -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G1&G2&G3&Age" -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -M 1 -d "lbo" -c "G3\&Age" -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G3&Age" -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -M 1 -d "lbo" -f 0.1 -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -f 0.1 -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -M 1 -d "lbo" -c "Age" -f 0.1 -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "Age" -f 0.1 -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -M 1 -d "lbo" -c "G1\&G2\&G3" -f 0.1 -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G1&G2&G3" -f 0.1 -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -M 1 -d "lbo" -c "G3" -f 0.1 -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G3" -f 0.1 -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -M 1 -d "lbo" -c "G1\&G2\&G3\&Age" -f 0.1 -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G1&G2&G3&Age" -f 0.1 -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -M 1 -d "lbo" -c "G3\&Age" -f 0.1 -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G3&Age" -f 0.1 -d "lbo"

# ========== RandomForest HCG

parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -m "rf" -M 1 -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -m "rf" -M 1 -c "Age" -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "Age" -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -m "rf" -M 1 -c "G1\&G2\&G3" -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G1&G2&G3" -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -m "rf" -M 1 -c "G3" -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G3" -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -m "rf" -M 1 -c "G1\&G2\&G3\&Age" -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G1&G2&G3&Age" -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -m "rf" -M 1 -c "G3\&Age" -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G3&Age" -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -m "rf" -M 1 -f 0.1 -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -f 0.1 -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -m "rf" -M 1 -c "Age" -f 0.1 -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "Age" -f 0.1 -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -m "rf" -M 1 -c "G1\&G2\&G3" -f 0.1 -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G1&G2&G3" -f 0.1 -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -m "rf" -M 1 -c "G3" -f 0.1 -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G3" -f 0.1 -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -m "rf" -M 1 -c "G1\&G2\&G3\&Age" -f 0.1 -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G1&G2&G3&Age" -f 0.1 -m "rf"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -m "rf" -M 1 -c "G3\&Age" -f 0.1 -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G3&Age" -f 0.1 -m "rf"

# ========== RandomForest LBO

parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -m "rf" -d "lbo" -M 1 -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -m "rf" -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -m "rf" -d "lbo" -M 1 -c "Age" -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "Age" -m "rf" -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -m "rf" -d "lbo" -M 1 -c "G1\&G2\&G3" -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G1&G2&G3" -m "rf" -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -m "rf" -d "lbo" -M 1 -c "G3" -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G3" -m "rf" -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -m "rf" -d "lbo" -M 1 -c "G1\&G2\&G3\&Age" -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G1&G2&G3&Age" -m "rf" -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -m "rf" -d "lbo" -M 1 -c "G3\&Age" -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G3&Age" -m "rf" -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -m "rf" -d "lbo" -M 1 -f 0.1 -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -f 0.1 -m "rf" -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -m "rf" -d "lbo" -M 1 -c "Age" -f 0.1 -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "Age" -f 0.1 -m "rf" -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -m "rf" -d "lbo" -M 1 -c "G1\&G2\&G3" -f 0.1 -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G1&G2&G3" -f 0.1 -m "rf" -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -m "rf" -d "lbo" -M 1 -c "G3" -f 0.1 -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G3" -f 0.1 -m "rf" -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -m "rf" -d "lbo" -M 1 -c "G1\&G2\&G3\&Age" -f 0.1 -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G1&G2&G3&Age" -f 0.1 -m "rf" -d "lbo"
parallel --timeout 7200 --bar -j18 Rscript './src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R' -l "10foldlasso" -k 10 -m "rf" -d "lbo" -M 1 -c "G3\&Age" -f 0.1 -r '{1}' ::: $(seq 1 1)
Rscript ./src/novel-discovery/LSOCV/kfold-10fold-panel-LSOCV.R -l "10foldlasso" -C -M 1 -k 10 -c "G3&Age" -f 0.1 -m "rf" -d "lbo"
