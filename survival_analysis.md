
# 1. What survival analysis is (core idea)

> Survival analysis models the time until an event occurs while properly handling patients who do not experience the event during the study period (censoring), and the key result is the hazard ratio.

> “Think of survival analysis as extending logistic regression by adding time. Instead of asking whether an event happened, we ask when it happened. Some patients won’t experience the event during the study, so we treat them as censored rather than missing. The Cox model then compares hazard rates between groups, and we interpret the results using hazard ratios.”


Survival analysis is used when your outcome is:

> **Time until an event happens**

Common medical events:

* death
* disease recurrence
* hospital discharge
* relapse
* recovery

So instead of:

* “Did it happen?” (logistic regression)

you ask:

* **“When did it happen?”**

---

# 2. Why we need survival analysis (key intuition)

In real clinical data, not everyone experiences the event.

Example:

* Study runs for 12 months
* Some patients are still alive at the end

These people are **not data failures** — they are **censored observations**.

### Censoring (very important concept)

Censoring means:
> we stop observing someone before the event happens, but we still know they were event-free up to that point.

> we know the event did NOT happen during observation time, but we don’t know what happens after.

Example:

* Patient is alive at 12 months → we only know survival ≥ 12 months

---

# 3. Key outputs you interpret

## (A) Survival probability

* Probability of surviving beyond time t

## (B) Hazard (risk over time)

* Instant risk of event happening at time t

## (C) Hazard Ratio (HR) ← most important

* HR = 1 → no difference
* HR > 1 → higher risk
* HR < 1 → protective effect

Example:

* HR = 0.70 → 30% lower risk of death

---

# 4. Main model: Cox Proportional Hazards Model

This is the standard medical survival model.

$$h(t) = h_0(t)e^{\beta x}$$

You don’t usually interpret the equation directly.

You interpret:

> $$exp(β)$$ = Hazard Ratio

---

# 5. Clinical example (simple dataset)

### Study: Cancer survival after treatment

| Patient | Treatment | Time (months) | Event (death) |
| ------- | --------- | ------------- | ------------- |
| 1       | A         | 6             | 1             |
| 2       | A         | 8             | 0 (censored)  |
| 3       | B         | 4             | 1             |
| 4       | B         | 10            | 1             |
| 5       | A         | 7             | 0             |

* Time = follow-up duration
* Event = 1 (death), 0 (censored)

---

# 6. What results might look like (dummy output)

### Cox regression output

| Variable         | HR   | p-value |
| ---------------- | ---- | ------- |
| Treatment B vs A | 1.60 | 0.03    |

### Interpretation:

> Patients receiving Treatment B have **60% higher hazard of death** compared to Treatment A.

---

# 7. Kaplan-Meier curve (what students often see)

This is the basic survival plot:

* x-axis = time
* y-axis = probability of surviving

You will see step-like curves.

---

# 8. How to do it in R (simple version)

## Step 1: install package

```r
install.packages("survival")
library(survival)
```

## Step 2: create data

```r
time <- c(6, 8, 4, 10, 7)
event <- c(1, 0, 1, 1, 0)
treatment <- c("A", "A", "B", "B", "A")
```

## Step 3: survival object

```r
surv_obj <- Surv(time, event)
```

## Step 4: Cox model

```r
model <- coxph(surv_obj ~ treatment)
summary(model)
```

### Output interpretation:

* Look at exp(coef) → hazard ratio

---

## Kaplan-Meier plot in R

```r
fit <- survfit(surv_obj ~ treatment)
plot(fit)
```

---

# 9. How to do it in SPSS (step-by-step)

## (A) Kaplan-Meier (descriptive survival)

1. Go to:

   ```
   Analyze → Survival → Kaplan-Meier
   ```

2. Set:

   * Time = survival time
   * Status = event (1 = event occurred)
   * Factor = group (treatment)

3. Click:

   * “Compare factor” → Log-rank test

---

## (B) Cox regression (main analysis)

1. Go to:

   ```
   Analyze → Survival → Cox Regression
   ```

2. Set:

   * Time = time variable
   * Status = event variable (define 1 = event)
   * Covariates = predictors (e.g. treatment, age)

3. Output:

   * Exp(B) = Hazard Ratio

---

# 10. Common student misunderstandings (important to pre-empt)

### Mistake 1: thinking censoring = missing data

- Wrong
- It is valid partial information

---

### Mistake 2: interpreting HR like odds ratio

- HR is NOT odds
- HR is about **rate over time**

---

### Mistake 3: ignoring time

Logistic regression:

* ignores *when* something happens

Survival analysis:

* includes *when + whether*

---

