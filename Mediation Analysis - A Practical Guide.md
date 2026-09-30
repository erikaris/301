# Mediation Analysis: A Practical Tutorial with R and SPSS

Mediation analysis is useful when we are interested not only in whether two variables are associated, but also in whether that association may operate indirectly through another variable.

This tutorial follows one running example from study planning and sample-size calculation through data analysis, bootstrapping and interpretation.

## Running example

The research question is:

> **Is social media use associated with disordered eating indirectly through body dissatisfaction?**

The variables are:

```text
X = Social media use
M = Body dissatisfaction
Y = Disordered eating
```

---

# PART 1. UNDERSTANDING MEDIATION

## 1. What is mediation?

A simple mediation model investigates whether the association between a predictor **X** and an outcome **Y** operates statistically through another variable **M**.

```text
                 a                    b
Social media ─────────→ Body ───────────────→ Disordered
    use                dissatisfaction          eating
      │                                           ↑
      │                                           │
      └──────────────── c' ──────────────────────┘
```

The main question is:

> **Is social media use associated with disordered eating indirectly through body dissatisfaction?**

More generally:

```text
X → M → Y
```

M is the **mediator**.

---

## 2. When is mediation appropriate?

Compare these two questions.

### Ordinary regression

> Is social media use associated with disordered eating?

```text
Social media use → Disordered eating
```

### Mediation

> Is social media use associated with disordered eating indirectly through body dissatisfaction?

```text
Social media use
        ↓
Body dissatisfaction
        ↓
Disordered eating
```

Regression addresses whether X and Y are associated.

Mediation investigates a proposed **indirect pathway** connecting X and Y.

The mediator should therefore have a theoretical or substantive justification. It should not simply be selected because it produces statistical significance.

---

## 3. Important caution about causality

Statistical mediation does not automatically establish causality.

This is particularly important when X, M and Y are measured at approximately the same time in a cross-sectional study.

A statistical model can estimate:

```text
X → M → Y
```

but this does not establish that X occurred before M or that M occurred before Y.

For cross-sectional observational data, it may therefore be more appropriate to say:

> **“There is evidence of an indirect association between X and Y through M.”**

rather than:

> “X causes M, which causes Y.”

---

## 4. What are a, b, c, c' and a×b?

```text
                 a                 b
X ─────────────────→ M ─────────────────→ Y
│                                         ↑
│                                         │
└──────────────── c' ─────────────────────┘
```

### a

X → M

In the example:

> Social media use → body dissatisfaction

### b

M → Y, controlling for X

> Body dissatisfaction → disordered eating after accounting for social media use

### c'

X → Y while M is included in the model.

This is the **direct effect**.

### c

X → Y without M included in the outcome model.

This is the **total effect**.

### a×b

The **indirect effect**:

\[
\text{Indirect effect}=a\times b
\]

This is the central quantity in a simple mediation analysis.

---

## 5. What does “controlling for X” mean?

The b path comes from a regression containing both X and M:

\[
Y=\beta_0+c'X+bM+\epsilon
\]

Therefore, b represents the association between M and Y **after statistically accounting for X**.

In the running example:

> Body dissatisfaction is associated with disordered eating after accounting for differences in social media use.

---

# PART 2. CHOOSING THE MEDIATOR

## 6. How should a mediator be selected?

A mediator should primarily come from:

1. theory;
2. conceptual reasoning;
3. previous empirical evidence;
4. an a priori hypothesis.

A useful question is:

> **Why should X be associated with M, and why should M subsequently be associated with Y?**

For example:

```text
Previous evidence:

Social media use
        ↓
Body dissatisfaction


Previous evidence:

Body dissatisfaction
        ↓
Disordered eating


Theory supports:

Social media use
        ↓
Body dissatisfaction
        ↓
Disordered eating
```

The literature does not necessarily need to contain exactly the same mediation analysis. Different studies may provide evidence for different parts of the proposed pathway.

Do not select whichever mediator happens to produce a statistically significant result.

---

# PART 3. POWER AND SAMPLE-SIZE CALCULATION

## 7. What is the actual question?

For prospective power analysis, the practical question is:

> **How many participants are required to have adequate power to detect the proposed indirect effect?**

The indirect effect is:

\[
a\times b
\]

Therefore, the sample-size calculation should ideally target the **indirect effect**, rather than only one of the individual regression paths.

The general sequence is:

```text
Previous literature / pilot evidence
                ↓
Specify plausible expected effects
                ↓
Choose desired power
                ↓
Choose alpha
                ↓
Mediation power calculation
                ↓
Find required analyzable N
                ↓
Allow for incomplete/unusable responses
                ↓
Final recruitment target
```

---

# 8. Monte Carlo power analysis for mediation

One practical option is the Monte Carlo Power Analysis for Indirect Effects calculator associated with the method developed by Schoemann, Boulton and Short.

**Calculator:**

https://schoemanna.shinyapps.io/mc_power_med/

The calculator can be used for questions such as:

> **“If I want 80% power to detect the proposed indirect effect, how many participants do I need?”**

This is exactly the situation where the option:

> **Set Power, Find N**

is useful.

---

# 9. “Set Power, Find N” versus “Set N, Find Power”

These answer different questions.

## Set Power, Find N

Use this when the question is:

> **How many participants do I need?**

For example:

```text
Desired power = .80
Alpha = .05
Expected mediation relationships = specified

                ↓

Find N
```

This is normally the relevant option when planning recruitment and the sample size is still flexible.

## Set N, Find Power

Use this when the question is:

> **I already know how many participants I can recruit. What power will I have?**

For example:

```text
Available N = 200

        ↓

Find Power
```

So the simple rule is:

```text
Need to FIND sample size?
        ↓
SET POWER, FIND N


Already HAVE a fixed sample size?
        ↓
SET N, FIND POWER
```

---

# 10. Practical example using standardised coefficients

Continue with the same model:

```text
                 a
Social media ─────────→ Body dissatisfaction
    use                         │
     │                          │ b
     │                          ↓
     └─────── c' ───────→ Disordered eating
```

Suppose previous literature provides plausible **standardised coefficients**:

```text
a  = .30
b  = .40
c' = .10
```

These are teaching values only.

They represent the expected population relationships used for planning the study.

---

## 11. What does a = .30 mean?

Suppose a previous study reports:

> Social media use predicted body dissatisfaction, β = .30.

If β is standardised, this means approximately:

> A one-standard-deviation increase in social media use is associated with a 0.30-standard-deviation increase in body dissatisfaction.

Therefore:

```text
a = .30
```

---

## 12. What does b = .40 mean?

Suppose another study reports:

> Body dissatisfaction predicted disordered eating after accounting for social media use, β = .40.

Then:

```text
b = .40
```

This means approximately:

> Holding social media use constant, a one-standard-deviation increase in body dissatisfaction is associated with a 0.40-standard-deviation increase in disordered eating.

---

## 13. What does c' = .10 mean?

Suppose the expected direct relationship between social media use and disordered eating, after accounting for body dissatisfaction, is:

```text
c' = .10
```

This is the expected **direct effect**.

The planning model is therefore:

```text
                  a = .30
Social media ───────────────→ Body dissatisfaction
    use                              │
     │                               │ b = .40
     │                               ↓
     └──────── c' = .10 ─────→ Disordered eating
```

---

# 14. Expected indirect effect

The expected indirect effect is:

\[
a\times b
\]

Therefore:

\[
.30\times.40=.12
\]

So:

```text
Expected indirect effect = .12
```

However, **do not use .12 itself in a simple formula to calculate N**.

There is no calculation such as:

```text
N = indirect effect / power
```

Instead, the mediation power procedure evaluates the sampling behaviour of the indirect effect under the specified model.

---

# 15. Where do the standardised coefficients come from?

This is one of the most important parts of the power calculation.

They should ideally come from previous evidence rather than being chosen arbitrarily.

Suppose a previous paper reports:

```text
Outcome: Body dissatisfaction

Predictor                  β
Social media use          .28
Age                      -.06
BMI                       .21
```

For the proposed X → M relationship:

```text
a ≈ .28
```

Now suppose another paper reports:

```text
Outcome: Disordered eating

Predictor                  β
Social media use          .12
Body dissatisfaction      .37
Age                       .04
BMI                       .25
```

This might provide:

```text
b ≈ .37

c' ≈ .12
```

The planning assumptions might therefore be:

```text
a  = .28
b  = .37
c' = .12
```

and:

\[
a\times b=.28\times.37=.1036
\]

So the expected indirect effect is approximately:

```text
a×b ≈ .104
```

---

# 16. The papers do not have to call them “a” and “b”

When searching the literature, do not necessarily search only for:

> “mediation path a”

or:

> “mediation path b”.

Instead, look for evidence about the actual relationships.

For the running example:

```text
For a:

Social media use
        ↓
Body dissatisfaction


For b:

Body dissatisfaction
        ↓
Disordered eating
while accounting for social media use


For c':

Social media use
        ↓
Disordered eating
while accounting for body dissatisfaction
```

The relevant evidence may come from different papers.

---

# 17. Be careful when using β from previous studies

Do not automatically copy every reported β into the power calculation.

Check:

### Is it standardised?

A standardised β and an unstandardised B are different quantities.

### Is the population reasonably comparable?

For example, results from adolescent participants may be more relevant to an adolescent study than estimates from a very different population.

### Are the measures comparable?

“Social media use” could mean:

- hours per day;
- frequency of use;
- problematic social media use;
- appearance-focused engagement;
- a validated scale score.

These are not necessarily interchangeable.

### What was controlled for?

A coefficient adjusted for many covariates may differ from a coefficient estimated under the planned mediation model.

Therefore, the values used for power analysis should be **plausible planning assumptions**, not numbers copied mechanically from whichever paper is available.

---

# 18. Practical Monte Carlo calculator walkthrough

Suppose the literature supports the following planning model:

```text
a  = .30
b  = .40
c' = .10
```

and the study wants:

```text
Alpha = .05
Desired power = .80
```

Open:

https://schoemanna.shinyapps.io/mc_power_med/

Choose the appropriate **simple mediation / one-mediator model**.

Then use:

```text
SET POWER, FIND N
```

The conceptual inputs are:

```text
Model:
Simple mediation

Expected standardised relationships:
a  = .30
b  = .40
c' = .10

Alpha:
.05

Desired power:
.80

Question:
What N is required?
```

The calculator then searches for a sample size that provides the specified power for the indirect effect under the assumed model.

The important output is the required:

```text
N = ?
```

That is the number of **analyzable participants** required under the specified assumptions.

> **Important:** The exact fields displayed by a calculator depend on the selected input/model option. If an input mode requests correlations rather than path coefficients, do not simply substitute regression β coefficients for correlations. They are not generally equivalent.

---

# 19. What number should be extracted?

Suppose, purely as an illustration, the power analysis returned:

```text
Required N = 240
```

Then the conclusion is:

> **Approximately 240 analyzable participants are required to achieve the specified power under the assumed model.**

Do not interpret this as:

> “Every mediation study requires 240 participants.”

The required N depends on the assumed effects and model.

Also, **240 is an illustrative result here**, not the actual output for the example coefficients above.

For a real study, use the N returned by the actual calculation using literature-supported assumptions.

---

# 20. Why “Set Power, Find N” is better than manually trying many Ns

It is possible to do:

```text
N = 100 → calculate power

N = 150 → calculate power

N = 200 → calculate power

N = 250 → calculate power

...
```

until power reaches .80.

But if the calculator provides:

```text
Set Power, Find N
```

there is no need to manually search this way.

Simply specify:

```text
Power = .80
```

and ask the calculator to find N.

So:

```text
Expected effects
       +
Alpha = .05
       +
Desired power = .80
       ↓
SET POWER, FIND N
       ↓
Required analyzable N
```

---

# 21. What if the expected coefficients are uncertain?

This is common.

Suppose the literature does not provide one clear value for a and b.

Rather than pretending the effects are known exactly, conduct a **sensitivity analysis**.

For example:

| Scenario | a | b | Expected a×b |
|---|---:|---:|---:|
| Smaller effects | .20 | .25 | .050 |
| Main assumptions | .30 | .40 | .120 |
| Larger effects | .40 | .50 | .200 |

Run:

```text
Set Power = .80
Find N
```

for each plausible scenario.

This answers:

> **How much does the required sample size change if the true effects are smaller or larger than expected?**

Generally:

```text
Smaller expected effects
          ↓
Larger required N


Larger expected effects
          ↓
Smaller required N
```

This can provide a more defensible sample-size justification when previous literature is uncertain.

---

# 22. Adjusting for incomplete or unusable responses

The power analysis gives the required **analyzable sample**.

It does not automatically mean that this is the number that should be recruited.

Suppose the actual power analysis gives:

```text
Required analyzable N = 240
```

and approximately:

```text
15%
```

of responses are expected to be incomplete or unusable.

Calculate:

\[
N_{\text{recruit}}
=
\frac{N_{\text{required}}}
{1-\text{expected loss}}
\]

Therefore:

\[
N_{\text{recruit}}
=
\frac{240}{1-.15}
\]

\[
=
\frac{240}{.85}
\]

\[
=282.35
\]

Round **up**:

\[
\boxed{N_{\text{recruit}}=283}
\]

So:

```text
Monte Carlo power analysis
          ↓
Required usable N = 240
          ↓
Expected unusable = 15%
          ↓
240 / .85
          ↓
282.35
          ↓
Round up
          ↓
Recruit at least 283
```

Do not simply add 15%:

```text
240 × 1.15 = 276
```

because losing 15% of 276 would leave fewer than 240 usable observations.

---

# 23. Complete practical sample-size workflow

```text
STEP 1
Define mediation model

X = Social media use
M = Body dissatisfaction
Y = Disordered eating


STEP 2
Search previous literature

Find plausible standardised
coefficients for the relevant paths


STEP 3
Example assumptions

a  = .30
b  = .40
c' = .10


STEP 4
Open Monte Carlo calculator

https://schoemanna.shinyapps.io/mc_power_med/


STEP 5
Choose simple mediation


STEP 6
Choose:

SET POWER, FIND N


STEP 7
Specify:

Alpha = .05
Power = .80

and the required population
parameters for the selected
input method


STEP 8
Run calculation


STEP 9
Extract:

Required N


STEP 10
If effects are uncertain:

Repeat under smaller and
larger plausible effects


STEP 11
Adjust required N for
anticipated incomplete data


FINAL RESULT:

Recruitment target
```

---

# PART 4. QUESTIONNAIRE SCORING

## 24. Established questionnaires

For an established validated questionnaire:

> **Follow the published scoring instructions.**

These may specify:

- which items belong to the scale;
- subscales;
- reverse-coded items;
- response coding;
- whether to calculate a sum or mean;
- missing-item rules;
- score interpretation.

Look for these in:

1. the questionnaire manual;
2. the original development or validation paper;
3. official materials from the questionnaire developer;
4. later validation papers where clarification is required.

---

## 25. Researcher-developed questionnaire items

If researchers create their own questions, there are no existing published scoring instructions.

First ask:

> **What is each question intended to measure?**

Then:

> **Are several questions intended to measure one underlying construct, or do they measure different things?**

---

## 26. Scenario A: questions measure different things

For example:

```text
Hours/day using social media

Main social media platform

Number of social media accounts

Follows appearance-related influencers

Posting frequency
```

These measure different characteristics.

Do not simply add or average them.

Depending on the research question, they may be:

- descriptive variables;
- predictors;
- covariates;
- variables that do not enter the main mediation model.

---

## 27. Scenario B: several items measure one intended construct

Suppose six Likert items are deliberately designed to measure:

> **Appearance-focused social media engagement**

Before combining them, consider:

- conceptual coherence;
- item distributions;
- inter-item relationships;
- reliability;
- dimensionality or factor structure where appropriate.

A high Cronbach's alpha alone does not prove that the items measure one construct.

---

## 28. Sum or mean?

Suppose:

```text
Q1 = 4
Q2 = 3
Q3 = 5
Q4 = 4
Q5 = 4
Q6 = 3
```

Sum:

\[
4+3+5+4+4+3=23
\]

Mean:

\[
23/6=3.83
\]

If the scale ranges from 1 to 5, the mean:

> **3.83 out of 5**

may be easier to interpret.

However, the first question is not:

> “Sum or mean?”

It is:

> **“Should these items be combined at all?”**

For validated questionnaires, follow the published scoring procedure.

---

# PART 5. AFTER DATA COLLECTION

## 29. Prepare the analysis variables

Suppose the final dataset contains:

```text
ID    X_social_media    M_body_dissatisfaction    Y_disordered_eating

1          2.1                   15                       8
2          2.5                   17                       9
3          2.8                   18                      11
4          3.0                   20                      12
5          3.2                   21                      13
6          3.5                   23                      14
7          3.7                   24                      16
8          4.0                   27                      17
9          4.2                   28                      19
10         4.5                   30                      21
...
```

Suppose the variables in R are called:

```text
X = social media use
M = body dissatisfaction
Y = disordered eating
```

Before running mediation, clean and score the questionnaire data according to the planned procedures.

---

## 30. Examine the data first

Check:

- missingness;
- impossible values;
- questionnaire scoring;
- means and standard deviations;
- distributions;
- scatterplots;
- unusual or influential observations;
- correlations.

For example:

```r
summary(dat)

cor(
  dat[, c("X", "M", "Y")],
  use = "complete.obs"
)
```

Correlations provide useful preliminary information, but correlations alone do not demonstrate mediation.

---

# PART 6. WORKED MEDIATION EXAMPLE: SCRIPT → OUTPUT → NUMBER

The following numerical values are **dummy values for teaching purposes**.

## 31. Step 1: Estimate a

Run:

```r
model_a <- lm(M ~ X, data = dat)

summary(model_a)
```

Suppose R produces:

```text
Coefficients:

             Estimate   Std. Error   t value   Pr(>|t|)
(Intercept)    12.480       1.320      9.455     <.001
X               3.540       0.590      6.000     <.001
```

Extract:

```text
             Estimate
X              3.540
               ↑
               a
```

Therefore:

> **a = 3.54**

---

## 32. Step 2: Estimate b and c'

Run:

```r
model_b <- lm(Y ~ X + M, data = dat)

summary(model_b)
```

Suppose:

```text
Coefficients:

             Estimate   Std. Error   t value   Pr(>|t|)
(Intercept)     2.140       1.090      1.963      .051
X               0.920       0.430      2.140      .033
M               0.480       0.058      8.276     <.001
```

Extract b:

```text
M    Estimate = 0.480
                ↑
                b
```

Therefore:

> **b = 0.48**

Extract c':

```text
X    Estimate = 0.920
                ↑
                c'
```

Therefore:

> **c' = 0.92**

---

## 33. Step 3: Estimate c

Run:

```r
model_c <- lm(Y ~ X, data = dat)

summary(model_c)
```

Suppose:

```text
Coefficients:

             Estimate   Std. Error   t value   Pr(>|t|)
(Intercept)     8.130       1.210      6.719     <.001
X               2.619       0.510      5.135     <.001
```

Extract:

```text
X    Estimate = 2.619
                ↑
                c
```

Therefore:

> **c = 2.619 ≈ 2.62**

---

## 34. Step 4: Calculate the indirect effect

We have:

```text
a = 3.54
b = 0.48
```

Therefore:

\[
a\times b
=
3.54\times.48
=
1.6992
\]

So:

> **Indirect effect ≈ 1.70**

Also:

\[
c\approx c'+ab
\]

\[
2.619\approx.920+1.699
\]

---

# PART 7. BOOTSTRAPPING

## 35. Why bootstrap?

The value:

> **1.70**

is only a point estimate.

We also need to quantify uncertainty around the indirect effect.

Bootstrapping is commonly used to obtain a confidence interval for the indirect effect.

---

## 36. What does bootstrapping do?

Suppose there are 300 participants.

The software repeatedly creates new samples containing 300 observations from the original sample **with replacement**.

This means some participants may appear more than once in a bootstrap sample, while others may not appear at all.

For each bootstrap sample:

```text
Estimate a
     ↓
Estimate b
     ↓
Calculate a×b
```

For example:

```text
Bootstrap 1       a×b = 1.55
Bootstrap 2       a×b = 1.82
Bootstrap 3       a×b = 1.43
Bootstrap 4       a×b = 2.01
...
Bootstrap 5000    a×b = 1.67
```

The distribution of these bootstrap indirect effects is then used to obtain a confidence interval.

---

# PART 8. MEDIATION IN R USING `lavaan`

## 37. What is `lavaan`?

`lavaan` is an R package commonly used for:

- structural equation modelling;
- path analysis;
- confirmatory factor analysis;
- mediation analysis.

Install once:

```r
install.packages("lavaan")
```

Load:

```r
library(lavaan)
```

---

## 38. Complete mediation script

```r
library(lavaan)

model <- '

  # a path
  M ~ a*X

  # b and c-prime
  Y ~ b*M + cprime*X

  # indirect effect
  indirect := a*b

  # total effect
  total := cprime + indirect
'

fit <- sem(
  model,
  data = dat,
  se = "bootstrap",
  bootstrap = 5000
)

summary(
  fit,
  ci = TRUE,
  standardized = TRUE
)
```

---

## 39. What does each line mean?

```r
M ~ a*X
```

Estimate X → M and label the coefficient **a**.

```r
Y ~ b*M + cprime*X
```

Estimate:

```text
M → Y = b

X → Y controlling for M = c'
```

```r
indirect := a*b
```

Define the indirect effect.

```r
total := cprime + indirect
```

Define the total effect.

```r
se = "bootstrap",
bootstrap = 5000
```

Request 5,000 bootstrap samples.

```r
ci = TRUE
```

Request confidence intervals in the output.

---

## 40. Example `lavaan` output

Suppose the relevant output is:

```text
Regressions:

                   Estimate   Std.Err   z-value   P(>|z|)
M ~
  X        (a)        3.540      0.590     6.000    <.001

Y ~
  M        (b)        0.480      0.058     8.276    <.001
  X   (cprime)        0.920      0.430     2.140     .032


Defined Parameters:

                   Estimate   Std.Err   ci.lower   ci.upper
indirect              1.699      0.367      1.020      2.460
total                 2.619      0.520      1.650      3.590
```

These are dummy values for teaching purposes.

`Defined Parameters` is generated by `lavaan` because the model contains:

```r
indirect := a*b
total := cprime + indirect
```

You do **not** type `Defined Parameters:` yourself.

---

## 41. Exactly what should be extracted?

| Quantity | Where to look | Dummy result |
|---|---|---:|
| **a** | `M ~ X (a)` → Estimate | **3.540** |
| **b** | `Y ~ M (b)` → Estimate | **0.480** |
| **c'** | `Y ~ X (cprime)` → Estimate | **0.920** |
| **a×b** | `indirect` → Estimate | **1.699** |
| Lower CI | `indirect` → `ci.lower` | **1.020** |
| Upper CI | `indirect` → `ci.upper` | **2.460** |
| **c** | `total` → Estimate | **2.619** |

Therefore:

```text
a             = 3.540
b             = 0.480
c'            = 0.920

indirect a×b  = 1.699

95% CI        = [1.020, 2.460]

c             = 2.619
```

---

# PART 9. INTERPRETING THE BOOTSTRAP CONFIDENCE INTERVAL

## 42. The key question

Ask:

> **Does the 95% bootstrap confidence interval for the indirect effect contain zero?**

```text
                 Does CI contain 0?

                        │
              ┌─────────┴─────────┐
              │                   │
             YES                  NO
              │                   │
              ↓                   ↓
       Insufficient          Evidence of
       evidence of an        an indirect
       indirect effect          effect
```

---

## 43. Case 1: CI excludes zero

Suppose:

```text
Indirect effect = 1.699

95% CI = [1.020, 2.460]
```

Zero is **not** between 1.020 and 2.460.

Therefore:

> **There is statistical evidence of an indirect effect under the specified model.**

A possible report is:

> The estimated indirect effect of social media use on disordered eating through body dissatisfaction was 1.70, with a bootstrap 95% confidence interval of [1.02, 2.46]. Because the interval did not contain zero, there was statistical evidence of an indirect association through body dissatisfaction.

For cross-sectional data, avoid interpreting this as proof of a causal mechanism.

---

## 44. Case 2: CI contains zero

Suppose:

```text
Indirect effect = 0.420

95% CI = [-0.110, 1.030]
```

Zero **is** between -0.110 and 1.030.

Therefore:

> **There is insufficient statistical evidence of an indirect effect.**

A possible report is:

> The estimated indirect effect was 0.42, with a bootstrap 95% confidence interval of [-0.11, 1.03]. Because the confidence interval included zero, there was insufficient statistical evidence of an indirect association through the proposed mediator.

---

## 45. What should be done if the CI contains zero?

First, **report the result**. A non-significant indirect effect is still a valid research result.

Then check:

- X, M and Y specification;
- questionnaire scoring;
- reverse coding;
- missing data;
- model specification;
- variable types;
- planned covariates;
- influential observations;
- precision of the estimate.

Do not repeatedly change mediators or covariates simply to obtain statistical significance.

If the analysis is correctly specified, consider the theoretical interpretation:

- Was the proposed mediator theoretically appropriate?
- Was the indirect effect smaller than expected?
- Was measurement sufficiently reliable?
- Was statistical precision sufficient?
- Was the design suitable for investigating the pathway?
- How does the result compare with previous research?

In supervised research, major changes to the theoretical model or planned analysis should normally be discussed with the relevant supervisor or research team.

Alternative theoretically meaningful models may still be investigated, but analyses developed after observing the original results should be identified as exploratory or post hoc where appropriate.

---

# PART 10. SPSS PROCESS

## 46. Running simple mediation in SPSS

A commonly used approach is Hayes' PROCESS macro.

For simple mediation:

```text
Model = 4
```

Specify:

```text
X = predictor
M = mediator
Y = outcome

Model = 4

Bootstrap samples = 5000
```

---

## 47. Example PROCESS output: a

```text
OUTCOME VARIABLE:
Body dissatisfaction

              coeff       se         t         p
SocialMedia    3.540      0.590      6.000     <.001
               ↑
               a
```

Therefore:

> **a = 3.540**

---

## 48. Example PROCESS output: b and c'

```text
OUTCOME VARIABLE:
Disordered eating

                       coeff       se         t         p

SocialMedia             0.920      0.430      2.140      .033
                        ↑
                        c'

BodyDissatisfaction     0.480      0.058      8.276     <.001
                        ↑
                        b
```

Therefore:

> **b = 0.480**

> **c' = 0.920**

---

## 49. Example PROCESS output: c

```text
Total effect of X on Y

              effect
SocialMedia    2.619
               ↑
               c
```

Therefore:

> **c = 2.619**

---

## 50. Example PROCESS output: indirect effect

```text
Indirect effect(s) of X on Y:

                         Effect    BootSE    BootLLCI    BootULCI

BodyDissatisfaction       1.699      .367       1.020       2.460
                          ↑                    ↑           ↑
                         a×b               lower CI    upper CI
```

Extract:

```text
Indirect effect = 1.699

BootLLCI = 1.020

BootULCI = 2.460
```

Therefore:

> **Bootstrap 95% CI = [1.020, 2.460]**

Because zero is not inside the interval, there is statistical evidence of an indirect effect under the specified model.

---

# PART 11. ASSUMPTIONS AND COVARIATES

## 51. Model checks

For ordinary linear mediation, consider:

- linearity;
- influential observations;
- residual behaviour;
- heteroscedasticity;
- independence according to the study design;
- multicollinearity;
- appropriate measurement and scaling.

Also consider:

- whether X → M → Y is theoretically defensible;
- possible confounding;
- cross-sectional versus longitudinal design;
- measurement reliability;
- whether covariates are justified.

Do not rely exclusively on assumption-test p-values. Graphical diagnostics and study design are also important.

---

## 52. Covariates

Suppose age is a theoretically justified covariate:

```r
model <- '

  M ~ a*X + age

  Y ~ b*M + cprime*X + age

  indirect := a*b

  total := cprime + indirect
'
```

Covariates should be selected because they are substantively or theoretically justified, not because including them produces a preferred statistical result.

---

# PART 12. COMPLETE WORKFLOW

```text
PLANNING
────────────────────────────

Research question
      ↓
Define X, M and Y
      ↓
Theoretical justification for M
      ↓
Find plausible expected effects
from previous literature
      ↓
Open mediation power calculator
      ↓
SET POWER, FIND N
      ↓
Power = .80 or .90
Alpha = .05
      ↓
Required analyzable N
      ↓
Sensitivity analysis if needed
      ↓
Adjust for incomplete responses
      ↓
Final recruitment target


DATA PREPARATION
────────────────────────────

Collect data
      ↓
Clean raw data
      ↓
Apply questionnaire
scoring instructions
      ↓
Create X, M and Y
      ↓
Descriptives and data checks


MEDIATION
────────────────────────────

                 a             b
X ─────────────────→ M ─────────────→ Y
│                                     ↑
│                                     │
└────────────── c' ───────────────────┘


a     = X → M

b     = M → Y controlling X

c'    = X → Y controlling M

c     = total X → Y

a×b   = indirect effect


ANALYSIS
────────────────────────────

Estimate a
      ↓
Estimate b and c'
      ↓
Estimate a×b
      ↓
Bootstrap a×b
      ↓
Obtain 95% CI


INTERPRETATION
────────────────────────────

Does indirect-effect CI
contain zero?

       ┌────────────┴────────────┐
       │                         │
      YES                        NO
       │                         │
       ↓                         ↓
Insufficient evidence       Evidence of an
of indirect effect          indirect effect
       │                         │
       ↓                         ↓
Report result               Report result
       │                         │
       ↓                         ↓
Check analysis              Interpret in
and measurement             relation to theory
       │                         │
       └────────────┬────────────┘
                    ↓
        Discuss design and limitations
```

# FINAL CHEAT SHEET

## Before collecting data

```text
1. Define X, M and Y

2. Justify M theoretically

3. Find plausible effects from literature

4. Open:
   https://schoemanna.shinyapps.io/mc_power_med/

5. Choose simple mediation

6. Choose:
   SET POWER, FIND N

7. Set:
   Alpha = .05
   Power = .80 or .90

8. Enter the required population
   parameters for the selected
   calculator input method

9. Extract:
   Required N

10. Run sensitivity analyses
    if effects are uncertain

11. Adjust N for expected
    incomplete responses
```

## After collecting data

```text
1. Clean data

2. Score questionnaires

3. Create X, M and Y

4. Examine descriptives/data

5. Estimate a

6. Estimate b and c'

7. Estimate indirect effect a×b

8. Bootstrap indirect effect

9. Extract bootstrap 95% CI

10. Check whether CI contains zero

11. Report and interpret
```

# Key take-home messages

**Mediation should be driven by theory and the research question.** Do not choose mediators simply because they produce significant results.

**For prospective sample-size planning, if the question is “How many participants do I need?”, use “Set Power, Find N”.** Specify plausible population relationships, alpha and the desired power, then obtain the required analyzable N.

**The effect-size assumptions should come from relevant previous evidence where possible.** Standardised coefficients may provide useful planning information when they correspond appropriately to the paths in the planned model.

**Do not confuse standardised regression coefficients with correlations.** If a calculator input mode asks for a correlation matrix, do not simply enter β coefficients as correlations.

**The N from the power calculation is the required analyzable N.** Increase it appropriately if incomplete or unusable responses are expected.

**The central quantity in the final mediation analysis is the indirect effect, a×b.** Estimate it and examine its bootstrap confidence interval.

**If the bootstrap CI excludes zero**, there is statistical evidence of an indirect effect under the specified model.

**If the bootstrap CI contains zero**, there is insufficient statistical evidence of an indirect effect. Report the result and consider the theoretical and methodological implications rather than changing the model merely to obtain significance.

**Statistical mediation does not automatically establish causality**, particularly in cross-sectional observational studies.
