# Propensity Score Matching (PSM)
---

## Table of contents

1. [Key concepts explained](#1-key-concepts-explained)
2. [What is PSM?](#2-what-is-psm)
3. [Clinical case example](#3-clinical-case-example)
4. [Dummy dataset](#4-dummy-dataset)
5. [SPSS step-by-step](#5-spss-step-by-step)
6. [Dummy outputs and how to interpret them](#6-dummy-outputs-and-how-to-interpret-them)
7. [Common mistakes](#7-common-mistakes)
8. [Key references](#8-key-references)

---

## 1. Key concepts explained

### What is a confounder?

A **confounder** is a variable that is linked to *both* the treatment being studied *and* the outcome — so it "confuses" the apparent relationship between treatment and outcome.

**Test to identify a confounder:** If you randomly assigned patients to treatment groups (as in a proper RCT), would this variable still differ between groups? If yes — it is a confounder.

**Example (CAP study):**
- **Age** is a confounder because:
  - Older patients are more likely to receive early antibiotics (clinicians respond faster to severe cases)
  - Older patients are also more likely to be readmitted (independent of treatment)
- Without accounting for age, a naive comparison would partly measure the effect of age, not the treatment

Common confounders in clinical research: age, sex, comorbidity scores, disease severity, socioeconomic status.

---

### What is a caliper?

A **caliper** is a maximum allowed difference in propensity score when forming a matched pair. It prevents "bad matches" — pairing two patients whose propensity scores are very different just because no closer match is available.

**Analogy:** Imagine height-matching pairs of people for a study. A caliper of ±3 cm means you will only form a pair if the two people are within 3 cm of each other in height. Someone 190 cm tall cannot be matched with someone 165 cm tall, even if they're the closest available.

**Recommended caliper width (Austin, 2011):** 0.2 × standard deviation of the logit of the propensity score. In most datasets, this works out to approximately 0.05–0.08.

**Consequence of caliper:** Patients who cannot be matched within the caliper are excluded from the matched sample. This is acceptable — it is better to drop unmatched cases than to create poor-quality matches that introduce noise.

---

## 2. What is PSM?

**Propensity Score Matching (PSM)** is a statistical method used to reduce selection bias in observational studies by creating matched groups that are balanced on key confounders.

### In plain terms:

PSM is a technique where you calculate one number per patient — their **probability of being in the treatment group** based on who they are (their observed characteristics). You then pair treated and untreated patients who share nearly identical numbers. Because their numbers match, their confounders are roughly balanced, making the comparison of outcomes as fair as if they had been randomised.

> **PSM is a score that represents:** the predicted probability (0 to 1) that a given patient would receive the treatment, based on their observed background characteristics (confounders). It is calculated using logistic regression, where the outcome is treatment group membership (1 = treated, 0 = control) and the predictors are all identified confounders.

### Why not just do a standard RCT?

In clinical research, randomisation is often ethically or practically impossible. You cannot randomly assign patients to "receive early antibiotics" vs "receive delayed antibiotics" — clinicians make that decision based on clinical urgency. PSM is the next best thing: it mimics randomisation by making the groups comparable **after the fact**, using observed data.

### PSM vs. standard regression adjustment

| Approach | What it does | Limitation |
|---|---|---|
| Standard regression | Adds confounders as covariates in the outcome model | Still models all patients together; interaction effects may be missed |
| PSM | Creates a matched subsample that is balanced before outcome analysis | Drops unmatched cases; only controls for observed confounders |

---

## 3. Clinical case example

### Research question

> Does early administration of IV antibiotics (within 1 hour of admission) reduce 30-day hospital readmission in patients admitted with community-acquired pneumonia (CAP)?

### Why this needs PSM

This is an observational study. Clinicians decided on antibiotic timing based on clinical severity — sicker patients received earlier treatment. The two groups are therefore not comparable:

- The early-antibiotics group contains more severe, older, and more comorbid patients
- A naive comparison would be biased: the early group looks worse partly because they were sicker to begin with

### Variables

| Variable | Type | Role |
|---|---|---|
| `Treatment` | Binary (1 = early AB, 0 = standard) | Treatment indicator |
| `Age` | Continuous (years) | Confounder |
| `CURB65` | Ordinal (0–5) | Confounder (pneumonia severity score) |
| `Charlson` | Continuous | Confounder (comorbidity index) |
| `Smoker` | Binary (1 = yes) | Confounder |
| `SpO2` | Continuous (%) | Confounder (oxygen saturation on admission) |
| `Readmit30` | Binary (1 = readmitted within 30 days) | Outcome variable |

### Note on CURB-65

CURB-65 is a clinical scoring tool used in pneumonia to estimate mortality risk. It awards 1 point each for: Confusion, Urea > 7 mmol/L, Respiratory rate ≥ 30, Blood pressure (systolic < 90 or diastolic ≤ 60), and age ≥ 65. Score of 0–1 = low risk; 3–5 = high risk, consider ICU.

---

## 4. Dummy dataset

The table below shows 10 representative rows. A full dataset for this study would contain approximately 200 rows (100 treated, 100 control).

**Set up variable names exactly as shown in SPSS Variable View before importing.**

| PatientID | Treatment | Age | CURB65 | Charlson | Smoker | SpO2 | Readmit30 |
|---|---|---|---|---|---|---|---|
| P001 | 1 | 67 | 3 | 4 | 1 | 91 | 0 |
| P002 | 0 | 54 | 1 | 1 | 0 | 97 | 0 |
| P003 | 1 | 78 | 4 | 6 | 0 | 88 | 1 |
| P004 | 0 | 61 | 2 | 3 | 1 | 94 | 0 |
| P005 | 1 | 72 | 3 | 5 | 1 | 90 | 1 |
| P006 | 0 | 45 | 1 | 0 | 0 | 98 | 0 |
| P007 | 1 | 83 | 4 | 7 | 0 | 85 | 1 |
| P008 | 0 | 58 | 2 | 2 | 1 | 95 | 0 |
| P009 | 1 | 70 | 3 | 4 | 1 | 92 | 0 |
| P010 | 0 | 49 | 1 | 1 | 0 | 96 | 0 |

> Treatment: 1 = early antibiotics, 0 = standard care. All other 1/0 variables are binary (yes/no). Notice the pattern: treated patients (Treatment = 1) tend to be older, have higher CURB-65 and Charlson scores, and lower SpO2 — this is the confounding we need to correct.

---

## 5. SPSS step-by-step

> **Note on software route:** This guide uses the built-in `Data → Propensity Score Matching` menu available in SPSS v24 and later. This is the recommended route for v31. You do **not** need a separate logistic regression step, and you do **not** need the old "PS Matching" extension under the Analyze menu (that is an older R-based tool and is not required here).

---

### Before you begin — install the required extension

The `Data → Propensity Score Matching` menu runs on the **Case Control Matching** extension (also called FUZZY) behind the scenes. Install it once before proceeding.

`Extensions → Extension Hub` → search `Case Control Matching` → Install

If the extension is already installed, skip this step and proceed directly to Phase 1.

> **Version check:** If you are on SPSS v31, confirm the full version number via `Help → About IBM SPSS Statistics`. It should read v31.0.1.0 or later. If it shows v31.0.0.0, PSM may freeze due to a known bug — update via IBM Fix Central before proceeding.

---

### Phase 1 & 2 — Run PSM (propensity scoring + matching in one step)

**Step 1: Open the PSM dialog**

`Data → Propensity Score Matching`

This single dialog handles both the propensity score estimation (logistic regression) and the matching — no separate steps needed.

**Step 2: Case Identification tab**

- Case indicator variable: `Treatment`
- Define groups: Case value = `1` (early antibiotics), Control value = `0` (standard care)

**Step 3: Variables tab**

Add all confounders to the model:
- `Age`, `CURB65`, `Charlson`, `Smoker`, `SpO2`

These are used internally to run logistic regression and estimate each patient's propensity score.

**Step 4: Matching tab**

| Setting | Value |
|---|---|
| Method | Nearest neighbour |
| Match tolerance (caliper) | 0.068 (see caliper calculation below) |
| Matching ratio | 1:1 |
| With replacement | No |

**Calculating caliper width (do this before running):**

The recommended caliper is 0.2 × SD of the logit of the propensity score (Austin, 2011). Since the propensity scores are not yet available before running the dialog, use the following practical approach:

- Run the dialog once with a wide tolerance (e.g. 0.2) just to generate the dataset
- In the output dataset, SPSS saves the propensity score as a variable (typically `PropensityScore` or similar)
- Compute: `Transform → Compute Variable` → `logit_ps = LN(PropensityScore / (1 - PropensityScore))`
- Get SD of `logit_ps`: `Analyze → Descriptive Statistics → Descriptives`
- Multiply SD × 0.2 = your caliper
- Re-run the dialog with the correct caliper value

**Step 5: Output tab**

- Tick `Create new dataset` and name it `CAP_matched`
- Tick any balance statistics options if available

Click OK. SPSS will produce a matched dataset. **All subsequent analysis must be done from `CAP_matched` only — never from the original dataset.**

---

### Phase 3 — Check covariate balance

The purpose of this phase is to prove that matching worked — that the two groups are now comparable. You do this by showing a **before and after picture**: how imbalanced the confounders were in the original data, and how balanced they are in the matched data. You need to run the same test twice, on two different datasets.

> **Why independent samples t-test and not paired t-test?** The balance check and the outcome analysis are asking different questions, so they use different tests. The balance check asks: *are the two groups similar on their background characteristics?* This is a group-level comparison — you are not measuring a difference within a pair, you are checking whether the treated group and control group look alike overall. The pairing is irrelevant to this question, so you use an independent samples t-test. The paired samples t-test is reserved for Phase 4 (outcome analysis), where each treated patient is linked to a specific control patient and that pairing must be respected. Think of it like twin studies: to check that twins are similar in age, you compare group averages (independent); to measure whether a drug changed their blood pressure, you compare within each twin pair (paired).

**Step 6: Run t-tests on the ORIGINAL dataset first**

Open your original file (e.g. `CAP_data.sav`, all 200 patients).

`Analyze → Compare Means → Independent Samples T-test`

- Test variables: `Age`, `CURB65`, `Charlson`, `SpO2`
- Grouping variable: `Treatment` (define groups: 0 and 1)

You expect to see **large, significant differences** here — that is the confounding problem you are correcting. Note down the mean for each group and the p-value for each variable.

**Step 7: Run the same t-tests on the MATCHED dataset**

Now open your matched file (`CAP_matched.sav`). Run the exact same t-test with the exact same settings.

You now want to see **small, non-significant differences** — this is evidence that matching has balanced the groups.

**Step 8: Build a balance table comparing both results**

Put the two sets of results side by side. This table goes in your results section:

| Variable | Mean (treated) before | Mean (control) before | Mean (treated) after | Mean (control) after | SMD before | SMD after |
|---|---|---|---|---|---|---|
| Age | 72.1 | 57.9 | 70.8 | 70.2 | 0.48 | 0.04 |
| CURB-65 | 3.2 | 1.4 | 3.1 | 3.0 | 0.51 | 0.06 |
| Charlson | 4.8 | 1.9 | 4.6 | 4.4 | 0.44 | 0.07 |
| SpO2 | 89.4 | 96.1 | 90.1 | 89.7 | 0.39 | 0.05 |

**Calculating SMD manually:**
SMD = (mean_treated − mean_control) / pooled SD

**What to look for:**
- SMD < 0.1 after matching = balance achieved for that variable
- SMD > 0.1 after matching = balance not achieved — re-specify the propensity score model (e.g. add an interaction term, or reconsider which confounders are included)

**Step 9: Check propensity score overlap (histogram)**

`Graphs → Legacy Dialogs → Histogram`

- Variable: `PropensityScore` (the variable created by the PSM dialog)
- Panel: split by `Treatment`

The two distributions should overlap substantially. Poor overlap means many patients had no plausible match on the other side — this limits how much PSM can help.

---

### Phase 4 — Outcome analysis on matched sample

Work only from the matched dataset (`CAP_matched.sav`) from here.

**Step 10: Chi-square test (binary outcome)**

`Analyze → Descriptive Statistics → Crosstabs`

- Row: `Treatment`
- Column: `Readmit30`
- Statistics: tick `Chi-square` and `Risk (odds ratio)`
- Cells: tick `Row percentages`

> Note: Because matched pairs are paired observations, some methodologists recommend McNemar's test rather than Pearson's chi-square. However, for a first analysis Pearson's chi-square is acceptable and interpretable. If the supervisor specifies McNemar's: `Analyze → Nonparametric Tests → Legacy Dialogs → 2 Related Samples`.

**For a continuous outcome:** use `Analyze → Compare Means → Paired Samples T-test`, pairing by match ID.

---

## 6. Dummy outputs and how to interpret them

> **Note:** When using `Data → Propensity Score Matching`, SPSS runs the logistic regression internally and does not display the full coefficients table in the output viewer. What you see instead is a matching summary and the new matched dataset. If you want to inspect the logistic regression coefficients (e.g. for reporting), run a separate logistic regression manually: `Analyze → Regression → Binary Logistic` with `Treatment` as dependent and all confounders as covariates, then click `Save → Probabilities`. This is optional but good practice for understanding your model.

### Output 1: Logistic regression model summary (if run separately)

```
Omnibus tests of model coefficients:
Chi-square = 41.28   df = 5   Sig. = .000
Nagelkerke R² = .312
```

**What to check:** Is the overall model significant (Sig. < .05)? Here, yes (p < .001). The Nagelkerke R² of 0.31 indicates a reasonable model fit. You do not need a perfect model — you just need the propensity scores to be reasonable estimates.

**Coefficients:**

| Variable | B | Sig. | Exp(B) |
|---|---|---|---|
| Age | 0.08 | .000 | 1.08 |
| CURB65 | 0.72 | .000 | 2.05 |
| Charlson | 0.31 | .005 | 1.36 |
| Smoker | 0.44 | .116 | 1.55 |
| SpO2 | −0.19 | .002 | 0.83 |
| Constant | 8.71 | .000 | — |

**Interpretation:** Higher CURB-65 doubles the odds of being in the early-antibiotics group (Exp(B) = 2.05), confirming it's a strong confounder. Smoker is not individually significant (p = .116) but was retained because it was identified a priori — this is correct practice. SpO2 is negative (lower oxygen = higher probability of treatment), which makes clinical sense.

---

### Output 2: PS matching report

```
Total treated cases:                98
Total control cases:               102
Caliper width (logit scale):       0.068
Cases successfully matched:        86 treated / 86 control
Cases dropped (outside caliper):   12 treated, 16 control
Final matched sample N:            172 (86 pairs)
```

**Interpretation:** 12 treated and 16 control patients could not be matched — they had extreme propensity scores with no comparable patient on the other side. This is expected. The final matched sample of 172 is what you now analyse. If > 30% of cases are dropped, this suggests poor overlap between groups and the model may need re-specification.

---

### Output 3: Balance table (before vs. after matching)

| Variable | SMD before | SMD after | Balance achieved? |
|---|---|---|---|
| Age | 0.48 | 0.04 | Yes |
| CURB-65 | 0.51 | 0.06 | Yes |
| Charlson index | 0.44 | 0.07 | Yes |
| Smoker | 0.22 | 0.03 | Yes |
| SpO2 | 0.39 | 0.05 | Yes |

**Interpretation:** Before matching, all five confounders showed large imbalances (SMD > 0.2) — this was the bias problem. After matching, all SMDs are below 0.10, indicating the groups are now balanced. This is the key quality check for PSM. Always include this table in your results section.

---

### Output 4: Outcome analysis (chi-square, matched sample)

**Crosstabulation:**

| | Not readmitted | Readmitted | Total | Readmission rate |
|---|---|---|---|---|
| Early antibiotics | 68 | 18 | 86 | 20.9% |
| Standard care | 56 | 30 | 86 | 34.9% |

```
Pearson Chi-Square = 4.71   df = 1   Sig. = .030
Odds Ratio = 0.50   95% CI [0.26, 0.96]
```

**Interpretation:**

After matching on propensity scores, patients who received early antibiotics had a significantly lower 30-day readmission rate (20.9%) compared to those who received standard care (34.9%). This difference was statistically significant (χ²(1) = 4.71, p = .030).

The odds ratio of 0.50 means patients in the early-antibiotics group had half the odds of readmission compared to matched controls. The 95% confidence interval [0.26, 0.96] does not cross 1.0, confirming the result is statistically significant at the 5% level.

**How to write this up in a results section:**

> After 1:1 nearest-neighbour propensity score matching (caliper = 0.068), the matched sample comprised 172 patients (86 per group). All five confounders achieved standardised mean differences below 0.10, indicating adequate balance. In the matched sample, the 30-day readmission rate was significantly lower in the early antibiotics group (20.9%) compared to the standard care group (34.9%; χ²(1) = 4.71, p = .030; OR = 0.50, 95% CI [0.26, 0.96]).

**Important caveat:** PSM only controls for *observed* confounders. Unmeasured variables (e.g. socioeconomic status, patient adherence, GP follow-up quality) may still bias the results. This is called **hidden bias** and is the principal limitation of all PSM analyses.

---

## 7. Common mistakes

| Mistake | Why it matters | How to avoid |
|---|---|---|
| Running outcome analysis on the original (unmatched) dataset | Defeats the purpose of PSM entirely | Always work from the saved matched `.sav` file |
| Skipping the balance check | You may have a failed match without knowing | Always report SMDs before AND after matching side by side |
| Only checking balance after matching, not before | You lose the "before" picture needed to prove matching helped | Run t-tests on both datasets; build the comparison table |
| Using independent t-test instead of paired t-test for continuous outcomes | Matched pairs are paired data — ignoring this inflates standard errors | Use Paired Samples T-test or McNemar's for matched pairs |
| Including post-treatment variables as confounders | Variables measured after treatment may be mediators, not confounders | Only include variables measured before or at treatment allocation |
| Not saving the matched dataset as a new file | Easy to accidentally run analysis on the wrong dataset | Immediately rename and save matched dataset before proceeding |
| Treating a non-significant covariate as unnecessary | Individual significance in the logistic model is irrelevant — use theory | Keep all a priori confounders regardless of p-value |
| Not installing Case Control Matching extension before running PSM | `Data → Propensity Score Matching` will fail silently or freeze | Install "Case Control Matching" from Extension Hub first |

---

## 8. Key references

**Foundational**

1. Rosenbaum, P. R., & Rubin, D. B. (1983). The central role of the propensity score in observational studies for causal effects. *Biometrika, 70*(1), 41–55. — The original paper that introduced propensity scores.

2. Austin, P. C. (2011). An introduction to propensity score methods for reducing the effects of confounding in observational studies. *Multivariate Behavioral Research, 46*(3), 399–424. https://doi.org/10.1080/00273171.2011.568786 — Best accessible overview for clinical researchers; recommended first read.

**Caliper and matching specifics**

3. Austin, P. C. (2011). Optimal caliper widths for propensity-score matching when estimating differences in means and differences in proportions in observational studies. *Pharmaceutical Statistics, 10*(2), 150–161. https://doi.org/10.1002/pst.433 — Source of the 0.2 × SD(logit PS) caliper recommendation.

**SPSS-specific**

4. Thoemmes, F. J., & Kim, E. S. (2011). A systematic review of propensity score methods in the social sciences. *Multivariate Behavioral Research, 46*(1), 90–118. arXiv:1201.6385 — Describes the PS Matching extension for SPSS; full PDF at https://arxiv.org/pdf/1201.6385

5. Hair, M. D. (2015). *Propensity score matching in SPSS: How to turn an audit into a RCT* [Presentation slides]. Available at: https://slideplayer.com/slide/10427780/ — Highly recommended beginner-friendly slides with a clinical example.

**Recent clinical guide**

6. Pourahmad, S., & Madadizadeh, F. (2025). Propensity score matching in non-interventional studies: A step-by-step guide for clinicians and researchers. *Iranian Journal of Medical Sciences.* DOI: 10.30476/ijms.2025.105595.3947 — Recently published, written specifically for clinicians and medical researchers.

---

*Document prepared for MASH Statistics tutoring session. For internal teaching use only.*
