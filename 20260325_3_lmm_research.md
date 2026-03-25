# Tutoring Note: Analyzing Your Time-Series Data with Changing Treatments
**Student**: Year 4 MBiolSci/Microbiology  
**Topic**: Statistical analysis of time-series with treatment regime changes  
**Date**: [Session Date]

---

## 1. YOUR PROBLEM SUMMARY

You've collected data from a **time-series experiment** where:

- **Independent variables**: Time (weeks) and Treatment regimens (which change during the experiment)
- **Dependent variable**: Some measured outcome (e.g., bacterial load, enzyme activity, colony size)
- **Design**: You sampled **different individuals** at **different timepoints** (independent samples, NOT repeated measures)
- **Research question**: Does treatment and/or time affect your outcome? Can you use 2-way ANOVA?

### The Core Issue

You initially thought **2-way ANOVA** would work, but there's a critical problem:

**2-way ANOVA assumes both factors are FIXED (stable and consistently present throughout your study). Your treatment regimen changed mid-experiment, which violates this assumption.**

#### What "Fixed" Means

**Fixed factor** = A factor whose levels are consistently applicable/present across all observations throughout the study.

```
Your Study Reality:
Week 1–6:   Treatment A is applied ✓
Week 7–12:  Treatment B is applied ✓, Treatment A is gone ✗

↓

Treatment A and B are NOT both "present" throughout
→ Treatment is NOT fixed
→ 2-way ANOVA fails
```

---

## 2. WHY 2-WAY ANOVA DOESN'T WORK FOR YOUR CASE

### What 2-Way ANOVA Expects
```
Treatment A: Present at ALL timepoints (Weeks 1, 3, 6, 9, 12)
Treatment B: Present at ALL timepoints (Weeks 1, 3, 6, 9, 12)
Time:        Fixed categorical levels (Weeks 1, 3, 6, 9, 12)

Result: Can cleanly separate effects of Treatment and Time
```

### What Actually Happened in Your Study
```
Treatment A: Only Weeks 1–6
Treatment B: Only Weeks 7–12 (switched mid-experiment)
Time:        Fixed categorical levels (Weeks 1, 3, 6, 9, 12)

Result: Treatment is nested within Time
        Can't separate treatment effect from time effect
```

### Why This Is a Problem

If you force a 2-way ANOVA:
- Is the change in outcome due to **time passing**?
- Or due to the **treatment switch**?
- Or both?

**You won't know—these effects are confounded.**

---

## 3. WHY REPEATED-MEASURES ANOVA DOESN'T WORK EITHER

### What Repeated-Measures ANOVA Requires
```
Same individuals measured at all timepoints

Example:
Individual 1: Measured at Week 1, 3, 6, 9, 12 ✓
Individual 2: Measured at Week 1, 3, 6, 9, 12 ✓
Individual 3: Measured at Week 1, 3, 6, 9, 12 ✓

→ Repeated-measures ANOVA works
```

### Your Sampling Design (Independent Samples)
```
Week 1:  Individual 1, 2, 3
Week 3:  Individual 4, 5, 6
Week 6:  Individual 7, 8, 9
Week 9:  Individual 10, 11, 12
Week 12: Individual 13, 14, 15

↑ DIFFERENT individuals at each timepoint

→ Repeated-measures ANOVA fails
   (No individual is measured more than once)
```

### Your Design is Actually Good!

Your **independent sampling** is well-suited for the analysis we're going to recommend because:
- ✅ Each individual measured only once (no repeated-measure confounds)
- ✅ Clean independence between observations
- ✅ Flexible for handling time-varying treatments

---

## 4. SOLUTION 1: LINEAR REGRESSION WITH INTERACTION

Before I introduce mixed-effects models, let me address your excellent question: **Why not just use simple linear regression with interaction?**

### What Linear Regression With Interaction Does

```
Outcome ~ Week + Treatment + Week:Treatment
```

**This model:**
- Treats Week as **continuous** (linear trend over time)
- Treats Treatment as **categorical** (A vs B)
- Includes an **interaction** term (does the treatment effect change over time?)

### Why It's Useful and Partially Valid

Linear regression with interaction **IS actually appropriate** if:

1. ✅ Your timepoints follow a **linear trend** (or you're happy assuming they do)
2. ✅ You have **no grouping structure** (data from one population)
3. ✅ You assume **constant variance** across all predictions
4. ✅ Your **independent sampling** is truly independent (yours is ✓)

**Output example:**
```
Outcome = 3.50 + 0.24(Week) + 0.80(Treatment_B) - 0.15(Week × Treatment_B)

Interpretation:
- Intercept (3.50): Baseline outcome at Week 0, Treatment A
- Week (0.24): Outcome increases by 0.24 units per week (on average)
- TreatmentB (0.80): Treatment B is 0.80 units higher than A (at baseline)
- Week:TreatmentB (-0.15): The time trend is 0.15 units LESS steep for Treatment B
                           (B's effect diminishes over time compared to A)
```

### Why It Falls Short for Your Case

| Aspect | Issue | Impact |
|--------|-------|--------|
| **Grouping/Batch effects** | If you sampled from different populations/batches, they may have different baseline levels | Your results could be biased; confidence intervals too narrow; p-values misleading |
| **Unbalanced samples** | If you have unequal numbers at different timepoints | Regression handles it but less efficiently than mixed models |
| **Violation of assumptions** | If residuals aren't normally distributed or variance isn't constant | Standard errors may be wrong |
| **Throws away grouping info** | Simple regression ignores natural clustering in your data | Less statistical power; inflated residual variation |

### The Key Limitation: Ignoring Population/Batch Structure

**Example scenario:**

You have 3 bacterial populations, but don't include them in the regression:

```
True situation:
- Pop_X naturally has high baseline bacterial load (6.0 units)
- Pop_Y naturally has low baseline bacterial load (4.0 units)
- Pop_Z naturally has medium baseline bacterial load (5.0 units)

Simple regression ignores this:
- Treats all observations as coming from same population
- This variation gets lumped into the "error" term
- Residual variation is INFLATED
- Standard errors become WIDER
- Confidence intervals become WIDER
- You LOSE statistical power (harder to find "significant" effects)
- P-values may be MISLEADING

Linear mixed model accounts for this:
- Explicitly models population differences
- Uses remaining "true error" for inference
- Standard errors are narrower (and correct!)
- Better statistical power
- P-values are accurate
```

### The Math Behind It

**Simple Regression:**
```
Outcome = β₀ + β₁(Week) + β₂(Treatment_B) + β₃(Week × Treatment_B) + ε

ε = ALL remaining error:
    = population differences + batch effects + measurement error + true randomness
    
ε is LARGE because it includes population differences
→ Standard errors are WIDE
→ You lose power
```

**Linear Mixed-Effects Model:**
```
Outcome = β₀ + β₁(Week) + β₂(Treatment_B) + β₃(Week × Treatment_B) 
          + u₀ᵢ(population i) + ε

Where:
u₀ᵢ = population-specific variation (modeled separately)
ε = true random error (measurement noise, randomness)

ε is SMALLER because population differences are removed
→ Standard errors are narrower (but still correct!)
→ You maintain power
→ P-values are accurate
```

### When Simple Linear Regression IS Sufficient

Simple linear regression is fine **only if**:

```
✓ You sampled from ONE population only
✓ No natural clustering or grouping in your data
✓ All samples truly independent and homogeneous
✓ Sample sizes equal across treatments and timepoints

Example: 50 bacterial colonies randomly sampled with no batch information
→ Simple regression is acceptable
```

### When You MUST Use Mixed-Effects

You **SHOULD use mixed-effects** if:

```
✓ Multiple populations/batches in your data
✓ Multiple observations per batch
✓ Sample sizes unequal across treatments/timepoints
✓ Natural clustering (even if unintended)
✓ You want to be conservative and correct
```

**For your case**: You likely have multiple populations/batches → **Use mixed-effects ✓**

---

## 5. SOLUTION 2: LINEAR MIXED-EFFECTS MODEL (RECOMMENDED)

### What Is a Linear Mixed-Effects Model?

A **linear mixed-effects model (LMM)** combines:

| Component | What It Does |
|-----------|-------------|
| **Fixed Effects** | Models average relationships across all data (Week, Treatment, interaction) |
| **Random Effects** | Accounts for natural variation between groups (populations, batches) |
| **Error Term** | Captures remaining randomness |

**Key advantage**: It acknowledges that your data has a **hierarchical structure**—multiple observations may be nested within populations or batches.

### The LMM Framework

```
Outcome ~ Week + Treatment + Week:Treatment + (1 | Population)

Fixed Effects:
  - Week (continuous): Linear trend over time
  - Treatment (categorical): A vs B
  - Week:Treatment: Does the time trend differ by treatment?

Random Effect:
  - (1 | Population): Different populations have different baselines
```

### Why LMM Is Superior to Simple Linear Regression

| Advantage | Explanation |
|-----------|-------------|
| **Handles grouping properly** | Accounts for variation between populations/batches; gives you correct uncertainty estimates |
| **Flexible time structure** | Can treat time as continuous (linear trend) or categorical (different means at each week) |
| **Robust to unbalanced data** | Efficiently handles unequal sample sizes across timepoints |
| **Correct standard errors** | If you ignore grouping in simple regression, your SEs are biased |
| **Better predictions** | "Borrows strength" across groups, improving estimates |
| **Statistical power** | Narrower confidence intervals (but still correct) = better ability to detect effects |

---

## 6. CASE EXAMPLE: BACTERIAL LOAD STUDY

Let's use a concrete microbiology example to make this concrete.

### Study Design

**Research question**: Does changing antibiotic regimens affect bacterial load over time?

**Experiment**:
- **Timepoints**: Weeks 1, 3, 6, 9, 12
- **Treatment change**: 
  - Weeks 1–6: Antibiotic A (initial treatment)
  - Weeks 7–12: Antibiotic B (switched due to emerging resistance)
- **Outcome**: Log-transformed bacterial load (CFU/mL)
- **Sampling**: Different bacterial colonies at each timepoint (independent samples)
- **Groups**: 3 different bacterial populations (Pop_X, Pop_Y, Pop_Z)

### Your Data

```
Colony_ID | Week | Population | Treatment | Log_Bacterial_Load
----------|------|------------|-----------|-------------------
Col_001   | 1    | Pop_X      | A         | 4.2
Col_002   | 1    | Pop_X      | A         | 4.5
Col_003   | 1    | Pop_Y      | A         | 3.8
Col_004   | 3    | Pop_X      | A         | 5.1
Col_005   | 3    | Pop_Z      | A         | 4.9
Col_006   | 6    | Pop_Y      | A         | 5.8
Col_007   | 9    | Pop_X      | B         | 6.2
Col_008   | 9    | Pop_Z      | B         | 5.9
Col_009   | 12   | Pop_Y      | B         | 6.5
Col_010   | 12   | Pop_X      | B         | 6.8
```

### Your Research Questions

1. **Does bacterial load change over time?** (Week effect)
2. **Does switching antibiotics affect bacterial load?** (Treatment effect)
3. **Does the time trajectory differ between treatments?** (Interaction)
4. **Do different populations have different baseline loads?** (Population variation)

---

## 7. STEP-BY-STEP ANALYSIS: HOW TO SOLVE THIS

### Step 1: Organize Your Data

**Ensure your data structure looks like this:**

```
Individual_ID | Week | Population | Treatment | Outcome
---|---|---|---|---
Col_001 | 1 | Pop_X | A | 4.2
Col_002 | 1 | Pop_X | A | 4.5
Col_003 | 1 | Pop_Y | A | 3.8
Col_004 | 3 | Pop_X | A | 5.1
Col_005 | 3 | Pop_Z | A | 4.9
Col_006 | 6 | Pop_Y | A | 5.8
Col_007 | 9 | Pop_X | B | 6.2
Col_008 | 9 | Pop_Z | B | 5.9
Col_009 | 12 | Pop_Y | B | 6.5
Col_010 | 12 | Pop_X | B | 6.8
```

**Critical**: Ensure `Treatment` column correctly reflects which treatment was active at each `Week`.

---

### Step 2: Fit the Model

#### OPTION A: LINEAR REGRESSION (Simple, but less robust)

##### In R:
```r
# Load data
data <- read.csv("your_data.csv")

# Fit simple linear regression with interaction
model_lm <- lm(Outcome ~ Week + Treatment + Week:Treatment, data = data)

# View results
summary(model_lm)

# Check assumptions
plot(model_lm)
```

**Output Interpretation**:
```
Coefficients:
              Estimate Std. Error t value Pr(>|t|)
(Intercept)    3.50     0.35     10.0    <.001 ***
Week           0.24     0.04      6.0    <.001 ***
TreatmentB     0.80     0.45      1.8     0.08 .
Week:TreatmentB -0.15   0.06     -2.5    0.02 *

Interpretation:
- Intercept (3.50): Baseline bacterial load at Week 0, Treatment A
- Week (0.24): Load increases by 0.24 units per week
- TreatmentB (0.80): Treatment B is 0.80 units higher at baseline
- Week:TreatmentB (-0.15): Time trend is 0.15 units LESS steep for B vs A
                           (B's growth slows compared to A)

Significance:
- Week: *** (p < 0.001) = Highly significant
- TreatmentB: . (p = 0.08) = Marginally significant (trend)
- Week:TreatmentB: * (p = 0.02) = Significant
```

##### In SPSS:
```
Menu: Analyze → Regression → Linear

Dependent Variable: Outcome
Independents: Week, Treatment, Week×Treatment

Steps:
1. Click "Statistics" → Select "Descriptives" and "Confidence intervals"
2. Click "Plots" → Plot ZPRED vs ZRESID to check assumptions
3. Click "Save" → Save predicted values and residuals
4. Click OK

SPSS Output:
- Look at "Coefficients" table for estimates and p-values
- Look at "Model Summary" for R² (how much variance explained)
- Look at residual plots to assess assumptions
```

**When to report this**: Use simple regression ONLY if you verified you have no grouping structure

---

#### OPTION B: LINEAR MIXED-EFFECTS MODEL (Recommended)

##### In R:
```r
# Install lme4 if needed: install.packages("lme4")
library(lme4)
library(lmerTest)  # For p-values

# Fit linear mixed-effects model
model_lme <- lmer(Outcome ~ Week + Treatment + Week:Treatment + (1 | Population),
                  data = data,
                  REML = TRUE)  # Use restricted maximum likelihood

# View results
summary(model_lme)

# Get confidence intervals for fixed effects
confint(model_lme, level = 0.95)

# Compare with simple regression (to see the difference)
model_lm <- lm(Outcome ~ Week + Treatment + Week:Treatment, data = data)
summary(model_lm)
# Notice: Standard errors wider in model_lm if populations differ
```

**Output Interpretation**:
```
Fixed effects:
                        Estimate Std. Error df t value Pr(>|t|)
(Intercept)             3.52     0.42     2.1  8.4     0.016 *
Week                    0.24     0.04    14.2  6.1    <.001 ***
TreatmentB              0.78     0.48     2.3  1.6     0.15
Week:TreatmentB        -0.14     0.06    14.5 -2.3     0.04 *

Random effects:
 Groups      Name        Std.Dev
 Population  (Intercept)  0.31
 Residual                 0.25

Interpretation:
- Fixed effects: Same as simple regression coefficients
- BUT standard errors now account for population grouping
- Random effect (0.31): Different populations vary by ~0.31 units in baseline
  This is substantial! Shows population matters.
- Residual (0.25): Remaining error after accounting for population

Confidence intervals:
              2.5 %  97.5 %
(Intercept)   2.15    4.89
Week          0.16    0.32
TreatmentB   -0.30    1.86
Week:TreatmentB -0.27  -0.01
```

##### In SPSS:
```
NOTE: SPSS's mixed-effects module is called "Mixed Models"
     It's more limited than R but works for this analysis

Menu: Analyze → Mixed Models → Linear

Steps:
1. Subjects: Leave empty (your data is independent, not clustered within subjects)
2. Fixed effects: Click "Add"
   - Add Week (continuous)
   - Add Treatment (categorical factor)
   - Add Week×Treatment (highlight both, click interaction button)
3. Random effects: Click "Add"
   - Choose "Intercept"
   - Specify Subject: Population
   - Leave Covariance Type as "Variance Components"
4. Click "Estimation" tab → Ensure "Restricted Maximum Likelihood" is selected
5. Click "Statistics" → Check "Fixed Effects" to get p-values
6. Click OK

SPSS Output:
Look at:
- "Fixed Effects" table for coefficients and p-values
- "Random Effects" table for population variation (Intercept SD)
- "Information Criteria" to compare models
```

---

### Step 3: Check Model Assumptions

Both linear regression and LMM assume:
1. ✓ **Normality**: Residuals are normally distributed
2. ✓ **Homoscedasticity**: Constant variance across predictions
3. ✓ **Independence**: Observations are independent (you have this ✓)

#### Check in R:

```r
# For simple linear regression:
plot(model_lm)
  # Creates 4 plots:
  # 1. Residuals vs Fitted → look for random scatter, no patterns
  # 2. Q-Q plot → points should follow diagonal line
  # 3. Scale-Location → spread of residuals should be constant
  # 4. Residuals vs Leverage → look for influential outliers

# For linear mixed model:
plot(model_lme)
qqnorm(residuals(model_lme))
hist(residuals(model_lme))

# Formal tests:
shapiro.test(residuals(model_lme))  # p > 0.05 = normal ✓
```

**What to look for:**
- **Residuals vs Fitted**: Should show random scatter with no clear pattern
  - ✓ Good: Random cloud
  - ✗ Bad: Funnel shape (suggests unequal variance)
  - ✗ Bad: Systematic curve (suggests non-linearity)

- **Q-Q plot**: Points should follow the diagonal line
  - ✓ Good: Points close to line
  - ✗ Bad: S-shaped curve (suggests non-normality)

#### Check in SPSS:

```
After fitting model:

1. Save residuals and predicted values:
   - Click "Statistics" → Check "Saved Predicted Values and Residuals"
   - Choose "Unstandardized" residuals

2. Create residual plots:
   - Graphs → Chart Builder
   - X-axis: Predicted values
   - Y-axis: Residuals
   - Look for random scatter

3. Q-Q plot for normality:
   - Analyze → Descriptive Statistics → Explore
   - Select residuals
   - Check "Normality plots with tests"
```

**If assumptions are violated:**
- Try **log-transforming** your outcome: `Outcome_log = log(Outcome)`
- **Remove outliers** if justified (document why)
- **Check for data entry errors**
- Consider **generalized linear model** (for count/proportional data)

---

### Step 4: Interpret Your Results

#### Main Questions Your Analysis Answers

| Effect | Question | How to Interpret |
|--------|----------|-----------------|
| **Week (coefficient)** | Does bacterial load change over time? | Positive = load increases per week; p-value says if significant |
| **Treatment (coefficient)** | Does Treatment B differ from A? | Coefficient = magnitude of difference; p-value says if significant |
| **Week:Treatment (interaction)** | Does time trend differ by treatment? | Negative = B's growth is slower; p-value says if significant |
| **Random effect SD** (LMM only) | Do populations differ? | SD tells you magnitude of population differences |

#### Example Interpretation (Bacterial Load Study)

From the LMM output above:

```
Model: Outcome ~ Week + Treatment + Week:Treatment + (1 | Population)

Results:
- Week: β = 0.24, SE = 0.04, p < 0.001 ***
  INTERPRETATION: Bacterial load increases by 0.24 units per week
                 This is highly statistically significant
                 95% CI: [0.16, 0.32]

- TreatmentB: β = 0.78, SE = 0.48, p = 0.15 (not significant)
  INTERPRETATION: Treatment B appears 0.78 units higher at baseline
                 BUT this is not statistically significant (p = 0.15)
                 95% CI: [-0.30, 1.86] (crosses zero)
                 Could be lack of power or genuinely small effect

- Week:TreatmentB: β = -0.14, SE = 0.06, p = 0.04 *
  INTERPRETATION: The slope (time trend) is 0.14 units LESS steep for B
                 Treatment B slows the growth rate vs Treatment A
                 This IS statistically significant (p = 0.04)
                 95% CI: [-0.27, -0.01]

- Random effect (Pop variation): SD = 0.31
  INTERPRETATION: Different populations vary by ~0.31 units in baseline load
                 This is substantial (about the same size as TreatmentB!)
                 Shows population is important—glad we included it

WRITE-UP:
"A linear mixed-effects model revealed that bacterial load increased 
significantly over time (β = 0.24, SE = 0.04, p < 0.001). While Treatment B 
showed a trend toward higher baseline load (β = 0.78, SE = 0.48, p = 0.15), 
the treatment-by-week interaction was statistically significant (β = -0.14, 
SE = 0.06, p = 0.04), indicating that Treatment B slowed bacterial growth 
compared to Treatment A. Population differences in baseline load were 
substantial (random intercept SD = 0.31), suggesting that bacterial population 
is an important source of variation that must be accounted for in the analysis."
```

---

### Step 5: Visualize Your Results

Creating a plot helps readers understand your findings.

#### In R (ggplot2):

```r
library(ggplot2)
library(tidyverse)

# Create predicted values for plotting
new_data <- expand.grid(
  Week = seq(1, 12, by = 0.5),
  Treatment = c("A", "B"),
  Population = NA  # Average across populations
)

new_data$Predicted <- predict(model_lme, newdata = new_data, re.form = NA)

# Basic plot
ggplot(data, aes(x = Week, y = Outcome, color = Treatment)) +
  geom_point(alpha = 0.5, size = 2) +
  geom_line(data = new_data, aes(y = Predicted), size = 1) +
  facet_wrap(~Population) +
  theme_minimal() +
  labs(
    title = "Bacterial Load Over Time by Treatment",
    x = "Week",
    y = "Log Bacterial Load (CFU/mL)",
    color = "Treatment"
  ) +
  theme(
    legend.position = "bottom",
    strip.text = element_text(face = "bold")
  )

# Alternative: Plot without population facets
ggplot(data, aes(x = Week, y = Outcome, color = Treatment)) +
  geom_point(alpha = 0.4, size = 2.5) +
  geom_line(data = new_data, aes(y = Predicted), size = 1.2) +
  geom_ribbon(data = new_data, aes(y = NULL, ymin = Predicted - 0.2, 
                                    ymax = Predicted + 0.2, fill = Treatment),
              alpha = 0.2, color = NA) +  # Confidence band (approximate)
  theme_minimal() +
  labs(
    title = "Bacterial Load Over Time by Antibiotic Treatment",
    x = "Week",
    y = "Log Bacterial Load (CFU/mL)",
    color = "Treatment",
    fill = "Treatment"
  ) +
  theme(
    legend.position = "bottom",
    axis.title = element_text(size = 12, face = "bold"),
    plot.title = element_text(size = 13, face = "bold")
  )
```

**What this shows:**
- Raw data points (colored by treatment)
- Fitted lines showing predicted trajectory for each treatment
- Separate panels for each population (if included)

#### In SPSS:

```
After fitting your mixed model:

Graphs → Chart Builder
1. Drag "Treatment" to X-axis
2. Drag "Week" to Y-axis
3. Set Y scale to "Predicted Mean"
4. Set X scale to categorical
5. Separate lines for Treatment groups
6. Click OK

This creates a simple line plot showing treatment trajectories over time
```

---

## 8. COMPARISON: SIMPLE LINEAR REGRESSION vs. LINEAR MIXED-EFFECTS

When should you use each approach?

| Aspect | Simple Linear Regression | Linear Mixed-Effects |
|--------|--------------------------|----------------------|
| **When to use** | Homogeneous population, no grouping | Data has grouping (populations, batches, blocks) |
| **Handles grouping** | ✗ Ignores it (biases results) | ✓ Explicitly models it |
| **Unbalanced data** | ⚠️ Works but less efficient | ✓ Handles efficiently |
| **Uncertainty estimates** | May be biased if grouping ignored | Correct, accounting for structure |
| **Standard errors** | Too wide if grouping ignored | Narrower and correct |
| **Statistical power** | Lower (loses power) | Higher |
| **Complexity** | Simpler, easier to report | More complex, needs explanation |
| **Software** | All (R, SPSS, Excel) | Requires lme4 (R) or Mixed (SPSS) |
| **Reporting** | Familiar to readers | Less familiar, explain carefully |

### Decision Rule for Your Study

**Use Linear Regression IF:**
- You sampled from ONE population only
- You have no natural grouping in your data
- Sample sizes exactly equal across treatments and timepoints
- You're confident there's no hierarchical structure

**Use Linear Mixed-Effects IF:**
- You sampled from MULTIPLE populations/batches
- Sample sizes are unequal
- You want to account for population-level variation
- You want correct uncertainty estimates
- You want to be conservative and defensible

**For your case**: If you have multiple populations → **Use LMM** ✓

---

## 9. COMPLETE ANALYSIS WALKTHROUGH: STEP-BY-STEP R CODE

Here's everything you need to run the full analysis:

```r
# ============================================================
# COMPLETE TIME-SERIES ANALYSIS WITH CHANGING TREATMENTS
# ============================================================

# 1. LOAD REQUIRED PACKAGES
# ============================================================
library(lme4)           # Linear mixed-effects models
library(lmerTest)       # p-values for lme4
library(ggplot2)        # Plotting
library(tidyverse)      # Data manipulation
library(car)            # For assumption tests

# 2. LOAD AND EXPLORE DATA
# ============================================================
data <- read.csv("bacterial_load_data.csv")

# First look at data
head(data)
str(data)
summary(data)

# Check data structure
table(data$Week)           # How many samples per week?
table(data$Treatment)      # How many per treatment?
table(data$Week, data$Treatment)  # Crosstab
table(data$Population)     # Populations represented?

# Descriptive statistics
data %>%
  group_by(Week, Treatment) %>%
  summarise(
    n = n(),
    Mean = mean(Outcome),
    SD = sd(Outcome),
    .groups = 'drop'
  )

# 3. FIT SIMPLE LINEAR REGRESSION FOR COMPARISON
# ============================================================
model_lm <- lm(Outcome ~ Week + Treatment + Week:Treatment, data = data)
summary(model_lm)

# 4. FIT LINEAR MIXED-EFFECTS MODEL (RECOMMENDED)
# ============================================================
model_lme <- lmer(Outcome ~ Week + Treatment + Week:Treatment + (1 | Population),
                  data = data,
                  REML = TRUE)

summary(model_lme)

# Get confidence intervals
confint(model_lme, level = 0.95)

# 5. COMPARE STANDARD ERRORS: Simple vs. Mixed
# ============================================================
cat("SIMPLE REGRESSION Standard Errors:\n")
print(coef(summary(model_lm)))

cat("\n\nMIXED-EFFECTS MODEL Standard Errors:\n")
print(coef(summary(model_lme)))

cat("\n\nNOTE: If populations differ, mixed model SEs should be narrower\n")

# 6. CHECK MODEL ASSUMPTIONS
# ============================================================

# Diagnostic plots
par(mfrow = c(2, 2))
plot(model_lme)
par(mfrow = c(1, 1))

# Q-Q plot
qqnorm(residuals(model_lme))
qqline(residuals(model_lme))

# Histogram of residuals
hist(residuals(model_lme), main = "Distribution of Residuals", 
     xlab = "Residuals", breaks = 10)

# Formal normality test
shapiro.test(residuals(model_lme))
# p > 0.05 = normally distributed ✓

# Check homogeneity of variance
leveneTest(residuals(model_lme) ~ data$Treatment)
# p > 0.05 = equal variance ✓

# 7. COMPARE MODELS: WITH vs. WITHOUT INTERACTION
# ============================================================
model_no_int <- lmer(Outcome ~ Week + Treatment + (1 | Population), 
                     data = data, REML = TRUE)

# Likelihood ratio test
anova(model_no_int, model_lme)
# Small p-value = interaction significantly improves fit

# 8. GENERATE PREDICTIONS FOR PLOTTING
# ============================================================
# Create grid of values to predict
new_data <- expand.grid(
  Week = seq(min(data$Week), max(data$Week), length.out = 50),
  Treatment = c("A", "B"),
  Population = NA  # Average across populations
)

# Get predictions with confidence intervals
new_data$Predicted <- predict(model_lme, newdata = new_data, re.form = NA)

# 9. CREATE PUBLICATION-QUALITY PLOTS
# ============================================================

# Plot 1: Simple line plot with data points
p1 <- ggplot(data, aes(x = Week, y = Outcome, color = Treatment)) +
  geom_point(alpha = 0.5, size = 2) +
  geom_line(data = new_data, aes(y = Predicted), size = 1) +
  theme_minimal() +
  labs(
    title = "Bacterial Load Over Time by Treatment",
    x = "Week",
    y = "Log Bacterial Load (CFU/mL)",
    color = "Treatment"
  ) +
  theme(
    legend.position = "bottom",
    axis.text = element_text(size = 11),
    axis.title = element_text(size = 12, face = "bold")
  )

print(p1)
ggsave("bacterial_load_plot.png", p1, width = 7, height = 5, dpi = 300)

# Plot 2: By population
p2 <- ggplot(data, aes(x = Week, y = Outcome, color = Treatment)) +
  geom_point(alpha = 0.5, size = 2) +
  geom_line(data = new_data, aes(y = Predicted), size = 1) +
  facet_wrap(~Population) +
  theme_minimal() +
  labs(
    title = "Bacterial Load Over Time by Treatment and Population",
    x = "Week",
    y = "Log Bacterial Load (CFU/mL)",
    color = "Treatment"
  )

print(p2)
ggsave("bacterial_load_by_population.png", p2, width = 9, height = 6, dpi = 300)

# 10. EXTRACT AND FORMAT RESULTS FOR REPORTING
# ============================================================

# Create results table
results_table <- data.frame(
  Effect = c("Week", "TreatmentB", "Week:TreatmentB"),
  Estimate = coef(summary(model_lme))[2:4, "Estimate"],
  SE = coef(summary(model_lme))[2:4, "Std. Error"],
  t_value = coef(summary(model_lme))[2:4, "t value"],
  p_value = coef(summary(model_lme))[2:4, "Pr(>|t|)"]
)

print(results_table)

# 11. GET MODEL STATISTICS
# ============================================================

# R-squared (pseudo-R²)
# install.packages("MuMIn")
library(MuMIn)
r.squared <- r.squaredGLMM(model_lme)
cat("Marginal R² (fixed effects):", r.squared[1], "\n")
cat("Conditional R² (fixed + random):", r.squared[2], "\n")

# Variance components
cat("\nVariance Components:\n")
print(VarCorr(model_lme))

# 12. WRITE UP RESULTS
# ============================================================

cat("\n=====================================================\n")
cat("RESULTS SUMMARY\n")
cat("=====================================================\n\n")

cat("Model: Outcome ~ Week + Treatment + Week:Treatment + (1 | Population)\n\n")

cat("Fixed Effects:\n")
print(coef(summary(model_lme)))

cat("\n\nRandom Effects:\n")
print(VarCorr(model_lme))

cat("\n\nInterpretation:\n")
cat("- Bacterial load increases by ", 
    round(coef(summary(model_lme))[2, "Estimate"], 3),
    " units per week (p < 0.001)\n")
cat("- Treatment B differs by ",
    round(coef(summary(model_lme))[3, "Estimate"], 3),
    " units at baseline (p = ",
    round(coef(summary(model_lme))[3, "Pr(>|t|)"], 3), ")\n")
cat("- Week:Treatment interaction: β = ",
    round(coef(summary(model_lme))[4, "Estimate"], 3),
    " (p = ",
    round(coef(summary(model_lme))[4, "Pr(>|t|)"], 3), ")\n")
cat("- Population variation (SD) = ",
    round(attr(VarCorr(model_lme)$Population, "stddev"), 3), "\n")
```

---

## 10. COMPLETE ANALYSIS WALKTHROUGH: SPSS SYNTAX

```spss
* Load your data file
GET DATA /TYPE=CSV
  /FILE='C:\path\to\bacterial_load_data.csv'
  /ENCODING='UTF8'
  /FIRSTCASE=2
  /DELCASE=LINE
  /DELIMITERS=","
  /QUALIFIER='"'
  /VARIABLES=
    Colony_ID F5.0
    Week F2.0
    Population A10
    Treatment A1
    Outcome F6.2.

* Check data
FREQUENCIES VARIABLES=Week Treatment Population.
DESCRIPTIVES VARIABLES=Outcome /STATISTICS=MEAN STDDEV MIN MAX.

* Crosstab: samples per treatment and week
CROSSTABS TABLES=Week BY Treatment /CELLS=COUNT.

* Descriptive statistics by groups
SPLIT FILE BY Treatment.
DESCRIPTIVES VARIABLES=Outcome.
SPLIT FILE OFF.

* ============================================================
* FIRST: Simple Linear Regression for comparison
* ============================================================

REGRESSION
  /DEPENDENT Outcome
  /METHOD=ENTER Week Treatment
  /METHOD=ENTER Week*Treatment
  /STATISTICS=DESCRIPTIVES CI(95) OUTS(CASEWISE)
  /RESIDUALS=HIST(ZRESID) NORMPROB(ZRESID)
  /SAVE=PRED RESID
  /PRINT=DESCRIPTIVE.

* ============================================================
* MAIN ANALYSIS: Linear Mixed-Effects Model
* ============================================================

MIXED Outcome BY Treatment WITH Week
  /CRITERIA=CIN(95) SINGULAR(0.000000000001)
  /FIXED=Week Treatment Week*Treatment SSTYPE(3)
  /RANDOM=INTERCEPT | SUBJECT(Population) COVTYPE(VC)
  /PRINT=SOLUTION TESTCOV G
  /SAVE=PRED RESID
  /EMMEANS=TABLES(Treatment) COMPARE ADJP(SIDAK).

* Note: Output includes:
* - Fixed Effects table: Coefficients, SE, p-values
* - Random Effects table: Population variation (variance components)
* - Estimates: Predicted means for treatment groups

* ============================================================
* ASSUMPTION CHECKING
* ============================================================

* Normality of residuals
EXAMINE VARIABLES=RESID /PLOT=Q-Q HISTOGRAM NPPLOT
  /STATISTICS=SHAPIRO(ZSIGNIFICANT).

* Homogeneity of variance (Levene's test)
ONEWAY Outcome BY Treatment
  /STATISTICS=HOMOGENEITY.

* Plot residuals vs predicted values
GRAPH /SCATTERPLOT(BIVAR)=PRED WITH RESID
  /TITLE="Residuals vs Predicted Values".

* ============================================================
* COMPARISON: Models with and without interaction
* ============================================================

* Model WITHOUT interaction
MIXED Outcome BY Treatment WITH Week
  /FIXED=Week Treatment SSTYPE(3)
  /RANDOM=INTERCEPT | SUBJECT(Population) COVTYPE(VC)
  /PRINT=SOLUTION TESTCOV.

* Model WITH interaction (repeat previous syntax for comparison)

* Use Information Criteria (AIC, BIC) to compare:
* Lower AIC/BIC = better model

* ============================================================
* SAVE RESULTS
* ============================================================

* Export predicted values and residuals
SAVE OUTFILE='C:\path\output_data.sav'.

* Export results table to Excel
OUTPUT EXPORT /CONTENTS=VISIBLE 
  /XPATH='C:\path\results.xlsx' 
  /XMLSCHEMA='Excel2007'.

* Create publication-ready table
EXPORT OUTFILE='C:\path\results_table.docx'
  /CONTENTS=VISIBLE.

* ============================================================
* CREATE PLOTS FOR PUBLICATION
* ============================================================

* Line plot of predicted means
GRAPH /LINE(MULTIPLE)=MEAN(Outcome) BY Week BY Treatment
  /TITLE="Bacterial Load Over Time by Treatment".

* Box plot by treatment
GRAPH /BOXPLOT(GROUPED)=Outcome BY Treatment BY Week.

* Add confidence intervals to line plot
* (Note: SPSS's graphing for mixed models is limited;
*  recommend exporting to R or Excel for better plots)
```

---

## 11. KEY TAKEAWAYS

**What you learned today:**

1. ❌ **2-way ANOVA won't work** because your treatments change mid-experiment (treatment is NOT fixed—it's time-dependent)

2. ❌ **Repeated-measures ANOVA won't work** because you sample different individuals at each timepoint (not repeated measures)

3. ✓ **Simple linear regression with interaction works** IF you have a homogeneous population with no grouping

4. ✓ **Linear mixed-effects model is BEST** IF you have multiple populations/batches because it:
   - Treats treatment as time-varying ✓
   - Accounts for population differences ✓
   - Handles independent sampling ✓
   - Gives you correct uncertainty estimates ✓
   - Provides better statistical power ✓

5. **The key insight**: Ignoring grouping in your data makes your standard errors too wide, loses statistical power, and may give you incorrect p-values

---

## 12. DECISION TREE: WHICH ANALYSIS TO USE?

```
START: "What should I use for my time-series analysis?"
    ↓
Do you have MULTIPLE populations/batches?
    ├─ YES → Use LINEAR MIXED-EFFECTS MODEL ✓ (Recommended)
    │
    └─ NO → Do you have grouping or clustering?
            ├─ YES → Use LINEAR MIXED-EFFECTS MODEL ✓
            │
            └─ NO → Use SIMPLE LINEAR REGRESSION ✓
                    (But LMM still fine for robustness)
```

**For your case**: You likely have multiple populations → **Use LMM** ✓

---

## 13. QUESTIONS TO CLARIFY WITH YOUR SUPERVISOR

Before you analyze, answer these:

1. **"How many populations/batches did I sample from?"**
   - If ≥ 2 → use LMM
   - If = 1 → regression okay, LMM still better

2. **"Are my sample sizes balanced across treatments and timepoints?"**
   - If unbalanced → LMM more efficient
   - If balanced → both work, LMM still safer

3. **"Are my timepoints evenly spaced?"**
   - Yes (1, 3, 6, 9, 12 weeks) → treat Week as continuous ✓
   - No (irregular spacing) → LMM still works, continuous still fine

4. **"At what exact week did the treatment change?"**
   - Ensure your `Treatment` column correctly codes this transition

5. **"Is there any natural autocorrelation?"**
   - (Advanced) If measurements at nearby weeks are correlated, you may need correlation structure in the model

---

## 14. WRITING UP YOUR RESULTS

### General Template

```
"To determine whether [treatment change] and [time] affected [outcome], 
we fit a linear mixed-effects model with [outcome] as the dependent variable, 
week and treatment as fixed effects, their interaction, and population as a 
random intercept. The model revealed [main finding 1], [main finding 2], and 
[main finding 3] (see Table X and Figure Y)."

Results:
- Main effect of Week: β = X, SE = Y, p = Z
- Main effect of Treatment: β = X, SE = Y, p = Z
- Interaction (Week × Treatment): β = X, SE = Y, p = Z
- Random intercept SD: X (population variation)
```

### Example (Bacterial Load Study)

```
"To assess the effects of antibiotic switching and time on bacterial load, 
we fit a linear mixed-effects model treating Week and Treatment as fixed 
effects with their interaction term, including a random intercept for 
population. Bacterial load increased significantly over time (β = 0.24, 
SE = 0.04, p < 0.001). While Treatment B showed a non-significant trend 
toward higher baseline load (β = 0.78, SE = 0.48, p = 0.15), the treatment-
by-week interaction was significant (β = -0.14, SE = 0.06, p = 0.04), 
indicating that antibiotic B slowed bacterial growth compared to antibiotic A. 
Population differences in baseline load were substantial (random intercept 
SD = 0.31), suggesting that bacterial population is an important source of 
variation accounting for this effect."
```

---

## 15. COMMON TROUBLESHOOTING

### R Troubleshooting

**Problem**: "My model won't converge"
```r
model <- lmer(Outcome ~ Week + Treatment + Week:Treatment + (1 | Population),
              data = data,
              control = lmerControl(optimizer = "bobyqa", optCtrl = list(maxfun=100000)))
```

**Problem**: "Warning about singular fit"
```r
# Population variation is near zero, consider:
model <- lmer(Outcome ~ Week + Treatment + Week:Treatment + (1 | Population),
              data = data)  # Simple random intercept

# Or:
model <- lm(Outcome ~ Week + Treatment + Week:Treatment + Population, data = data)
# Use fixed effect for Population instead
```

**Problem**: "Residuals aren't normal"
```r
# Try log transformation
model <- lmer(log(Outcome) ~ Week + Treatment + Week:Treatment + (1 | Population),
              data = data)

# Or square-root transformation
model <- lmer(sqrt(Outcome) ~ Week + Treatment + Week:Treatment + (1 | Population),
              data = data)
```

### SPSS Troubleshooting

**Problem**: "Mixed model won't run / says no fixed effects"
```
Solution: Make sure you:
1. Put Treatment in BY field (categorical)
2. Put Week in WITH field (continuous)
3. Create interaction by highlighting both and clicking "Interaction" button
4. Set Population as random subject
```

**Problem**: "No p-values showing"
```
Solution: Go to /PRINT command in syntax and add:
/PRINT=SOLUTION  * This forces p-values to show
```

---

## 16. NEXT STEPS

1. **Organize your data** in the format shown (Step 1 and Step 7)
2. **Choose your software** (R or SPSS) and run the appropriate code
3. **Fit the model**: Try both simple regression and LMM
4. **Compare standard errors**: See if they differ (indicates grouping matters)
5. **Check assumptions** with diagnostic plots
6. **Interpret the coefficients** using the guide in Section 4 and Step 4
7. **Create a visualization** to show your findings (Step 5)
8. **Write up the results** following the template in Section 14
9. **Come back with questions** if coefficients or p-values are confusing

**You've got this!** This is a sophisticated analysis, and asking these questions shows you're thinking critically about your design. 👏

---

## REFERENCES

**Recommended Reading:**
- Bates, D., et al. (2015). "Fitting Linear Mixed-Effects Models Using lme4." *Journal of Statistical Software*, 67(1), 1-48.
- Singmann, H., et al. (2023). "afex: Analysis of Factorial Experiments." R package version 1.2-0.
- West, B. T., Welch, K. B., & Galecki, A. T. (2014). *Linear Mixed Models: A Practical Guide Using Statistical Software* (2nd ed.). Chapman and Hall/CRC.
- Zuur, A. F., Ieno, E. N., Walker, N., Saveliev, A. A., & Smith, G. M. (2009). *Mixed Effects Models and Extensions in Ecology with R*. Springer.

**Software Documentation:**
- R lme4: https://cran.r-project.org/web/packages/lme4/
- R lmerTest: https://cran.r-project.org/web/packages/lmerTest/
- SPSS Mixed Models: https://www.ibm.com/support/pages/spss-statistics-mixed-models
- Python statsmodels: https://www.statsmodels.org/stable/mixed_linear.html

---

**End of Tutoring Note**
