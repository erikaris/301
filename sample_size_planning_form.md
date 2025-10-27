# 📋 **Power & Sample Size Planning Form (Pre-Calculation Worksheet)**

**Purpose:**
To collect and organize all information needed *before* performing a sample size or power analysis in G*Power, R, SPSS, or another tool.
Fill this form completely before running any software.

---

## 1. **Basic Study Information**

| Question                                    | Description / Example                                                  | Your Entry |
| ------------------------------------------- | ---------------------------------------------------------------------- | ---------- |
| **Study Title / Topic**                     | e.g., “Effect of three surface treatments on implant osseointegration” |            |
| **Primary Research Question / Hypothesis**  | e.g., “Treatment A produces greater bone contact than control.”        |            |
| **Outcome Variable**                        | What is measured? (Continuous, Binary, Count, Ordinal)                 |            |
| **Measurement Unit / Scale**                | e.g., %, mm, test score, Likert 1–5                                    |            |
| **Primary Endpoint (if multiple outcomes)** | Which variable determines sample size?                                 |            |

---

## 2. **Study Design Details**

| Item                                       | Description / Example                                                                                                    | Your Entry |
| ------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------ | ---------- |
| **Design Type**                            | ☐ Between-subjects ☐ Within-subjects (repeated) ☐ Paired ☐ Cross-sectional ☐ Correlation ☐ Regression ☐ Survival ☐ Other |            |
| **Number of Groups / Levels / Predictors** | e.g., 3 treatments; or 2 independent groups                                                                              |            |
| **Equal group sizes?**                     | ☐ Yes ☐ No → specify allocation ratio                                                                                    |            |
| **Randomization or Matching**              | e.g., simple random, matched pairs                                                                                       |            |
| **Independence of observations**           | Are data points independent? ☐ Yes ☐ No                                                                                  |            |
| **Planned analysis type**                  | e.g., ANOVA, t-test, χ², regression, logistic, mixed model                                                               |            |

---

## 3. **Parameters Needed for Power Analysis**

*(Collect these before opening software)*

| Parameter                                                 | Description / Guidance                                                                              | Your Entry |
| --------------------------------------------------------- | --------------------------------------------------------------------------------------------------- | ---------- |
| **Significance level (α)**                                | Usually 0.05; can be 0.01 for stricter control                                                      |            |
| **Desired power (1 – β)**                                 | Typical = 0.80 or 0.90                                                                              |            |
| **Type of test**                                          | ☐ One-tailed ☐ Two-tailed                                                                           |            |
| **Effect size metric**                                    | Choose appropriate type: d (t-test), f (ANOVA), r (correlation), OR (logistic), Δ (mean difference) |            |
| **Expected / Minimal Detectable Effect Size**             | Numeric estimate (from pilot or literature)                                                         |            |
| **Effect size justification / source**                    | Reference, pilot data, or rationale                                                                 |            |
| **Population SD / variance (if known)**                   | For continuous outcomes                                                                             |            |
| **Baseline or control mean / proportion**                 | Needed for 2-group or proportion comparisons                                                        |            |
| **Expected difference between groups / change over time** | Clinical / educationally meaningful difference                                                      |            |
| **Correlation between repeated measures (ρ)**             | For within-subject designs                                                                          |            |
| **Sphericity correction (ε)**                             | For repeated-measures ANOVA (default = 1)                                                           |            |
| **Cluster design?**                                       | If clustered, record ICC (intraclass correlation coefficient)                                       |            |
| **Anticipated dropout or non-response rate**              | e.g., 10 % → adjust total N upward                                                                  |            |

---

## 4. **Study-Specific Considerations**

| Item                                            | Description                                 | Your Entry |
| ----------------------------------------------- | ------------------------------------------- | ---------- |
| **Sampling frame / recruitment source**         | Where will participants come from?          |            |
| **Feasible maximum sample size**                | Realistic upper limit due to time/cost      |            |
| **Ethical or logistical constraints**           | e.g., animal use limits, participant burden |            |
| **Planned subgroup analyses**                   | If yes, list subgroups (affects required N) |            |
| **Planned covariates or blocking factors**      | May reduce error variance                   |            |
| **Primary statistical test for power analysis** | Specify test and model parameters           |            |
| **Alternative tests (sensitivity checks)**      | Optional secondary analyses                 |            |

---

## 5. **Software Planning**

| Software / Tool                      | Notes (version, test family, syntax)                      |
| ------------------------------------ | --------------------------------------------------------- |
| ☐ G*Power                            | Test family (t, F, χ², z). Plan what parameters to enter. |
| ☐ R (pwr, simr, WebPower)            | Script or package planned.                                |
| ☐ SPSS SamplePower / Power procedure | Identify correct module.                                  |
| ☐ Python (statsmodels)               | Planned function.                                         |
| ☐ Other                              |                                                           |

---

## 6. **Output You Intend to Report**

| Item                                     | Description / Example                                                                                                               |
| ---------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| **Target sample size per group / total** | Computed later in software                                                                                                          |
| **Expected power (if fixed N)**          | Will be calculated later                                                                                                            |
| **Minimal detectable effect**            | If sample size is limited                                                                                                           |
| **Sentence for Methods section**         | “A priori power analysis (α = 0.05, power = 0.80) using [software] indicated that [test] requires N = ___ to detect [effect size].” |

---

## 7. **Documentation / Attachments**

☐ Pilot data summary <br />
☐ Literature tables or prior studies for effect sizes <br />
☐ Assumptions for ICC / correlation <br />
☐ Any constraints or notes from ethics or supervisor <br />

---

### 8. **Quick Reference: Cohen’s Conventional Effect Sizes**

| Test            | Small | Medium | Large |
| --------------- | ----- | ------ | ----- |
| t-test (d)      | 0.20  | 0.50   | 0.80  |
| ANOVA (f)       | 0.10  | 0.25   | 0.40  |
| Correlation (r) | 0.10  | 0.30   | 0.50  |
| Regression (f²) | 0.02  | 0.15   | 0.35  |
| Odds Ratio (OR) | 1.5   | 2.5    | 4.0   |

---

### 9. **Recommended Workflow**

1. **Define** hypothesis, outcome, and analysis → fill Sections 1–2.
2. **Specify** α, power, test type, and plausible effect size → fill Section 3.
3. **Account for design features** (repeated, cluster, dropout).
4. **Open G*Power / R / SPSS** → input parameters.
5. **Record computed N** and paste result into Section 6.
6. **Save** both this worksheet and the software printout with your project files.

---
