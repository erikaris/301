# Mediation Analysis: A Practical Tutorial with R and SPSS

Mediation analysis is used when we are interested not only in whether two variables are associated, but also in whether that association may operate indirectly through another variable.

This tutorial explains mediation analysis from beginning to end, including:

- what mediation means;
- mediation versus moderation;
- how to choose a mediator;
- the meaning of a, b, c and c';
- sample-size and power considerations;
- questionnaire scoring;
- how to run mediation in R;
- how to use bootstrapping;
- how to read the statistical output;
- how to run simple mediation in SPSS PROCESS;
- what to do when the bootstrap confidence interval includes or excludes zero;
- how to report and interpret the results.

A running example is used throughout:

> **Is social media use associated with disordered eating indirectly through body dissatisfaction?**

The variables are:

```text id="x5xdy1"
X = Social media use

M = Body dissatisfaction

Y = Disordered eating
```

---

# 1. What is mediation?

A simple mediation model investigates whether the association between a predictor **X** and an outcome **Y** operates statistically through another variable **M**.

The model is:

```text id="1kh5n5"
                 a                    b
Social media ─────────→ Body ───────────────→ Disordered
    use                dissatisfaction          eating
      │                                           ↑
      │                                           │
      └──────────────── c' ──────────────────────┘
```

The question is:

> **Is social media use associated with disordered eating indirectly through body dissatisfaction?**

More generally:

```text id="t3q8p1"
X → M → Y
```

where M is called the **mediator**.

---

# 2. When is mediation appropriate?

Mediation is useful when the research question concerns a proposed **pathway or mechanism**, rather than simply whether X and Y are associated.

Compare the following questions.

## Ordinary regression question

> Is social media use associated with disordered eating?

```text id="tvjdap"
Social media use → Disordered eating
```

This investigates the X–Y association.

## Mediation question

> Is social media use associated with disordered eating indirectly through body dissatisfaction?

```text id="hghfpu"
Social media use
        ↓
Body dissatisfaction
        ↓
Disordered eating
```

This investigates a proposed pathway connecting X and Y.

However, a mediator should not be selected simply because it produces a statistically significant result.

The proposed pathway should have a theoretical or substantive justification.

---

# 3. An important caution about causality

Mediation terminology often uses words such as:

- effect;
- direct effect;
- indirect effect;
- mechanism.

However, statistical mediation alone does not establish causality.

This is particularly important with cross-sectional observational data.

If X, M and Y are measured at approximately the same time, a model such as:

```text id="94jdcq"
X → M → Y
```

can be estimated statistically, but the analysis itself does not establish that X occurred before M or that M occurred before Y.

Therefore, instead of automatically concluding:

> “X causes M, which causes Y,”

it may be more appropriate to say:

> **“The results provide evidence of an indirect association between X and Y through M.”**

Longitudinal or experimental designs can provide stronger evidence regarding temporal or causal processes, depending on how they are designed.

---

# 4. What are a, b, c, c' and a×b?

The standard simple mediation model is:

```text id="mgdwyu"
                 a                 b
X ─────────────────→ M ─────────────────→ Y
│                                         ↑
│                                         │
└──────────────── c' ─────────────────────┘
```

## Path a

The **a path** represents:

> X → M

In the running example:

> Social media use → body dissatisfaction

---

## Path b

The **b path** represents:

> M → Y, controlling for X

In the example:

> Body dissatisfaction → disordered eating after accounting for social media use.

---

## Direct effect c'

The **c' path** represents:

> X → Y while M is included in the model.

This is usually called the **direct effect**.

---

## Total effect c

The **c path** represents:

> X → Y without M included in the outcome model.

This is the **total effect**.

---

## Indirect effect a×b

The indirect effect is:

```text id="p5tjnc"
a × b
```

It represents the estimated indirect pathway:

```text id="ps3pbk"
X → M → Y
```

The indirect effect and its confidence interval are central to the mediation analysis.

---

# 5. What does “controlling for X” mean?

The b path is estimated from a regression containing both X and M:

```text id="yd2rpn"
Y = intercept + c'X + bM + error
```

Therefore, b represents the association between M and Y **after statistically accounting for X**.

For example:

> “Body dissatisfaction is associated with disordered eating after accounting for differences in social media use.”

It does not mean physically holding X constant. It means including X in the statistical model.

---

# 6. Mediation versus moderation

Mediation and moderation answer different questions.

A useful shorthand is:

> **Mediation = HOW or WHY might X relate to Y?**

> **Moderation = WHEN or FOR WHOM does the relationship between X and Y differ?**

## Mediation example

```text id="kyswrv"
Social media use
        ↓
Body dissatisfaction
        ↓
Disordered eating
```

Body dissatisfaction is the **mediator**.

The question is whether there is an indirect X → M → Y pathway.

---

## Moderation example

Suppose the association between social media use and disordered eating differs depending on age.

Age would be a **moderator**.

Statistically, moderation usually involves an interaction:

```r id="cvyl1e"
lm(Y ~ X * Age, data = dat)
```

The model contains:

```text id="m6fzvi"
X

Age

X × Age
```

The interaction term tells us whether the relationship between X and Y changes depending on age.

A useful summary is:

| | Mediation | Moderation |
|---|---|---|
| Main question | How/why? | When/for whom? |
| Third variable | Mediator | Moderator |
| Main quantity | a×b | X×W interaction |
| Structure | X → M → Y | Effect of X depends on W |

---

# 7. How should a mediator be selected?

A mediator should primarily be selected using:

1. theory;
2. conceptual reasoning;
3. previous empirical evidence;
4. an a priori research hypothesis.

A useful question is:

> **Why should X be associated with M, and why should M subsequently be associated with Y?**

For example, a body of literature might suggest:

```text id="mkr57z"
Greater social media exposure
            ↓
Greater appearance comparison
            ↓
Greater body dissatisfaction
            ↓
Greater disordered eating
```

The literature does not necessarily need to contain exactly the same mediation analysis.

Evidence may come from studies investigating different parts of the proposed pathway.

The important principle is:

> **Do not select the mediator simply because it produces a statistically significant result.**

---

# 8. The overall mediation workflow

A sensible workflow is:

```text id="zdjnzg"
Define research question
        ↓
Define X, M and Y
        ↓
Justify proposed mediator
        ↓
Decide measurement/scoring
        ↓
Obtain plausible expected effects
        ↓
Conduct power/sample-size analysis
        ↓
Collect data
        ↓
Clean and score data
        ↓
Descriptive analysis and data checks
        ↓
Estimate a
        ↓
Estimate b and c'
        ↓
Estimate c
        ↓
Calculate a×b
        ↓
Bootstrap a×b
        ↓
Obtain confidence interval
        ↓
Check model assumptions
        ↓
Interpret and report
```

---

# 9. Power comes before the main data collection

It is important to distinguish **expected effects** from **observed effects**.

## Before collecting the main data

```text id="v4ev4p"
Previous research
        ↓
Expected effects
        ↓
Power analysis
        ↓
Required sample size
```

## After collecting the data

```text id="hfcamj"
Observed data
        ↓
Estimate effects
        ↓
Mediation analysis
        ↓
Bootstrap confidence interval
        ↓
Interpretation
```

Observed effects from the completed study should not be used retrospectively to determine how many participants the study should originally have recruited.

---

# 10. Where do expected a and b come from?

Before the main study, a and b are unknown.

For power planning, plausible expected values can come from:

- previous studies;
- meta-analyses;
- pilot data;
- comparable published research;
- theoretically defensible assumptions.

For example, suppose previous evidence suggests:

```text id="2a2jv3"
Expected a = 0.25

Expected b = 0.30
```

The expected indirect effect would be:

```text id="wbx4pn"
a × b

= 0.25 × 0.30

= 0.075
```

These are assumptions for prospective power planning.

They are not the eventual observed results.

---

# 11. Power analysis for mediation

If the indirect effect is the primary hypothesis, the power calculation should ideally target:

```text id="vau5yq"
a × b
```

One approach is simulation-based power analysis.

Conceptually:

```text id="th0gnk"
Specify expected model
        ↓
Choose sample size N
        ↓
Generate artificial dataset
        ↓
Fit mediation model
        ↓
Estimate/test indirect effect
        ↓
Repeat many times
        ↓
Power =
proportion of simulations
detecting the indirect effect
```

An illustrative result might look like:

| N | Illustrative power |
|---:|---:|
| 100 | .42 |
| 150 | .55 |
| 200 | .66 |
| 250 | .74 |
| 300 | .81 |
| 350 | .86 |
| 400 | .90 |

These numbers are **illustrative only** and should not be used as a real sample-size calculation.

Under this hypothetical scenario, approximately N = 300 would provide 80% power.

---

# 12. Sensitivity analysis

Expected effects are rarely known precisely.

Instead of assuming only one pair of a and b values, several plausible scenarios can be considered.

| Scenario | a | b | a×b |
|---|---:|---:|---:|
| Smaller | .15 | .20 | .030 |
| Main assumption | .25 | .30 | .075 |
| Larger | .35 | .40 | .140 |

The analysis can then investigate how required sample size changes under different assumptions.

This is often more informative than pretending the true effect sizes are known exactly.

---

# 13. Allowing for incomplete responses

Suppose the required **analyzable** sample is:

```text id="nmbvtb"
N = 300
```

and 15% of responses are expected to be incomplete or unusable.

Calculate:

```text id="bxqsl8"
300 / (1 - .15)

= 300 / .85

= 352.94
```

Therefore:

> **Recruit approximately 353 participants.**

This is different from simply adding 15% to 300.

---

# 14. Can G*Power be used?

G*Power is useful for analyses such as:

- t-tests;
- correlations;
- ANOVA;
- multiple regression.

However:

> **G*Power does not directly calculate power for the mediation indirect effect a×b.**

It may be useful for power calculations for individual regression components, but this is not equivalent to directly powering the indirect effect.

A mediation-specific method or appropriately specified simulation is preferable when the indirect effect is the primary hypothesis.

---

# 15. Questionnaire scoring: established questionnaires

For an established validated questionnaire:

> **Follow the published scoring instructions.**

Do not automatically decide to calculate a sum or average.

Scoring instructions may specify:

- which items belong to the scale;
- which items belong to different subscales;
- reverse-coded items;
- response coding;
- whether to calculate a sum or mean;
- missing-item rules;
- score interpretation.

These instructions can often be found in:

1. the questionnaire manual;
2. the original development/validation paper;
3. official materials from the questionnaire developer;
4. later validation papers when clarification is needed.

For example:

```text id="eujhfl"
Items 1, 2, 4, 5 and 7
    → score normally

Items 3 and 6
    → reverse-score

Then calculate the specified
total or mean score
```

---

# 16. Researcher-developed questionnaire items

If researchers create their own questions, there are no existing published scoring instructions.

The first questions should therefore be:

> **What is each item intended to measure?**

and:

> **Are several items deliberately intended to measure the same underlying construct, or are they measuring different things?**

These lead to very different approaches.

---

# 17. Researcher-developed questions measuring different things

Consider:

```text id="a52d69"
Hours per day using social media

Main social media platform

Number of social media accounts

Whether someone follows appearance-related influencers

Posting frequency
```

These measure different characteristics.

They should not simply be added or averaged.

Instead, they may remain separate variables:

```text id="i4f4dh"
Hours/day
    ↓
Continuous variable


Main platform
    ↓
Categorical variable


Number of accounts
    ↓
Count variable


Follows appearance influencers
    ↓
Binary/categorical variable


Posting frequency
    ↓
Ordinal/appropriately coded variable
```

Some may only be descriptive variables.

Others may potentially be predictors or covariates if justified by the research question.

---

# 18. Researcher-developed items intended to measure one construct

Suppose six Likert items are deliberately created to measure:

> **Appearance-focused social media engagement**

Before adding or averaging the items, consider whether treating them as one scale is defensible.

Relevant considerations include:

### Conceptual coherence

Do all items genuinely represent the intended construct?

### Item distributions

Are there unusual response patterns or serious floor/ceiling effects?

### Inter-item relationships

Do the items behave as expected in relation to one another?

### Reliability

Internal-consistency reliability may be informative.

However:

> **A high Cronbach's alpha alone does not prove that the items measure one construct.**

### Dimensionality

Depending on the purpose and stage of scale development, factor analysis may be appropriate to investigate whether the items represent one or several dimensions.

---

# 19. Sum or mean?

If combining the items is justified and all items use the same response scale, both sum and mean scores may be possible.

For example:

```text id="fb9dfk"
Q1 = 4
Q2 = 3
Q3 = 5
Q4 = 4
Q5 = 4
Q6 = 3
```

Sum:

```text id="z9vzrk"
4 + 3 + 5 + 4 + 4 + 3

= 23
```

Mean:

```text id="sqy0kb"
23 / 6

= 3.83
```

If the response scale runs from 1–5, a mean of:

> **3.83 out of 5**

may be easier to interpret than a total score of 23.

However, the most important question comes first:

> **Should these items be combined at all?**

---

# 20. Preparing the data for mediation

After data cleaning and questionnaire scoring, an analysis dataset might look like:

```text id="5w4s1u"
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

```text id="vudmzy"
X = social media use

M = body dissatisfaction

Y = disordered eating
```

---

# 21. Examine the data before running mediation

Check:

- sample size;
- missingness;
- impossible values;
- means;
- standard deviations;
- minimum and maximum;
- distributions;
- scatterplots;
- unusual observations;
- questionnaire scoring;
- correlations.

For example:

```r id="ccp9rx"
summary(dat)

cor(
  dat[, c("X", "M", "Y")],
  use = "complete.obs"
)
```

Correlations provide useful preliminary information, but:

> **Correlations alone do not demonstrate mediation.**

---

# 22. A complete worked mediation example

The following section demonstrates:

> **script → output → number to extract → interpretation**

The numerical results are dummy values designed to demonstrate how mediation output is read. Real analyses will produce values from the actual dataset.

---

# 23. Step 1: Estimate path a

Path a is:

```text id="nmvy6p"
X → M
```

Run:

```r id="op4j2i"
model_a <- lm(M ~ X, data = dat)

summary(model_a)
```

Suppose R produces:

```text id="vcxdyc"
Call:
lm(formula = M ~ X, data = dat)

Coefficients:

             Estimate   Std. Error   t value   Pr(>|t|)
(Intercept)    12.480       1.320      9.455     <.001
X               3.540       0.590      6.000     <.001
```

## What number should be extracted?

Look at:

```text id="51q8a2"
             Estimate
X              3.540
               ↑
               a
```

Therefore:

> **a = 3.54**

Interpretation:

> A one-unit increase in X is associated with an estimated 3.54-unit increase in M.

In the running example:

> A one-unit increase in social media use is associated with an estimated 3.54-unit increase in body dissatisfaction.

---

# 24. Step 2: Estimate b and c'

Run:

```r id="sc8cr8"
model_b <- lm(Y ~ X + M, data = dat)

summary(model_b)
```

Suppose the output is:

```text id="1yb7sv"
Call:
lm(formula = Y ~ X + M, data = dat)

Coefficients:

             Estimate   Std. Error   t value   Pr(>|t|)
(Intercept)     2.140       1.090      1.963      .051
X               0.920       0.430      2.140      .033
M               0.480       0.058      8.276     <.001
```

There are two important numbers.

## Find b

Look at the M row:

```text id="7i8kvb"
             Estimate
M              0.480
               ↑
               b
```

Therefore:

> **b = 0.48**

Interpretation:

> A one-unit increase in M is associated with an estimated 0.48-unit increase in Y after accounting for X.

---

## Find c'

Look at the X row:

```text id="83s32h"
             Estimate
X              0.920
               ↑
               c'
```

Therefore:

> **c' = 0.92**

This is the direct X–Y association after accounting for M.

---

# 25. Step 3: Estimate total effect c

To estimate the total X–Y association without M in the outcome model:

```r id="b42ef3"
model_c <- lm(Y ~ X, data = dat)

summary(model_c)
```

Suppose:

```text id="0o7ioy"
Call:
lm(formula = Y ~ X, data = dat)

Coefficients:

             Estimate   Std. Error   t value   Pr(>|t|)
(Intercept)     8.130       1.210      6.719     <.001
X               2.619       0.510      5.135     <.001
```

Look at:

```text id="q2b3yl"
             Estimate
X              2.619
               ↑
               c
```

Therefore:

> **c = 2.619 ≈ 2.62**

---

# 26. Step 4: Calculate the indirect effect

We have:

```text id="h3j5bx"
a = 3.54

b = 0.48
```

The indirect effect is:

```text id="3ky7cx"
a × b

= 3.54 × 0.48

= 1.6992
```

Therefore:

> **Indirect effect ≈ 1.70**

We can also see:

```text id="yfq4j9"
c ≈ c' + ab
```

Using the dummy values:

```text id="p44u3v"
0.920 + 1.699

= 2.619
```

which corresponds to the total effect.

---

# 27. Why isn't a×b enough?

The value:

> **1.70**

is a point estimate.

A point estimate does not tell us how uncertain the estimate is.

For the indirect effect, a common approach is therefore to calculate a **bootstrap confidence interval**.

---

# 28. What is bootstrapping?

Bootstrapping repeatedly resamples observations from the original dataset **with replacement**.

Suppose a dataset contains 300 participants.

A bootstrap procedure creates another sample of 300 observations by repeatedly drawing from those original participants.

Because sampling is with replacement:

- some participants may appear more than once;
- some may not appear in a particular bootstrap sample.

For each bootstrap sample:

```text id="b5nyy6"
Estimate a
     ↓
Estimate b
     ↓
Calculate a×b
```

For example:

```text id="vvq58e"
Bootstrap 1       a×b = 1.55

Bootstrap 2       a×b = 1.82

Bootstrap 3       a×b = 1.43

Bootstrap 4       a×b = 2.01

...

Bootstrap 5000    a×b = 1.67
```

This produces a distribution of bootstrap indirect-effect estimates.

The software uses that distribution to construct a confidence interval.

The researcher does **not** manually calculate 5,000 indirect effects.

---

# 29. What is `lavaan`?

`lavaan` is an **R package**.

Its name comes from:

> **latent variable analysis**

It is commonly used for:

- structural equation modelling;
- path analysis;
- confirmatory factor analysis;
- mediation analysis.

Install it once:

```r id="o3sw76"
install.packages("lavaan")
```

Then load it:

```r id="4vnn3e"
library(lavaan)
```

---

# 30. Complete mediation analysis using `lavaan`

Run:

```r id="dnnxjp"
library(lavaan)

model <- '

  # a path
  M ~ a*X

  # b and direct c-prime paths
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

# 31. What does each line do?

## Estimate a

```r id="ld8nyv"
M ~ a*X
```

This means:

> Regress M on X and label the X coefficient `a`.

---

## Estimate b and c'

```r id="ehy7aa"
Y ~ b*M + cprime*X
```

This means:

> Regress Y on M and X.

The M coefficient is labelled:

```text id="7idmd7"
b
```

and the X coefficient is labelled:

```text id="jng8xc"
cprime
```

---

## Define the indirect effect

```r id="t5p0v3"
indirect := a*b
```

This tells `lavaan`:

> Calculate a×b and call the resulting parameter `indirect`.

The `:=` operator is used to define a new parameter.

---

## Define the total effect

```r id="6enw1p"
total := cprime + indirect
```

This tells `lavaan`:

> Calculate c' + ab and call the result `total`.

---

## Request bootstrapping

```r id="wlyl5d"
se = "bootstrap",
bootstrap = 5000
```

This requests:

> **5,000 bootstrap samples.**

---

## Request confidence intervals

```r id="93ad2h"
ci = TRUE
```

This asks the summary output to display confidence intervals.

---

# 32. Example `lavaan` output

Suppose the relevant output is:

```text id="2jrmkv"
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

These numerical values are **dummy values for teaching purposes**.

The important task is learning where to find each result.

---

# 33. Where does “Defined Parameters” come from?

`Defined Parameters` is generated automatically by `lavaan`.

It appears because the model contains:

```r id="5u5fzz"
indirect := a*b

total := cprime + indirect
```

These lines tell `lavaan` to create two additional parameters called:

```text id="1x2pwm"
indirect

total
```

Therefore, `lavaan` reports them under:

```text id="4m0cqj"
Defined Parameters:
```

---

# 34. Exactly what should be extracted from the output?

## Find a

```text id="n9ef6h"
M ~
  X        (a)        3.540
                       ↑
```

Therefore:

> **a = 3.540**

---

## Find b

```text id="mr6yhs"
Y ~
  M        (b)        0.480
                       ↑
```

Therefore:

> **b = 0.480**

---

## Find c'

```text id="dqqo9c"
Y ~
  X   (cprime)        0.920
                       ↑
```

Therefore:

> **c' = 0.920**

---

## Find the indirect effect

Go to:

```text id="ms6ekj"
Defined Parameters:
```

Then find:

```text id="blv5fw"
                   Estimate
indirect              1.699
                      ↑
```

Therefore:

> **a×b = 1.699**

---

## Find the bootstrap confidence interval

Stay on the `indirect` row:

```text id="c59b58"
                   Estimate   ci.lower   ci.upper

indirect              1.699      1.020      2.460
                                 ↑          ↑
                               lower      upper
```

Therefore:

> **Bootstrap 95% CI = [1.020, 2.460]**

The confidence interval comes from the bootstrap procedure.

It is **not manually calculated from 1.699**.

---

## Find c

Look at:

```text id="tt4j1a"
total                 2.619
```

Therefore:

> **c = 2.619**

because:

```text id="3zebvw"
c = c' + ab

= 0.920 + 1.699

= 2.619
```

---

# 35. Quick output-reading table

| Quantity | Where to look | Dummy result |
|---|---|---:|
| **a** | `M ~ X (a)` → Estimate | **3.540** |
| **b** | `Y ~ M (b)` → Estimate | **0.480** |
| **c'** | `Y ~ X (cprime)` → Estimate | **0.920** |
| **a×b** | `indirect` → Estimate | **1.699** |
| Lower CI | `indirect` → `ci.lower` | **1.020** |
| Upper CI | `indirect` → `ci.upper` | **2.460** |
| **c** | `total` → Estimate | **2.619** |

So the key results are:

```text id="u0ftwg"
a             = 3.540

b             = 0.480

c'            = 0.920

indirect a×b  = 1.699

95% CI        = [1.020, 2.460]

total c       = 2.619
```

---

# 36. The most important question: does the CI contain zero?

The bootstrap confidence interval provides the main inferential information about the indirect effect.

The simple rule is:

```text id="nlrb2d"
Does the bootstrap CI for a×b contain 0?

                 ↓

          ┌──────┴──────┐
          │             │
         YES            NO
          │             │
          ↓             ↓
   Insufficient      Evidence of
   evidence of       an indirect
   an indirect          effect
      effect
```

---

# 37. Case 1: the CI does NOT contain zero

Suppose:

```text id="np2y7s"
Indirect effect = 1.699

95% CI = [1.020, 2.460]
```

Is zero between 1.020 and 2.460?

> **No.**

Therefore:

> **There is statistical evidence of an indirect effect.**

A possible report is:

> The estimated indirect effect of social media use on disordered eating through body dissatisfaction was 1.70, with a bootstrap 95% confidence interval of [1.02, 2.46]. Because the confidence interval did not contain zero, there was statistical evidence of an indirect association through body dissatisfaction.

The result should then be considered in relation to:

- the original hypothesis;
- theory;
- previous literature;
- study design;
- measurement;
- limitations.

For cross-sectional observational data, avoid treating the result as proof of a causal mechanism.

---

# 38. Case 2: the CI DOES contain zero

Suppose the output instead shows:

```text id="i13nbg"
Defined Parameters:

                   Estimate   Std.Err   ci.lower   ci.upper

indirect              0.420      0.290     -0.110      1.030
```

Extract:

```text id="h2qr46"
Indirect effect = 0.420

95% CI = [-0.110, 1.030]
```

Is zero between -0.110 and 1.030?

> **Yes.**

Therefore:

> **There is insufficient statistical evidence of an indirect effect.**

A possible report is:

> The estimated indirect effect was 0.42, with a bootstrap 95% confidence interval of [-0.11, 1.03]. Because the confidence interval included zero, there was insufficient statistical evidence of an indirect association through the proposed mediator.

---

# 39. What should be done when the CI contains zero?

This is an important practical question.

## 1. Report the result

A non-significant indirect effect is still a research result.

Do not hide it or treat it as an analysis failure.

---

## 2. Check the analysis

Check whether:

- X, M and Y were specified correctly;
- questionnaires were scored correctly;
- reverse-coded items were handled correctly;
- the planned mediation model was fitted correctly;
- variables were appropriate for the chosen model;
- missing data were handled appropriately;
- planned covariates were handled appropriately;
- there are serious data-quality problems;
- influential observations are affecting the model;
- the confidence interval is very wide, indicating considerable uncertainty.

---

## 3. Do not change the mediator simply to obtain significance

For example, do not automatically test:

```text id="4og3qj"
Mediator 1
Mediator 2
Mediator 3
Mediator 4
Mediator 5
...
```

until one produces a confidence interval excluding zero.

Similarly, do not repeatedly add and remove covariates simply to make the indirect effect statistically significant.

---

## 4. Reconsider the theoretical interpretation

If the analysis is correctly specified but the proposed indirect effect is not supported, consider what the result means for the original hypothesis and theory.

Questions may include:

- Was the proposed mediator theoretically appropriate?
- Was the expected indirect effect perhaps smaller than anticipated?
- Is measurement quality adequate?
- Was statistical precision sufficient?
- Could the design adequately investigate the proposed pathway?
- Does previous literature show similar or conflicting findings?

In supervised research, major changes to the theoretical model or planned analyses should normally be discussed with the relevant supervisor/research team rather than being driven solely by statistical significance.

---

## 5. Alternative models can still be investigated when scientifically justified

A non-significant result does not mean that no further research or analysis is permitted.

Alternative models may be scientifically meaningful.

However, analyses developed **after observing the original result** should be clearly distinguished as exploratory or post hoc where appropriate.

---

# 40. Do a and b individually have to be significant?

Avoid using a rigid rule such as:

> “a must have p < .05 AND b must have p < .05 before mediation can be tested.”

The main inferential quantity for the mediation hypothesis is:

```text id="8qifrr"
a × b
```

Therefore, directly examine:

> **the estimated indirect effect and its confidence interval.**

---

# 41. Running simple mediation in SPSS

A commonly used approach is **Hayes' PROCESS macro**.

For simple mediation:

```text id="9z5nr4"
Model = 4
```

Specify:

```text id="8ay92w"
X = predictor

M = mediator

Y = outcome

Model = 4

Bootstrap samples = 5000
```

PROCESS performs the bootstrap automatically.

---

# 42. Example SPSS PROCESS output: a

Suppose PROCESS reports:

```text id="v47i7r"
OUTCOME VARIABLE:
Body dissatisfaction

              coeff       se         t         p

constant      12.480      1.320      9.455     <.001

SocialMedia    3.540      0.590      6.000     <.001
               ↑
               a
```

Extract:

> **a = 3.540**

---

# 43. Example PROCESS output: b and c'

Suppose:

```text id="29z7ao"
OUTCOME VARIABLE:
Disordered eating

                       coeff       se         t         p

constant                2.140      1.090      1.963      .051

SocialMedia             0.920      0.430      2.140      .033
                        ↑
                        c'

BodyDissatisfaction     0.480      0.058      8.276     <.001
                        ↑
                        b
```

Extract:

> **b = 0.480**

> **c' = 0.920**

---

# 44. Example PROCESS output: c

Suppose:

```text id="zljl4h"
Total effect of X on Y

              effect       se         t         p

SocialMedia    2.619       0.510      5.135     <.001
               ↑
               c
```

Extract:

> **c = 2.619**

---

# 45. Example PROCESS output: indirect effect and bootstrap CI

Suppose:

```text id="trgjci"
Indirect effect(s) of X on Y:

                         Effect    BootSE    BootLLCI    BootULCI

BodyDissatisfaction       1.699      .367       1.020       2.460
                          ↑                    ↑           ↑
                         a×b               lower CI    upper CI
```

Extract:

> **Indirect effect = 1.699**

and:

> **Bootstrap 95% CI = [1.020, 2.460]**

The important PROCESS columns are:

```text id="rf78nx"
Effect
    ↓
Estimated indirect effect


BootLLCI
    ↓
Bootstrap lower confidence limit


BootULCI
    ↓
Bootstrap upper confidence limit
```

Again:

```text id="22l6ga"
BootLLCI > 0
and
BootULCI > 0

→ CI excludes zero
```

or:

```text id="zqqltm"
BootLLCI < 0
and
BootULCI > 0

→ CI contains zero
```

---

# 46. Assumptions and model checks

Mediation based on ordinary linear regression inherits relevant regression considerations.

These include:

- linearity;
- influential observations;
- residual behaviour;
- heteroscedasticity;
- independence where required by the design;
- multicollinearity;
- appropriate measurement/scaling.

Substantive considerations are equally important:

- Is X → M → Y theoretically defensible?
- Are important confounders omitted?
- Is the study cross-sectional?
- Are the measurements sufficiently reliable?
- Are covariates justified?

Do not rely exclusively on assumption-test p-values.

Graphical diagnostics and study design should also be considered.

---

# 47. What about covariates?

Suppose age is a theoretically justified pre-specified covariate.

A `lavaan` model could be:

```r id="h3e6pk"
model <- '

  M ~ a*X + age

  Y ~ b*M + cprime*X + age

  indirect := a*b

  total := cprime + indirect
'
```

Covariates should have substantive justification.

Do not add or remove covariates simply because doing so changes statistical significance.

---

# 48. Example reporting: CI excludes zero

A report might state:

> Social media use was positively associated with body dissatisfaction (a = 3.54). Body dissatisfaction was positively associated with disordered eating after accounting for social media use (b = 0.48). The estimated indirect effect of social media use on disordered eating through body dissatisfaction was 1.70, with a bootstrap 95% confidence interval of [1.02, 2.46]. As the interval did not contain zero, there was statistical evidence of an indirect association through body dissatisfaction.

For cross-sectional data, it may be appropriate to add:

> The results are consistent with the proposed indirect association, but the cross-sectional design does not establish the temporal or causal sequence implied by the mediation model.

---

# 49. Example reporting: CI contains zero

Suppose:

```text id="f85vx7"
Indirect effect = 0.42

95% CI = [-0.11, 1.03]
```

A report might state:

> The estimated indirect effect was 0.42, with a bootstrap 95% confidence interval of [-0.11, 1.03]. Because the confidence interval included zero, there was insufficient statistical evidence of an indirect association through the proposed mediator.

The discussion can then consider:

- theory;
- previous literature;
- uncertainty around the estimate;
- measurement quality;
- statistical precision;
- study design;
- limitations.

---

# 50. Common questions

## “What is mediation?”

> **Mediation investigates whether the association between X and Y operates indirectly through another variable M.**

## “What is a?”

> **The coefficient for X predicting M.**

## “What is b?”

> **The coefficient for M predicting Y while accounting for X.**

## “What is c?”

> **The total X–Y association without M included in the outcome model.**

## “What is c'?”

> **The X–Y association after M is included in the outcome model.**

## “What is the indirect effect?”

> **a×b.**

## “Where do a and b for a prospective power calculation come from?”

> **Plausible expected values can come from previous research, meta-analysis, comparable studies, pilot data or defensible sensitivity assumptions.**

## “Can G*Power calculate mediation power?”

> **Not directly for the indirect effect a×b. A mediation-specific power procedure or appropriately specified simulation is preferable when the indirect effect is the main hypothesis.**

## “What is `lavaan`?”

> **`lavaan` is an R package commonly used for structural equation modelling, path analysis, confirmatory factor analysis and mediation analysis.**

## “How is bootstrapping requested in `lavaan`?”

```r id="ux8rcp"
fit <- sem(
  model,
  data = dat,
  se = "bootstrap",
  bootstrap = 5000
)
```

Then request confidence intervals:

```r id="tk5qav"
summary(
  fit,
  ci = TRUE,
  standardized = TRUE
)
```

## “Where does the confidence interval come from?”

> **It comes from the bootstrap distribution generated by repeatedly resampling the observed data and re-estimating the indirect effect.**

## “What if the bootstrap CI excludes zero?”

> **There is statistical evidence of an indirect effect under the specified model. Report and interpret the result.**

## “What if the bootstrap CI contains zero?”

> **There is insufficient statistical evidence of an indirect effect. Report the result, check that the analysis and measurement are appropriate, and consider the theoretical and methodological implications. Do not change the model simply to obtain significance.**

## “Should researcher-developed questionnaire items be added together?”

> **Not automatically. First determine what each item measures. If the items measure different things, keep them separate. If several were deliberately designed to measure one construct, investigate whether treating them as a scale is justified before creating a composite score.**

## “Should I use a sum or mean?”

> **For validated questionnaires, follow the published scoring instructions. For researcher-developed items, first establish whether combining the items is justified. If a single scale is justified and all items use the same response scale, a mean can be convenient because it retains the original response metric.**

---

# 51. Complete mediation cheat sheet

```text id="j2ad3i"
                 MEDIATION

                 a                 b
X ─────────────────→ M ─────────────────→ Y
│                                         ↑
│                                         │
└──────────────── c' ─────────────────────┘


a
│
└── X → M


b
│
└── M → Y controlling for X


c'
│
└── X → Y controlling for M


c
│
└── total X → Y association


a×b
│
└── INDIRECT EFFECT
```

In R:

```text id="9r1l00"
M ~ a*X

Y ~ b*M + cprime*X

indirect := a*b

total := cprime + indirect
```

Bootstrap:

```text id="l5e1op"
se = "bootstrap"

bootstrap = 5000

ci = TRUE
```

Read the output:

```text id="12h9jd"
M ~ X (a)
      ↓
      a


Y ~ M (b)
      ↓
      b


Y ~ X (cprime)
      ↓
      c'


indirect Estimate
      ↓
      a×b


indirect ci.lower
      ↓
lower confidence limit


indirect ci.upper
      ↓
upper confidence limit


total Estimate
      ↓
      c
```

Then:

```text id="egq3bg"
DOES THE BOOTSTRAP CI CONTAIN ZERO?

              ↓

       ┌──────┴──────┐
       │             │
      YES            NO
       │             │
       ↓             ↓
Insufficient       Evidence
evidence of        of an
indirect effect    indirect effect
       │             │
       ↓             ↓
Report result      Report result
       │             │
       ↓             ↓
Check analysis     Interpret in
and measurement    relation to theory
       │             │
       ↓             ↓
Consider theory, design and limitations
```

---

# 52. Three key take-home messages

### 1. Mediation should be driven by theory and the research question

A mediator should not be selected simply because it produces statistical significance.

### 2. The indirect effect is the central quantity
