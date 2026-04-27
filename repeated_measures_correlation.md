
# Repeated Measures Correlation (Analysing Relationships in Repeated Measures Data)

---

## 1. What your data looks like

You are working with:

* Two variables (for example X and Y)
* Measured repeatedly over time
* Across multiple participants

So your dataset looks like:

* Participant 1: many rows over time
* Participant 2: many rows over time
* Participant 3: many rows over time

This is called **repeated measures (longitudinal) data**.

---

### Key problem

You cannot treat each row as independent because:

* Measurements within the same person are related
* People differ in their baseline levels

This is important because most basic statistical methods assume independence.

---

## 2. What you are trying to find out

You are asking:

> “How strongly are two variables related over time across all participants?”

But this can mean two different things:

### A. Between-person question (NOT your focus)

* Do people with higher X tend to have higher Y overall?

### B. Within-person question (your focus)

* When X increases in a person, does Y also increase in that same person?

Most repeated measures analysis focuses on **within-person relationships**.

---

## 3. Why simple correlation is not suitable

If you run a normal Pearson correlation:

* You treat all observations as independent
* But each participant contributes multiple repeated values

#### Problem:

* This inflates statistical significance
* It mixes two effects:

  * differences between people
  * changes within people

So the result is misleading.

---

# 4. Case Study Examples

## Example 1: Heart rate and activity

You measure:

* Activity level (X)
* Heart rate (Y)

Every minute for 10 participants

### What you want to know:

> When a person becomes more active, does their heart rate increase?

---

## Example 2: Mood and screen time

You measure daily:

* Screen time (X)
* Mood score (Y)

For 25 participants over 14 days

### What you want to know:

> When you use your phone more than usual, does your mood decrease?

---

## Example 3: Reaction time experiment (CS example)

You measure:

* Task difficulty (X)
* Reaction time (Y)

Across many trials per participant

### What you want to know:

> When a task becomes harder, does your reaction time increase?

---

# 5. Solution 1: Repeated Measures Correlation (rmcorr)

## What it is

Repeated measures correlation measures:

> The relationship between X and Y **within individuals**, averaged across all participants.

---

## Simple explanation

It removes each person’s baseline level and focuses only on changes over time.

So instead of comparing people, it asks:

> “When YOU go above your normal X, does YOUR Y also go above your normal level?”

---

## How it works (intuitively)

For each participant:

* subtract their personal mean from each value

So:

* X becomes “deviation from your average X”
* Y becomes “deviation from your average Y”

Then correlation is computed on these deviations.

In R, it is handled by the package [rmcorr](https://lmarusich.github.io/rmcorr/reference/rmcorr.html). Also read [this](https://rdrr.io/cran/matrixCorr/man/rmcorr.html).

---

## Example output

```
Repeated Measures Correlation

r = 0.62  
p < 0.001  
n = 10 participants, 300 observations
```

---

## Interpretation

You would say:

* There is a **moderate to strong positive relationship**
* When X increases within a person, Y tends to increase as well
* This relationship holds consistently across participants

---

## When to use it

Use repeated measures correlation when:

* You only care about relationship strength
* You have two variables
* You want a simple within-person summary

---

## Limitation

* Cannot include extra variables (like time, conditions, covariates)
* Less flexible than modern modelling approaches

---

# 6. Solution 2: Linear Mixed Effects Model (LMM)
Also read: [this notes about LMM](https://github.com/erikaris/301/blob/main/linear_mixed_model.md)

## What it is

A linear mixed model explains:

> How X predicts Y while accounting for differences between participants.

It separates:

* fixed effects (overall effect)
* random effects (individual differences)

---

## Core model

$$y_{ij} = \beta_0 + \beta_1 x_{ij} + u_j + \epsilon_{ij}$$

---

## What each part means

* (y_{ij}): outcome for person j at time i
* (x_{ij}): predictor at time i for person j
* (\beta_1): overall effect of X on Y
* (u_j): each person’s baseline difference
* (\epsilon_{ij}): random noise

---

## Simple explanation

A mixed model says:

* Everyone has a different starting point
* But we estimate a shared trend across everyone
* And we still account for individual differences

---

## Example output

```
Fixed effects:

Intercept = 5.20  
Screen time = -0.45  
p < 0.001  

Random effects:
Participant variance = 1.80
```

---

## Interpretation

You would say:

* On average, increasing screen time is associated with a decrease in mood
* For each additional unit of screen time, mood decreases by 0.45 points
* People differ in their baseline mood levels

---

## When to use it

Use LMM when:

* You want a more complete model
* You have repeated measures data
* You may have missing data or unequal time points
* You want to include additional predictors (time, condition, etc.)

---

## Advantage

* Very flexible
* Most appropriate for real experimental longitudinal data

---

# 7. Key difference between the two methods

| Feature     | Repeated Measures Correlation | Linear Mixed Model       |
| ----------- | ----------------------------- | ------------------------ |
| Goal        | strength of relationship      | full modelling           |
| Output      | correlation (r)               | regression coefficients  |
| Complexity  | simple                        | advanced                 |
| Flexibility | low                           | high                     |
| Best use    | quick analysis                | research-grade modelling |

---

# 8. Important conceptual idea

Your data has two types of variation:

### 1. Between-person variation

* Some people are generally higher/lower in X or Y

### 2. Within-person variation (what you care about)

* How X and Y change together within the same person

---

Both repeated measures correlation and LMM focus on **within-person relationships**, but:

* rmcorr → gives a summary correlation
* LMM → gives a full statistical model

---

# 9. Comparison Summary

1. **Repeated Measures Correlation**

* It directly answers your question
* Easy to interpret
* Good first analysis step

2. **Linear Mixed Effects Model**
   
* More flexible
* Handles complex experimental design
* Suitable for publication-level analysis


----

# CASE EXAMPLE: Sleep Quality vs Screen Time

## Research question

> How is screen time related to sleep quality over time across multiple people?

---

# 1. DUMMY DATASET (LONG FORMAT)

We use:

* 5 participants
* 5 time points each (day)
* Variables:

  * X = ScreenTime (hours)
  * Y = SleepQuality (0–10 scale)

| participant | DAY | ScreenTime | SleepQuality |
| ----------- | ---- | ---------- | ------------ |
| 1           | 1    | 3.0        | 7.6          |
| 1           | 2    | 4.0        | 7.0          |
| 1           | 3    | 5.0        | 6.2          |
| 1           | 4    | 6.0        | 5.6          |
| 1           | 5    | 7.0        | 5.1          |
| 2           | 1    | 2.0        | 8.2          |
| 2           | 2    | 3.0        | 7.5          |
| 2           | 3    | 4.0        | 6.9          |
| 2           | 4    | 5.0        | 6.1          |
| 2           | 5    | 6.0        | 5.5          |
| 3           | 1    | 1.5        | 8.5          |
| 3           | 2    | 2.5        | 7.9          |
| 3           | 3    | 3.5        | 7.2          |
| 3           | 4    | 4.5        | 6.6          |
| 3           | 5    | 5.5        | 6.0          |
| 4           | 1    | 3.5        | 7.3          |
| 4           | 2    | 4.5        | 6.7          |
| 4           | 3    | 5.5        | 6.0          |
| 4           | 4    | 6.5        | 5.4          |
| 4           | 5    | 7.5        | 4.9          |
| 5           | 1    | 2.5        | 8.0          |
| 5           | 2    | 3.5        | 7.4          |
| 5           | 3    | 4.5        | 6.8          |
| 5           | 4    | 5.5        | 6.2          |
| 5           | 5    | 6.5        | 5.6          |

---

# 2. SCENARIO 1: Repeated Measures Correlation + LMM

---

# A) R CODE

## Load data

```r
library(dplyr)
library(rmcorr)
library(lme4)

data <- read.csv("sleep_data.csv")
```

---

## 1. Repeated Measures Correlation

```r
rmcorr(participant, ScreenTime, SleepQuality, data)
```

---

## 2. Linear Mixed Model

```r
model1 <- lmer(SleepQuality ~ ScreenTime + (1 | participant), data=data)
summary(model1)
```

> (1 | participant) means that each participant is allowed to have their own baseline level of sleep quality. So instead of forcing everyone to start from the same point, the model adjusts for individual differences in average sleep.

> A **baseline** is: the expected value of SleepQuality when ScreenTime = 0 (or at the average level in practice)

So “different baseline” means:

* some people naturally sleep better
* some people naturally sleep worse
* even if their screen time is the same
---

# B) SPSS INSTRUCTIONS

---

## STEP 1: Enter data

* Open SPSS

* Variable View:

  * participant (numeric)
  * time (numeric)
  * ScreenTime (scale)
  * SleepQuality (scale)

* Enter data in Data View (long format)

---

## STEP 2: Repeated Measures Correlation (manual approach)

SPSS has no direct rmcorr button, so you do:

### Method: Demeaning approach

Go to:

**Transform → Compute Variable**

Create:

### 1. Participant mean ScreenTime

* Target Variable: mean_X
* Numeric Expression:

```
AGGREGATE(ScreenTime, participant, MEAN(ScreenTime))
```

(Alternatively use:)
**Data → Aggregate → Break variable = participant**

---

### 2. Demeaned variables

Transform → Compute:

* X_centered = ScreenTime - mean_X
* Y_centered = SleepQuality - mean_Y

---

### 3. Correlation

Analyze → Correlate → Bivariate
Select:

* X_centered
* Y_centered

---

## STEP 3: Linear Mixed Model

Go to:

**Analyze → Mixed Models → Linear**

### Setup:

**1. Subjects**

* participant → Subject

---

**2. Repeated (optional)**

* time → Repeated (optional structure)

---

**3. Fixed Effects**

* Add ScreenTime

---

**4. Random Effects**

* Click “Random”
* Choose:

  * Intercept
  * Subject = participant

---

Click OK

---

# 3. DUMMY OUTPUT (SCENARIO 1)

---

## Repeated Measures Correlation

```text
r = -0.78  
p < 0.001  
95% CI [-0.85, -0.65]
```

---

## Mixed Model

```text
Fixed effects:
Intercept = 9.2
ScreenTime = -0.65
p < 0.001

Random effects:
Participant variance = 1.5
```

---

# 4. INTERPRETATION (SCENARIO 1)

## Repeated Measures Correlation

* Strong negative relationship
* Within individuals:

  * when screen time increases
  * sleep quality decreases

Meaning:
> “Within-person increase in screen time is associated with worse sleep.”

---

## Mixed Model

* Each 1-hour increase in screen time reduces sleep quality by 0.65 points
* Effect is statistically significant
* Participants differ in baseline sleep quality

Meaning: 
> “Screen time has a negative effect on sleep quality after accounting for individual differences.”

---

# 5. SCENARIO 2: ADVANCED LMM (WITH RANDOM SLOPES)

This is closer to real research.

---

## R CODE

```r
model2 <- lmer(SleepQuality ~ ScreenTime + 
               (1 + ScreenTime | participant), data=data)

summary(model2)
```

---

## SPSS STEPS

Go to:

**Analyze → Mixed Models → Linear**

### Fixed Effects

* ScreenTime

---

### Random Effects

Click “Random”:

* Add:

  * Intercept
  * ScreenTime
* Grouping factor = participant

---

### Method

* REML (default)

Click OK

---

# 6. DUMMY OUTPUT (SCENARIO 2)

```text
Fixed Effects:
Intercept = 9.1
ScreenTime = -0.70
p < 0.001

Random Effects:
Intercept variance = 1.6
Slope variance = 0.12
```

---

# 7. INTERPRETATION (SCENARIO 2)

## Fixed effect

* Screen time negatively predicts sleep quality
* Strong and significant effect

---

## Random intercept

* People differ in baseline sleep quality

---

## Random slope (important insight)

* The effect of screen time is NOT identical for everyone
* Some people are more sensitive than others

Meaning:
> “The impact of screen time on sleep varies across individuals.”

---

## Two correct approaches:

### 1. Repeated Measures Correlation

* gives within-person relationship
* simple and interpretable

### 2. Linear Mixed Models

* more flexible
* accounts for individual differences
* can include time and covariates
