# Measurement evaluation: reliability, agreement, validity and accuracy

*A reusable statistics tutoring reference. All examples and outputs are illustrative unless explicitly calculated. Adapt the method to the actual sampling and measurement design.*

## Applying the guide to Abeer's appointment (provisional)

The referral does **not** establish what "reliability" means, whether the outcome is numerical or categorical, whether one or both eyes are measured, or how many observers and occasions are involved. The most defensible immediate task is to clarify the statistical question and data layout. Ask Abeer to show five anonymised rows and define the unit, scale, repetition, observer/instrument and acceptable error. Then use Section A to select the appropriate method. **Do not prescribe ICC or Bland–Altman solely because the research is ophthalmological.**

## 1. What are we trying to establish?

| Property | Question | Why assess it? | When? |
|---|---|---|---|
| **Reliability** | Are repeated measurements sufficiently consistent, relative to differences among objects? | Determine whether measurement noise overwhelms differences of interest | Before using a measure for research or clinical decisions; after changes to raters, procedures or instruments |
| **Repeatability / precision** | How variable are repeated measurements under specified conditions? | Quantify measurement error in original units | Same operator/instrument/conditions, or explicitly specified reproducibility conditions |
| **Agreement** | How close are two measurements, raters or instruments? | Decide whether measurements can be substituted or compared | Method-comparison and inter-rater studies |
| **Validity** | Does evidence support the proposed interpretation and use of scores? | Avoid measuring the wrong construct | When developing, adapting or applying a measurement instrument |
| **Accuracy** | How close is a numerical measurement to an appropriate reference, or how well does a test identify the true condition? | Assess systematic and total error or diagnostic classification performance | With a suitable reference value or diagnostic reference standard |

Reliability is not validity. A bathroom scale can always read 3 kg too high (repeatable but inaccurate). Two thermometers can correlate perfectly while disagreeing by 2 °C. A non-significant paired t-test does **not** establish agreement. A high ICC does **not** guarantee clinically acceptable absolute error.

## A. Translate the research question into a statistical question — guided conversation

The **answer examples are hypothetical**, not statements about Abeer's actual dataset. Ask the student to replace them with their own answers.

| Ask the student | Why it matters | Example answer (hypothetical ophthalmology study) |
|---|---|---|
| What is your precise research question? | Identifies the estimand and purpose. | "How repeatable are measurements of an eye angle using one device?" |
| What is one measurement, and what are its units? | Determines outcome scale and interpretation. | "A numerical angle in degrees." |
| What does one row represent? | Identifies the observational unit. | "One eye at one visit; two readings in separate columns." |
| How many people, eyes, raters, devices, visits and trials? | Reveals replication and clustering. | "40 people, one eye each, one examiner, two trials at the same visit." |
| Are the same units measured each time? | Establishes pairing and missing-data structure. | "Yes, both readings are available for every eye." |
| What does 'reliable' mean for this study? | Distinguishes relative reliability from absolute repeatability and agreement. | "The two readings should be close enough for clinical use." |
| Is there a reference or gold standard? | Determines whether accuracy/criterion validation is possible. | "No; the aim is repeatability, not accuracy." |
| What difference would be clinically acceptable? | Enables interpretation beyond a coefficient. | "Differences within ±2 degrees, justified by clinical literature." |
| Are any observations correlated? | Avoids false independence assumptions. | "Only one eye per person, so no within-person eye clustering." |

**Translate the example:** Numerical paired readings from independent participants, same examiner and instrument, two trials. Quantify mean bias, 95% limits of agreement and within-subject standard deviation/repeatability coefficient; optionally report a correctly specified single-measure absolute-agreement ICC for relative reliability. Assess the limits against the prespecified ±2-degree criterion, with confidence intervals. This is a worked *design example*, not a conclusion about Abeer's study.

## 2. Ask these questions before selecting a test

1. **Question:** What decision will the measurements support? What constitutes a meaningful difference?
2. **Unit:** What is measured (patient, eye, image, specimen, questionnaire)? In what units?
3. **Scale:** Continuous numerical, ordinal, nominal, or binary?
4. **Replication:** How many readings per unit, how many occasions, and how far apart?
5. **Raters and instruments:** Same or different? Fixed set or random sample from a population?
6. **Clustering:** Both eyes, multiple lesions, repeated visits, or several ratings of one patient?
7. **Reference:** Is there a defensible gold/reference standard? Is it itself imperfect?
8. **Acceptability:** What bias, difference, classification error or measurement error is acceptable *before* inspecting results?
9. **Precision:** What confidence interval width is required? How was sample size justified?

## 3. Method catalogue and software guide

| Method | Typical use | SPSS | R |
|---|---|---|---|
| Intraclass correlation coefficient (ICC) | Numerical intra-/inter-rater relative reliability | Analyze > Scale > Reliability Analysis > Statistics > ICC; select model, agreement/consistency, single/average | `irr::icc()`, `psych::ICC()`; mixed models for complex designs |
| Within-subject SD (sw), standard error of measurement (SEM), repeatability coefficient (RC), coefficient of variation (CV) | Absolute error/repeatability | Compute paired differences; Descriptives SD; compute `sw=SD(diff)/sqrt(2)`, `RC=1.96*sqrt(2)*sw`; for >2 replicates use ANOVA/mixed-model residual variance | `sd(diff)/sqrt(2)`, `1.96*sd(diff)`; `lme4::lmer()` for replicates |
| Pearson/Spearman correlation | Association, **not agreement** | Analyze > Correlate > Bivariate | `cor.test()` |
| Cronbach's alpha; McDonald's omega | Internal consistency of multi-item scales (not test–retest reliability) | Analyze > Scale > Reliability Analysis (alpha); omega may need extensions | `psych::alpha()`, `psych::omega()` |
| Cohen's kappa | Two raters, nominal categorical data | Analyze > Descriptive Statistics > Crosstabs > Statistics > Kappa | `irr::kappa2()` |
| Weighted Cohen's kappa | Two raters, ordered categories | Standard Crosstabs kappa is unweighted; use an extension or R | `irr::kappa2(...,weight="squared")` (confirm weighting convention) |
| Fleiss' kappa | Multiple raters, nominal categories under appropriate design | Extension/custom syntax | `irr::kappam.fleiss()` |
| Krippendorff's alpha | Multi-rater data, nominal/ordinal/interval, with missingness depending on implementation | Extension/R | `irr::kripp.alpha()` (check matrix orientation and distance) |
| Percentage / positive / negative agreement | Categorical agreement, particularly binary outcomes | Crosstabs counts; calculate percentages | `table()`, manual proportions |
| Bland–Altman mean bias and limits of agreement (LOA) | Two paired numerical methods/readings | Compute difference and mean; Descriptives; scatterplot with reference lines | Base R `mean()`, `sd()`, `plot()`, `abline()`; `MethComp` for complex method comparison |
| Concordance correlation coefficient (CCC) | Numerical concordance (precision plus location agreement) | Extension/custom syntax | `DescTools::CCC()` or `epiR::epi.ccc()` |
| Passing–Bablok / Deming regression | Method-comparison calibration; both methods have error | Extensions/custom syntax | `mcr::mcreg()`; not a replacement for LOA |
| Content validity | Expert assessment of whether items cover construct | Descriptive expert ratings; content-validity indices computed manually | Manual indices; qualitative evidence |
| Exploratory factor analysis (EFA) | Investigate latent dimensionality of questionnaire | Analyze > Dimension Reduction > Factor | `psych::fa()` |
| Confirmatory factor analysis (CFA) | Test prespecified factor structure | AMOS (if available) or other SEM software | `lavaan::cfa()` |
| Convergent / discriminant / criterion-related evidence | Relationship to theoretically related/unrelated measures or criterion | Correlations/regression; depends on hypothesis | `cor.test()`, `lm()`; SEM if appropriate |
| Mean error (bias), MAE, RMSE | Continuous accuracy vs numeric reference | Compute error, absolute error and squared error; aggregate | `mean(pred-ref)`, `mean(abs(pred-ref))`, `sqrt(mean((pred-ref)^2))` |
| Sensitivity, specificity, PPV, NPV, likelihood ratios | Binary diagnostic test vs reference standard | Crosstabs; compute ratios manually or use extensions | `table()` and manual ratios; `epiR::epi.tests()` |
| ROC curve / AUC | Discrimination of a numerical test score | Analyze > Classify > ROC Curve (menu varies by version) | `pROC::roc()`, `pROC::auc()` |
| Calibration plot / calibration slope/intercept | Accuracy of predicted probabilities | Custom compute, binning, regression or extensions | `glm()` and calibration packages; external validation preferable |

**Terminology caveat:** Some papers call within-subject SD an SEM, while others compute `SEM = SD_total * sqrt(1-ICC)`. These are not always interchangeable. State the definition and underlying model. Also distinguish SEM (standard error of measurement) from SEM (standard error of the mean).

## 4. Worked example A: numerical test–retest repeatability and Bland–Altman

**Scenario:** A technician measures the same ocular dimension twice in five stable eyes. Each row is one independent eye from a different participant. Values are arbitrary units.

| Eye | Test 1 | Test 2 | Difference (2 − 1) |
|---|---:|---:|---:|
| 1 | 12 | 13 | 1 |
| 2 | 18 | 17 | -1 |
| 3 | 24 | 25 | 1 |
| 4 | 30 | 29 | -1 |
| 5 | 36 | 37 | 1 |

**R (every line explained):**

```r
first <- c(12, 18, 24, 30, 36)      # Enter first measurements
second <- c(13, 17, 25, 29, 37)     # Enter second measurements
diff <- second - first               # Calculate paired differences
avg <- (first + second) / 2          # Calculate paired averages
bias <- mean(diff)                   # Calculate systematic mean difference
sd_diff <- sd(diff)                  # Sample SD of differences
lower <- bias - 1.96 * sd_diff        # Approximate lower 95% LOA
upper <- bias + 1.96 * sd_diff        # Approximate upper 95% LOA
sw <- sd_diff / sqrt(2)              # Within-subject SD for this paired design
rc <- 1.96 * sqrt(2) * sw            # Repeatability coefficient
print(c(bias=bias, sd_diff=sd_diff, lower=lower, upper=upper, sw=sw, RC=rc)) # Print statistics
plot(avg, diff, xlab="Paired average", ylab="Second minus first") # Bland–Altman scatterplot
abline(h=bias)                       # Add mean-bias line
abline(h=c(lower,upper), lty=2)      # Add 95% LOA lines
```

**Calculated output (rounded):** bias = **0.20**; SD of differences = **1.095**; LOA = **−1.947 to 2.347**; within-subject SD = **0.775**; RC = **2.147**.

**Interpretation:** On average, the second reading is 0.20 units higher. Individual repeat differences could be considerably larger. Compare the limits to a *predefined* clinical tolerance, e.g. ±1 unit would not be met. Five pairs are inadequate for a precise clinical estimate; compute confidence intervals for bias and LOA in a real study. The RC describes repeatability only under assumptions of negligible bias and stable variance.

**SPSS:** Transform > Compute Variable: `difference=second-first` and `average=(first+second)/2`. Analyze > Descriptive Statistics > Descriptives on `difference`. Compute LOA as mean ± 1.96×SD. Graphs > Chart Builder > Scatter: X=`average`, Y=`difference`; add horizontal lines. For ICC use Analyze > Scale > Reliability Analysis > Statistics > ICC, but decide model from the design first.

## 5. Worked example B: two clinicians classify a finding

**Scenario:** Two raters independently classify 40 examinations as normal or abnormal.

| | B normal | B abnormal |
|---|---:|---:|
| A normal | 18 | 2 |
| A abnormal | 4 | 16 |

**R:**

```r
counts <- matrix(c(18, 4, 2, 16), nrow=2)   # Construct 2×2 table by columns
rownames(counts) <- c("Normal", "Abnormal")  # Label rater A's rows
colnames(counts) <- c("Normal", "Abnormal")  # Label rater B's columns
po <- sum(diag(counts)) / sum(counts)        # Calculate observed agreement
pe <- sum(rowSums(counts)*colSums(counts)) / sum(counts)^2 # Chance agreement
kappa <- (po-pe)/(1-pe)                     # Cohen's kappa
print(c(agreement=po, kappa=kappa))          # Display results
```

**Calculated output:** observed agreement **0.85**; kappa **0.70**.

**Interpretation:** Raters agree on 85% of cases; chance-corrected kappa is 0.70. Kappa is affected by prevalence and marginal imbalance, so show the table and category-specific agreement too. Do not apply unweighted kappa to ordered severity scores without considering weighted kappa.

**SPSS:** Enter one row per examination, with separate rater columns. Analyze > Descriptive Statistics > Crosstabs; select Kappa under Statistics and observed counts under Cells.

## 6. Worked example C: numerical accuracy against a reference

**Scenario:** A device reports measurements against known reference values (arbitrary units).

| Specimen | Reference | Device | Error |
|---|---:|---:|---:|
| 1 | 10 | 11 | 1 |
| 2 | 20 | 19 | -1 |
| 3 | 30 | 32 | 2 |
| 4 | 40 | 42 | 2 |

**R:**

```r
ref <- c(10, 20, 30, 40)                 # Reference values
measured <- c(11, 19, 32, 42)            # Device measurements
error <- measured - ref                   # Signed error for each specimen
bias <- mean(error)                       # Average signed error
mae <- mean(abs(error))                   # Mean absolute error
rmse <- sqrt(mean(error^2))               # Root mean squared error
print(c(bias=bias, MAE=mae, RMSE=rmse))   # Display accuracy metrics
```

**Calculated output:** bias **1.00**, MAE **1.50**, RMSE **1.581**.

**Interpretation:** The device reads 1 unit high on average; typical absolute error is 1.5 units; RMSE penalises larger errors more strongly. These metrics assess numerical accuracy *only if the reference is suitable*. For method interchangeability, also inspect error against magnitude and Bland–Altman limits.

**SPSS:** Compute `error=device-reference`, `absolute_error=ABS(error)`, `squared_error=error**2`. Descriptives gives mean error and MAE; square-root the mean squared error to obtain RMSE.

## 7. Worked example D: diagnostic accuracy

**Scenario:** A binary screening test is compared with an independent reference diagnosis in 100 patients.

| | Disease present | Disease absent |
|---|---:|---:|
| Test positive | 36 (TP) | 12 (FP) |
| Test negative | 4 (FN) | 48 (TN) |

**R:**

```r
tp <- 36                                 # True positives
fp <- 12                                 # False positives
fn <- 4                                  # False negatives
tn <- 48                                 # True negatives
sensitivity <- tp/(tp+fn)                # Probability of positive test if diseased
specificity <- tn/(tn+fp)                # Probability of negative test if non-diseased
ppv <- tp/(tp+fp)                        # Probability of disease if test positive
npv <- tn/(tn+fn)                        # Probability of no disease if test negative
lr_pos <- sensitivity/(1-specificity)    # Positive likelihood ratio
lr_neg <- (1-sensitivity)/specificity    # Negative likelihood ratio
print(c(sensitivity=sensitivity,specificity=specificity,PPV=ppv,NPV=npv,LRpos=lr_pos,LRneg=lr_neg)) # Show metrics
```

**Calculated output:** sensitivity **0.90**, specificity **0.80**, PPV **0.75**, NPV **0.923**, LR+ **4.50**, LR− **0.125**.

**Interpretation:** The test detects 90% of cases with disease and correctly excludes 80% without disease in this example. PPV and NPV depend on disease prevalence; they may differ in another clinical population. Report uncertainty and consider selection and verification bias.

**SPSS:** Analyze > Descriptive Statistics > Crosstabs with test and reference result; use counts to compute metrics. If the test generates continuous scores, use ROC Curve to examine sensitivity–specificity trade-offs and AUC; choose thresholds with clinical consequences in mind.

## 8. Worked example E: internal consistency of a questionnaire

**Scenario:** Five questionnaire items are intended to reflect one latent construct, such as perceived fatigue. Assess whether item responses cohere before creating a total score.

```r
# Install once if needed: install.packages("psych")
library(psych)                              # Load psychometric functions
items <- data.frame(                       # Create illustrative item responses
  q1=c(1,2,3,4,5,2,4,3),                  # Item 1
  q2=c(1,2,4,4,5,2,4,3),                  # Item 2
  q3=c(2,2,3,4,5,1,4,3),                  # Item 3
  q4=c(1,3,3,4,5,2,5,3),                  # Item 4
  q5=c(1,2,3,5,5,2,4,4)                   # Item 5
)
result <- psych::alpha(items)              # Estimate Cronbach's alpha
print(result$total)                       # Inspect raw and standardised alpha
print(result$item.stats)                  # Inspect item statistics
```

**Hypothetical output (not calculated from these eight rows):** alpha = **0.84**, 95% CI **0.78–0.89**. This suggests relatively high internal consistency, but it does not establish unidimensionality, validity, or test–retest reliability. Investigate factor structure and item content; a large alpha may arise from redundant items.

**SPSS:** Analyze > Scale > Reliability Analysis; move item columns into Items, choose Alpha, request item-total and alpha-if-item-deleted statistics. Reverse-code reverse-worded items before analysis. For omega or factor analysis, R or SEM software may be preferable.

## 9. Worked example F: Intraclass Correlation Coefficient (ICC) and repeated ratings

**Intraclass Correlation Coefficient (ICC)** is a family of statistics for quantifying relative reliability of numerical measurements. It compares variation between measured objects with variation arising from raters, occasions and measurement error, according to the specified model. It does not, by itself, establish clinically acceptable agreement.

**Scenario:** Two clinicians give numerical ratings to the same ten participants. ICC model choice depends on whether raters are fixed or sampled, whether the aim is consistency or absolute agreement, and whether the eventual score is a single rating or an average.

```r
# Install once if needed: install.packages("irr")
library(irr)                                # Load ICC implementation
ratings <- data.frame(                     # Create paired numerical ratings
  clinicianA=c(12,18,24,30,36,15,21,27,33,39), # First clinician
  clinicianB=c(13,17,25,29,37,16,22,26,34,38) # Second clinician
)
fit <- irr::icc(ratings,                    # Estimate ICC from paired columns
                model="twoway",             # Two-way design
                type="agreement",           # Penalise systematic rater differences
                unit="single",              # Reliability of a single reading
                conf.level=0.95)           # 95% confidence interval
print(fit)                                  # Inspect estimate, CI and model details
```

**Dummy input (each row is one participant):**

| Participant | Clinician A | Clinician B |
|---|---:|---:|
| P01 | 12 | 13 |
| P02 | 18 | 17 |
| P03 | 24 | 25 |
| P04 | 30 | 29 |
| P05 | 36 | 37 |
| P06 | 15 | 16 |
| P07 | 21 | 22 |
| P08 | 27 | 26 |
| P09 | 33 | 34 |
| P10 | 39 | 38 |

**Example of the output fields to inspect** (illustrative numbers, **not verified results for the table above**):

```text
Intraclass Correlation Coefficient (ICC)
Model: Two-way; Type: Absolute agreement; Unit: Single measurement
Number of participants: 10; Raters: 2
ICC estimate: 0.96
95% confidence interval: 0.86 to 0.99
```

**Interpretation:** Under the selected two-way, single-measure, absolute-agreement model, an ICC of 0.96 indicates high relative reliability. The lower confidence limit of 0.86 indicates uncertainty about how high the population reliability is. This alone cannot tell us whether a disagreement of 2 units would be clinically acceptable. Calculate Bland–Altman limits of agreement or within-subject measurement error as appropriate. ICC may be high because participants differ substantially from one another.

**SPSS step-by-step:**

1. Put one participant on each row, with `clinicianA` and `clinicianB` as separate numeric columns.
2. Choose **Analyze → Scale → Reliability Analysis**; move both columns into *Items*.
3. Open **Statistics → Intraclass correlation coefficient**.
4. Select **Two-Way Random** if raters represent a random sample from the population of raters of interest, or **Two-Way Mixed** for fixed raters; this choice depends on the generalisation target.
5. Select **Absolute Agreement** if numerical interchangeability matters, or **Consistency** if a systematic rater shift is not considered error.
6. Request the **95% confidence interval**. Read **Single Measures** for one future rating or **Average Measures** for the average of both ratings.
7. Report the full model specification, estimate, confidence interval, sample size and clinical tolerance.

**R output:** Run the commented code above and use the actual printed estimate and confidence interval; do not substitute the illustrative values in this guide.

**SPSS:** Analyze > Scale > Reliability Analysis > Statistics > ICC. Specify the full model and whether single or average measures apply. Do not infer the model solely from a paper's ICC(2,1)/ICC(3,1) label: naming conventions differ.

## 10. Complex designs: stop and adapt

- **Both eyes per patient:** eyes are correlated; avoid treating them as independent patients. Consider mixed models or cluster-aware agreement methods.
- **Multiple repeats per person:** a simple two-column Bland–Altman calculation is not sufficient; estimate within-person variance using a suitable repeated-measures approach.
- **Multiple raters, incomplete crossing:** standard ICC and Fleiss kappa assumptions may fail; consider mixed models or suitable generalisability theory.
- **Changing biological state:** a test–retest study cannot separate real change from measurement error without design assumptions.
- **Ordinal vs continuous:** avoid automatically treating few-category severity ratings as interval-scale measurements.
- **Reference standard errors:** no method can establish absolute truth from an unreliable reference.
- **Sample size:** plan precision for ICC/LOA or diagnostic sensitivity/specificity, not merely statistical significance.

## 11. How to report results

State (1) units and sample, (2) exact replication and sampling design, (3) method and model choice, (4) estimate and confidence interval, (5) prespecified acceptable tolerance or performance criterion, (6) limitations including clustering and reference-standard quality. Distinguish *statistically detectable* from *clinically important* differences.

### Useful foundational references

- Bland JM, Altman DG (1986). Statistical methods for assessing agreement between two methods of clinical measurement. *Lancet*.
- Bland JM, Altman DG (2007). Agreement between methods of measurement with multiple observations per individual. *Journal of Biopharmaceutical Statistics*.
- Koo TK, Li MY (2016). A guideline of selecting and reporting intraclass correlation coefficients for reliability research. *Journal of Chiropractic Medicine*. https://doi.org/10.1016/j.jcm.2016.02.012
- COSMIN methodology: measurement properties of patient-reported outcome measures (reliability, validity, responsiveness).
- STARD reporting guidelines: diagnostic accuracy studies.
