# BlastRNAPredict

Predicting IVF pregnancy outcome from RNA content in blastocyst fluid conditioned medium (BFCM) samples using a regularised machine learning pipeline.

---

## Overview

BFCM is the spent culture medium surrounding an embryo prior to transfer. This project develops and validates a prediction model for pregnancy outcome (urine hCG result and live birth) based on small RNA sequencing of BFCM samples, and benchmarks it against standard morphological assessment alone.

The pipeline includes:

- DESeq2-based normalisation of raw RNA-seq counts
- Bootstrap-enhanced LASSO feature selection to identify a stable gene panel
- Ridge regression (L2-penalised logistic regression) as the primary classifier
- Random Forest as a secondary comparator
- Internal validation via sibling-stratified 10-fold cross-validation (LSOCV)
- External validation on a held-out cohort from a geographically distinct IVF centre
- Morphology-only and age-only baseline models for comparison

---

## Repository structure

```
BlastRNAPredict-main/
├── data/
│   ├── raw_counts.txt.gz                          # Raw RNA-seq count matrix (genes × samples)
│   ├── metadata_260525.xlsx                        # Sample metadata (all samples + BF cohort sheet)
│   ├── Including Day4_Validation chorts_260324.xlsx  # Proposed train/validation splits (6 configs)
│   └── Validation cohort suggestions_with variables_260319.xlsx  # Earlier split proposals
│
├── src/
│   ├── novel-discovery/                # R scripts — main RNA-based pipeline
│   │   ├── load-data.R                 # Data loading and preprocessing
│   │   ├── obtain-data.R               # Feature subsetting helper
│   │   ├── helper.R                    # Shared utility functions
│   │   ├── feature-select/             # Bootstrap-LASSO feature selection
│   │   │   ├── lasso-by-data-split-ext-val.R   # Feature selection for external validation
│   │   │   ├── 10fold-lasso-LSOCV.R            # Nested feature selection for LSOCV
│   │   │   ├── *.sh                            # Shell scripts to run on HPC
│   │   │   └── file-descriptions               # Description of scripts in this folder
│   │   ├── external-validation/        # External validation scripts
│   │   │   ├── fold-panel-by-data-split.R          # External validation (test set)
│   │   │   ├── internal-fold-panel-by-data-split.R # Internal CV on the training split
│   │   │   ├── *.sh                                # HPC shell scripts
│   │   │   └── file-descriptions
│   │   └── LSOCV/                      # Sibling-stratified 10-fold CV
│   │       ├── kfold-10fold-panel-LSOCV.R
│   │       └── kfold-10fold-panel-LSOCV.sh
│   │
│   └── morphology-baseline/            # Python — morphology and age baseline models
│       ├── ridge_logistic.py           # Ridge logistic regression using Emb_stage features
│       ├── ridge_logistic_age.py       # Ridge logistic regression using Age only
│       └── results/
│           ├── ridge_logistic_results.md    # Morphology model results (formatted)
│           ├── ridge_logistic_results.txt   # Morphology model results (raw output)
│           └── ridge_logistic_age_results.txt  # Age model results (raw output)
│
├── markdown/                           # R Markdown analysis notebooks
│   ├── LSOCV-v3.Rmd / .html           # LSOCV analysis and results
│   ├── val-6-models.Rmd / .html        # External validation across 6 split configurations
│   └── meta-data.Rmd / .html           # Metadata exploration and QC
│
├── docs/
│   └── Methods.docx                    # Detailed methods description
│
├── .gitignore
└── README.md
```

---

## Data

### `raw_counts.txt.gz`

Space-delimited raw RNA-seq count matrix. Rows are genes (Ensembl IDs with version suffix, e.g. `ENSG00000000003.16`), columns are samples. The 490 samples fall into four groups:

| Group | Description | n |
|-------|-------------|---|
| BF | Blastocyst fluid conditioned medium | 75 |
| ESM | Endometrial / spent medium controls | 393 |
| Ctrl | Negative controls | 18 |
| Water | Water blanks | 4 |

### `metadata_260525.xlsx`

Primary sample metadata. The **BF cohort** sheet (75 samples, 54 columns) is the main input to the prediction pipeline. Key columns include:

| Column | Description |
|--------|-------------|
| `sample_id` | Analysis sample ID (e.g. BF_1) |
| `Seq_Sample_ID` | Sequencing sample ID |
| `Cohort` | `Training` (n = 65) or `Validation` (n = 10) |
| `Emb_stage` | Gardner blastocyst grade (e.g. `4AB` — expansion / ICM / TE) |
| `hCG_Result` | Primary outcome: `Positive` / `Negative` |
| `outcome_preg` | Secondary outcome: `Live_birth` / `NPO` |
| `Age` | Maternal age at oocyte retrieval |
| `IVF_center` | Clinic of origin |
| `Sibling` / `Sibling_Family_ID` | Sibling embryo relationships |

---

## Morphology baseline models

Two Python scripts in `src/morphology-baseline/` implement L2-penalised logistic regression using clinical features only, as comparators to the RNA-based model. The regularisation parameter λ is selected by minimising 10-fold CV binomial deviance within the training set.

### Emb_stage model (`ridge_logistic.py`)

Emb_stage is parsed into three ordinal predictors (expansion numeric; ICM and TE graded A = 1, B = 2).

**Optimal λ = 4.61**

| Predictor | Coefficient |
|-----------|-------------|
| Intercept | +0.096 |
| Expansion | +0.247 |
| ICM       | −0.217 |
| TE        | −0.408 |

| | Internal CV (n = 65) | External validation (n = 10) |
|---|---|---|
| AUC | 0.561 | 0.667 |
| Accuracy | 60.0% | 60.0% |
| Sensitivity | 46.9% | 66.7% |
| Specificity | 72.7% | 50.0% |

### Age model (`ridge_logistic_age.py`)

**Optimal λ = 270.5**  — Coefficient: Age = −0.060 (older age → lower implantation probability).

| | Internal CV (n = 65) | External validation (n = 10) |
|---|---|---|
| AUC | 0.626 | 0.458 |
| Accuracy | 56.9% | 50.0% |
| Sensitivity | 53.1% | 50.0% |
| Specificity | 60.6% | 50.0% |

Age does not generalise to the external cohort (AUC < 0.5), confirming it carries no independent predictive signal beyond the training set.

---

## Dependencies

### R (main pipeline)

- `caret`, `DESeq2`, `edgeR`, `glmnet`, `openxlsx`, `dplyr`, `tidyr`
- `ROCR`, `MLmetrics`, `org.Hs.eg.db`
- `EnhancedVolcano`, `umap`, `lme4`, `kableExtra`

### Python (baseline models)

- `scikit-learn >= 1.0`
- `pandas`, `numpy`, `openpyxl`

Install with:
```bash
pip install scikit-learn pandas numpy openpyxl
```

---

## Running the baseline models

From the repository root:

```bash
# Morphology-only baseline
python src/morphology-baseline/ridge_logistic.py

# Age-only baseline
python src/morphology-baseline/ridge_logistic_age.py
```

Note: the R pipeline scripts were designed to run on an HPC cluster via the accompanying `.sh` shell scripts. Refer to the `file-descriptions` files within each subdirectory for parameter details.

---

## Citation

> *Manuscript in preparation.*
