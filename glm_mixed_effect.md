# Linear, Generalised Linear, and Mixed-Effects Models

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


# Writing Statistical Analysis for a Paper

## 1. The central rule

The Methods/Data Analysis paragraph should allow a knowledgeable reader to understand:

> **What was analysed, why that model was appropriate, what predictors were included, how dependency/repeated observations were handled, and how inference was conducted.**

The wording should match the actual model.

For example, if the R model is:

```r id="81yq5z"
model <- glmer(
  response ~ age_group * context +
    (1 | participant),
  family = binomial,
  data = dat
)
```

the manuscript should not simply say:

> “A regression analysis was performed.”

That's too vague.

A much better description is:

> “A generalised linear mixed-effects model (GLMM) with a binomial distribution and logit link was fitted to examine the association of age group and context with the probability of the response. Age group, context, and their interaction were included as fixed effects. A random intercept for participant was included to account for repeated observations within participants.”

That description maps directly onto the R model:

```text id="5i4krb"
generalised linear mixed-effects model
             ↓
           glmer()

binomial distribution + logit
             ↓
      family = binomial

age group + context + interaction
             ↓
      age_group * context

random intercept for participant
             ↓
       (1 | participant)
```

This is exactly the correspondence you should check.

---

# 2. Likely ideal wording for the current type of analysis

Based on the previous discussion, suppose the actual model is something like:

```r id="46hyff"
glmer(
  response ~ predictor1 * predictor2 +
    (1 | participant),
  family = binomial,
  data = dat
)
```

A strong Methods description would be:

> “A generalised linear mixed-effects model (GLMM) with a binomial distribution and logit link was fitted using the `glmer()` function in the `lme4` package in R. Predictor 1, Predictor 2, and their interaction were included as fixed effects. The interaction was included to examine whether the association between Predictor 1 and the response varied according to Predictor 2. A random intercept for participant was included to account for repeated observations within participants.”

If the interaction was specifically added following reviewer feedback, I would **not necessarily write that in the statistical Methods section**. The manuscript should explain the scientific/statistical rationale rather than:

> “An interaction was added because the reviewer requested it.”

The response-to-reviewers document can explain that it was added in response to the reviewer.

---

# 3. If there is no interaction

R:

```r id="kwnzmq"
glmer(
  response ~ age_group + context +
    (1 | participant),
  family = binomial,
  data = dat
)
```

Suitable wording:

> “A generalised linear mixed-effects model (GLMM) with a binomial distribution and logit link was fitted to examine the associations of age group and context with the probability of the response. Age group and context were included as fixed effects, and a random intercept for participant was included to account for repeated observations within participants.”

Notice that we don't claim:

> “to examine the effect of age group on…”

unless the research design supports a causal interpretation.

For observational research, **“association”** is often safer than **“effect”**.

---

# 4. If there is an interaction

R:

```r id="mwnqfj"
response ~ age_group * context +
  (1 | participant)
```

Suitable wording:

> “Age group, context, and their interaction were included as fixed effects. The interaction was included to examine whether the association between context and the response differed between age groups.”

This is much better than:

> “The interaction between age and context was added to the model.”

because the improved version explains **what the interaction actually tests**.

---

# 5. If there is a random slope

Suppose:

```r id="e6evse"
response ~ age_group * context +
  (1 + context | participant)
```

Suitable wording:

> “The model included random intercepts for participants and random slopes for context by participant, allowing participants to vary both in their baseline probability of the response and in the association between context and the response.”

That's a particularly useful sentence to remember.

It translates:

```r id="v51kxr"
(1 + context | participant)
```

into plain language.

---

# 6. If there are multiple random slopes

Suppose:

```r id="tpgm6b"
response ~ age_group * context +
  (1 + context + task_type | participant)
```

Suitable wording:

> “Random intercepts for participants and random slopes for context and task type by participant were included, allowing participants to vary in their baseline responses as well as in their responses to context and task type.”

Again:

```text id="2ojjuz"
1
→ different participant baselines

context
→ context effect can vary between participants

task_type
→ task-type effect can vary between participants
```

---

# 7. If participants AND items are random effects

This is especially relevant to language/psychology-type research.

Suppose:

```r id="fm3tmx"
response ~ age_group * context +
  (1 | participant) +
  (1 | item)
```

Suitable wording:

> “Random intercepts were included for participants and items to account for repeated observations within participants and variation across items.”

Or slightly more explicit:

> “The model included random intercepts for participants and items, allowing baseline response probabilities to vary across both participants and stimulus items.”

If appropriate to the actual design, both ideas can be combined:

> “Random intercepts for participants and items were included to account for the crossed structure of the data and variation in baseline response probabilities across participants and items.”

---

# 8. Linear regression wording

Suppose:

```r id="5mw90c"
lm(
  score ~ age_group + context,
  data = dat
)
```

Suitable wording:

> “A multiple linear regression model was fitted to examine the associations of age group and context with the outcome score. Age group and context were included as predictors.”

If there's one predictor:

```r id="nydhc3"
lm(score ~ age, data = dat)
```

you could say:

> “A simple linear regression model was fitted to examine the association between age and outcome score.”

For a paper, it may also be appropriate to describe relevant diagnostic checks.

---

# 9. Linear model with interaction

R:

```r id="iqmvnh"
lm(
  score ~ age_group * context,
  data = dat
)
```

Suitable wording:

> “A linear regression model was fitted with age group, context, and their interaction as predictors. The interaction term was included to examine whether the association between context and outcome score differed between age groups.”

Again:

```r id="evm0o2"
age_group * context
```

means:

```r id="gyut9f"
age_group +
context +
age_group:context
```

---

# 10. Linear mixed-effects model

Suppose the outcome is continuous and measurements are repeated:

```r id="4sxt0j"
lmer(
  score ~ age_group + context +
    (1 | participant),
  data = dat
)
```

Suitable wording:

> “A linear mixed-effects model was fitted to examine the associations of age group and context with outcome score. Age group and context were included as fixed effects, with a random intercept for participant to account for repeated observations within participants.”

This is an important distinction:

**LM:**

```r id="dbr5dd"
lm(score ~ age_group + context)
```

> “A linear regression model…”

**LMM:**

```r id="0i8trp"
lmer(score ~ age_group + context + (1 | participant))
```

> “A linear mixed-effects model…”

---

# 11. Linear mixed-effects model with interaction and random slope

R:

```r id="jgvwfn"
lmer(
  score ~ age_group * context +
    (1 + context | participant),
  data = dat
)
```

Strong manuscript wording:

> “A linear mixed-effects model was fitted with age group, context, and their interaction as fixed effects. The interaction tested whether the association between context and outcome score differed between age groups. The model included random intercepts and random slopes for context by participant, allowing participants to vary in both their baseline scores and their responses to context.”

That is a very good template.

---

# 12. Generalised linear model: binary outcome

If observations are independent:

```r id="i10tk9"
glm(
  response ~ age_group + context,
  family = binomial,
  data = dat
)
```

Suitable wording:

> “A logistic regression model was fitted to examine the associations of age group and context with the probability of the binary response.”

Or, more technically:

> “A generalised linear model with a binomial distribution and logit link was fitted to examine the associations of age group and context with the probability of the response.”

Both are correct.

“Logistic regression” is often easier for readers.

---

# 13. Generalised linear model with interaction

R:

```r id="y49zo9"
glm(
  response ~ age_group * context,
  family = binomial,
  data = dat
)
```

Suitable wording:

> “A logistic regression model was fitted with age group, context, and their interaction as predictors. The interaction was included to examine whether the association between context and the probability of the response differed between age groups.”

---

# 14. Generalised linear mixed-effects model

Now add repeated observations:

```r id="x8uhqr"
glmer(
  response ~ age_group + context +
    (1 | participant),
  family = binomial,
  data = dat
)
```

Suitable wording:

> “A generalised linear mixed-effects model with a binomial distribution and logit link was fitted to examine the associations of age group and context with the probability of the response. Age group and context were included as fixed effects, and a random intercept for participant was included to account for repeated observations within participants.”

This is probably one of the most useful templates for the appointment.

---

# 15. GLMM with interaction

R:

```r id="st8b85"
glmer(
  response ~ age_group * context +
    (1 | participant),
  family = binomial,
  data = dat
)
```

Suitable wording:

> “A generalised linear mixed-effects model with a binomial distribution and logit link was fitted. Age group, context, and their interaction were included as fixed effects. The interaction tested whether the association between context and the probability of the response differed between age groups. A random intercept for participant was included to account for repeated observations within participants.”

---

# 16. GLMM with random intercept + random slope

R:

```r id="skhw8g"
glmer(
  response ~ age_group * context +
    (1 + context | participant),
  family = binomial,
  data = dat
)
```

Suitable wording:

> “A generalised linear mixed-effects model with a binomial distribution and logit link was fitted. Age group, context, and their interaction were included as fixed effects. Random intercepts and random slopes for context by participant were included, allowing participants to vary in both their baseline probability of the response and their response to context.”

If you want to explicitly explain the interaction:

> “The age group × context interaction tested whether the association between context and response differed between age groups.”

---

# 17. Count outcome: Poisson GLM

Suppose the outcome is number of occurrences:

```r id="jq5eq5"
glm(
  count ~ age_group + context,
  family = poisson,
  data = dat
)
```

Suitable wording:

> “A Poisson regression model with a log link was fitted to examine the associations of age group and context with the expected count of the outcome.”

Don't call this ordinary linear regression.

---

# 18. Count outcome with repeated observations: Poisson GLMM

```r id="gr2azg"
glmer(
  count ~ age_group + context +
    (1 | participant),
  family = poisson,
  data = dat
)
```

Suitable wording:

> “A generalised linear mixed-effects model with a Poisson distribution and log link was fitted to model the count outcome. Age group and context were included as fixed effects, with a random intercept for participant to account for repeated observations within participants.”

For count data, you would also want to consider whether Poisson assumptions such as the mean–variance relationship are reasonable; overdispersion may require a different model.

---

# 19. Reporting the results is different from describing the methods

This distinction is important.

**Methods** answers:

> What did you do and why?

**Results** answers:

> What did the model find?

For example, Methods:

> “Age group, context, and their interaction were included as fixed effects.”

Results might say:

> “There was evidence of an age group × context interaction (β = 0.79, SE = 0.25, z = 3.16, p = .002), indicating that the association between context and the probability of the response differed between age groups.”

But ideally, don't stop there.

Explain **how** it differed.

For example:

> “Model-predicted probabilities indicated a larger difference between formal and informal contexts among younger participants than among older participants.”

That gives the interaction substantive meaning.

---

# 20. Wording for a non-significant interaction

Avoid:

> “There was no interaction.”

That's stronger than the statistical evidence supports.

Prefer:

> “There was insufficient evidence of an interaction between age group and context (β = ..., 95% CI [...], p = ...).”

Or:

> “The analysis did not provide clear evidence that the association between context and the response differed between age groups.”

This is more statistically careful.

---

# 21. Wording when there is a significant interaction

Avoid simply:

> “The interaction was significant.”

Better:

> “There was evidence of an interaction between age group and context, indicating that the association between context and the response differed between age groups.”

Then describe the pattern using predicted probabilities or appropriate contrasts.

---

# 22. Wording for `(1 | participant)`

This is worth having as a direct translation table.

| R | Good manuscript wording |
|---|---|
| `(1 \| participant)` | “A random intercept for participant was included to account for repeated observations within participants.” |
| `(1 \| item)` | “A random intercept for item was included to account for variation across items.” |
| `(1 \| participant) + (1 \| item)` | “Random intercepts were included for participants and items.” |
| `(1 + context \| participant)` | “Random intercepts and random slopes for context by participant were included.” |
| `(1 + context + task \| participant)` | “Random intercepts and random slopes for context and task by participant were included.” |

If explaining rather than merely reporting, add:

> “…allowing participants to vary in their baseline responses.”

for `(1 | participant)`.

And:

> “…allowing participants to vary in both their baseline responses and their responses to context.”

for `(1 + context | participant)`.

---

# 23. A very useful formula-to-English translation

Suppose you see:

```r id="ny7sr7"
response ~ age_group * context +
  (1 + context | participant) +
  (1 | item)
```

Don't panic.

Break it down:

```text id="9vgugp"
response
↓
Outcome


age_group + context
↓
Fixed effects


age_group:context
↓
Fixed interaction


(1 | participant)
↓
Participant random intercept


(context | participant)
↓
Participant random slope for context


(1 | item)
↓
Item random intercept
```

Then translate:

> “A mixed-effects model was fitted with age group, context, and their interaction as fixed effects. Random intercepts and random slopes for context were included by participant, allowing participants to differ in their baseline responses and in their responses to context. A random intercept for item was also included to account for variation across items.”

Then add the distribution/link depending on whether this is an LMM or GLMM.

---

# 24. What I would actually check when they show you their paragraph

You don't need to rewrite everything immediately.

Take each sentence and ask:

**1. Does the model name match the actual analysis?**

If they used:

```r id="4ehg6f"
glmer(...)
```

and binary outcome, “linear regression” would be wrong.

You want something like:

> “generalised linear mixed-effects model with binomial distribution and logit link”

or appropriate equivalent wording.

**2. Are the fixed and random effects described correctly?**

If:

```r id="fz2tq9"
(1 | participant)
```

they should not call participant a fixed effect.

If:

```r id="f9bcv1"
age * context
```

the Methods should make clear that the interaction was modelled.

**3. Does the explanation of the interaction match what an interaction actually means?**

You want something equivalent to:

> “to examine whether the association between X and the outcome differed according to Y.”

**4. Does the Results interpretation actually correspond to the coefficients/model?**

Especially check:

- reference categories;
- interaction interpretation;
- estimates;
- CIs;
- p-values;
- predicted probabilities/contrasts if used.

---

# 25. Example of a weak paragraph and how you could improve it

Suppose you are shown:

> “A mixed model was conducted using R. Age and context were analysed and participant was controlled for. An interaction was also added to see whether it was significant.”

There are several problems.

“Mixed model” is vague.

“Participant was controlled for” doesn't properly describe `(1 | participant)`.

“Interaction was added to see whether it was significant” is poor statistical justification.

A better version would be:

> “A generalised linear mixed-effects model with a binomial distribution and logit link was fitted in R using the `glmer()` function from the `lme4` package. Age group, context, and their interaction were included as fixed effects. The interaction was included to examine whether the association between context and the probability of the response differed between age groups. A random intercept for participant was included to account for repeated observations within participants.”

That is the kind of transformation I suspect may be useful in the appointment.

---

# 26. Your quickest wording cheat sheet

If you're looking over their manuscript and need to decide whether a sentence makes sense, translate their R model into these components:

```text id="r2w7fw"
MODEL FAMILY
What model?

OUTCOME/DISTRIBUTION
What is Y and why this distribution/link?

FIXED EFFECTS
What predictors are being estimated?

INTERACTION
Does the relationship between X and Y depend on Z?

RANDOM INTERCEPT
What grouping units have different baselines?

RANDOM SLOPE
Which within-unit relationships are allowed to vary?
```

For example:

```r id="vs8w0b"
glmer(
  response ~ age_group * context +
    (1 + context | participant),
  family = binomial
)
```

becomes:

> “A generalised linear mixed-effects model with a binomial distribution and logit link was fitted. Age group, context, and their interaction were included as fixed effects. The interaction tested whether the association between context and the response differed between age groups. Random intercepts and random slopes for context by participant were included to account for repeated observations and to allow both baseline responses and the association with context to vary across participants.”

If what they've written conveys those ideas accurately, their **description of the model is in good shape**. You can then move on to checking whether the actual model is appropriate, whether it fitted successfully, and whether the Results interpretation matches the output.
