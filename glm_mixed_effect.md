# A. Linear, Generalised Linear, and Mixed-Effects Models

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

---

# A. Reporting Regression and Mixed-Effects Models in Academic Writing

The statistical analysis section should provide enough information for readers to understand **what was analysed, which model was fitted, why the model was appropriate, which predictors were included, how dependencies in the data were handled, and how the model was interpreted**.

The description should correspond directly to the fitted statistical model.

## 1. Linear regression

For a continuous outcome with independent observations:

```r id="l9p5of"
lm(score ~ age_group + context, data = dat)
```

An appropriate description is:

> A multiple linear regression model was fitted to examine the associations of age group and context with the outcome score. Age group and context were included as predictors.

With a single predictor:

```r id="wh9v02"
lm(score ~ age, data = dat)
```

the analysis may be described as:

> A simple linear regression model was fitted to examine the association between age and the outcome score.

---

## 2. Linear regression with an interaction

For:

```r id="c1zn2s"
lm(
  score ~ age_group * context,
  data = dat
)
```

an appropriate description is:

> A linear regression model was fitted with age group, context, and their interaction as predictors. The interaction term was included to examine whether the association between context and the outcome score differed between age groups.

In R,

```r id="wsnt8a"
age_group * context
```

expands to:

```r id="oh6ofh"
age_group + context + age_group:context
```

The interaction therefore tests whether the association between one predictor and the outcome depends on the value or level of the other predictor.

---

## 3. Linear mixed-effects model with a random intercept

When a continuous outcome contains repeated observations within participants:

```r id="xy35xp"
lmer(
  score ~ age_group + context +
    (1 | participant),
  data = dat
)
```

the model may be described as:

> A linear mixed-effects model was fitted to examine the associations of age group and context with the outcome score. Age group and context were included as fixed effects. A random intercept for participant was included to account for repeated observations within participants.

The term:

```r id="y4xhl1"
(1 | participant)
```

allows participants to have different baseline levels of the outcome.

A more detailed description may therefore state:

> A random intercept for participant was included to account for repeated observations within participants and to allow baseline outcome levels to vary across participants.

---

## 4. Linear mixed-effects model with an interaction

For:

```r id="zq4ws2"
lmer(
  score ~ age_group * context +
    (1 | participant),
  data = dat
)
```

an appropriate description is:

> A linear mixed-effects model was fitted with age group, context, and their interaction as fixed effects. The interaction tested whether the association between context and the outcome score differed between age groups. A random intercept for participant was included to account for repeated observations within participants.

---

## 5. Linear mixed-effects model with a random slope

For:

```r id="8wctkc"
lmer(
  score ~ age_group * context +
    (1 + context | participant),
  data = dat
)
```

an appropriate description is:

> A linear mixed-effects model was fitted with age group, context, and their interaction as fixed effects. Random intercepts and random slopes for context by participant were included, allowing participants to vary in both their baseline outcome scores and their responses to context.

The random-effects specification can be interpreted as:

| Component | Interpretation |
|---|---|
| `1` | Baseline outcome can differ between participants |
| `context` | The association between context and outcome can differ between participants |
| `participant` | Participant is the grouping variable |

A random slope is generally meaningful when the predictor varies **within the grouping unit**. For example, if each participant experiences both formal and informal contexts, the effect of context can potentially vary across participants.

---

## 6. Multiple random slopes

If several predictors vary within participants:

```r id="g0on8x"
lmer(
  score ~ age_group * context +
    (1 + context + task_type | participant),
  data = dat
)
```

the model may be described as:

> Random intercepts and random slopes for context and task type by participant were included, allowing participants to vary in their baseline outcome scores as well as in their responses to context and task type.

The inclusion of multiple random slopes increases model complexity and should be supported by the study design and available data.

---

## 7. Generalised linear model for a binary outcome

For a binary outcome with independent observations:

```r id="0fr1q8"
glm(
  response ~ age_group + context,
  family = binomial,
  data = dat
)
```

the model may be described as:

> A logistic regression model was fitted to examine the associations of age group and context with the probability of the response.

A more technical description is:

> A generalised linear model with a binomial distribution and logit link was fitted to examine the associations of age group and context with the probability of the response.

---

## 8. Generalised linear model with an interaction

For:

```r id="9v5zy3"
glm(
  response ~ age_group * context,
  family = binomial,
  data = dat
)
```

an appropriate description is:

> A logistic regression model was fitted with age group, context, and their interaction as predictors. The interaction was included to examine whether the association between context and the probability of the response differed between age groups.

---

# 9. Generalised linear mixed-effects model

For a binary outcome containing repeated observations:

```r id="x4v3l2"
glmer(
  response ~ age_group + context +
    (1 | participant),
  family = binomial,
  data = dat
)
```

an appropriate description is:

> A generalised linear mixed-effects model (GLMM) with a binomial distribution and logit link was fitted to examine the associations of age group and context with the probability of the response. Age group and context were included as fixed effects, and a random intercept for participant was included to account for repeated observations within participants.

If relevant, the software may also be reported:

> The model was fitted in R using the `glmer()` function from the `lme4` package.

---

## 10. GLMM with an interaction

For:

```r id="il86bf"
glmer(
  response ~ age_group * context +
    (1 | participant),
  family = binomial,
  data = dat
)
```

an appropriate description is:

> A generalised linear mixed-effects model with a binomial distribution and logit link was fitted. Age group, context, and their interaction were included as fixed effects. The interaction tested whether the association between context and the probability of the response differed between age groups. A random intercept for participant was included to account for repeated observations within participants.

---

## 11. GLMM with random intercept and random slope

For:

```r id="d5fmwh"
glmer(
  response ~ age_group * context +
    (1 + context | participant),
  family = binomial,
  data = dat
)
```

an appropriate description is:

> A generalised linear mixed-effects model with a binomial distribution and logit link was fitted. Age group, context, and their interaction were included as fixed effects. Random intercepts and random slopes for context by participant were included, allowing participants to vary in both their baseline probability of the response and their response to context.

---

## 12. Multiple grouping factors

In some studies, observations may be clustered by both participants and stimulus items:

```r id="tm6lhc"
glmer(
  response ~ age_group * context +
    (1 | participant) +
    (1 | item),
  family = binomial,
  data = dat
)
```

An appropriate description is:

> Random intercepts were included for participants and items to account for variation in baseline response probabilities across both participants and stimulus items.

When participants respond to multiple items and items are presented to multiple participants, this represents a crossed rather than simply nested data structure.

---

## 13. Participants and items with random slopes

A more complex model might be:

```r id="5yxznt"
glmer(
  response ~ age_group * context +
    (1 + context | participant) +
    (1 + age_group | item),
  family = binomial,
  data = dat
)
```

Here, `context` varies within participants, while different age groups may respond to the same items.

An appropriate description is:

> The model included random intercepts and random slopes for context by participant, as well as random intercepts and random slopes for age group by item. This specification allowed the association with context to vary across participants and the association with age group to vary across items.

The appropriate random-slope structure depends on which predictors vary within each grouping factor.

---

## 14. Count outcomes

For independent count data:

```r id="8ffrsc"
glm(
  count ~ age_group + context,
  family = poisson,
  data = dat
)
```

an appropriate description is:

> A Poisson regression model with a log link was fitted to examine the associations of age group and context with the expected count of the outcome.

For repeated count observations:

```r id="i18n2a"
glmer(
  count ~ age_group + context +
    (1 | participant),
  family = poisson,
  data = dat
)
```

the analysis may be described as:

> A generalised linear mixed-effects model with a Poisson distribution and log link was fitted to model the count outcome. Age group and context were included as fixed effects, with a random intercept for participant to account for repeated observations within participants.

The suitability of the Poisson distribution should also be assessed, particularly with respect to overdispersion and, where relevant, excess zeros.

---

# 15. Translating random-effects notation into academic writing

| Model specification | Interpretation | Example wording |
|---|---|---|
| `(1 \| participant)` | Random intercept | “A random intercept for participant was included to account for repeated observations within participants.” |
| `(1 \| item)` | Random intercept for items | “A random intercept for item was included to account for variation across items.” |
| `(1 \| participant) + (1 \| item)` | Two grouping factors | “Random intercepts were included for participants and items.” |
| `(1 + context \| participant)` | Random intercept + context slope | “Random intercepts and random slopes for context by participant were included.” |
| `(context \| participant)` | Same basic specification as `1 + context` | “Random intercepts and random slopes for context by participant were included.” |
| `(0 + context \| participant)` | No standard random intercept; random effects associated with context | The wording should reflect the specific parameterisation rather than describing it as an ordinary random-intercept model. |
| `(1 + context + task \| participant)` | Random intercept + two random slopes | “Random intercepts and random slopes for context and task by participant were included.” |

---

# 16. Translating a complete model into academic writing

Consider:

```r id="xnhc9m"
glmer(
  response ~ age_group * context +
    (1 + context | participant) +
    (1 | item),
  family = binomial,
  data = dat
)
```

The model contains:

| R component | Meaning |
|---|---|
| `response` | Outcome |
| `family = binomial` | Binary/binomial outcome |
| `age_group` | Fixed effect |
| `context` | Fixed effect |
| `age_group:context` | Fixed interaction |
| `(1 \| participant)` | Participant random intercept |
| `(context \| participant)` | Participant random slope for context |
| `(1 \| item)` | Item random intercept |

A complete Methods description could therefore be:

> A generalised linear mixed-effects model with a binomial distribution and logit link was fitted to model the probability of the response. Age group, context, and their interaction were included as fixed effects. The interaction tested whether the association between context and the response differed between age groups. Random intercepts and random slopes for context were included by participant, allowing participants to vary in both their baseline response probabilities and their responses to context. A random intercept for item was also included to account for variation across stimulus items.

---

# 17. Methods wording versus Results wording

The **Methods** section describes what was done:

> Age group, context, and their interaction were included as fixed effects. A random intercept for participant was included to account for repeated observations within participants.

The **Results** section describes what was found:

> There was evidence of an interaction between age group and context (β = 0.79, SE = 0.25, z = 3.16, p = .002), indicating that the association between context and the probability of the response differed between age groups.

The interaction should then be interpreted substantively, preferably using appropriate contrasts or predicted values:

> Model-predicted probabilities indicated a larger difference between formal and informal contexts among younger participants than among older participants.

This is more informative than reporting only that an interaction was “significant”.

---

# 18. Reporting a non-significant interaction

Statements such as:

> “There was no interaction.”

can overstate the evidence.

More appropriate wording includes:

> There was insufficient evidence of an interaction between age group and context (β = ..., 95% CI [...], p = ...).

or:

> The analysis did not provide clear evidence that the association between context and the response differed between age groups.

A non-significant result does not demonstrate that the interaction is exactly zero.

---

# 19. Common wording problems

### Too vague

> “A regression was conducted.”

Better:

> “A generalised linear mixed-effects model with a binomial distribution and logit link was fitted.”

### Incorrect description of random effects

> “Participant was controlled for.”

Better:

> “A random intercept for participant was included to account for repeated observations within participants.”

### Poor justification for an interaction

> “An interaction was added to determine whether it was significant.”

Better:

> “The interaction was included to examine whether the association between context and the response differed between age groups.”

### Overstating causality

> “Context caused an increase in the response.”

For an observational design, wording such as the following is generally more appropriate:

> “Context was associated with a higher probability of the response.”

### Misinterpreting separate significance tests

> “The association was significant in the younger group but not in the older group; therefore, the groups differed significantly.”

A significant result in one subgroup and a non-significant result in another does **not** itself establish a significant difference between the groups. The interaction or an appropriate contrast should directly test that difference.

---

# 20. A reusable reporting template

For many mixed-effects analyses, the following structure can be adapted:

> **A [model type] was fitted to examine the association between [predictors] and [outcome]. [Predictors] were included as fixed effects. [Interaction], where applicable, was included to examine whether the association between [X] and [outcome] differed according to [Z]. [Random intercept(s)] were included to account for [repeated observations/clustering]. [Random slope(s)] were included to allow the association between [predictor] and [outcome] to vary across [grouping units].**

For a GLMM, add the distribution and link:

> **A generalised linear mixed-effects model with a [binomial/Poisson/etc.] distribution and [logit/log/etc.] link was fitted...**

This version works better as reusable teaching material because it reads independently of any particular tutoring appointment or student.

If what they've written conveys those ideas accurately, their **description of the model is in good shape**. You can then move on to checking whether the actual model is appropriate, whether it fitted successfully, and whether the Results interpretation matches the output.
