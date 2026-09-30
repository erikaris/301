# Mediation Analysis: A Practical Tutorial for Students

This tutorial explains how to approach a simple mediation study from the initial research question through sample-size planning, questionnaire preparation, data analysis and interpretation.

A running example is used throughout:

> **Is social media use associated with disordered eating indirectly through body dissatisfaction?**

The proposed model is:

```text
Social media use (X)
        │
        │ a
        ↓
Body dissatisfaction (M)
        │
        │ b
        ↓
Disordered eating (Y)

X ───────────── c' ─────────────→ Y
```

---

# 1. The three main questions

## Question 1: Is a simple mediation model appropriate?

### Straightforward answer

**Potentially yes, if the research question concerns a proposed mechanism rather than simply whether X is associated with Y.**

For example:

### Regression question

> Is social media use associated with disordered eating?

This asks about:

```text
Social media use → Disordered eating
```

### Mediation question

> Is social media use associated with disordered eating indirectly through body dissatisfaction?

This asks about:

```text
Social media use → Body dissatisfaction → Disordered eating
```

If the research question is specifically about **how** social media use might relate to disordered eating, mediation is more aligned with that question than a simple X → Y regression.

However, the mediator should not simply be chosen because it produces a statistically significant result.

Ask:

> **What theory or previous literature suggests that body dissatisfaction sits between social media use and disordered eating?**

If there is a strong theoretical and empirical rationale for:

> X → M → Y

then a simple mediation model is reasonable.

---

# 2. Important caution: mediation does not automatically establish causality

Suppose X, M and Y are measured at approximately the same time in a cross-sectional online survey.

We can statistically estimate:

```text
X → M → Y
```

but the analysis itself does not establish the temporal sequence.

Therefore, avoid automatically concluding:

> “Social media use causes body dissatisfaction, which causes disordered eating.”

A safer interpretation is:

> “The results provide evidence of an indirect association between social media use and disordered eating through body dissatisfaction.”

A longitudinal design can provide stronger evidence about temporal ordering if X, M and Y are appropriately measured at different time points.

---

# 3. What exactly is mediation?

For a simple mediation model:

```text
                 a                 b
X ─────────────────→ M ─────────────────→ Y
│
└───────────────────────────────────────→ Y
                       c'
```

where:

- **X** = predictor/exposure
- **M** = mediator
- **Y** = outcome
- **a** = X → M
- **b** = M → Y, controlling for X
- **c'** = direct X → Y association, controlling for M
- **a × b** = indirect effect
- **c** = total effect

The main mediation question is:

> **Is there evidence of an indirect effect of X on Y through M?**

---

# 4. What are a and b?

## The a path

The **a path** asks:

> Is X associated with M?

For our example:

> Is social media use associated with body dissatisfaction?

The regression is:

```r
model_a <- lm(M ~ X, data = dat)
summary(model_a)
```

---

## The b path

The **b path** asks:

> Is M associated with Y after accounting for X?

For our example:

> Is body dissatisfaction associated with disordered eating after accounting for social media use?

The regression is:

```r
model_b <- lm(Y ~ X + M, data = dat)
summary(model_b)
```

---

# 5. What does “controlling for X” mean?

It simply means that **X is also included in the regression model** when estimating the association between M and Y.

For example:

```text
Y = intercept + c'X + bM + error
```

The coefficient for M represents its association with Y **after statistically accounting for X**.

A simple explanation for students is:

> **“We are asking whether body dissatisfaction is associated with disordered eating after accounting for differences in social media use.”**

It does not mean physically holding social media use constant.

---

# 6. How do we choose the mediator?

The mediator should primarily come from:

1. theory
2. conceptual reasoning
3. previous empirical literature
4. the research hypothesis

Ask:

> **“Why should X be associated with M, and why should M subsequently be associated with Y?”**

For example, previous theory and evidence might support:

```text
Greater social media exposure
            ↓
Greater appearance comparison
            ↓
Greater body dissatisfaction
            ↓
Greater disordered eating
```

The mediation analysis then tests the proposed indirect pathway.

Importantly:

> X being associated with M and M being associated with Y does not, by itself, prove mediation.

The indirect effect must be evaluated.

---

# 7. The complete workflow

For a new study, a sensible order is:

```text
1. Define the research question
             ↓
2. Define X, M and Y
             ↓
3. Justify the mediator using theory/literature
             ↓
4. Decide how variables/questionnaires will be measured
             ↓
5. Obtain plausible expected effect sizes
             ↓
6. Conduct prospective power/sample-size analysis
             ↓
7. Recruit participants and collect data
             ↓
8. Clean the raw data
             ↓
9. Score questionnaires/create analysis variables
             ↓
10. Descriptive statistics and data checks
             ↓
11. Fit the mediation model
             ↓
12. Estimate a, b, c', c and a×b
             ↓
13. Bootstrap the indirect effect
             ↓
14. Check model assumptions/sensitivity
             ↓
15. Interpret and report
```

The important distinction is:

```text
BEFORE MAIN DATA COLLECTION

Literature / previous studies / pilot
                  ↓
          Expected effects
                  ↓
           Power analysis
                  ↓
        Required sample size


AFTER DATA COLLECTION

              Raw data
                 ↓
          Clean + score
                 ↓
       Mediation analysis
                 ↓
       Estimate a, b, c'
                 ↓
         Indirect a × b
                 ↓
        Bootstrap 95% CI
                 ↓
       Interpret + report
```

---

# 8. Question 2: How do I calculate the sample size/power?

### Straightforward answer

If the **indirect effect** is the main hypothesis, a standard regression power calculation is not necessarily sufficient.

The indirect effect depends particularly on:

> **a × b**

Therefore, prospective power planning needs plausible assumptions about these paths and the rest of the planned model.

Useful sources include:

- previous studies
- meta-analyses
- pilot data
- comparable published research
- sensitivity analysis when effects are uncertain

---

# 9. Where do a and b come from?

This is one of the most important distinctions.

## Before collecting the main data

We need **expected a and b** for power planning.

These might come from previous research.

Suppose comparable research suggests approximately:

> Expected a = 0.25

> Expected b = 0.30

These become assumptions for the power calculation.

## After collecting the data

We estimate the **observed a and b** from the actual dataset.

Therefore:

> **Before the study: expected a and b → power calculation.**

> **After the study: observed a and b → mediation analysis.**

Do not confuse the two.

---

# 10. Worked power example

Suppose previous evidence suggests:

> a = 0.25

> b = 0.30

The expected indirect effect is:

> a × b = 0.25 × 0.30 = **0.075**

Suppose we want:

- α = 0.05
- power = 0.80
- simple mediation
- continuous X, M and Y

A mediation-specific power calculation or simulation can then investigate the sample size required.

Conceptually:

```text
Specify expected model/effects
             ↓
Choose N
             ↓
Simulate dataset
             ↓
Fit mediation
             ↓
Test indirect effect
             ↓
Repeat many times
             ↓
Power = proportion detecting
        the indirect effect
```

Suppose we test:

|   N | Illustrative power |
| --: | -----------------: |
| 100 |               0.42 |
| 150 |               0.55 |
| 200 |               0.66 |
| 250 |               0.74 |
| 300 |               0.81 |
| 350 |               0.86 |
| 400 |               0.90 |

**These values are illustrative only and must not be used as the student's actual power calculation.**

Under this hypothetical scenario:

> approximately **N = 300** would provide 80% power.

---

# 11. Allow for incomplete responses

Suppose:

> Required analyzable N = 300

and:

> Expected incomplete/unusable data = 15%

Calculate:

> 300 / (1 − 0.15)

> \= 352.9

Therefore, the recruitment target would be approximately:

> **353 participants**

---

# 12. Sensitivity analysis

Expected effects are rarely known precisely.

Instead of relying on only one assumption, consider several plausible scenarios:

| Scenario        |    a |    b | a × b |
| --------------- | ---: | ---: | ----: |
| Smaller         | 0.15 | 0.20 | 0.030 |
| Main assumption | 0.25 | 0.30 | 0.075 |
| Larger          | 0.35 | 0.40 | 0.140 |

Then ask:

> **How does the required sample size change under each scenario?**

This can be much more informative than pretending the effect sizes are known exactly.

---

# 13. Can G\*Power be used?

### Straightforward answer

**G\*Power can be useful for ordinary regression components, but it does not directly calculate power for the mediation indirect effect a × b.**

G\*Power is useful for analyses such as:

- correlations
- t-tests
- ANOVA
- multiple regression

If the primary hypothesis concerns:

> **a × b**

then a mediation-specific power procedure or Monte Carlo simulation is preferable.

---

# 14. Can R be used for power analysis?

Yes.

R is particularly useful for simulation-based power analysis because the assumed model can be explicitly specified.

Conceptually:

```r
# Expected effects
a <- 0.25
b <- 0.30

# Desired alpha
alpha <- 0.05

# Candidate sample sizes
sample_sizes <- c(100, 150, 200, 250, 300, 350, 400)

# For each N:
# 1. Simulate many datasets
# 2. Fit the planned mediation model
# 3. Estimate the indirect effect
# 4. Determine whether it is detected
# 5. Power = proportion of simulations detecting it
```

For a real PhD sample-size justification, use an appropriate validated mediation-power method/package or carefully specified Monte Carlo simulation.

---

# 15. Question 3: What should I do with the questionnaires?

This question needs to be split into **two different situations**:

### A. Existing validated questionnaires

versus:

### B. Questions developed by the researcher herself

They should not automatically be handled in the same way.

---

# 16. Existing validated questionnaires

Suppose the researcher uses an established body-image questionnaire containing eight items.

Do not automatically decide:

> “I'll average all eight.”

Instead, follow the questionnaire's **published scoring instructions**.

These are instructions from the questionnaire's developers explaining:

- which items belong to which scale
- whether items require reverse scoring
- whether to calculate a sum or mean
- whether there are separate subscales
- how missing items are handled
- how scores should be interpreted

These can often be found in:

1. the questionnaire manual/scoring manual
2. the original development/validation paper
3. the questionnaire developer's official materials
4. later validation papers, if clarification is necessary

For example, instructions might say:

```text
Items 1, 2, 4, 5, 7 → score normally

Items 3 and 6 → reverse-score

Then SUM all items
```

Or:

```text
Reverse items 3 and 6

Then calculate the MEAN
of all seven items
```

Follow the validated instrument's specified method rather than choosing arbitrarily.

---

# 17. Researcher-developed questions

If the researcher has **written the questions herself**, there are no existing published scoring instructions.

The first question should therefore be:

> **“What is each question intended to measure?”**

Then ask:

> **“Are several questions deliberately intended to measure one underlying construct, or are they measuring different things?”**

This distinction determines what happens next.

---

# 18. Scenario A: The researcher-developed questions measure different things

Suppose the researcher asks:

> How many hours per day do you use social media?

> Which platform do you use most?

> How many social media accounts do you have?

> Do you follow appearance-related influencers?

> How often do you post photographs?

These measure different characteristics.

Do **not** simply add or average them.

Instead:

```text
Hours/day
    ↓
Continuous variable


Main platform
    ↓
Categorical variable


Number of accounts
    ↓
Count variable


Follow appearance-related influencers
    ↓
Binary/categorical variable


Posting frequency
    ↓
Ordinal or appropriately coded variable
```

Some may only be useful for describing the sample.

Others may potentially be predictors or covariates if the research question and theory justify that role.

They do not all need to enter the mediation model.

---

# 19. Scenario B: The researcher-developed questions are intended to measure one construct

Suppose the researcher creates six Likert items intended to measure:

> **Appearance-focused social media engagement**

For example:

> Q1. I compare my appearance with influencers.

> Q2. I compare my body with people I see online.

> Q3. Social media makes me think about how my body compares with others.

> Q4. I compare my appearance with friends' photographs.

> Q5. I compare my appearance with people I follow.

> Q6. I pay attention to how my appearance compares with people online.

Now it may make sense to investigate whether these items can form a scale.

But do **not immediately calculate**:

> Q1 + Q2 + Q3 + Q4 + Q5 + Q6

or:

> (Q1 + Q2 + Q3 + Q4 + Q5 + Q6) / 6

First ask:

> **“Is there sufficient conceptual and empirical justification for treating these six questions as indicators of one construct?”**

---

# 20. How do we investigate whether researcher-developed items can form a scale?

Depending on the purpose and stage of questionnaire development, consider:

### 1. Conceptual coherence

Do all items genuinely represent the same intended construct?

This should be considered **before** looking at statistics.

### 2. Item distributions

Are there problematic floor/ceiling effects or unusual response patterns?

### 3. Inter-item relationships

Do the items behave as expected in relation to one another?

### 4. Reliability

Measures such as internal-consistency reliability may be useful.

However:

> **A high Cronbach's alpha alone does not prove that the items measure one construct.**

### 5. Dimensionality/factor structure

Depending on the research purpose and questionnaire-development stage, factor analysis may be appropriate to investigate whether the proposed items behave as one dimension or several dimensions.

---

# 21. Sum or average?

If there is sufficient justification for combining the items, the researcher must then decide how to construct the composite score.

Two common approaches are:

### Sum

> Q1 + Q2 + Q3 + Q4 + Q5 + Q6

### Mean

> (Q1 + Q2 + Q3 + Q4 + Q5 + Q6) / 6

If every participant answers all items and every item uses the same response scale, the sum and mean contain essentially the same ordering information.

For example:

```text
Q1 = 4
Q2 = 3
Q3 = 5
Q4 = 4
Q5 = 4
Q6 = 3
```

Sum:

> **23**

Mean:

> 23 / 6 = **3.83**

If responses were on a 1–5 scale, a mean of:

> **3.83 out of 5**

may be easier to interpret than a total of 23.

For researcher-developed Likert items on the same scale, a mean score can therefore be convenient.

However:

> **The important decision is not “sum or mean?”**

The important first decision is:

> **“Should these items be combined at all?”**

---

# 22. What should I recommend for researcher-developed questions?

A useful decision rule is:

```text
Researcher-developed questions
             ↓
Do they measure the same construct?
       ↙                  ↘
     NO                    YES
      ↓                     ↓
Keep separate          Investigate whether
variables              they function as a scale
                            ↓
                     If justified:
                            ↓
                    Create composite score
                    (e.g. mean or sum)
```

A practical recommendation is:

> **If the questions measure different things, keep them separate. If several items were deliberately designed to measure one construct, first establish whether treating them as a scale is defensible. Only then decide whether to calculate a sum, mean or another score.**

---

# 23. A particularly important question for the researcher

Ask:

> **“Are your researcher-developed questions intended to measure your main social-media-use variable X, or are they additional descriptive/background questions?”**

This matters considerably.

If the researcher is creating her **own measure of the main predictor X**, measurement validity becomes an important part of the study design.

If they are simply additional questions about participants' social-media habits, they may not need to form a scale or enter the main mediation model.

---

# 24. After power planning: collect the data

Suppose the power calculation suggested:

> Required analyzable N ≈ 300

and the recruitment target was:

> approximately 353

Suppose the study eventually obtains:

```text
Started survey            = 380
Incomplete/ineligible     = 47
Final analyzable sample   = 333
```

Now the main analysis begins.

---

# 25. Example raw data

Before scoring questionnaires, the dataset may look like:

| ID | SM1 | SM2 | SM3 | ... | BD1 | BD2 | ... | DE1 | DE2 | ... | Age |
| -: | --: | --: | --: | --- | --: | --: | --- | --: | --: | --- | --: |
|  1 |   4 |   3 |   5 | ... |   3 |   4 | ... |   2 |   3 | ... |  16 |
|  2 |   2 |   2 |   3 | ... |   2 |   1 | ... |   1 |   2 | ... |  15 |
|  3 |   5 |   4 |   5 | ... |   4 |   5 | ... |   4 |   4 | ... |  17 |
|  4 |   3 |   4 |   3 | ... |   3 |   3 | ... |   2 |   3 | ... |  16 |

Do not immediately run mediation on the individual item columns.

First prepare the data appropriately.

---

# 26. Clean the raw data

Check:

- missing values
- impossible values
- duplicate cases where relevant
- eligibility criteria
- reverse-coded items
- coding errors
- questionnaire completion rules

For example, if a questionnaire item should range from 1–5 and the dataset contains:

> SM3 = 55

investigate before analysis.

---

# 27. Create the final analysis variables

After following the relevant questionnaire scoring procedures, the analysis dataset might look like:

|  ID | Social media X | Body dissatisfaction M | Disordered eating Y | Age |
| --: | -------------: | ---------------------: | ------------------: | --: |
|   1 |           3.80 |                     26 |                  15 |  16 |
|   2 |           2.30 |                     15 |                   8 |  15 |
|   3 |           4.60 |                     34 |                  24 |  17 |
|   4 |           3.20 |                     22 |                  13 |  16 |
|   5 |           4.10 |                     29 |                  19 |  15 |
| ... |            ... |                    ... |                 ... | ... |

Now X, M and Y are ready for the planned mediation analysis.

---

# 28. Explore the data first

Before running mediation, examine:

- sample size
- missingness
- means
- standard deviations
- minimum/maximum
- distributions
- scatterplots
- unusual observations
- correlations

In R:

```r
summary(dat)

cor(
  dat[, c("X", "M", "Y")],
  use = "complete.obs"
)
```

Suppose:

|   |    X |    M |    Y |
| - | ---: | ---: | ---: |
| X | 1.00 | 0.31 | 0.24 |
| M | 0.31 | 1.00 | 0.42 |
| Y | 0.24 | 0.42 | 1.00 |

These are useful preliminary results.

But:

> **Correlations alone do not demonstrate mediation.**

---

# 29. Estimate the a path

Run:

```r
model_a <- lm(M ~ X, data = dat)
summary(model_a)
```

Hypothetical output:

```text
Call:
lm(formula = M ~ X, data = dat)

Residuals:
     Min       1Q   Median       3Q      Max
-10.542   -3.126   -0.184    3.052   11.374

Coefficients:
             Estimate Std. Error t value Pr(>|t|)
(Intercept)   12.4800     1.3200    9.455  <2e-16 ***
X              3.5400     0.5900    6.000  5.3e-09 ***

Residual standard error: 4.71
Multiple R-squared: 0.098
Adjusted R-squared: 0.095
F-statistic: 36.00, p-value: 5.3e-09
```

Look at:

```text
             Estimate
X              3.5400   ← a
```

Therefore:

> **a = 3.54**

Interpretation:

> A one-unit increase in social media score is associated with an estimated 3.54-unit increase in body dissatisfaction.

---

# 30. Estimate b and c'

Run:

```r
model_b <- lm(Y ~ X + M, data = dat)
summary(model_b)
```

Hypothetical output:

```text
Call:
lm(formula = Y ~ X + M, data = dat)

Residuals:
     Min       1Q   Median       3Q      Max
-9.220   -2.431   -0.105    2.357   10.811

Coefficients:
             Estimate Std. Error t value Pr(>|t|)
(Intercept)    2.1400     1.0900    1.963   0.0505 .
X              0.9200     0.4300    2.140   0.0331 *
M              0.4800     0.0580    8.276  <2e-16 ***

Residual standard error: 3.82
Multiple R-squared: 0.244
Adjusted R-squared: 0.239
F-statistic: 53.2, p-value: <2e-16
```

Look at:

```text
             Estimate
X              0.920   ← c'
M              0.480   ← b
```

Therefore:

> **b = 0.48**

> **c' = 0.92**

---

# 31. Calculate the indirect effect

We have:

> a = 3.54

> b = 0.48

Therefore:

> **a × b = 3.54 × 0.48**

> **= 1.70 approximately**

So:

> **Indirect effect ≈ 1.70**

But do not stop there.

This is only the point estimate.

We need to quantify its uncertainty.

---

# 32. Bootstrap the indirect effect

Suppose a bootstrap analysis gives:

> Indirect effect = **1.70**

> Bootstrap 95% CI = **[1.02, 2.46]**

Zero is not contained in this hypothetical interval.

Therefore, the model provides statistical evidence of an indirect effect.

If instead:

> 95% CI = **[-0.11, 1.03]**

zero is contained in the interval.

Then:

> **There is insufficient evidence of an indirect effect.**

Do not automatically conclude:

> “There is definitely no mediation.”

---

# 33. Run the complete mediation in R

Using `lavaan`:

```r
library(lavaan)

model <- '
  # a path
  M ~ a*X

  # b and direct paths
  Y ~ b*M + cprime*X

  # indirect effect
  indirect := a*b

  # total effect
  total := cprime + (a*b)
'

fit <- sem(
  model,
  data = dat,
  se = "bootstrap",
  bootstrap = 5000
)

summary(
  fit,
  standardized = TRUE,
  ci = TRUE
)
```

A simplified hypothetical result:

```text
Regressions:

M ~
  X        (a)        3.540

Y ~
  M        (b)        0.480
  X   (cprime)        0.920


Defined Parameters:

                   Estimate       95% CI
indirect             1.699      1.02 – 2.46
total                2.619
```

---

# 34. What is the total effect?

The total effect **c** represents the association between X and Y without M included in the outcome regression.

Run:

```r
model_total <- lm(Y ~ X, data = dat)
summary(model_total)
```

Suppose:

> **c = 2.62**

We approximately have:

> c = c' + ab

Therefore:

> 0.92 + 1.70 = **2.62**

So:

```text
Total effect c       = 2.62

Direct effect c'     = 0.92

Indirect effect a×b  = 1.70
```

---

# 35. Put the mediation model together

```text
                 a = 3.54               b = 0.48
Social media ─────────────────→ Body ─────────────────→ Disordered
    use                         dissatisfaction          eating
      │                                                   ↑
      │                                                   │
      └──────────────── c' = 0.92 ───────────────────────┘
```

Indirect effect:

> **a × b = 1.70**

Bootstrap 95% CI:

> **[1.02, 2.46]**

Total effect:

> **c = 2.62**

All values are hypothetical.

---

# 36. Do a and b individually have to be statistically significant?

Do not rely on the rule:

> “a must be significant AND b must be significant before mediation can exist.”

The main inferential quantity is:

> **a × b**

Therefore, directly examine the estimated indirect effect and its confidence interval.

---

# 37. What assumptions and checks should be considered?

Mediation using ordinary linear regression inherits relevant regression considerations.

Consider:

- linearity
- influential observations
- residual behaviour
- heteroscedasticity
- independence where required by the design
- multicollinearity
- appropriate measurement/scaling

Also consider substantive issues:

- Is X → M → Y theoretically defensible?
- Are important confounders omitted?
- Is the study cross-sectional?
- Are measurements sufficiently reliable?
- Are covariates justified?

Do not rely exclusively on assumption-test p-values. Graphical diagnostics and study design also matter.

---

# 38. What about covariates?

Suppose age is a theoretically justified pre-specified covariate.

The model could become:

```r
model <- '
  M ~ a*X + age
  Y ~ b*M + cprime*X + age

  indirect := a*b
  total := cprime + (a*b)
'
```

Do not select covariates simply because including them makes the mediation significant.

Covariate selection should have substantive justification.

---

# 39. Running mediation in SPSS

A commonly used approach is **Hayes' PROCESS macro**.

For simple mediation:

> **Model 4**

Specify:

```text
X = Social media use

M = Body dissatisfaction

Y = Disordered eating

Model = 4

Bootstrap samples = 5,000
```

Then identify:

- **a** = X → M
- **b** = M → Y controlling for X
- **c'** = X → Y controlling for M
- **c** = total X → Y effect
- **a × b** = indirect effect
- bootstrap CI for the indirect effect

The indirect effect and its bootstrap confidence interval are central to the mediation conclusion.

---

# 40. How should the hypothetical result be reported?

For example:

> Social media use was positively associated with body dissatisfaction (a = 3.54). Body dissatisfaction was positively associated with disordered eating after accounting for social media use (b = 0.48). The estimated indirect effect of social media use on disordered eating through body dissatisfaction was 1.70, with a bootstrap 95% confidence interval of [1.02, 2.46].

For cross-sectional data, add:

> The results are consistent with the proposed indirect association, but the cross-sectional design does not establish the temporal or causal sequence implied by the mediation model.

---

# 41. Practical checklist for a tutoring appointment

## Research question

Ask:

- What exactly is X?
- What exactly is M?
- What exactly is Y?
- Is the question about association or a proposed mechanism?

## Mediator

Ask:

- Why is M proposed as the mediator?
- What theory supports it?
- What previous literature supports X → M?
- What previous literature supports M → Y?

## Study design

Ask:

- Cross-sectional or longitudinal?
- When are X, M and Y measured?
- What causal claims are appropriate?

## Validated questionnaires

Ask:

- What are the questionnaire names?
- Where did they come from?
- What are the published scoring instructions?
- Are there subscales?
- Are any items reverse-coded?

## Researcher-developed questions

Ask:

- Which questions did you write yourself?
- What is each intended to measure?
- Are they descriptive/background variables?
- Are several intended to measure one construct?
- Are you proposing to use them as X, M or Y?
- If you want to combine them, what evidence supports treating them as a scale?

## Power

Ask:

- What are the expected a and b?
- Where did those estimates come from?
- What α is planned?
- Is 80% or 90% power required?
- What incomplete/missing-data rate is expected?
- Would sensitivity analysis be useful?

## Analysis

Ask:

- What covariates are theoretically justified?
- Are X, M and Y continuous?
- How will missing data be handled?
- What diagnostics will be examined?
- Will the indirect effect be bootstrapped?

---

# 42. Straightforward answers to likely questions

## “Should I use mediation?”

> **If your research question is about whether the association between social media use and disordered eating operates indirectly through body dissatisfaction, and theory/literature supports that pathway, then simple mediation is a reasonable approach. Because your survey is cross-sectional, however, interpret it as an indirect association rather than proof of a causal mechanism.**

## “Why can't I just use regression?”

> **Regression can tell you whether X is associated with Y. Mediation specifically evaluates whether part of that association operates statistically through M.**

## “How do I choose the mediator?”

> **Use theory, previous literature and your research hypothesis, rather than choosing whichever variable produces significance.**

## “What is a?”

> **The regression coefficient for X predicting M.**

## “What is b?”

> **The regression coefficient for M predicting Y while accounting for X.**

## “What does controlling for X mean?”

> **X is included in the regression so that the M–Y association is estimated after statistically accounting for X.**

## “What is the indirect effect?”

> **a × b.**

## “Where do a and b come from for my power calculation?”

> **Before the main study, use plausible expected values based on previous research, meta-analysis, pilot data or sensitivity assumptions. After data collection, a and b are estimated from your actual dataset.**

## “Can I use G\*Power?”

> **It can help with ordinary regression power calculations, but it does not directly power the mediation indirect effect a × b. A mediation-specific power method or simulation is preferable for that hypothesis.**

## “Can I use SPSS?”

> **Yes. PROCESS Model 4 is commonly used for simple mediation.**

## “Can I use R?”

> **Yes. `lavaan` is a common option for mediation analysis, and R is also useful for simulation-based power analysis.**

## “What tells me whether there is evidence of an indirect effect?”

> **Look primarily at a × b and its bootstrap confidence interval.**

## “If the bootstrap CI doesn't contain zero?”

> **There is statistical evidence of an indirect effect under the specified model.**

## “Does that prove the mechanism?”

> **No. Statistical mediation alone does not establish causality, particularly with cross-sectional observational data.**

## “I made some questionnaire questions myself. Should I add them together?”

> **Not automatically. First decide what each question measures. If they measure different things, keep them as separate variables. If several were deliberately designed to measure one construct, investigate whether treating them as a scale is justified before creating a composite score.**

## “Should I use a sum or average?”

> **For a validated questionnaire, follow its published scoring instructions. For researcher-developed items, first establish whether the items should be combined at all. If a single scale is justified and the items share the same response scale, a mean can be convenient because it retains the original response metric, but the scoring choice should still be justified.**

## “Where do I find the scoring instructions?”

> **For an existing questionnaire, look at its scoring manual, original development/validation paper or official materials from the questionnaire developers. If you created the questions yourself, there are no existing published scoring instructions, so you need to develop and justify the scoring approach.**

---

# 43. The whole process in one picture

```text
RESEARCH QUESTION
       ↓
Define X, M and Y
       ↓
Does theory/literature support X → M → Y?
       ↓
MEASUREMENT PLAN
       ↓
Validated questionnaire?
       │
       ├── YES → Follow published scoring method
       │
       └── NO / researcher-developed
                   ↓
          What does each item measure?
                   ↓
          Same construct or different?
             ↙               ↘
        Different             Same
           ↓                   ↓
     Keep separate       Evaluate whether
                         a scale is justified
                               ↓
                       Create score if justified
                               ↓
POWER PLANNING
       ↓
Expected a + expected b
       ↓
Required sample size
       ↓
COLLECT DATA
       ↓
CLEAN + SCORE DATA
       ↓
DESCRIPTIVE ANALYSIS
       ↓
M ~ X
       ↓
Estimate a
       ↓
Y ~ X + M
       ↓
Estimate b + c'
       ↓
INDIRECT EFFECT
a × b
       ↓
BOOTSTRAP 95% CI
       ↓
CHECK ASSUMPTIONS
       ↓
INTERPRET
       ↓
REPORT WITH APPROPRIATE CAUTION
```

# 44. The three things to remember

### 1. Mediation should come from the research question and theory

Do not choose a mediator simply because it produces a significant result.

### 2. Power comes before the main data

Before data collection:

> **expected effects → power analysis → required N**

After data collection:

> **observed data → estimated effects → inference**

### 3. Do not automatically combine questionnaire items

For validated instruments:

> **follow the established scoring method.**

For researcher-developed questions:

> **first determine what the items measure and whether combining them is conceptually and empirically defensible.**

Only then decide whether a sum, mean, subscale or separate-variable approach is appropriate.
