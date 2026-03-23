# Normality in Statistics

## What is a Normality Test?

A **normality test** examines whether your data follow a **normal distribution** (also called a Gaussian distribution). Many **parametric tests** (e.g., t-test, ANOVA, Pearson correlation, linear regression) assume that the **residuals** (and sometimes the variables) are normally distributed.

### Why it matters

If the normality assumption is violated:

* Parameter estimates are usually still unbiased,
* But **p-values and confidence intervals** may become inaccurate (especially in small samples).

---

# What Exactly Should Be Normal?

This is very important (and often misunderstood):

* **t-test / ANOVA** → The **dependent variable** should be approximately normal *within each group*.
* **Correlation (Pearson)** → Both variables should be approximately normally distributed.
* **Linear regression** → The **residuals**, not X or Y themselves, must be normally distributed.

With **large samples (n > 30–50)**, normality becomes less critical due to the Central Limit Theorem.

---

# Common Normality Tests

### A. Shapiro–Wilk Test (Recommended)

* Best for small to medium samples (n < 2000).
* Null hypothesis (H₀): Data are normally distributed.
* If **p > .05** → assume normality.
* If **p < .05** → evidence against normality.

> Don’t rely only on p-value — combine with plots

### B. Kolmogorov–Smirnov (K–S) Test

* Less powerful than Shapiro–Wilk.
* Often reported automatically in software.

---

# Graphical Methods (Always Recommended!)

Statistical tests are sensitive in large samples. So combine with:

* Histogram
  - Bell-shaped → good
  - Skewed → not normal
* Q–Q Plot (most informative)
  - Points follow a straight line → normal
  - Systematic curve/deviation → not normal
* Boxplot (to detect outliers)

---

# 4️⃣ How to Test Normality in SPSS

### 🔹 Method 1: Using Explore (Best Way)

1. Go to **Analyze**
2. Click **Descriptive Statistics**
3. Click **Explore**
4. Move your variable into *Dependent List*
5. Click **Plots**
6. Tick:

   * ✔ Normality plots with tests
   * ✔ Histogram
7. Click **Continue → OK**

### 🔹 Output Interpretation

In the output:

* Look at **Shapiro–Wilk** column
* Check **Sig. value**

Example:

```
Shapiro-Wilk
Statistic = .978
Sig. = .213
```

Since p = .213 > .05 → Data are approximately normal.

Also inspect:

* Q–Q plot → points should follow diagonal line
* Histogram → bell-shaped curve

---

# 5️⃣ How to Test Normality in R

## A. Shapiro–Wilk Test

```r
shapiro.test(data$variable)
```

Example:

```r
shapiro.test(df$score)
```

Output:

```r
Shapiro-Wilk normality test

W = 0.97, p-value = 0.21
```

If p > .05 → normality assumed.

---

## B. Kolmogorov–Smirnov Test

```r
ks.test(df$score, "pnorm", 
        mean(df$score), 
        sd(df$score))
```

(Note: Must specify mean and SD.)

---

## C. Histogram

```r
hist(df$score, breaks = 10)
```

---

## D. Q–Q Plot (Very Important)

```r
qqnorm(df$score)
qqline(df$score)
```

If points roughly follow the straight line → acceptable normality.

---

# 6️⃣ What If Data Are Not Normal?

Options:

### ✔ If Sample Size Is Large (> 50)

Often safe to continue with parametric tests.

### ✔ Transform Data

* Log transformation:

  ```r
  log_data <- log(df$score)
  ```
* Square root transformation:

  ```r
  sqrt_data <- sqrt(df$score)
  ```

### ✔ Use Nonparametric Tests

* Instead of t-test → Mann–Whitney U
* Instead of Pearson → Spearman correlation
* Instead of ANOVA → Kruskal–Wallis

---

# 7️⃣ Important Concept (Advanced but Useful)

For regression:

```r
model <- lm(y ~ x, data = df)
shapiro.test(residuals(model))
```

You test **residuals**, not y.

---

# 8️⃣ Practical Advice (What I Tell Students)

As a statistics tutor, you might like this guideline:

1. Always check histogram + Q–Q plot first.
2. Use Shapiro–Wilk for small samples.
3. Don’t rely only on p-value.
4. With large samples, focus more on plots than tests.
5. Report both test statistic and visual inspection.

---

# 9️⃣ Example of How to Report

> Shapiro–Wilk test indicated that the scores did not significantly deviate from normality, W = .97, p = .21. Visual inspection of the Q–Q plot also suggested approximate normality.

---

# How to Test Normality for Residuals?

Great question — this is the **correct way** to think about normality in regression.

In **linear regression**, we do **NOT** test whether X or Y is normal.

We test whether the **residuals** are normally distributed.

---

# 1️⃣ What Are Residuals?

Residual = observed value − predicted value

[
e_i = y_i - \hat{y}_i
]

Normality assumption applies to:

[
e_i \sim N(0, \sigma^2)
]

---

# 2️⃣ When Do We Need Residual Normality?

Residual normality is required for:

* Valid **p-values**
* Valid **confidence intervals**
* Valid **hypothesis tests**

It is **not required** for:

* Estimating regression coefficients (they remain unbiased)

---

# 3️⃣ How to Test Residual Normality in SPSS

### Step 1: Run Linear Regression

1. Go to **Analyze**
2. Click **Regression**
3. Click **Linear**
4. Move:

   * Dependent variable → *Dependent*
   * Independent variable(s) → *Independent(s)*

---

### Step 2: Save Standardized Residuals

1. Click **Save**
2. Tick:

   * ✔ Standardized Residuals
3. Click **Continue → OK**

SPSS will create a new variable (usually named `ZRESID`).

---

### Step 3: Test Normality of Residuals

Now:

1. Go to **Analyze**
2. Click **Descriptive Statistics**
3. Click **Explore**
4. Move `ZRESID` into *Dependent List*
5. Click **Plots**
6. Tick:

   * ✔ Histogram
   * ✔ Normality plots with tests
7. Click **Continue → OK**

---

### Interpretation

Look at:

* **Shapiro–Wilk test**
* Q–Q plot
* Histogram

If:

* p > .05 → residuals approximately normal
* Q–Q plot follows diagonal → acceptable

---

# 4️⃣ How to Test Residual Normality in R

## Step 1: Run Regression

```r
model <- lm(y ~ x1 + x2, data = df)
```

---

## Step 2: Extract Residuals

```r
res <- residuals(model)
```

---

## Step 3: Shapiro–Wilk Test

```r
shapiro.test(res)
```

If p > .05 → normality assumption satisfied.

---

## Step 4: Q–Q Plot (Very Important)

```r
qqnorm(res)
qqline(res)
```

If points roughly follow straight line → good.

---

## Step 5: Histogram

```r
hist(res, breaks = 10)
```

---

# 5️⃣ Important Teaching Point (Very Useful for You)

For large samples (n > 100):

* Shapiro–Wilk will almost always be significant.
* Even tiny deviations become statistically significant.

So for large samples:
👉 Rely more on **Q–Q plot**
👉 Look for severe skewness or heavy tails
👉 Minor deviations are acceptable

---

# 6️⃣ What If Residuals Are Not Normal?

Options:

### ✔ Check for outliers

```r
rstandard(model)
```

### ✔ Transform dependent variable

```r
model2 <- lm(log(y) ~ x1 + x2, data = df)
```

### ✔ Use robust regression

### ✔ Use bootstrapped confidence intervals

---

# 7️⃣ How to Report It

Example:

> Visual inspection of the Q–Q plot suggested that residuals were approximately normally distributed. The Shapiro–Wilk test was non-significant, W = .98, p = .18.

Or (large sample):

> Although the Shapiro–Wilk test was significant, inspection of the Q–Q plot indicated only minor deviations from normality; therefore, the assumption was considered met.

---

# Normality and Likert Data

**With Likert data, true normality is unlikely because:**
- Likert responses are ordinal (ranked categories), not continuous
- Averaging multiple items creates a quasi-continuous variable, but it's still bounded (e.g., if you have 5-point scales, the average is between 1-5)
- True normality requires unbounded, continuous data

**In practice:**
- **Paired t-test:** Reasonably robust to violations of normality, especially if:
  - Your averaged DV has enough items (e.g., 5+ Likert questions averaged gives more stability)
  - Your sample size is moderate-to-large (n > 30 helps)
  - The distribution isn't severely skewed
  
- **Wilcoxon signed-rank test:** The safer, more conservative choice for ordinal/quasi-continuous Likert data. It makes fewer distributional assumptions.

**Suggestion:** 
Check normality with a **Shapiro-Wilk test** AND **visual inspection (Q-Q plot)**. If either shows moderate deviation from normality, **lean toward Wilcoxon**—it's more defensible for Likert data anyway.


