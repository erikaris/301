
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

y_{ij} = \beta_0 + \beta_1 x_{ij} + u_j + \epsilon_{ij}

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

# 8. Important conceptual idea (very important for your understanding)

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
3. 
* More flexible
* Handles complex experimental design
* Suitable for publication-level analysis


