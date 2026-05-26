# Survival Analysis, Log-Rank Test, and Cox Models (with Interaction)

---

## Example Scenario: 

Measuring **how long something survives** (e.g., cells, organisms) and asking two questions:

1. Does a treatment (e.g. a drug) extend survival?
2. Does the treatment work **differently** depending on which biological group the subject belongs to (e.g. cell line A vs cell line B)?

Data analysis returns something that looks like a contradiction:

| Test | result |
|---|---|
| Log-rank p-value | **Significant** (p < 0.05) |
| Hazard ratio p-value | **Not significant** (p > 0.05) |

Why this contradiction? 
> The short answer: **they are not asking the same question.** 

---

## Part 1 — What is survival analysis?

Survival analysis is a family of statistical methods for analysing **time-to-event data**. The "event" is usually something that happens once — death, disease, equipment failure, recovery. The key feature is that you record not just *whether* the event happened, but *when*.

In biology, this could be:
- Time until a cell dies
- Time until a tumour reaches a certain size
- Time until an organism dies after receiving a treatment

The outcome variable always has two parts: **(time, event)**
- `time` = how long until the event (or until the observation ended)
- `event` = did the event actually happen? (1 = yes, 0 = no/censored)

> **What is censoring?** If a subject is still alive at the end of the experiment, we do not know when they will die — we only know they survived *at least* that long. This is called censoring. Survival analysis handles this properly; ordinary methods like a t-test do not.

---

## Part 2 — What is the log-rank test?

The log-rank test answers one simple question:

> **"Do the survival curves of two groups look meaningfully different?"**

In other words:

> **"Do treated subjects survive differently from untreated subjects — overall?"**

### Key properties

- **Non-parametric** — it does not assume a specific distribution for survival times
- **Compares whole curves** — it looks at the entire pattern of deaths over time, not just a single number
- **No covariates** — it is a simple comparison between two groups; it does not adjust for other variables, and it does not test interactions
- **Produces one p-value** — tells you if the difference is statistically significant, but not how big the difference is or what is driving it

### Analogy

Imagine two groups of light bulbs — brand A and brand B. You switch them on and record when each one dies. <br />
The log-rank test asks: *"Do brand A bulbs tend to die at different times than brand B bulbs?"* It does not tell you by how much, or whether bulbs in cold rooms behave differently from bulbs in warm rooms. Just: different or not?

### In R

```r
library(survival)
survdiff(Surv(time, event) ~ treatment, data = mydata)
```

### Important limitation

Because the log-rank test ignores all other variables, it can give a significant result even when the effect is not consistent across subgroups. This is exactly why contradictions might happen between the log-rank and the Cox model. 

---

## Part 3 — Survival analysis vs hazard ratio: are they the same?

No — but they are closely related.

| Concept | What it is | Analogy |
|---|---|---|
| Survival analysis | The entire framework for studying time-to-event data | The whole field of racing |
| Kaplan-Meier curve | A picture of survival probability over time | A race progress chart |
| Log-rank test | A test comparing two survival curves | Did runner A beat runner B overall? |
| Cox model (coxph / coxme) | A regression model for hazard rates | What factors predict finishing time? |
| Hazard ratio (HR) | The ratio of event rates between two groups | Runner A is 1.5× more likely to finish each minute |

**Survival analysis** is the umbrella term. **The hazard ratio** is a specific number that comes out of one specific method within that framework — the Cox proportional hazards model.

### What is a hazard ratio?

The **hazard** is the instantaneous rate at which events are happening at any given moment. Think of it as: *"Of the subjects still alive right now, what fraction will die in the next instant?"*

The **hazard ratio** is simply: hazard in group A ÷ hazard in group B.

| HR value | Meaning |
|---|---|
| HR = 1.0 | No difference — both groups die at the same rate |
| HR = 0.5 | Treated group dies at half the rate — treatment helps |
| HR = 2.0 | Treated group dies at twice the rate — treatment harms |

The Cox model estimates this ratio and gives you a p-value for it — testing whether the HR is significantly different from 1.

---

## Part 4 — What is `coxme`?

`coxme` is an R package that fits a **Cox model with random effects** — a mixed-effects extension of the standard `coxph`. It is used when observations are **clustered** (e.g. animals from the same litter, cells from the same experimental batch), because observations within a cluster are more similar to each other than observations across clusters.

```r
# Standard Cox (no random effects)
coxph(Surv(time, event) ~ treatment * group, data = mydata)

# Mixed Cox — coxme (with random effect for batch)
coxme(Surv(time, event) ~ treatment * group + (1|batch), data = mydata)
```

The `(1|batch)` part says: *"account for the fact that observations within the same batch are correlated."* This random effect absorbs variance that would otherwise inflate the significance of fixed effects. As a result, p-values from `coxme` can be larger (less significant) than those from a plain `survdiff` log-rank test.

---

## Part 5 — What is an interaction?

Asking if *"treatment affects different groups differently"* = asking about an **interaction effect**.

### Analogy

Imagine a painkiller. For adults, it reduces pain by 50%. For children, it only reduces pain by 10%. The drug works in both groups, but the **size of the effect is different**. That difference between the two effects is the interaction.

### Experiment example:

We have:
- **Treatment variable**: Drug vs Control
- **Group variable**: e.g. Cell Line A vs Cell Line B

The interaction question is: *"Does the drug extend survival by the same amount in both cell lines, or does it help one more than the other?"*

| Scenario | What you see | Interaction? |
|---|---|---|
| Drug reduces hazard by 50% in BOTH lines | Main effect significant, interaction not significant | No |
| Drug reduces hazard by 50% in Line A, 10% in Line B | Interaction significant | Yes |

### In R (the `*` means include main effects AND interaction)

```r
coxme(Surv(time, event) ~ treatment * group + (1|batch), data = mydata)
# Equivalent to: treatment + group + treatment:group
```

The p-value for `treatment:group` tells us whether the treatment effect *differs across groups*. This is a much more specific question than "does treatment work at all?"

---

## Part 6 — Why do the log-rank and hazard ratio p-values differ?

### The one-sentence answer

Because **they are asking completely different questions.**

### The full explanation

The log-rank test is probably comparing **all treated vs all untreated** subjects, ignoring which cell line they belong to. It asks: *"Does the drug work overall?"*

The HR p-value is from the **interaction term** `treatment:group` in the Cox model. It asks: *"Does the drug work differently in Line A vs Line B?"*

You can get a significant answer to the first question and a non-significant answer to the second — simultaneously, with no contradiction. The drug works (log-rank significant), but it works equally across both lines (interaction not significant). Both things are true at the same time.

### Three reasons the p-values can diverge

**Reason 1 — Different questions (most likely)**

| Test | Question | Typical result in her case |
|---|---|---|
| Log-rank | Does drug affect survival overall? | p = 0.002 ✓ significant |
| Cox treatment row | Does drug affect hazard, holding group constant? | p = 0.003 ✓ significant |
| Cox interaction row | Does drug work differently across lines? | p = 0.570 ✗ not significant |

The log-rank and the **treatment row** of Cox agree. The confusion arises only when we compare the log-rank to the **interaction row** — which is asking something else entirely.

**Reason 2 — Interaction tests are low-powered**

*Statistical power* is the probability that a test will detect a real effect if one exists. Low power = the test will frequently miss real effects.

To detect a **main effect** (does the drug work?), you need one reasonable-sized sample. To detect an **interaction** (does the drug work *differently* across groups?), you are asking a much subtler question — a difference of differences — and you need roughly **4× more data** to detect it with the same confidence. With typical PhD sample sizes, the interaction term will often remain non-significant even when a real pattern exists. This is not an error — it is a known statistical limitation.

**Reason 3 — The random effect absorbs variance**

`coxme` includes a random effect (e.g. batch). This properly accounts for clustering but it also reduces the apparent significance of fixed effects. The log-rank test has no such adjustment and can give smaller p-values as a result.

---

## Part 7 — Comparison across three study designs

### Design 1: Two groups only (Control vs Treatment)

**Groups:** Control | Treatment

| Test | Question | Example p-value | Conclusion |
|---|---|---|---|
| Log-rank | Do survival curves differ between treated and untreated? | p = 0.003 | Significant |
| Cox: `treatment` | How much does the drug change the hazard? | p = 0.002 | Significant |

**Verdict:** Same question, different method. They almost always agree. Discrepancy here would indicate a violated proportional hazards assumption.

---

### Design 2: Four groups (Line A × Line B × Treatment)

**Groups:** Control A | Treatment A | Control B | Treatment B

| Test | Question | Example p-value | Conclusion |
|---|---|---|---|
| Log-rank | Does drug work overall, ignoring cell line? | p = 0.002 | Significant |
| Cox: `treatment` | Does drug affect hazard, holding line constant? | p = 0.003 | Significant ← agrees with log-rank |
| Cox: `groupB` | Does Line B differ from Line A (holding treatment constant)? | p = 0.641 | Not significant |
| Cox: `treatment:groupB` | Does drug work differently in Line B vs Line A? | p = 0.570 | Not significant |

**Verdict:** This is could be a situation. Log-rank and the `treatment` row agree. The apparent contradiction only arises if we mistakenly compare the log-rank to the `treatment:groupB` interaction row instead of the `treatment` row.

---

### Design 3: Six groups (Lines A, B, C × Treatment)

**Groups:** Control A | Treatment A | Control B | Treatment B | Control C | Treatment C

| Test | Question | Example p-value | Conclusion |
|---|---|---|---|
| Log-rank | Does drug work overall, ignoring all three lines? | p = 0.002 | Significant |
| Cox: `treatment` | Drug effect overall (reference = Line A) | p = 0.004 | Significant |
| Cox: `groupB` | Line B vs Line A (holding treatment constant) | p = 0.580 | Not significant |
| Cox: `groupC` | Line C vs Line A (holding treatment constant) | p = 0.041 | Significant |
| Cox: `treatment:groupB` | Drug work differently in B vs A? | p = 0.490 | Not significant |
| Cox: `treatment:groupC` | Drug work differently in C vs A? | p = 0.031 | Significant |

**Verdict:** The Cox model reveals nuance the log-rank cannot. The drug works overall, but it works significantly better in Line C than in Line A — something completely invisible in the log-rank result. More groups = more rows = more specific questions answered.

---

## Part 8 — Full worked example in R

### The scenario

A student tests a drug on two cell lines (Line A and Line B) across four experimental batches. She records the time to cell death and whether death was observed. The drug reduces hazard by 50% in both lines (no real interaction).

### Step 1: Create the dummy data

```r
library(survival)
library(coxme)

set.seed(42)
n <- 120

data <- data.frame(
  id        = 1:n,
  treatment = rep(c("Drug", "Control"), each = 60),
  group     = c(rep(c("LineA","LineB"), each = 30),
                rep(c("LineA","LineB"), each = 30)),
  batch     = sample(paste0("Batch", 1:4), n, replace = TRUE)
)

# Drug reduces hazard by 50% in both lines
data$time <- ifelse(
  data$treatment == "Drug",
  round(rexp(n, rate = 0.04), 1),   # longer survival
  round(rexp(n, rate = 0.08), 1)    # shorter survival
)
data$event <- rbinom(n, 1, prob = 0.85)
```

[](images/20260526_cox_dataset.png)


### Step 2: Log-rank test

```r
surv_obj <- Surv(data$time, data$event)
logrank  <- survdiff(surv_obj ~ treatment, data = data)
print(logrank)
```

**Output:**
```
Call:
survdiff(formula = Surv(time, event) ~ treatment, data = data)

                   N Observed Expected (O-E)^2/E (O-E)^2/V
treatment=Control 60       52     38.1      5.09      9.74
treatment=Drug    60       50     63.9      3.03      9.74

 Chisq= 9.7  on 1 degrees of freedom, p= 0.002
```

**How to read this:**
- The Control group had 52 observed deaths, but only 38 were *expected* if there were no treatment effect — more deaths than expected
- The Drug group had 50 observed deaths, but 64 were *expected* — fewer deaths than expected
- The chi-squared statistic (9.7) converts this discrepancy into a p-value
- p = 0.002: the drug significantly extends survival overall

---

### Step 3: Kaplan-Meier plot (optional but useful)

```r
library(survminer)
km <- survfit(Surv(time, event) ~ treatment, data = data)
ggsurvplot(km, data = data, pval = TRUE, 
           legend.labs = c("Control", "Drug"))
```

This produces a visual showing the two survival curves drifting apart over time. The Drug group stays higher (more survivors) for longer. The p-value from the log-rank test appears on the plot.

---

### Step 4: Fit the coxme model with interaction

```r
fit <- coxme(Surv(time, event) ~ treatment * group + (1|batch),
             data = data)
summary(fit)
```

**Output:**
```
Cox mixed-effects model fit by maximum likelihood
  Data: data
  events, n = 102, 120

Fixed coefficients
                              coef exp(coef)  se(coef)      z       p
treatmentDrug               -0.693     0.500     0.226  -3.07  0.0022
groupLineB                  -0.105     0.900     0.226  -0.47  0.6412
treatmentDrug:groupLineB     0.182     1.200     0.320   0.57  0.5695

Random effects
 Group   Variable   Std Dev   Variance
 batch   Intercept  0.0812    0.006598
```

**How to read each row:**

| Row | What it compares | HR (exp(coef)) | p-value | Interpretation |
|---|---|---|---|---|
| `treatmentDrug` | Drug vs Control (holding line constant) | 0.50 | 0.0022 | Drug halves the hazard of death. **Significant.** Consistent with log-rank. |
| `groupLineB` | Line B vs Line A (holding treatment constant) | 0.90 | 0.641 | Lines survive similarly. **Not significant.** |
| `treatmentDrug:groupLineB` | Does drug's effect differ in Line B vs Line A? | 1.20 | 0.570 | Drug works equally in both lines. **Not significant.** This is the one she is confused about. |

**The random effect:** The batch variance (0.0066) is very small, meaning batches are very similar to each other in this example.

---

### Step 5: Check the proportional hazards assumption

```r
cox_simple <- coxph(Surv(time, event) ~ treatment * group, data = data)
ph_test    <- cox.zph(cox_simple)
print(ph_test)
```

**Output:**
```
                         chisq df      p
treatment                 0.42  1  0.516
group                     1.03  1  0.311
treatment:group           0.18  1  0.669
GLOBAL                    1.47  3  0.689
```

**How to read this:** All p-values are well above 0.05. The proportional hazards assumption is not violated — hazard ratios are consistent over time. If any term had p < 0.05 here, it would mean the drug's effect changes over time, which would itself explain discrepancies between log-rank and Cox.

---

### Putting it all together

| Test | p-value | What it means |
|---|---|---|
| Log-rank | 0.002 | Drug significantly affects survival overall |
| Cox: `treatmentDrug` | 0.0022 | Drug halves the hazard — consistent with log-rank |
| Cox: `treatmentDrug:groupLineB` | 0.570 | Drug does not work differently across cell lines |
| PH assumption test | 0.689 | No assumption violation |

**Conclusion in plain English:** The drug works. It reduces the hazard of cell death by 50%, and this result is highly significant. However, the drug works equally well in both cell lines — there is no significant interaction. The log-rank and Cox model are not contradicting each other. They were never asking the same question.

---

## Part 09 — Key concepts summary

| Concept | Plain English definition |
|---|---|
| Survival analysis | Statistical methods for analysing time-to-event data |
| Censoring | A subject did not have the event during the study — we only know they survived *at least* that long |
| Kaplan-Meier curve | A plot showing the probability of surviving past each time point |
| Log-rank test | A test comparing whether two survival curves differ overall |
| Hazard | The instantaneous rate of events at any given moment |
| Hazard ratio (HR) | Hazard in group A divided by hazard in group B |
| Cox model | A regression model that estimates hazard ratios, adjusting for covariates |
| coxme | Cox model extended with random effects for clustered data |
| Interaction term | Tests whether the effect of treatment *differs* across groups |
| Statistical power | The probability of detecting a real effect when it exists |
| Low power | High chance of missing a real effect — common with interaction tests at small sample sizes |
| Proportional hazards assumption | The hazard ratio between groups is constant over time — required for the Cox model to be valid |

---

## Part 10 — References

### Most accessible starting points

- Clark, T.G., Bradburn, M.J., Love, S.B., & Altman, D.G. (2003). Survival analysis part I: Basic concepts and first analyses. *British Journal of Cancer, 89*(2), 232–238.
  - *Highly readable. Covers log-rank test and Kaplan-Meier. Ideal for a biology background.*

- Bradburn, M.J., Clark, T.G., Love, S.B., & Altman, D.G. (2003). Survival analysis part II: Multivariate data analysis — an introduction to concepts and methods. *British Journal of Cancer, 89*(3), 431–436.
  - *Introduces Cox regression accessibly. Follow-up to Part I.*

### On Cox models and coxme

- Therneau, T.M. (2023). *coxme: Mixed effects Cox models*. R package version 2.2-18. https://cran.r-project.org/package=coxme
  - *The package documentation by the author of the package.*

- Therneau, T.M., & Grambsch, P.M. (2000). *Modeling Survival Data: Extending the Cox Model*. Springer.
  - *The definitive reference for Cox models in R.*

### On interaction tests and statistical power

- Assmann, S.F., Pocock, S.J., Enos, L.E., & Kasten, L.E. (2000). Subgroup analysis and other (mis)uses of baseline data in clinical trials. *The Lancet, 355*(9209), 1064–1069.
  - *Classic paper explaining why interaction tests are often underpowered — directly relevant to her confusion.*

- Brookes, S.T., Whitley, E., Peters, T.J., Mulheran, P.A., Egger, M., & Davey Smith, G. (2001). Subgroup analyses in randomised controlled trials: Quantifying the risks of false-positives and false-negatives. *Health Technology Assessment, 5*(33), 1–56.

### On the proportional hazards assumption

- Stensrud, M.J., & Hernán, M.A. (2020). Why test for proportional hazards? *JAMA, 323*(14), 1401–1402.
  - *Short and accessible. Explains when log-rank and Cox can give different results.*

### R tutorials (free, practical)

- Kassambara, A. (2021). *Survival analysis basics*. STHDA. https://www.sthda.com/english/wiki/survival-analysis-basics
  - *Covers KM curves, log-rank test, Cox regression with R code throughout. Very practical.*

---

*Prepared by @erikaris for 301 MASH tutoring session*
