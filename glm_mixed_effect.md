Absolutely. I would separate this into two things: a **reusable teaching guide to linear/GLM/mixed models**, followed by a **very practical publication-analysis checking framework** you can use in appointments.

# Reusable Guide: Linear, Generalised Linear, and Mixed-Effects Models

## 1. The big picture

A useful starting framework is to ask **two questions**:

**Question 1: What type of outcome variable do I have?**

- Continuous outcome → often a linear model.
- Binary, count, proportion, etc. → often a generalised linear model.

**Question 2: Are the observations independent?**

- Independent observations → ordinary model.
- Repeated/clustered observations → consider a mixed-effects model.

This gives:

| | Independent observations | Repeated/clustered observations |
|---|---|---|
| Continuous outcome | Linear model (LM) | Linear mixed-effects model (LMM) |
| Binary/count/etc. | Generalised linear model (GLM) | Generalised linear mixed model (GLMM) |

Examples:

```text
Continuous + independent
→ LM

Continuous + repeated within participant
→ LMM

Binary + independent
→ logistic GLM

Binary + repeated within participant
→ logistic GLMM
```

One important qualification: don't choose between LM and GLM simply by running a normality test on the raw outcome. In a standard linear model, the normality assumption concerns the **errors/residuals conditional on the predictors**. For GLMs, the response distribution is explicitly modelled using an appropriate family.

---

# 2. Linear model

Suppose the outcome is a continuous `score`:

```r
lm(score ~ age_group + context, data = dat)
```

Read this as:

> Predict score using age group and context.

Here:

```text
score       = outcome/dependent variable
age_group   = predictor
context     = predictor
```

The model assumes observations are independent and, among other assumptions, that the model's residual errors are approximately normally distributed.

For example:

| Participant | Age group | Context | Score |
|---|---|---|---:|
| P01 | younger | formal | 75 |
| P02 | younger | informal | 68 |
| P03 | older | formal | 62 |
| P04 | older | informal | 58 |

If every row represents a different independent participant, an ordinary linear model may be appropriate.

---

# 3. Why repeated observations create a problem

Now suppose each participant contributes several observations:

| Participant | Context | Score |
|---|---|---:|
| P01 | formal | 75 |
| P01 | informal | 65 |
| P01 | neutral | 70 |
| P02 | formal | 58 |
| P02 | informal | 52 |
| P02 | neutral | 55 |

The observations are no longer completely independent.

Why?

Because:

```text
P01 → 75
P01 → 65
P01 → 70
```

all come from the same person.

P01 might simply tend to score higher than P02 regardless of context.

An ordinary model doesn't explicitly represent that stable participant-to-participant baseline variation.

This motivates a mixed-effects model.

---

# 4. Linear mixed-effects model

We could write:

```r
library(lme4)

model <- lmer(
  score ~ context + (1 | participant),
  data = dat
)
```

The important new part is:

```r
(1 | participant)
```

This is a **random intercept for participant**.

It tells the model:

> Observations are clustered within participants, and participants are allowed to have different baseline levels of the outcome.

---

# 5. Understanding `(1 | participant)`

This notation causes a lot of confusion initially.

The `1` does **not** mean:

- participant 1;
- level 1;
- one participant;
- first random effect.

It means:

> **intercept**

And:

```text
participant
```

is the grouping variable.

Therefore:

```r
(1 | participant)
```

means:

> **Allow the intercept to vary across participants.**

Or simply:

> **random intercept for participant.**

Suppose the population intercept is 60.

The model might estimate participant deviations conceptually like:

```text
Overall baseline = 60

P01: 60 + 10 = 70
P02: 60 -  8 = 52
P03: 60 +  1 = 61
```

The participants have different baseline tendencies.

---

# 6. What changes when `(1 | participant)` is added?

Compare:

```r
score ~ age_group + context
```

with:

```r
score ~ age_group + context + (1 | participant)
```

The first says:

> Predict score using age group and context.

The second says:

> Predict score using age group and context, **while recognising that observations are clustered within participants and allowing participants to have different baseline scores.**

This is the central purpose of the random intercept.

---

# 7. Fixed effects versus random effects

In:

```r
score ~ age_group + context + (1 | participant)
```

the fixed effects are:

```text
age_group
context
```

These are effects we explicitly want to estimate.

The random effect is:

```r
(1 | participant)
```

We normally aren't interested in making substantive claims such as:

> P037 is significantly different from P052.

Instead, participant is used to account for **between-participant heterogeneity and clustering**.

A useful distinction is:

> **Fixed effect:** What relationship/effect do I want to estimate?

> **Random effect:** Where are observations grouped/repeated, and what variation across those groups should the model represent?

---

# 8. Why `participant` after `|`?

The variable after `|` identifies the **grouping factor**.

For example:

```r
(1 | participant)
```

means observations are grouped by participant.

If students are clustered within schools:

```r
(1 | school)
```

If observations are clustered within countries:

```r
(1 | country)
```

If linguistic responses are repeated across stimuli/items:

```r
(1 | item)
```

You can also have multiple grouping factors:

```r
response ~ context +
  (1 | participant) +
  (1 | item)
```

This says:

> Allow baseline responses to vary across participants **and** across items.

This is common when participants respond repeatedly to the same collection of stimuli.

---

# 9. Why not `(1 | context)`?

Suppose `context` has:

```text
formal
informal
```

and the research question is specifically interested in the difference between formal and informal conditions.

Then `context` is normally treated as a **fixed effect**:

```r
response ~ context
```

Participants, however, may represent a grouping factor:

```text
P001
P002
...
P100
```

So:

```r
response ~ context + (1 | participant)
```

makes sense.

It says:

> Estimate the formal-versus-informal association while accounting for repeated observations within participants.

A variable can sometimes serve as a random-effects grouping factor in another design, but that depends on what the variable represents. It isn't determined merely by whether its name is `context`.

---

# 10. What is a random slope?

Consider:

```r
(1 | participant)
```

Participants have different baselines, but the fixed effect of `context` is assumed to apply in the same way across participants, apart from residual/random variation.

But perhaps people respond differently to context.

For example:

```text
P01: strong formal/informal difference
P02: almost no difference
P03: moderate difference
```

Then we could consider:

```r
(1 + context | participant)
```

This means:

> Allow participants to have different intercepts **and different context slopes**.

So:

```text
1
```

= random intercept

and:

```text
context
```

= random slope.

---

# 11. Does a random-slope variable need to vary within the grouping factor?

Generally, yes.

Suppose:

| Participant | Age group | Context |
|---|---|---|
| P01 | younger | formal |
| P01 | younger | informal |
| P01 | younger | formal |
| P02 | older | formal |
| P02 | older | informal |
| P02 | older | formal |

Within P01:

```text
age_group:
younger
younger
younger
→ no within-participant variation

context:
formal
informal
formal
→ varies within participant
```

Therefore:

```r
(1 + context | participant)
```

can make sense.

But:

```r
(1 + age_group | participant)
```

generally does not, because an individual participant doesn't change between younger and older.

A useful question is:

> **Does X vary within the grouping variable?**

If yes, a random slope for X by that grouping variable may be meaningful.

---

# 12. Can there be multiple random slopes?

Yes.

Suppose both `context` and `task_type` vary within participant:

```r
(1 + context + task_type | participant)
```

This allows participants to differ in:

```text
baseline response
context effect
task-type effect
```

For example:

| Participant | Baseline | Context effect | Task effect |
|---|---|---|---|
| P01 | high | strong | weak |
| P02 | low | weak | strong |
| P03 | medium | moderate | moderate |

However, adding random slopes increases model complexity. They should be supported by the design and data rather than added automatically.

---

# 13. What does `0` mean?

R includes an intercept by default.

Therefore:

```r
(context | participant)
```

is effectively:

```r
(1 + context | participant)
```

Both specify random intercepts and random slopes for context.

But:

```r
(0 + context | participant)
```

removes the usual random intercept.

It specifies a random effect associated with `context` without the standard random intercept parameterisation.

For a first introduction, remember:

| Syntax | Basic interpretation |
|---|---|
| `(1 \| participant)` | Random intercept |
| `(context \| participant)` | Random intercept + random slope for context |
| `(1 + context \| participant)` | Same basic specification |
| `(0 + context \| participant)` | No standard random intercept; random effects associated with context |

There are additional nuances when `context` is categorical, because removing the intercept changes its parameterisation, but this is sufficient for an introductory explanation.

---

# 14. What is an interaction?

Now keep **interaction** separate from **random slope**.

Suppose:

```r
response ~ age_group * context
```

In R:

```r
age_group * context
```

expands to:

```r
age_group +
context +
age_group:context
```

So:

```r
response ~ age_group * context
```

asks about:

1. age group;
2. context;
3. the interaction between age group and context.

The interaction asks:

> **Does the relationship/effect of context differ depending on age group?**

---

# 15. Interaction example

Suppose:

| Age group | Formal | Informal |
|---|---:|---:|
| Younger | 80% | 40% |
| Older | 50% | 45% |

For younger people:

```text
80% → 40%
difference = 40 percentage points
```

For older people:

```text
50% → 45%
difference = 5 percentage points
```

The context difference is very different between age groups.

That suggests an **age group × context interaction**.

Contrast that with:

| Age group | Formal | Informal |
|---|---:|---:|
| Younger | 80% | 60% |
| Older | 50% | 30% |

Here the formal-informal difference is approximately 20 percentage points in both groups.

There may be main effects of age group and context without much interaction.

The easiest definition to remember is:

> **Interaction = does the effect/association of X depend on Y?**

---

# 16. Fixed interaction versus random slope

These are related but **not the same thing**.

Consider:

```r
response ~ age_group * context +
  (1 + context | participant)
```

The fixed interaction:

```r
age_group * context
```

asks:

> Does the average context effect differ between younger and older groups?

The random slope:

```r
(1 + context | participant)
```

asks:

> Do individual participants differ in their context effects?

So one concerns systematic differences associated with `age_group`; the other represents unexplained participant-to-participant variation in the context effect.

A useful translation of the whole model is:

> Estimate whether context is associated with the response differently across age groups, while allowing individual participants to differ in their baseline responses and in how strongly they respond to context.

---

# 17. GLM and GLMM

Now suppose the outcome isn't continuous.

For example:

```text
response = 0 → linguistic feature absent
response = 1 → linguistic feature present
```

This is binary.

For independent observations, logistic regression can be fitted as a GLM:

```r
glm(
  response ~ age_group + context,
  family = binomial,
  data = dat
)
```

If observations are repeatedly measured within participants:

```r
glmer(
  response ~ age_group + context +
    (1 | participant),
  family = binomial,
  data = dat
)
```

Now we have a **generalised linear mixed model**.

Why?

`family = binomial`

→ accommodates the binary outcome through a binomial GLM, normally with a logit link.

`(1 | participant)`

→ accommodates participant-level clustering.

---

# 18. A practical model-selection framework

Rather than asking:

> “Are my data normal?”

start with:

### Question 1: What is the outcome?

Continuous?

Binary?

Count?

Proportion/binomial?

Ordinal?

Other?

Then select an appropriate model family.

### Question 2: What is the structure of the observations?

Are observations genuinely independent?

Or are there:

- repeated measurements;
- participants;
- items;
- schools;
- hospitals;
- countries;
- households;
- classrooms;
- other meaningful clusters?

If observations are clustered, consider whether a mixed-effects structure is appropriate.

### Question 3: What predictors answer the research question?

These become the fixed effects.

### Question 4: Are interactions scientifically meaningful?

Ask:

> Does the research question predict that the relationship between X and Y depends on Z?

If yes, an interaction may be appropriate.

### Question 5: Which predictors vary within the grouping units?

These may potentially require random slopes, depending on the design and modelling strategy.

---


If they can provide coherent answers to those questions and the model/output supports those answers, you're in a strong position.

And for a short publication-checking appointment, I'd prioritise the four checks in exactly this order: **model choice → model specification → diagnostics → interpretation/reporting**. That prevents getting distracted by individual p-values before establishing whether the underlying model makes sense.
