# Analysing Likert-scale data: a comprehensive step-by-step guide

---

## The scenario

You have surveyed 20 participants on their aesthetic preference for an urban green space using a 5-item Likert scale (each item scored 1–5: strongly dislike to strongly like). You also recorded gender (male/female) and a wellbeing score (continuous, 1–100). You want to know:

- Does aesthetic preference differ by gender?
- Is there a relationship between wellbeing and aesthetic preference?

---

## Dummy dataset

Each participant answered 5 Likert items (Q1–Q5) about aesthetic preference. These will be combined into one composite score.

| ID | Gender | Wellbeing | Q1 | Q2 | Q3 | Q4 | Q5 |
|----|--------|-----------|----|----|----|----|----|
| 1  | Male   | 72        | 4  | 3  | 4  | 4  | 3  |
| 2  | Female | 55        | 3  | 3  | 2  | 3  | 3  |
| 3  | Female | 88        | 5  | 5  | 4  | 5  | 5  |
| 4  | Male   | 61        | 2  | 2  | 3  | 2  | 2  |
| 5  | Female | 45        | 3  | 2  | 3  | 3  | 3  |
| 6  | Male   | 79        | 4  | 4  | 5  | 4  | 4  |
| 7  | Female | 50        | 2  | 2  | 2  | 3  | 2  |
| 8  | Male   | 66        | 3  | 3  | 3  | 3  | 4  |
| 9  | Female | 91        | 5  | 5  | 5  | 4  | 5  |
| 10 | Male   | 58        | 3  | 2  | 3  | 3  | 3  |
| 11 | Female | 83        | 4  | 4  | 4  | 5  | 4  |
| 12 | Male   | 44        | 2  | 2  | 2  | 2  | 3  |
| 13 | Female | 70        | 4  | 4  | 3  | 4  | 4  |
| 14 | Male   | 77        | 4  | 4  | 4  | 3  | 4  |
| 15 | Female | 60        | 3  | 3  | 3  | 3  | 3  |
| 16 | Male   | 52        | 2  | 3  | 2  | 2  | 2  |
| 17 | Female | 85        | 5  | 5  | 5  | 5  | 4  |
| 18 | Male   | 68        | 3  | 3  | 4  | 3  | 3  |
| 19 | Female | 74        | 4  | 4  | 4  | 4  | 3  |
| 20 | Male   | 48        | 2  | 2  | 2  | 2  | 3  |

---

## Overview of steps

```
Step 1  →  Descriptive statistics and frequency check
Step 2  →  Cronbach's alpha (reliability of composite scale)
Step 3  →  Create composite score
Step 4  →  Normality testing (Shapiro-Wilk + histogram + QQ plot)
Step 5  →  Check skewness and kurtosis if non-normal
Step 6  →  Check homogeneity of variance (Levene's test)
Step 7A →  Parametric tests (if normal or skewness/kurtosis within ±2)
Step 7B →  Non-parametric tests (if non-normal and outside ±2)
Step 8  →  Effect sizes
Step 9  →  Multiple comparisons correction (if running many tests)
Step 10 →  Interpret and report
```

---

## Step 1: descriptive statistics and frequency check

Always start here before running any inferential test. This gives you a picture of your data and helps spot errors (e.g. values outside the expected range).

### In SPSS
Analyze → Descriptive Statistics → Frequencies
- Move Q1–Q5 and composite score to Variables
- Statistics: mean, median, SD, minimum, maximum, skewness, kurtosis
- Charts: histograms

### In R
```r
data <- data.frame(
  id = 1:20,
  gender = c("Male","Female","Female","Male","Female","Male","Female",
             "Male","Female","Male","Female","Male","Female","Male",
             "Female","Male","Female","Male","Female","Male"),
  wellbeing = c(72,55,88,61,45,79,50,66,91,58,83,44,70,77,60,52,85,68,74,48),
  Q1 = c(4,3,5,2,3,4,2,3,5,3,4,2,4,4,3,2,5,3,4,2),
  Q2 = c(3,3,5,2,2,4,2,3,5,2,4,2,4,4,3,3,5,3,4,2),
  Q3 = c(4,2,4,3,3,5,2,3,5,3,4,2,3,4,3,2,5,4,4,2),
  Q4 = c(4,3,5,2,3,4,3,3,4,3,5,2,4,3,3,2,5,3,4,2),
  Q5 = c(3,3,5,2,3,4,2,4,5,3,4,3,4,4,3,2,4,3,3,3)
)

summary(data[, c("wellbeing","Q1","Q2","Q3","Q4","Q5")])

# Frequency table for a single item
table(data$Q1)
```

**What to look for:**
- Are all values within the expected range (1–5)?
- Are any items heavily skewed (e.g. nearly everyone answered 5)?
- Is the distribution roughly spread, or is it extremely peaked?

---

## Step 2: Cronbach's alpha — reliability of the composite scale

Before combining items into a composite score, check whether they are consistently measuring the same underlying construct. Cronbach's alpha is the standard test for this.

**Rule of thumb (George & Mallery, 2010):**
- α ≥ .90 → excellent
- α ≥ .80 → good
- α ≥ .70 → acceptable
- α < .70 → questionable — consider removing weak items

*Note: if you only have a single Likert item (one question), skip this step — Cronbach's alpha requires at least two items.*

### In SPSS
Analyze → Scale → Reliability Analysis
- Move Q1–Q5 to Items
- Model: Alpha
- Statistics → tick "Item" and "Scale if item deleted" → OK

### In R
```r
library(psych)
alpha(data[, c("Q1","Q2","Q3","Q4","Q5")])
```

### Example output
```
Cronbach's alpha = .91

           raw_alpha  std.alpha  alpha if deleted
Q1              .91        .91            .90
Q2              .91        .91            .90
Q3              .91        .91            .91
Q4              .91        .91            .91
Q5              .91        .91            .91
```

**Interpretation:** α = .91 is excellent — all five items are consistently measuring the same construct. The "alpha if item deleted" column shows that removing any single item would not substantially improve reliability, so all items are retained.

**If alpha is below .70:** check the "alpha if item deleted" column — if removing a specific item raises alpha above .70, consider dropping it and re-running.

---

## Step 3: create the composite score

Average (or sum) the items to form one composite score per participant.

### In SPSS
Transform → Compute Variable
- Target variable: aesthetic_composite
- Expression: MEAN(Q1, Q2, Q3, Q4, Q5)

### In R
```r
data$aesthetic_composite <- rowMeans(data[, c("Q1","Q2","Q3","Q4","Q5")])
```

Now use `aesthetic_composite` as your outcome variable for all subsequent analyses.

---

## Step 4: normality testing

Test whether the composite score is normally distributed within each group. Use three complementary methods: Shapiro-Wilk, histogram, and QQ plot.

### 4a. Shapiro-Wilk test

Use Shapiro-Wilk for samples under 300. Kolmogorov-Smirnov is designed for larger samples and is overly sensitive with small ones.

**In SPSS:**
Analyze → Descriptive Statistics → Explore
- Dependent List: aesthetic_composite
- Factor List: gender
- Plots → tick "Normality plots with tests" → OK

**In R:**
```r
by(data$aesthetic_composite, data$gender, shapiro.test)
```

**Example output:**
```
Female: W = 0.943, p = .581
Male:   W = 0.911, p = .252
```

Both p > .05 → normally distributed within each group.

**If p < .05:** do not stop here — proceed to Step 4b and 4c before deciding.

---

### 4b. Histogram

A visual check that complements Shapiro-Wilk. Shapiro-Wilk can flag minor deviations as significant in large samples, or miss them in very small ones — so always look at the shape of the distribution too.

**In SPSS:** produced automatically by Explore (Step 4a above).

**In R:**
```r
par(mfrow = c(1,2))
hist(data$aesthetic_composite[data$gender == "Female"],
     main = "Female", xlab = "Aesthetic composite", col = "lightblue", breaks = 5)
hist(data$aesthetic_composite[data$gender == "Male"],
     main = "Male", xlab = "Aesthetic composite", col = "lightgreen", breaks = 5)
```

**What to look for:** roughly bell-shaped, no extreme outliers, no severe pile-up at one end.

---

### 4c. QQ plot (quantile-quantile plot)

A QQ plot compares your data's distribution against what a perfectly normal distribution would look like. Points should fall approximately along the diagonal reference line.

**In SPSS:** produced automatically alongside Shapiro-Wilk in the Explore output (labelled "Normal Q-Q Plot").

**In R:**
```r
par(mfrow = c(1,2))
qqnorm(data$aesthetic_composite[data$gender == "Female"], main = "QQ plot: Female")
qqline(data$aesthetic_composite[data$gender == "Female"], col = "red")

qqnorm(data$aesthetic_composite[data$gender == "Male"], main = "QQ plot: Male")
qqline(data$aesthetic_composite[data$gender == "Male"], col = "red")
```

**How to read the QQ plot:**
- Points closely following the line → approximately normal → proceed with parametric tests
- Points curving away at both ends (S-shape) → heavy tails → check kurtosis
- Points veering off at one end only → skewed distribution → check skewness
- One or two points far from the line → potential outliers → investigate individually

---

## Step 5: skewness and kurtosis (if Shapiro-Wilk is significant)

If Shapiro-Wilk gives p < .05 but the histogram and QQ plot look roughly normal, check skewness and kurtosis values to decide whether to proceed with parametric tests.

**Accepted threshold (George & Mallery, 2010):** both skewness and kurtosis within **±2**.

If both are within ±2: parametric tests are justifiable — report the values and cite George & Mallery (2010) in your methods section.
If either exceeds ±2: switch to non-parametric alternatives (Step 7B).

### In SPSS
Produced automatically in the Explore output (Descriptives table).

### In R
```r
library(e1071)
tapply(data$aesthetic_composite, data$gender, skewness)
tapply(data$aesthetic_composite, data$gender, kurtosis)
```

**Example output:**
```
Skewness — Female: 0.21, Male: -0.18
Kurtosis — Female: -0.74, Male: -0.62
```

Both within ±2 → proceed with parametric tests.

---

## Step 6: Levene's test — homogeneity of variance

Before running a t-test or ANOVA, check that variance is roughly equal across groups. This is a separate assumption from normality.

### In SPSS
Produced automatically in the Independent Samples T-test output.

### In R
```r
library(car)
leveneTest(aesthetic_composite ~ gender, data = data)
```

**Example output:**
```
F(1, 18) = 0.43, p = .521
```

p > .05 → variances are equal across groups → use standard t-test output.

**If p < .05 (unequal variances):** use Welch's t-test instead (SPSS labels this "Equal variances not assumed"; in R use `var.equal = FALSE` in `t.test()`).

---

## Step 7A: parametric tests (normal distribution or skewness/kurtosis within ±2, Levene's p > .05)

### Gender vs aesthetic preference → independent samples t-test

**In SPSS:**
Analyze → Compare Means → Independent Samples T-test
- Test variable: aesthetic_composite
- Grouping variable: gender (1 = Male, 2 = Female) → OK

**In R:**
```r
t.test(aesthetic_composite ~ gender, data = data, var.equal = TRUE)
```

**Example output:**
```
t(18) = -2.31, p = .033
Mean (Female) = 3.80, Mean (Male) = 2.90
95% CI [-1.74, -0.08]
```

**Interpretation:** there is a statistically significant difference in aesthetic composite scores between female (M = 3.80) and male (M = 2.90) participants (t(18) = -2.31, p = .033). Female participants rated the green space more favourably on average.

**Effect size (Cohen's d):**
```r
library(effsize)
cohen.d(aesthetic_composite ~ gender, data = data)
# d = 1.03 → large effect
```

---

### Wellbeing vs aesthetic preference → Pearson correlation

**In SPSS:**
Analyze → Correlate → Bivariate
- Variables: wellbeing, aesthetic_composite
- Pearson → OK

**In R:**
```r
cor.test(data$wellbeing, data$aesthetic_composite, method = "pearson")
```

**Example output:**
```
r = .93, t(18) = 10.44, p < .001
95% CI [.83, .97]
```

**Interpretation:** there is a strong, statistically significant positive correlation between wellbeing and aesthetic composite score (r = .93, p < .001). Participants with higher wellbeing scores consistently rated the green space more favourably.

---

## Step 7B: non-parametric tests (non-normal and skewness/kurtosis outside ±2)

### Gender vs aesthetic preference → Mann-Whitney U

**In SPSS:**
Analyze → Nonparametric Tests → Legacy Dialogs → 2 Independent Samples
- Test variable: aesthetic_composite
- Grouping variable: gender (define groups: 1, 2)
- Mann-Whitney U → OK

**In R:**
```r
wilcox.test(aesthetic_composite ~ gender, data = data)
```

**Example output:**
```
W = 11.5, p = .028
Median (Female) = 4.0, Median (Male) = 3.0
```

**Interpretation:** aesthetic composite scores were significantly higher in the female group (Mdn = 4.0) than the male group (Mdn = 3.0), U = 11.5, p = .028. Report medians, not means, for non-parametric tests.

**Effect size:**
```r
library(rstatix)
wilcox_effsize(data, aesthetic_composite ~ gender)
# r = 0.51 → large effect
```

---

### Wellbeing vs aesthetic preference → Spearman correlation

**In SPSS:**
Analyze → Correlate → Bivariate
- Variables: wellbeing, aesthetic_composite
- Spearman → OK

**In R:**
```r
cor.test(data$wellbeing, data$aesthetic_composite, method = "spearman")
```

**Example output:**
```
rho = .91, S = 84, p < .001
```

**Interpretation:** a strong positive rank-order association between wellbeing and aesthetic composite score (rho = .91, p < .001).

---

## Step 8: effect sizes — always report alongside p-values

A significant p-value only tells you the result is unlikely due to chance. Effect size tells you how large the difference or association actually is.

| Test | Effect size measure | Small | Medium | Large |
|---|---|---|---|---|
| t-test | Cohen's d | 0.2 | 0.5 | 0.8 |
| Mann-Whitney U | r = Z/√N | 0.1 | 0.3 | 0.5 |
| Pearson correlation | r | 0.1 | 0.3 | 0.5 |
| Spearman correlation | rho | 0.1 | 0.3 | 0.5 |
| ANOVA | eta-squared (η²) | 0.01 | 0.06 | 0.14 |
| Kruskal-Wallis | eta-squared (η²) | 0.01 | 0.06 | 0.14 |

---

## Step 9: multiple comparisons correction

If you are running several tests on the same dataset (e.g. testing gender, age, and wellbeing all against the same outcome), the chance of at least one false positive increases. Apply a Bonferroni correction: divide your alpha threshold by the number of tests.

Example: running 3 tests at α = .05 → new threshold = .05/3 = .017. Only results with p < .017 are considered significant.

In SPSS and R, you apply this manually by adjusting the threshold you compare your p-values against — it is not a button, it is a decision you report in your methods section.

---

## Step 10: interpreting and reporting results

For every test, report:
1. The test statistic (t, U, r, rho, F, H)
2. Degrees of freedom where applicable
3. The p-value
4. The effect size
5. Means and SDs (parametric) or medians and IQRs (non-parametric)
6. The direction of the effect (who scored higher, or which direction the correlation goes)

**Common interpretation mistakes to avoid:**
- "p < .05 means the effect is large" — no, it means the result is statistically significant. Always check effect size separately.
- "p > .05 means there is no effect" — no, it means there was insufficient evidence of an effect in this sample. A small sample may simply lack the power to detect a real effect.
- Reporting only means for non-parametric tests — always report medians when using Mann-Whitney or Kruskal-Wallis.

---

## Complete decision flowchart

```
START
│
├── Is your scale a single Likert item or a composite of multiple items?
│   ├── Single item → treat as ordinal → go to Step 7B (non-parametric)
│   └── Composite (multiple items summed/averaged)
│       │
│       ├── Step 2: Cronbach's alpha ≥ .70?
│       │   ├── Yes → proceed
│       │   └── No → revise scale (remove weak items), re-check alpha
│       │
│       ├── Step 3: compute composite score
│       │
│       ├── Step 4: normality (Shapiro-Wilk + histogram + QQ plot)
│       │   ├── p > .05 AND histogram/QQ look normal → PARAMETRIC (Step 7A)
│       │   └── p < .05 OR visual concerns
│       │       │
│       │       ├── Step 5: check skewness and kurtosis
│       │       │   ├── Both within ±2 → PARAMETRIC justifiable (Step 7A)
│       │       │   │   → report values, cite George & Mallery (2010)
│       │       │   └── Either outside ±2 → NON-PARAMETRIC (Step 7B)
│       │       │
│       ├── Step 6: Levene's test (before t-test/ANOVA only)
│       │   ├── p > .05 → equal variances → standard t-test/ANOVA
│       │   └── p < .05 → unequal variances → Welch's t-test
│       │
│       ├── 2 groups (e.g. gender) → t-test or Mann-Whitney U
│       ├── 3+ groups (e.g. age bands) → ANOVA or Kruskal-Wallis + post-hoc
│       └── Continuous predictor (e.g. wellbeing) → Pearson or Spearman
│
├── Step 8: always report effect sizes alongside p-values
└── Step 9: apply Bonferroni correction if running multiple tests
```

---

## Reporting checklist

- [ ] Descriptive statistics reported (M, SD for parametric; Mdn, IQR for non-parametric)
- [ ] Cronbach's alpha reported if using a composite scale
- [ ] Normality test results reported (W statistic + p-value from Shapiro-Wilk)
- [ ] Histogram and QQ plot inspected (note this in methods even if not included in the report)
- [ ] Skewness and kurtosis values reported if Shapiro-Wilk was significant
- [ ] Levene's test result reported before t-test/ANOVA
- [ ] Correct parametric or non-parametric test selected and justified
- [ ] Test statistic, degrees of freedom, and p-value reported for every test
- [ ] Effect size reported alongside every p-value
- [ ] Bonferroni correction applied and noted if running multiple tests
- [ ] Alpha threshold stated at the start of the analysis section (usually .05)
