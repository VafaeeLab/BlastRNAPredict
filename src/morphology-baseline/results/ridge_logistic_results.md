# Ridge Logistic Regression — BF Cohort Results

**Date:** 2026-05-26  
**Data:** `metadata_260525.xlsx` — BF cohort sheet  

---

## Model Setup

- **Outcome:** `hCG_Result` (Positive = 1, Negative = 0)
- **Features** (parsed from `Emb_stage`):
  - Expansion stage — numeric (3, 4, 5)
  - ICM grade — ordinal (A = 1, B = 2)
  - TE grade — ordinal (A = 1, B = 2)
- **Penalty:** L2 (Ridge), λ selected by 10-fold CV minimising binomial deviance
- **Training set:** n = 65 (pos = 32, neg = 33)
- **Validation set:** n = 10 (pos = 6, neg = 4)

---

## Optimal Regularisation

| Parameter | Value |
|-----------|-------|
| λ (optimal) | 4.606 |
| C = 1/λ | 0.217 |

---

## Model Coefficients

| Term      | Coefficient |
|-----------|-------------|
| Intercept | 0.0959      |
| Expansion | +0.2469     |
| ICM       | −0.2173     |
| TE        | −0.4075     |

Higher expansion → higher implantation probability.  
Worse ICM/TE grade (higher ordinal) → lower implantation probability.

---

## Internal Validation (10-fold CV, n = 65 training set)

| Metric      | Value |
|-------------|-------|
| AUC         | 0.561 |
| Accuracy    | 0.600 |
| Sensitivity | 0.469 |
| Specificity | 0.727 |

---

## External Validation (holdout, n = 10)

| Metric      | Value |
|-------------|-------|
| AUC         | 0.667 |
| Accuracy    | 0.600 |
| Sensitivity | 0.667 |
| Specificity | 0.500 |

**Confusion matrix:**  
TP = 4, FP = 2, FN = 2, TN = 2

**Predicted probabilities:** [0.560, 0.459, 0.560, 0.613, 0.513, 0.553, 0.398, 0.553, 0.398, 0.459]  
**True labels:**              [1, 1, 1, 1, 1, 0, 1, 0, 0, 0]
