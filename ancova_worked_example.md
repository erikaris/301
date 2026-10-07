## Worked example: Fitting ANCOVA in R using the MPS314 clinical-trial data

This worked example follows the **MPS314 Medical Statistics** example of a fictitious randomised controlled trial investigating a drug intended to reduce non-HDL cholesterol.

The purpose is to show the complete progression:

> **research question → identify variables → understand the data → specify the ANCOVA model → fit it in R → read the output → interpret the coefficients → test the hypothesis → report the result**

---

### 1. Research scenario

Suppose a clinical trial is investigating whether a new drug reduces non-HDL cholesterol.

Patients are randomly allocated to one of two groups:

- **Placebo**
- **Drug**

Cholesterol is measured before treatment (**baseline**) and then monthly for six months.

The main research question is:

> **Is cholesterol after six months different between the Drug and Placebo groups after adjusting for baseline cholesterol?**

This is an ANCOVA problem because we have:

| Variable | Role | Type |
|---|---|---|
| `month6` | Outcome | Continuous |
| `treatment` | Factor | Categorical |
| `baseline` | Covariate | Continuous |

So:

```text
Outcome     = cholesterol after 6 months
Factor      = treatment group
Covariate   = baseline cholesterol
```

The MPS314 notes explain that baseline cholesterol is expected to affect the end-of-trial cholesterol measurement, so incorporating it into the analysis can help explain variation in the outcome.

---

## 2. What does the data look like?

The dataset contains variables including:

```text
treatment
age
baseline
month1
month2
month3
month4
month5
month6
```

Each row represents one patient.

Conceptually, the relevant part looks like:

```text
patient   treatment   baseline   month6
1         placebo     ...        ...
2         drug        ...        ...
3         placebo     ...        ...
4         drug        ...        ...
...       ...         ...        ...
```

For this particular ANCOVA, we only need:

```text
treatment
baseline
month6
```

The trial has 100 patients, with 50 patients in each treatment group.

---

# 3. Why not simply compare Drug and Placebo?

We could initially ask:

> Is the average `month6` cholesterol different between Drug and Placebo?

That would be a simple two-group comparison.

For example, we could use:

```r
# Compare month-6 cholesterol between Drug and Placebo
t.test(month6 ~ treatment,
       data = cholesterol_imputed)
```

But this analysis ignores an important piece of information:

> **Patients did not necessarily have exactly the same cholesterol before treatment.**

Baseline cholesterol is also expected to be related to cholesterol after six months.

ANCOVA therefore asks a more informative question:

> **If we account for patients' baseline cholesterol, is there evidence that the treatment groups differ at six months?**

---

# 4. The ANCOVA model

The MPS314 notes express the model as:

```math
Y_{ij} = \mu + \tau_i + \beta x_{ij} + \epsilon_{ij}
```

where:

| Symbol | Meaning |
|---|---|
| $Y_{ij}$ | Six-month cholesterol for patient $j$ in treatment group $i$ |
| $\mu$ | Intercept/reference level |
| $\tau_i$ | Treatment-group effect |
| $\beta$ | Effect/slope associated with baseline cholesterol |
| $x_{ij}$ | Baseline cholesterol for patient $j$ in group $i$ |
| $\epsilon_{ij}$ | Random/unexplained variation |

The model assumes:

```math
\epsilon_{ij} \sim N(0,\sigma^2)
```

In simple language:

> **Six-month cholesterol = reference level + treatment effect + baseline-cholesterol effect + unexplained variation.**

The placebo group is treated as the reference group, so:

```math
\tau_1 = 0
```

and:

```math
\tau_2 = \text{Drug effect compared with Placebo}
```

Therefore, $\tau_2$ is the main quantity of interest.

---

# 5. State the hypotheses

The main question is whether there is a treatment effect after adjusting for baseline cholesterol.

The null hypothesis is:

```math
H_0: \tau_2 = 0
```

In words:

> **After adjusting for baseline cholesterol, there is no difference in mean six-month cholesterol between Drug and Placebo.**

The alternative hypothesis is:

```math
H_1: \tau_2 \neq 0
```

In words:

> **After adjusting for baseline cholesterol, there is a difference in mean six-month cholesterol between Drug and Placebo.**

This is a two-sided hypothesis.

---

# 6. Fit the ANCOVA model in R

The MPS314 notes fit the model using `lm()`:

```r
# Fit the ANCOVA model and save it as lm1
#
# month6    = continuous outcome
# baseline  = continuous covariate
# treatment = categorical factor
lm1 <- lm(
  month6 ~ baseline + treatment,
  data = cholesterol_imputed
)

# Display the fitted model results
summary(lm1)
```

The key part is:

```r
month6 ~ baseline + treatment
```

Read this as:

> **Model six-month cholesterol using baseline cholesterol and treatment group.**

Or, in ANCOVA language:

> **Compare the treatment groups on six-month cholesterol while adjusting for baseline cholesterol.**

---

# 7. Why `lm()` rather than `aov()`?

ANCOVA belongs to the general linear-model framework.

The model:

```r
lm(month6 ~ baseline + treatment,
   data = cholesterol_imputed)
```

contains:

- a continuous outcome;
- a continuous predictor/covariate;
- a categorical predictor/factor.

Using `lm()` is particularly useful because the coefficients directly give us:

- the estimated baseline effect;
- the estimated treatment effect;
- their standard errors;
- t-statistics;
- p-values.

This makes it straightforward to estimate and interpret $\beta$ and $\tau$ from the mathematical model.

---

# 8. R output

The MPS314 output is:

```text
Call:
lm(formula = month6 ~ baseline + treatment,
   data = cholesterol_imputed)

Coefficients:
                Estimate Std. Error t value  Pr(>|t|)
(Intercept)      2.41959    0.45292   5.342  6.07e-07 ***
baseline         0.49485    0.10063   4.918  3.57e-06 ***
treatmentdrug   -0.16205    0.05494  -2.950   0.00399 **

Residual standard error: 0.2713 on 97 degrees of freedom
Multiple R-squared:  0.2305
Adjusted R-squared:  0.2147
F-statistic: 14.53
p-value: 3.024e-06
```



---

# 9. Connect the mathematical model to the R output

Recall:

```math
Y_{ij} = \mu + \tau_i + \beta x_{ij} + \epsilon_{ij}
```

R estimates:

```text
(Intercept)      =  2.41959
baseline         =  0.49485
treatmentdrug    = -0.16205
```

Therefore:

```math
\hat{\mu} = 2.41959
```

```math
\hat{\beta} = 0.49485
```

and:

```math
\hat{\tau}_2 = -0.16205
```

The fitted regression equation is therefore approximately:

```math
\widehat{Y} = 2.420 + 0.495(\text{Baseline}) - 0.162(\text{Drug})
```

where:

```math
\text{Drug} =
\begin{cases}
0 & \text{Placebo}\\
1 & \text{Drug}
\end{cases}
```

---

# 10. What does the intercept mean?

The R output gives:

```text
(Intercept) = 2.41959
```

This corresponds to:

```math
\hat{\mu}=2.41959
```

Because Placebo is the reference group, this represents the model's expected six-month cholesterol for a placebo patient whose baseline cholesterol is:

```math
\text{Baseline}=0
```

That is not a particularly meaningful clinical situation.

Therefore, the intercept is mathematically necessary but is not the main quantity we care about here.

This is common in regression models.

---

# 11. What does the baseline coefficient mean?

The output gives:

```text
baseline = 0.49485
```

Therefore:

```math
\hat{\beta}=0.49485
```

Interpretation:

> **Holding treatment group constant, a 1 mmol/L higher baseline cholesterol is associated with approximately 0.495 mmol/L higher expected cholesterol after six months.**

The corresponding test gives:

```text
t = 4.918
p = 3.57e-06
```

So there is strong evidence that baseline cholesterol is associated with the six-month outcome.

This helps explain why baseline is useful as a covariate.

---

# 12. What does `treatmentdrug` mean?

This is the most important coefficient for the treatment question:

```text
treatmentdrug = -0.16205
```

Because Placebo is the reference group:

```math
\text{treatmentdrug} = \text{Drug} - \text{Placebo}
```

Therefore:

```math
\hat{\tau}_2=-0.16205
```

Interpretation:

> **After adjusting for baseline cholesterol, patients receiving the drug are estimated to have mean six-month cholesterol approximately 0.162 mmol/L lower than patients receiving placebo.**

The negative sign is important:

```math
-0.162
```

means that the expected cholesterol is **lower** in the Drug group.

---

# 13. Test the treatment hypothesis

The R output gives:

```text
Estimate = -0.16205
SE       =  0.05494
t        = -2.950
p        =  0.00399
```

We are testing:

```math
H_0:\tau_2=0
```

against:

```math
H_1:\tau_2\neq0
```

Because:

```math
p=0.00399 < 0.05
```

we reject $H_0$ at the 5% significance level.

Therefore:

> **There is evidence of a difference in six-month cholesterol between Drug and Placebo after adjusting for baseline cholesterol.**

More specifically:

> **The Drug group is estimated to have lower mean cholesterol than the Placebo group after adjusting for baseline cholesterol.**

---

# 14. Obtain the confidence interval in R

We should not report only the p-value.

We also want the confidence interval for the estimated treatment effect.

In R:

```r
# Calculate 95% confidence intervals for all model coefficients
confint(lm1)

# Alternatively, request only the confidence interval
# for the treatment coefficient
confint(lm1, "treatmentdrug")
```

For `treatmentdrug`, MPS314 gives approximately:

```text
                    2.5 %       97.5 %
treatmentdrug   -0.2710942   -0.05300828
```

So the 95% confidence interval is approximately:

```math
(-0.271,\,-0.053)
```

This means the data are compatible with the drug reducing mean six-month cholesterol by approximately **0.05 to 0.27 mmol/L**, relative to placebo, after adjustment for baseline cholesterol.

The interval does not contain zero, which is consistent with:

```math
p=0.004
```



---

# 15. How should the result be reported?

A concise report would be:

> **After adjusting for baseline cholesterol, there was evidence of a treatment effect ($p=.004$). The drug was estimated to reduce mean non-HDL cholesterol by approximately 0.16 mmol/L compared with placebo after six months, with a 95% confidence interval of approximately 0.05 to 0.27 mmol/L reduction.**

The MPS314 notes use this same substantive interpretation.

---

# 16. What does "adjusting for baseline" actually mean here?

This is the central idea of ANCOVA.

Suppose two patients have the **same baseline cholesterol**.

The model asks:

> What difference in six-month cholesterol would we expect between them if one received Drug and the other received Placebo?

Because baseline is being held constant, the estimated difference is simply:

```math
\hat{\tau}_2=-0.162
```

We can demonstrate this using a hypothetical baseline value.

Suppose:

```math
\text{Baseline}=5
```

For a Placebo patient:

```math
\widehat{Y}_{Placebo}
=
2.41959 + 0.49485(5)
```

Therefore:

```math
\widehat{Y}_{Placebo}
\approx4.894
```

For a Drug patient with the **same baseline cholesterol**:

```math
\widehat{Y}_{Drug}
=
2.41959 + 0.49485(5)-0.16205
```

Therefore:

```math
\widehat{Y}_{Drug}
\approx4.732
```

The difference is:

```math
4.732-4.894\approx-0.162
```

So at the same baseline cholesterol:

> **The model predicts approximately 0.162 mmol/L lower six-month cholesterol for Drug than Placebo.**

This is what the **adjusted treatment effect** means.

---

# 17. Why not simply use a t-test?

Because there are only two treatment groups, a reasonable question is:

> Why not just compare Drug and Placebo with a t-test?

If we ignore baseline cholesterol, the MPS314 notes show a Welch two-sample t-test:

```r
# Compare the raw month-6 means between treatment groups
# without adjusting for baseline cholesterol
t.test(
  month6 ~ treatment,
  data = cholesterol_imputed
)
```

The unadjusted comparison gives approximately:

```text
Mean in Placebo = 4.639020
Mean in Drug    = 4.519184

p = 0.0501
```

The raw difference is approximately:

```math
4.519-4.639=-0.120
```

So without baseline adjustment, the evidence is much weaker.

---

# 18. Compare the unadjusted model with ANCOVA

The unadjusted linear model can also be fitted using:

```r
# Fit a model containing treatment only
# Baseline cholesterol is deliberately omitted
lm2 <- lm(
  month6 ~ treatment,
  data = cholesterol_imputed
)

# Display the model
summary(lm2)
```

This model is:

```math
Y_{ij}=\mu+\tau_i+\epsilon_{ij}
```

Compare this with ANCOVA:

```math
Y_{ij}=\mu+\tau_i+\beta x_{ij}+\epsilon_{ij}
```

The difference is the additional term:

```math
\beta x_{ij}
```

which allows baseline cholesterol to explain some of the variation in the outcome.

---

# 19. What happens when baseline is omitted?

The MPS314 results provide an excellent illustration.

### ANCOVA

```r
lm(month6 ~ baseline + treatment,
   data = cholesterol_imputed)
```

approximately gives:

```text
Treatment estimate = -0.1621
Treatment SE       =  0.0549
Residual sigma     =  0.2713
R-squared          =  0.2305
p-value treatment  =  0.004
```

### Without baseline

```r
lm(month6 ~ treatment,
   data = cholesterol_imputed)
```

approximately gives:

```text
Treatment estimate = -0.1198
Treatment SE       =  0.0603
Residual sigma     =  0.3017
R-squared          =  0.0387
p-value treatment  ≈ 0.050
```

The important pattern is:

| | Without baseline | ANCOVA |
|---|---:|---:|
| Treatment estimate | -0.120 | -0.162 |
| SE of treatment effect | 0.0603 | 0.0549 |
| Residual standard error | 0.3017 | 0.2713 |
| $R^2$ | 0.0387 | 0.2305 |
| Treatment p-value | about 0.050 | 0.004 |



Why?

Because baseline cholesterol explains some of the differences between patients.

If baseline is omitted, those differences are pushed into:

```math
\epsilon_{ij}
```

the unexplained variation.

That makes the model noisier.

ANCOVA therefore allows:

```text
baseline cholesterol
        ↓
explains some variation
        ↓
less unexplained residual variation
        ↓
more precise treatment estimate
```

This is one of the main reasons baseline adjustment can improve precision in a clinical trial.

---

# 20. Why does the treatment estimate itself change?

Notice that:

```text
Unadjusted difference ≈ -0.120
Adjusted difference   ≈ -0.162
```

The adjusted effect is not simply the raw difference between the two observed group means.

ANCOVA estimates the treatment comparison **after accounting for the relationship between baseline cholesterol and the outcome**.

So:

```math
\text{raw group difference}
\neq
\text{adjusted group difference}
```

in general.

That is exactly what "adjusted" means.

---

# 21. ANCOVA does not mean randomisation failed

This is an important point in the MPS314 clinical-trial context.

Patients were randomly allocated to Drug or Placebo.

Randomisation means that, in expectation, baseline characteristics should be balanced between treatment groups.

It does **not** guarantee that the observed sample means will be exactly identical.

More importantly, if baseline cholesterol is strongly related to six-month cholesterol, including it can explain outcome variation and improve precision.

Therefore:

> **We are not necessarily adjusting for baseline because randomisation failed. We are using relevant baseline information to model the outcome more efficiently.**

---

# 22. Why not simply analyse change from baseline?

Another tempting approach is:

```math
\text{Change}=\text{Month6}-\text{Baseline}
```

and then compare the change scores between Drug and Placebo.

For example:

```r
# Create the change-from-baseline variable
cholesterol_imputed$change <-
  cholesterol_imputed$month6 -
  cholesterol_imputed$baseline

# Compare change between treatment groups
change_model <- lm(
  change ~ treatment,
  data = cholesterol_imputed
)

# Display the result
summary(change_model)
```

However, MPS314 explains that change-score analysis is **not equivalent to ANCOVA**.

ANCOVA estimates:

```math
\text{Month6}
=
\text{Treatment}
+
\beta(\text{Baseline})
+
\epsilon
```

from the data.

By contrast, modelling:

```math
\text{Month6}-\text{Baseline}
```

effectively imposes a baseline coefficient of 1 in the corresponding outcome model.

But in the MPS314 ANCOVA:

```math
\hat{\beta}\approx0.495
```

not 1.

The module therefore cautions against automatically replacing ANCOVA with change-from-baseline analysis.

---

# 23. Adding another covariate

ANCOVA can contain more than one covariate.

For example, suppose we also want to include age.

The model becomes:

```math
Y_{ij}
=
\mu
+
\tau_i
+
\beta x_{ij}
+
\gamma z_{ij}
+
\epsilon_{ij}
```

where:

- $x$ = baseline cholesterol;
- $z$ = age.

In R:

```r
# Fit ANCOVA with two continuous covariates:
# baseline cholesterol and age
lm4 <- lm(
  month6 ~ treatment + baseline + age,
  data = cholesterol_imputed
)

# Display the model results
summary(lm4)
```

In the MPS314 example, the estimated age coefficient is approximately:

```text
age estimate = -0.004235
p = 0.21388
```

so there is no evidence of an age effect in this model.

However, the module makes an important methodological point:

> **Do not simply search through available variables and add covariates because they produce favourable p-values.**

Covariates should generally have a substantive reason for inclusion and, in clinical trials, would normally be specified in advance in the protocol or Statistical Analysis Plan.

---

# 24. Complete R workflow for the MPS314 example

```r
# ============================================================
# STEP 1: INSPECT THE DATA
# ============================================================

# Display the first few rows of the dataset
head(cholesterol_imputed)

# Check variable names and variable types
str(cholesterol_imputed)

# Summarise the variables
summary(cholesterol_imputed)


# ============================================================
# STEP 2: CHECK THE TREATMENT VARIABLE
# ============================================================

# Check the treatment categories
levels(cholesterol_imputed$treatment)

# Count patients in each treatment group
table(cholesterol_imputed$treatment)


# ============================================================
# STEP 3: LOOK AT DESCRIPTIVE STATISTICS
# ============================================================

# Calculate mean baseline cholesterol by treatment group
aggregate(
  baseline ~ treatment,
  data = cholesterol_imputed,
  FUN = mean
)

# Calculate mean month-6 cholesterol by treatment group
aggregate(
  month6 ~ treatment,
  data = cholesterol_imputed,
  FUN = mean
)


# ============================================================
# STEP 4: UNADJUSTED COMPARISON
# ============================================================

# Compare Drug and Placebo at month 6 without adjusting
# for baseline cholesterol
t.test(
  month6 ~ treatment,
  data = cholesterol_imputed
)


# ============================================================
# STEP 5: FIT THE ANCOVA
# ============================================================

# Fit the ANCOVA:
#
# outcome   = month6
# covariate = baseline
# factor    = treatment
lm1 <- lm(
  month6 ~ baseline + treatment,
  data = cholesterol_imputed
)


# ============================================================
# STEP 6: VIEW THE ANCOVA OUTPUT
# ============================================================

# Display coefficients, standard errors,
# t-statistics, p-values and model-fit information
summary(lm1)


# ============================================================
# STEP 7: CONFIDENCE INTERVALS
# ============================================================

# Calculate 95% confidence intervals
# for all model coefficients
confint(lm1)

# Show only the confidence interval
# for the adjusted treatment effect
confint(lm1, "treatmentdrug")


# ============================================================
# STEP 8: MODEL DIAGNOSTICS
# ============================================================

# Arrange the four standard diagnostic plots
# in a 2 × 2 grid
par(mfrow = c(2, 2))

# Display linear-model diagnostic plots
plot(lm1)

# Return to the normal plotting layout
par(mfrow = c(1, 1))


# ============================================================
# STEP 9: COMPARE WITH THE UNADJUSTED MODEL
# ============================================================

# Fit treatment-only model
lm2 <- lm(
  month6 ~ treatment,
  data = cholesterol_imputed
)

# Display the unadjusted model
summary(lm2)

# Compare model summaries
summary(lm1)
summary(lm2)


# ============================================================
# STEP 10: OPTIONAL ADDITIONAL COVARIATE
# ============================================================

# Add age as another continuous covariate
lm4 <- lm(
  month6 ~ treatment + baseline + age,
  data = cholesterol_imputed
)

# Display results
summary(lm4)
```

---

# 25. A systematic way to read any ANCOVA output

When looking at an ANCOVA result, work through it in this order.

### Question 1: What is the outcome?

Here:

```text
month6 cholesterol
```

### Question 2: What is the categorical factor?

Here:

```text
treatment
```

with:

```text
Placebo
Drug
```

### Question 3: What is the continuous covariate?

Here:

```text
baseline cholesterol
```

### Question 4: What is the reference group?

Here:

```text
Placebo
```

### Question 5: What is the covariate coefficient?

Here:

```text
baseline = 0.49485
```

Interpretation:

> Higher baseline cholesterol is associated with higher six-month cholesterol, holding treatment constant.

### Question 6: What is the adjusted group effect?

Here:

```text
treatmentdrug = -0.16205
```

Interpretation:

> Drug is associated with approximately 0.162 mmol/L lower six-month cholesterol than Placebo after adjusting for baseline.

### Question 7: What is the p-value for the treatment effect?

Here:

```text
p = 0.00399
```

Therefore:

```math
p<0.05
```

Reject $H_0$.

### Question 8: What is the confidence interval?

Approximately:

```math
(-0.271,-0.053)
```

It does not contain zero.

### Question 9: What is the conclusion?

> **There is evidence that Drug and Placebo differ in mean six-month cholesterol after adjusting for baseline cholesterol, with the Drug group having lower expected cholesterol.**

---

# 26. The main lesson from this worked example

Without adjustment, we ask:

> **Are Drug and Placebo different at six months?**

With ANCOVA, we ask:

> **Are Drug and Placebo different at six months after taking baseline cholesterol into account?**

In R, the difference is very simple.

Without the covariate:

```r
lm(month6 ~ treatment,
   data = cholesterol_imputed)
```

With the covariate:

```r
lm(month6 ~ baseline + treatment,
   data = cholesterol_imputed)
```

Conceptually:

```text
ANOVA / unadjusted group comparison:

Treatment
    |
    v
 Month 6


ANCOVA:

Treatment ----\
               \
                > Month 6
               /
Baseline -----/
```

The ANCOVA model allows baseline cholesterol to explain some of the variation between patients before estimating the treatment comparison.

The most important line of the R output is therefore:

```text
treatmentdrug   -0.16205   0.05494   -2.950   0.00399
```

Read it as:

> **After adjusting for baseline cholesterol, the Drug group is estimated to have mean six-month cholesterol approximately 0.162 mmol/L lower than the Placebo group, and there is evidence that this adjusted difference is not zero ($p=.004$).**

That is the central idea of the MPS314 ANCOVA example.
