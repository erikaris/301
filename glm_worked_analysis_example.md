
# Worked Example: GLMM in R

## 1. Research scenario

Suppose a language study investigates whether participants use a particular linguistic form.

The outcome is:

- `response = 1`: target linguistic form was used
- `response = 0`: target linguistic form was not used

There are two predictors:

- `age_group`: younger / older
- `context`: formal / informal

Each participant provides several responses, so observations from the same participant are **not independent**.

The research questions are:

1. Is use of the linguistic form associated with age group?
2. Is it associated with context?
3. Does the association with context differ between younger and older participants?

---

# 2. Dummy data

A small version of the dataset might look like this:

| participant | age_group | context | response |
|---|---|---|---:|
| P01 | younger | formal | 1 |
| P01 | younger | informal | 0 |
| P01 | younger | formal | 1 |
| P01 | younger | informal | 1 |
| P02 | younger | formal | 1 |
| P02 | younger | informal | 0 |
| P02 | younger | formal | 1 |
| P02 | younger | informal | 0 |
| P03 | older | formal | 1 |
| P03 | older | informal | 0 |
| P03 | older | formal | 0 |
| P03 | older | informal | 0 |
| P04 | older | formal | 1 |
| P04 | older | informal | 0 |
| P04 | older | formal | 0 |
| P04 | older | informal | 1 |

Notice the structure:

```text
P01 → multiple rows
P02 → multiple rows
P03 → multiple rows
...
```

Therefore, the observations are clustered within participants.

Also notice:

```text
Within P01:

age_group = younger, younger, younger, younger
            └────── does NOT vary ─────────┘

context   = formal, informal, formal, informal
            └───────── varies ─────────────┘
```

---

# 3. Generate a larger dummy dataset in R

A realistic model needs more than the tiny table above. The following creates 100 participants with 10 observations each:

```r
library(lme4)

set.seed(123)

dat <- data.frame(
  participant = factor(rep(1:100, each = 10)),
  age_group = factor(
    rep(c("younger", "older"), each = 500)
  ),
  context = factor(
    rep(c("formal", "informal"), 500)
  )
)

# Participant-specific baseline differences
participant_effect <- rnorm(100, mean = 0, sd = 0.7)

# Generate the underlying log-odds
dat$eta <- -0.5 +
  0.7 * (dat$age_group == "younger") +
  1.0 * (dat$context == "formal") +
  0.8 * (dat$age_group == "younger") *
        (dat$context == "formal") +
  participant_effect[dat$participant]

# Convert log-odds to probabilities
dat$probability <- plogis(dat$eta)

# Generate binary responses
dat$response <- rbinom(
  nrow(dat),
  size = 1,
  prob = dat$probability
)

head(dat)
```

The resulting dataset has:

```text
100 participants
×
10 observations each
=
1,000 observations
```

But these are **not 1,000 independent participants**.

---

# 4. Fit the GLMM

The model is:

```r
model <- glmer(
  response ~ age_group * context +
    (1 | participant),
  family = binomial,
  data = dat
)
```

Read it as:

> Model the probability of `response = 1` using age group, context, and their interaction, while allowing each participant to have their own baseline response tendency.

Breaking it down:

| R | Meaning |
|---|---|
| `response` | Binary outcome |
| `age_group` | Fixed effect |
| `context` | Fixed effect |
| `age_group * context` | Main effects + interaction |
| `(1 \| participant)` | Random intercept for participant |
| `family = binomial` | Binomial model for binary outcome |

---

# 5. Look at the output

Run:

```r
summary(model)
```

A **simplified dummy output** might look like:

```text
Generalized linear mixed model fit by maximum likelihood
Family: binomial  ( logit )

Random effects:

 Groups      Name        Variance Std.Dev.
 participant (Intercept) 0.49     0.70

Number of obs: 1000
Number of groups: participant, 100


Fixed effects:

                                 Estimate Std. Error z value Pr(>|z|)
(Intercept)                       -0.48      0.18    -2.67    0.008
age_groupyounger                   0.72      0.20     3.60   <0.001
contextformal                      1.03      0.18     5.72   <0.001
age_groupyounger:contextformal     0.79      0.25     3.16    0.002
```

Assume the reference categories are:

```text
age_group = older
context   = informal
```

---

# 6. How to read the output

### Intercept

```text
(Intercept) = -0.48
```

This represents the log-odds of the response for the reference combination:

> older participants in the informal context.

Usually, this is not the most interesting substantive result.

### Age group

```text
age_groupyounger = 0.72
p < .001
```

Because an interaction is present, this is **not simply the overall effect of age group**.

It represents the younger-versus-older difference **when `context = informal`**, the reference context.

### Context

```text
contextformal = 1.03
p < .001
```

Again, because of the interaction, this isn't simply the overall context effect.

It represents formal versus informal **for the reference age group: older participants**.

### Interaction

```text
age_groupyounger:contextformal

β = 0.79
SE = 0.25
z = 3.16
p = .002
```

This is particularly important.

It indicates that:

> **The formal-versus-informal association differs between younger and older participants.**

That is the interaction.

---

# 7. Get predicted probabilities

Because GLMM coefficients are expressed in log-odds, predicted probabilities are often easier to communicate.

For example:

```r
library(ggeffects)

pred <- ggpredict(
  model,
  terms = c("context", "age_group")
)

pred
```

Suppose the output is approximately:

```text
context    age_group    predicted    95% CI

informal   older          0.38       0.31–0.45
formal     older          0.63       0.56–0.70

informal   younger        0.56       0.49–0.63
formal     younger        0.88       0.83–0.92
```

Now the interaction becomes much easier to understand.

For older participants:

```text
informal → formal

0.38 → 0.63
```

For younger participants:

```text
informal → formal

0.56 → 0.88
```

The association between context and response differs between age groups.

---

# 8. How this could be written in the Methods section

A publication-ready description could be:

> A generalised linear mixed-effects model (GLMM) with a binomial distribution and logit link was fitted to examine the associations of age group and context with the probability of using the target linguistic form. Age group, context, and their interaction were included as fixed effects. The interaction was included to examine whether the association between context and the response differed between age groups. A random intercept for participant was included to account for repeated observations within participants.

If software details are required:

> The model was fitted in R using the `glmer()` function from the `lme4` package.

---

# 9. How the output could be written in the Results section

A concise version:

> There was evidence of an interaction between age group and context (β = 0.79, SE = 0.25, z = 3.16, p = .002), indicating that the association between context and the probability of using the target linguistic form differed between age groups.

But this doesn't tell the reader **how** it differed.

A better version would continue:

> Model-predicted probabilities indicated that younger participants had a predicted probability of 0.56 of using the target form in the informal context and 0.88 in the formal context. Among older participants, the corresponding predicted probabilities were 0.38 and 0.63, respectively.

The substantive conclusion can then be stated:

> Thus, the association between context and use of the target linguistic form was stronger among younger participants than among older participants.

The exact wording of “stronger” should ideally be supported by the model-based contrast on the appropriate scale, rather than inferred solely from visually comparing raw percentage-point differences.

---

# 10. What if the interaction were not significant?

Suppose instead the output showed:

```text
age_groupyounger:contextformal

Estimate = 0.18
SE       = 0.25
z        = 0.72
p        = 0.472
```

Avoid:

> “There was no interaction between age group and context.”

A more appropriate Results statement is:

> There was insufficient evidence of an interaction between age group and context (β = 0.18, SE = 0.25, z = 0.72, p = .472), providing no clear evidence that the association between context and the probability of the response differed between age groups.

---

# 11. Now add a random slope

Suppose context varies within every participant and there is a reason to allow participants to respond differently to context.

The model becomes:

```r
model2 <- glmer(
  response ~ age_group * context +
    (1 + context | participant),
  family = binomial,
  data = dat
)
```

The difference is:

```r
(1 | participant)
```

means:

> participants can have different **baselines**.

Whereas:

```r
(1 + context | participant)
```

means:

> participants can have different **baselines AND different context slopes**.

---

# 12. Dummy random-slope output

The random-effects section might look something like:

```text
Random effects:

 Groups      Name            Variance Std.Dev.
 participant (Intercept)      0.52     0.72
             contextformal    0.20     0.45

Number of obs: 1000
Number of groups: participant, 100
```

Conceptually, this allows something like:

```text
P01 → strong context association
P02 → small context association
P03 → moderate context association
P04 → strong context association
...
```

while still estimating the overall fixed effect of context.

---

# 13. How to write the random-slope model

### Methods

> A generalised linear mixed-effects model with a binomial distribution and logit link was fitted. Age group, context, and their interaction were included as fixed effects. Random intercepts and random slopes for context by participant were included, allowing participants to vary in both their baseline probability of using the target linguistic form and their response to context.

### Results

Suppose the fixed interaction remains:

```text
β = 0.76
SE = 0.26
z = 2.92
p = .004
```

Then:

> There was evidence of an interaction between age group and context (β = 0.76, SE = 0.26, z = 2.92, p = .004), indicating that the association between context and the probability of using the target linguistic form differed between age groups.

The random slope does **not** mean the Results should say:

> “Context was significant for some participants but not others.”

Instead, if the random-effects variation itself is worth mentioning:

> The random-effects estimates indicated between-participant variation in both baseline response probabilities and the association between context and response.

---

# 14. The complete journey

This is the key connection:

```text
RESEARCH DESIGN
│
├── Binary outcome
│       ↓
│   Binomial model
│
├── Repeated observations
│       ↓
│   Mixed-effects model
│
├── Repeated within participant
│       ↓
│   (1 | participant)
│
├── Does context differ by age group?
│       ↓
│   age_group * context
│
└── Does the context association vary between participants?
        ↓
    (1 + context | participant)
```

Leading to:

```r
glmer(
  response ~ age_group * context +
    (1 + context | participant),
  family = binomial,
  data = dat
)
```

And the Methods section translates the **model structure**:

> A binomial GLMM with a logit link was fitted. Age group, context, and their interaction were included as fixed effects. Random intercepts and random slopes for context by participant were included.

While the Results section translates the **model output**:

> There was evidence of an age group × context interaction (β = ..., SE = ..., z = ..., p = ...), indicating that the association between context and the probability of the response differed between age groups. Model-predicted probabilities showed that...

That distinction is useful when reviewing a manuscript: **the Methods should match the R code, while the Results should match the model output and its correct interpretation.**
