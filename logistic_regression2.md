# Understanding Your Logistic Regression Output

This guide walks through the R output line by line, so you can see exactly where each number comes from and what it tells you.

---

## 1. What is logistic regression?

**Linear regression** predicts a continuous outcome (like height or temperature) — a straight line, with coefficients you can interpret directly.

**Logistic regression** is used when the outcome is **binary** (yes/no) or, as in this case, a **proportion** bounded between 0 and 1 — here, `fractMAP2`, the fraction of cells in a well that became neurons (MAP2-positive). Because probabilities can't go below 0% or above 100%, a straight line doesn't work well for this kind of outcome. Logistic regression solves this by modelling the **log-odds** of the outcome instead (which can be any number, with no upper or lower bound), and then converting back to a 0–1 probability scale using the logistic (S-shaped) curve.

In this task, the model is asking: as we change the dose of NGN2 virus or NT3 growth factor, how does the proportion of cells becoming neurons change?

- **NGN2_MOI** — how much virus the cells received (a dose, treated as categories: 0, 2, 5, 10)
- **NT3_ng** — whether the cells also got a growth factor called NT3 (0 or 10)

---

## 2. What to look at in the output — a roadmap

A full R `glm()` printout has several blocks. For this task, here's what matters and what doesn't:

| Block in the output | Do you need it for your conclusions? |
|---|---|
| **Model formula** (the `glm(...)` line) | Useful context — tells you what's being modelled. Not a conclusion itself. |
| **Deviance Residuals** | Skip — a fit diagnostic, not something you report. |
| **Coefficients table** | **Yes — this is the main thing.** Direction, size, and significance of each effect live here. |
| **Dispersion parameter** | Skip — a technical assumption check. |
| **Null deviance / Residual deviance / AIC** | Worth one sentence — tells you how well the model fits overall. |

So in practice: **spend most of your attention on the Coefficients table**, glance at the deviance numbers at the bottom for an overall fit statement, and don't worry about the rest. The sections below walk through each of these in order.

---

## 3. What is "log-odds", exactly?

**Odds** compare the chance of something happening to the chance of it not happening.

> If 80% of cells became neurons, the probability is 0.8. The odds are:
> 0.8 / (1 − 0.8) = 0.8 / 0.2 = **4**
> (i.e., 4 times more likely to happen than not)

**Log-odds** is just the natural logarithm of that odds value:

> log(4) ≈ **1.39**

That's it — log-odds = log(odds) = log(p / (1−p)).

**Why bother taking the log at all?** Probability is stuck between 0 and 1. Odds can go from 0 to infinity, but only in the positive direction. Neither behaves like a nice, evenly-spread number line, which causes problems for a model trying to fit a straight-line relationship. Taking the log fixes this: log-odds can be **any real number**, positive or negative, with no upper or lower bound. That's why logistic regression coefficients are estimated on the log-odds scale rather than directly on probability.

| Probability | Odds | Log-odds |
|---|---|---|
| 0.01 (1%) | 0.0101 | -4.60 |
| 0.5 (50%) | 1 | 0 |
| 0.8 (80%) | 4 | 1.39 |
| 0.99 (99%) | 99 | 4.60 |

Notice: probability is squeezed between 0 and 1, but log-odds stretches out symmetrically around 0. A probability of 0.5 (equally likely either way) corresponds to log-odds of exactly **0**, because the odds are 1-to-1 and log(1) = 0.

---

## 4. The model formula line

```
glm(formula = fractMAP2 ~ NGN2_MOI + NT3_ng, family = binomial(link = "logit"),
    data = data, weights = rep(10000, nrow(data)))
```

| Part | Meaning |
|---|---|
| `glm(...)` | "Generalised Linear Model" — the R function used to fit logistic regression |
| `fractMAP2 ~ NGN2_MOI + NT3_ng` | The outcome (left of `~`) is predicted by NGN2 dose and NT3 dose (right of `~`) |
| `family = binomial(link = "logit")` | Tells R to use logistic regression specifically (binomial family, logit link) |
| `weights = rep(10000, nrow(data))` | Each proportion is based on ~10,000 cells per well — this tells R how much "weight" or confidence to give each data point |

---

## 5. Deviance Residuals

```
Min       1Q   Median     3Q    Max
-18.2885 -2.1286 0.5841 2.5317 8.0978
```

These describe how far the model's predictions are from the actual data, across all observations (similar in spirit to residuals in linear regression, but on a different scale). You don't need to interpret these in detail for this task — just know they're a diagnostic of fit, not a conclusion to report.

---

## 6. The Coefficients table — the most important part

```
                Estimate Std. Error z value Pr(>|z|)
(Intercept)     -6.30098    0.08862  -71.10   <2e-16 ***
NGN2_MOI2        2.12408    0.09307   22.82   <2e-16 ***
NGN2_MOI5        3.97231    0.08883   44.72   <2e-16 ***
NGN2_MOI10       3.11278    0.08992   34.62   <2e-16 ***
NT3_ng10         0.31290    0.02084   15.02   <2e-16 ***
```

**Column by column:**

| Column | What it means |
|---|---|
| **Estimate** | The effect of that variable on the **log-odds** of the outcome |
| **Std. Error** | How precisely that estimate is known — smaller is more precise |
| **z value** | Estimate ÷ Std. Error — how many standard errors away from zero the estimate is |
| **Pr(>\|z\|)** | The p-value — the probability of seeing an effect this large if there were truly no effect |
| **Signif. codes (\*\*\*)** | A quick visual flag for how small the p-value is. `***` means p < 0.001, i.e. very strong evidence of a real effect |

**Row by row — what each coefficient means:**

- **(Intercept) = -6.30**: the baseline log-odds of MAP2 expression for cells with no treatment at all (NGN2_MOI = 0, NT3_ng = 0). Very negative, meaning very low odds of becoming a neuron untreated.
- **NGN2_MOI2 = 2.12**, which means MOI = 2 cells had about exp(2.12) ≈ **8x** the odds of becoming neurons compared to untreated (MOI = 0) cells.
- **NGN2_MOI5 = 3.97**, which means MOI = 5 cells had about exp(3.97) ≈ **53x** the odds of becoming neurons compared to untreated cells — the strongest boost of any dose.
- **NGN2_MOI10 = 3.11**, which means MOI = 10 cells had about exp(3.11) ≈ **22x** the odds compared to untreated cells — a big boost, but smaller than MOI = 5's.
- **NT3_ng10 = 0.31**, which means getting NT3 multiplied the odds of becoming a neuron by about exp(0.31) ≈ **1.4x** — a modest boost on top of whatever NGN2 dose the cells received.

> **Quick way to remember it:** exp(coefficient) tells you "how many times more likely" something becomes. A coefficient of 0 would mean exp(0) = 1, i.e., no change at all.

> **Key insight to notice:** MOI = 5 has a bigger effect than MOI = 10. This means the relationship isn't simply "more virus = more neurons" — there appears to be an optimal dose around MOI 5, with a slight drop-off at the highest dose tested.

**Why are all the categorical NGN2 levels compared to MOI = 0?**
Because MOI = 0 is the **reference level** — the baseline that every other category is compared against. R picks this automatically (usually the lowest numeric or first alphabetical value) unless you tell it otherwise.

---

## 7. Why is there a second printout with different numbers?

```
*** The full dataset, using 5 MOI as the reference level for NGN2 treatment ***
```

This is **the exact same model** — notice the residual deviance, null deviance, and AIC are *identical* to the first printout. All that's changed is which category is used as the baseline for comparison (now MOI = 5 instead of MOI = 0).

```
(Intercept)     -2.32867
NGN2_MOI0       -3.97231
NGN2_MOI2       -1.84823
NGN2_MOI10      -0.85953
NT3_ng10         0.31290
```

Now every coefficient is expressed **relative to MOI = 5**:
- **NGN2_MOI0 = -3.97**: MOI = 0 has *lower* log-odds of MAP2 expression than MOI = 5 (matches what we already knew)
- **NGN2_MOI2 = -1.85**: MOI = 2 is also lower than MOI = 5
- **NGN2_MOI10 = -0.86**: MOI = 10 is *also* lower than MOI = 5 — this confirms MOI = 5 gives the best outcome of all doses tested
- **NT3_ng10 = 0.31**: unchanged — NT3's effect doesn't depend on which NGN2 category is the reference, because it's a separate variable

**Takeaway:** Releveling doesn't change what the model has learned, only how the results are *expressed*. It's a useful trick when you want to directly compare every group against a specific category of interest (here, the best-performing dose).

**How do you actually tell which category is the reference, just from the table?**

Two clues:

1. **A text label may say so directly** — here, the heading above the second printout literally states `using 5 MOI as the reference level for NGN2 treatment`.
2. **The missing-row trick (the one that works even without a label):** the reference category never gets its own row in the coefficients table, because it's the baseline everything else is compared to.
   - In the **first** printout, the rows are `NGN2_MOI2, NGN2_MOI5, NGN2_MOI10` — MOI = 0 is missing → MOI = 0 is the reference.
   - In the **second** printout, the rows are `NGN2_MOI0, NGN2_MOI2, NGN2_MOI10` — MOI = 5 is missing → MOI = 5 is the reference.

> **Rule of thumb:** whichever category from a categorical predictor *isn't listed* in the coefficients table is the reference level.

---

## 8. The bottom section

```
(Dispersion parameter for binomial family taken to be 1)

Null deviance: 10204.34 on 23 degrees of freedom
Residual deviance: 712.97 on 19 degrees of freedom
AIC: 890.95
```

| Term | Meaning |
|---|---|
| **Null deviance** | How poorly a model with *no predictors* (just an intercept) fits the data |
| **Residual deviance** | How poorly *your* model (with NGN2 and NT3) fits the data |
| **Degrees of freedom** | Roughly, the number of data points minus the number of parameters estimated |
| **AIC** | A score for comparing different models — lower is better — but only meaningful when comparing models against each other, not in isolation |

**Why this matters:** the deviance dropped enormously (10204 → 713) when NGN2 and NT3 were added to the model. This tells you these predictors explain a large amount of the variation in MAP2 expression — the model fits the data well.

---

## 9. Quick-reference checklist for writing your conclusions

When summarising results like these, ask yourself:

- [ ] Which predictors have significant effects (look at the p-values / stars)?
- [ ] What is the *direction* of each effect (positive = increases odds, negative = decreases odds)?
- [ ] How do effect *sizes* compare to each other (which predictor matters most)?
- [ ] Is the relationship simple/linear, or is there a peak/optimum (as with MOI 5 vs 10)?
- [ ] How well does the model fit overall (deviance reduction)?

You don't need to mention every number in the printout — focus on translating the most important coefficients into a plain-English biological story.

---

## 10. [TUTOR ONLY — hide before sharing] Draft answer to the actual task

> The student's task asks for 2–4 bullet points summarising key conclusions. The draft below is for tutor reference during session prep — not for sharing directly with the student. Use the discussion points above to help them construct their own version instead.

- Increasing the NGN2 viral dose (MOI) strongly increases the likelihood of cells becoming neurons (MAP2+), with all doses showing highly significant effects compared to no virus (p < 2e-16).
- The relationship isn't simply "more virus = more neurons": MOI = 5 produced the largest increase in MAP2 expression of any dose tested, slightly outperforming the highest dose (MOI = 10), suggesting an optimal dose around MOI = 5 rather than a maximum dose being best.
- NT3 treatment also significantly increases the odds of MAP2 expression, but its effect is much smaller than the effect of NGN2 dose, indicating NGN2 is the main driver of neuronal differentiation.
- Overall, the model fits the data well, with NGN2 dose and NT3 treatment together explaining most of the variation in MAP2 expression across the dataset.

---

## 11. [TUTOR ONLY — hide before sharing] Session prompts to test understanding rather than hand over answers

- Cover the second printout and ask the student to predict what releveling to MOI = 5 would do to the signs/values of each coefficient, then check against the real output.
- Show just the list of row names from each table (without labels) and ask: "which dose is missing here, and what does that tell you?" — tests the missing-row trick directly.
- Ask the student to explain, in their own words, why MOI 5 outperforming MOI 10 is biologically interesting, before confirming — tests whether they can move from coefficient table to scientific reasoning.
- Ask them to convert one coefficient (e.g. NT3_ng10 = 0.31) into an odds multiplier themselves using exp(), to check they've understood the log-odds-to-odds conversion rather than just memorised the numbers from this session.
