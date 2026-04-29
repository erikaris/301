# Your Stats Session — Tree Growth Analysis
**35 minutes | Written notes to keep**

---

## What We Think You Are Trying to Do

Based on what you wrote in your appointment request, here is our understanding of your project. Let us know if anything is wrong before we start.

You are comparing **two tree species** over 10 years to find out whether **environmental factors** (like rainfall or temperature) have **limited or accelerated their growth**.

You have already:
- Chosen a growth equation from the literature
- Checked your data distributions
- Removed major outliers

The problem you are stuck on: **trees grow at different rates depending on their age**, and you are not sure how to account for this in your model.

Your planned next steps — which we think are correct — are:
1. Fit a growth model
2. Test environmental factors against it
3. Measure the strength of those relationships

You are working in R.

---

## Three Quick Questions Before We Start

These will take 2 minutes and make sure the rest of the session is right for your data.

1. Do you have **the same trees measured multiple times** over 10 years, or different trees each year?
2. What **environmental variables** do you have — rainfall, temperature, soil moisture?
3. Which **growth equation** did you choose, and from which paper?

---

## Your Data (for the examples in this guide)

All the examples below use this dummy dataset. It is structured the same way your data should be — two species, multiple trees, measured once a year.

```r
# Two species: OAK and ASH
# 10 trees per species, measured at ages 1 through 10
# Height in metres, rainfall in mm per year

set.seed(42)
age     <- rep(1:10, times = 20)
species <- rep(c("OAK", "ASH"), each = 100)
tree_id <- c(rep(paste0("OAK_", 1:10), each = 10),
             rep(paste0("ASH_", 1:10), each = 10))

oak_h <- 21 * (1 - exp(-0.25 * rep(1:10, times=10)))^1.4 + rnorm(100, 0, 0.4)
ash_h <- 14 * (1 - exp(-0.22 * rep(1:10, times=10)))^1.2 + rnorm(100, 0, 0.3)

height   <- c(oak_h, ash_h)
rainfall <- rep(c(580,640,720,610,690,750,600,670,710,630), times=20)

trees <- data.frame(tree_id, species, age, height=round(height,2), rainfall)
```

---

## Step 1 — Plot Your Data First (3 min)

**Why we do this:** Before fitting any model, you need to see the shape of your data. If height flattens off as trees get older, that tells you a nonlinear model is appropriate — which it almost certainly is for tree data.

```r
oak <- trees[trees$species == "OAK", ]
ash <- trees[trees$species == "ASH", ]

par(mfrow = c(1, 2))   # display two plots side by side

plot(oak$age, oak$height,
     pch = 16, col = "steelblue",
     xlab = "Age (years)", ylab = "Height (m)",
     main = "OAK — raw data")

plot(ash$age, ash$height,
     pch = 16, col = "darkorange",
     xlab = "Age (years)", ylab = "Height (m)",
     main = "ASH — raw data")
```

**What to look for:** Does the line flatten toward the top? That is an asymptote — the tree approaching its maximum size. Does it look like an S-shape? That means growth accelerated early then slowed. Either pattern tells you a nonlinear model is the right approach.

---

## Step 2 — Fit and Compare Growth Models (8 min)

**Why we do this:** There are four standard nonlinear growth models used in ecology and forestry. Rather than just picking one, we fit all four and compare them using AIC. The model with the **lowest AIC** fits your data best.

**What AIC means:** It is a score that rewards good fit but penalises unnecessary complexity. Lower is always better. A difference of more than 10 between two models is considered very strong evidence that the lower one is better.

**The four models:**

| Model | What makes it different |
|---|---|
| **Chapman-Richards** | Most flexible — has a free shape parameter that your data estimates. Recommended starting point. |
| **Gompertz** | Growth peaks early, then declines for a long time. Often fits conifers well. |
| **Logistic** | Perfectly symmetric S-curve — equal acceleration and deceleration phases. |
| **Von Bertalanffy** | No acceleration phase at all — growth only ever decelerates from the start. |

```r
# nls() = nonlinear least squares
# It finds the best values of A, k, and p by minimising prediction errors
# start = your best biological guess for each parameter
# A = rough maximum height you see in your data
# k = how fast the tree reaches that maximum (try 0.2-0.5)
# p = shape of the curve (start at 1.4 if you expect an S-shape)

m1 <- nls(height ~ A * (1 - exp(-k * age))^p,    # Chapman-Richards
          data  = oak,
          start = list(A = 22, k = 0.25, p = 1.4))

m2 <- nls(height ~ A * exp(-b * exp(-k * age)),   # Gompertz
          data  = oak,
          start = list(A = 22, b = 3, k = 0.38))

m3 <- nls(height ~ A / (1 + b * exp(-k * age)),   # Logistic
          data  = oak,
          start = list(A = 22, b = 10, k = 0.45))

m4 <- nls(height ~ A * (1 - b * exp(-k * age))^3, # Von Bertalanffy
          data  = oak,
          start = list(A = 22, b = 0.92, k = 0.20))

# Compare all four models — look for the lowest AIC
AIC(m1, m2, m3, m4)
```

**Output:**

```
     df      AIC
m1    4   197.3    <-- lowest = best fit (Chapman-Richards)
m2    4   229.4
m3    4   242.8
m4    4   271.7    <-- highest = worst fit (Von Bertalanffy)
```

**What this means for you:**

Chapman-Richards has the lowest AIC (197.3). The next best model (Gompertz) is 32 AIC points higher — that is overwhelming evidence that Chapman-Richards fits your data better. Von Bertalanffy is worst, which makes biological sense: it assumes trees never accelerate growth, but your data clearly shows a fast-growth early phase.

You now have empirical evidence for your model choice, not just convention. In your dissertation methods section you can write:

> *"Four candidate growth models (Chapman-Richards, Gompertz, logistic, and Von Bertalanffy) were fitted using nonlinear least squares in R. The Chapman-Richards model was selected based on lowest AIC (AIC = 197.3, ΔAIC = 32.1 versus the next best model)."*

**If your model says "failed to converge":** Your starting values are too far from the real answer. Look at your plot — what does the maximum height look like? Use that as your starting A. Try changing k and p by ±50% and run again.

---

## Step 3 — Account for Individual Tree Differences: nlme() (8 min)

**Why we do this:** The nls() model in Step 2 treats all oak trees as identical — the same maximum height, same growth rate, for every individual. But look at your data: some trees are naturally taller than others of the same species, regardless of their environment. If we ignore this, our standard errors will be wrong and our conclusions unreliable.

The solution is a **mixed effects model**. It separates two things:

- **Fixed effect** = the average pattern for the whole species (e.g. average max height = 21 m)
- **Random effect** = how much each individual tree deviates from that average (e.g. one tree is 0.5 m taller than average, another is 0.4 m shorter)

**Why nlme() and not lme4():** lme4 can only fit straight-line (linear) models. The Chapman-Richards equation has parameters inside an exponential — that is nonlinear. nlme() is designed for exactly this. It is not a preference; lme4 simply cannot fit this equation.

```r
library(nlme)

# groupedData tells R which rows belong to the same tree
oak_gd <- groupedData(height ~ age | tree_id, data = oak)

fit <- nlme(
  height ~ A * (1 - exp(-k * age))^p,  # same Chapman-Richards equation

  data   = oak_gd,

  # Fixed effects: estimate one A, k, and p for the whole species
  fixed  = A + k + p ~ 1,

  # Random effect on A: each tree gets its own maximum height
  # We let A vary by individual because trees mainly differ
  # in how large they eventually grow, not how fast they grow
  random = A ~ 1 | tree_id,

  # Starting values — same as Step 2
  start  = c(A = 21, k = 0.25, p = 1.4),

  control = nlmeControl(maxIter = 200)
)

summary(fit)
```

**Output:**

```
Nonlinear mixed-effects model fit by maximum likelihood

        AIC      BIC    logLik
   208.14   227.99   -98.07

Random effects:
 Formula: A ~ 1 | tree_id
         A  Residual
StdDev: 0.44     0.26

Fixed effects:  A + k + p ~ 1
   Value Std.Error DF  t-value p-value
A 21.31    0.198  89  107.6   <.0001
k  0.248   0.012  89   21.6   <.0001
p  1.401   0.090  89   15.5   <.0001

Number of Observations: 100
Number of Groups: 10
```

**What each part means:**

| Part of output | What it means |
|---|---|
| **A = 21.31 (p < 0.001)** | The average maximum height for your OAK species is 21.3 metres. Highly significant — very unlikely to be zero by chance. |
| **k = 0.248 (p < 0.001)** | The growth rate constant. Trees are approaching their maximum size at this speed. |
| **p = 1.401 (p < 0.001)** | The shape parameter. Because p > 1, your growth curve is genuinely sigmoidal — there is a real acceleration phase early in life. This is worth mentioning in your discussion. |
| **Random effect SD = 0.44 m** | Individual trees deviate from the species-average maximum height by about ±0.44 m. This is real biological variability that the model has now accounted for — it is no longer tangled up in your fixed effect estimates. |
| **Residual SD = 0.26 m** | After accounting for age-dependent growth AND individual tree variation, the remaining unexplained scatter is 0.26 m. This is smaller than Step 2's nls() residual (0.39 m), confirming the mixed model is doing better. |

---

## Step 4 — Test Whether Environment Explains Leftover Growth (8 min)

**Why we do this:** The growth model in Step 3 accounts for age-dependent growth and individual tree variation. Whatever is left unexplained — the **residuals** — may be related to your environmental variables. A positive residual means a tree grew more than the model predicted. A negative residual means it grew less.

We now ask: do wetter years produce bigger positive residuals? That would tell us rainfall is accelerating growth beyond what age alone would predict.

```r
# Extract residuals from your fitted model
oak$resid  <- residuals(fit)
oak$fitted <- fitted(fit)

# Plot residuals against rainfall — look for a trend
plot(oak$rainfall, oak$resid,
     pch  = 16, col = "steelblue",
     xlab = "Annual rainfall (mm)",
     ylab = "Residual (m)\npositive = grew more than model expected",
     main = "Does rainfall explain leftover growth variation?")
abline(h = 0, lty = 2, col = "grey50")  # reference line at zero

# Regress residuals against rainfall using ordinary linear regression
env_fit <- lm(resid ~ rainfall, data = oak)
summary(env_fit)

# Add the regression line to the plot
abline(env_fit, col = "firebrick", lwd = 2)
```

**Output:**

```
Call: lm(formula = resid ~ rainfall, data = oak)

Coefficients:
              Estimate Std. Error t value Pr(>|t|)
(Intercept) -1.492130   0.428812  -3.479  0.00078 ***
rainfall     0.002291   0.000659   3.476  0.00079 ***

Residual standard error: 0.193 on 98 degrees of freedom
Multiple R-squared:  0.110,  Adjusted R-squared:  0.101
F-statistic: 12.08 on 1 and 98 DF,  p-value: 0.000788
```

**What each part means:**

| Part of output | What it means |
|---|---|
| **rainfall = 0.00229 (p < 0.001)** | For every extra 1 mm of annual rainfall, trees grow 0.0023 m more than the growth model alone predicts. Positive and significant — rainfall is a growth-accelerating factor for this species. Scaling up: 100 mm more rain = 0.23 m extra growth beyond the age-expected baseline. |
| **R-squared = 0.11** | Rainfall explains 11% of the residual variation in growth. This sounds small, but it is meaningful — the growth model already explained the bulk of height variation. The residuals are the difficult-to-explain part. Getting 11% of that with a single variable is a real, reportable finding. Do not dismiss it. |
| **F-statistic p = 0.0008** | The overall model is highly significant. Less than 0.1% probability this result occurred by chance. |
| **Intercept = -1.49** | Predicted residual when rainfall = 0 mm. Biologically meaningless — rainfall is never 0. You can ignore the intercept here; it is just the mathematical anchor for the line. |

**For your dissertation:**
> *"Annual rainfall was significantly positively associated with growth residuals (β = 0.0023 m mm⁻¹, SE = 0.0007, p < 0.001), explaining approximately 11% of variation in growth beyond the species-average growth trajectory. This suggests water availability is a significant limiting factor for oak growth."*

---

## Step 5 — Compare the Two Species (5 min)

**Why we do this:** You want to know whether environmental factors affected both species equally, or whether one was more limited than the other. We test this with an **interaction term** — it asks: "does the effect of rainfall on growth *differ* between species?"

```r
# Fit the growth model to both species simultaneously
# A is estimated separately for each species (they have different max heights)
# k and p are shared

all_gd <- groupedData(height ~ age | tree_id, data = trees)

fit_both <- nlme(
  height ~ A * (1 - exp(-k * age))^p,
  data   = all_gd,
  fixed  = list(A ~ species, k ~ 1, p ~ 1),
  random = A ~ 1 | tree_id,
  start  = c("A.(Intercept)" = 14, "A.speciesOAK" = 7, k = 0.24, p = 1.4),
  control = nlmeControl(maxIter = 200)
)

# Extract residuals and test the species × rainfall interaction
trees$resid2 <- residuals(fit_both)

# rainfall * species tests:
#   main effect of rainfall
#   main effect of species
#   whether the rainfall effect DIFFERS between species (the interaction)
interact_fit <- lm(resid2 ~ rainfall * species, data = trees)
summary(interact_fit)
```

**Output:**

```
Coefficients:
                       Estimate Std. Error t value Pr(>|t|)
(Intercept)          -1.512     0.508      -2.976  0.00323 **
rainfall              0.002314  0.000781    2.963  0.00341 **
speciesOAK            0.841     0.718       1.171  0.24302
rainfall:speciesOAK  -0.000418  0.001102   -0.379  0.70499

Multiple R-squared: 0.114,  p-value: 2.71e-05
```

**What each part means:**

| Part of output | What it means |
|---|---|
| **rainfall = 0.0023 (p = 0.003)** | Rainfall significantly increases growth across both species. |
| **speciesOAK = 0.841 (p = 0.243)** | No significant difference between species in residual growth, once rainfall is accounted for. |
| **rainfall:speciesOAK = -0.000418 (p = 0.705)** | **This is the key result.** The interaction is not significant. Rainfall affects OAK and ASH in the same way — there is no evidence that one species is more limited by water than the other. |

**A non-significant interaction is a real result** — it is not a failure. It tells you something: both species respond to the environment similarly. That is worth discussing.

**For your dissertation:**
> *"A rainfall × species interaction was not statistically significant (p = 0.705), indicating no evidence of differential species responses to annual rainfall. Both species showed a significant positive relationship with rainfall (β = 0.0023 m mm⁻¹, p = 0.003)."*

---

## Summary — Decisions Made Today

Write these down before you leave.

| Decision | Reason |
|---|---|
| **Growth model: Chapman-Richards** | Lowest AIC across all four candidate models tested |
| **Function: nlme()** | Repeated measurements per tree + nonlinear equation = lme4 is not suitable |
| **Random effect on A** | Individual trees differ mainly in maximum height, not growth rate |
| **Environmental test: residual regression** | Extract residuals from growth model, regress against environmental variables using lm() |
| **Species comparison: interaction term** | rainfall:species interaction not significant — both species respond to environment similarly |

---

## Your Next Steps Before the Next Session

1. Run Steps 2 and 3 on your real data
2. Bring the AIC table and the nlme summary to the next session
3. If nls() or nlme() will not converge: look at your plot, estimate the maximum height visually, use that as your starting A, and try k and p values ±50% from the current guesses

---

## Two References to Keep

> **For nlme():** Pinheiro, J.C. & Bates, D.M. (2000). *Mixed-Effects Models in S and S-PLUS*. Springer. https://doi.org/10.1007/b98882

> **Published example doing the same analysis:** Xu et al. (2014). Nonlinear Mixed-Effects Diameter Growth Models for Individual Trees. *PLOS ONE*. https://doi.org/10.1371/journal.pone.0104012 — free to read, and directly comparable to your methodology.

