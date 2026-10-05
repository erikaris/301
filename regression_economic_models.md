# Regression and Piecewise Economic Models: An Accessible Guide

Regression equations and theoretical economic models can look intimidating when they contain many symbols. A useful strategy is to translate each equation into an ordinary-language question first.

This guide reviews **simple and multiple linear regression, log outcomes, interaction terms, and piecewise economic models**, using wages, working hours, and occupational differences as examples.

---

## 1. Regression: The Basic Idea

A simple linear regression can be written as:

**Yᵢ = β₀ + β₁Xᵢ + εᵢ**

The purpose is to examine how an outcome **Y** is related to an explanatory variable **X**.

For example:

**Wageᵢ = β₀ + β₁Educationᵢ + εᵢ**

where:

- **Wage** is the dependent or outcome variable
- **Education** is the independent or explanatory variable
- **β₀** is the intercept
- **β₁** is the regression coefficient (slope)
- **ε** represents other influences on wages that are not captured by the model
- **i** represents an individual observation

Suppose the estimated regression equation is:

**Predicted Wage = 8 + 1.5 × Education**

The coefficient **1.5** means that one additional unit of education (for example, one additional year) is associated with an average increase of **£1.50 in predicted hourly wage**.

The word *associated* is important. A regression coefficient does not automatically establish that education *causes* the wage difference.

---

## 2. Multiple Regression

Most economic outcomes depend on more than one factor. We can therefore extend the regression model:

**Wageᵢ = β₀ + β₁Educationᵢ + β₂Experienceᵢ + β₃Femaleᵢ + εᵢ**

The key principle when interpreting a multiple regression is:

> **Interpret each coefficient while holding the other variables in the model constant.**

For example, suppose:

**β₃ = −2**

and:

- `Female = 1` represents women
- `Female = 0` represents men

A suitable interpretation is:

> Holding education and experience constant, women are predicted to earn £2 less per hour on average than men.

This is particularly useful in labour economics because a **raw pay gap** and a pay gap after accounting for characteristics such as education and experience are not necessarily the same thing.

---

## 3. Why Economists Often Use Log Wages

Rather than modelling wages directly, economists frequently model the natural logarithm of wages:

**ln(Wageᵢ) = β₀ + β₁Xᵢ + εᵢ**

One advantage is that coefficients can often be interpreted in terms of **percentage differences or percentage changes**.

For example:

**ln(Wageᵢ) = β₀ + β₁Femaleᵢ + εᵢ**

Suppose:

**β₁ = −0.10**

A useful approximation is that the group coded `Female = 1` has wages approximately **10% lower** than the reference group.

For relatively small coefficients, the quick approximation is:

**Percentage difference ≈ 100 × β**

So:

**100 × (−0.10) = −10%**

For a dummy variable, a more accurate calculation is:

**Percentage difference = 100 × (eᵝ − 1)**

For β = −0.10:

**100 × (e⁻⁰·¹⁰ − 1) ≈ −9.5%**

So the approximate interpretation is **10% lower**, while the more exact calculation gives approximately **9.5% lower**.

---

## 4. Interaction Terms

An interaction asks:

> **Does the relationship between one variable and the outcome depend on another variable?**

A regression containing an interaction can be written as:

**Y = β₀ + β₁X + β₂Z + β₃(X × Z) + ε**

Here, **β₃** represents the interaction.

For example:

**ln(Earnings) = β₀ + β₁ln(Hours) + β₂Female + β₃[ln(Hours) × Female] + ε**

The coefficients have different roles:

- **β₁** = relationship between hours and earnings for the reference group
- **β₂** = difference between the two groups when `ln(Hours) = 0`
- **β₃** = difference in the hours–earnings relationship between the two groups

The interaction coefficient should therefore not simply be interpreted as "the effect of gender".

Instead, **β₃ tells us whether the slope relating hours to earnings differs between the groups**.

### Simple Example

Imagine that earnings increase with working hours for both men and women, but the increase is larger for men.

Without an interaction, we are effectively assuming that the relationship between hours and earnings has the same slope for both groups.

An interaction allows those slopes to differ.

In simple terms:

> **The effect of hours on earnings depends on gender.**

That is what an interaction is designed to capture.

---

## 5. Not Every Equation Is a Regression

A common source of confusion is assuming that every equation containing variables and parameters represents a regression.

Consider the following model:

**Q = λᵢkⱼ, if λᵢ > λⱼ\***

**Q = λᵢkⱼ(1 − δⱼ), if λᵢ ≤ λⱼ\***

This is **not a regression equation**.

It is a theoretical economic model describing a reward or output schedule.

An easy way to understand it is:

> **This is an "if/else" statement written mathematically.**

There are simply two possible rules.

Which rule applies depends on whether **λᵢ** is above or below a particular threshold.

---

## 6. Reading the Piecewise Model

The model is:

**Q = λᵢkⱼ, if λᵢ > λⱼ\***

**Q = λᵢkⱼ(1 − δⱼ), if λᵢ ≤ λⱼ\***

The symbols represent:

- **Q** = output or reward
- **λᵢ** = fraction of full-time employment, or another metric concerning when hours are worked
- **kⱼ** = output per unit in occupation *j*
- **λⱼ\*** = threshold for occupation *j*
- **δⱼ** = reduction in output when the worker does not meet the required working threshold
- **i** = individual worker
- **j** = occupation

The model assumes:

**0 < λ ≤ 1**

For example:

- λ = 1 could represent full-time employment
- λ = 0.8 could represent 80% of full-time
- λ = 0.5 could represent 50% of full-time

However, λ can also represent a broader measure concerning **which hours are worked**, rather than simply the total number of hours.

---

## 7. What Happens Above the Threshold?

If:

**λᵢ > λⱼ\***

then:

**Q = λᵢkⱼ**

There is no additional penalty.

Output simply depends on:

**working-time measure × output per unit**

For example, suppose:

- λ = 0.9
- k = 100

Then:

**Q = 0.9 × 100**

**Q = 90**

---

## 8. What Happens At or Below the Threshold?

If:

**λᵢ ≤ λⱼ\***

then:

**Q = λᵢkⱼ(1 − δⱼ)**

Now an additional term appears:

**(1 − δⱼ)**

This represents the penalty or reduction in output.

For example, if:

**δ = 0.30**

then:

**1 − δ = 1 − 0.30 = 0.70**

Only 70% of the otherwise expected output remains.

---

## 9. A Numerical Example

Suppose:

- **k = 100**
- **δ = 0.30**
- **λ\* = 0.80**

Now compare two workers.

### Person A: λ = 0.90

Because:

**0.90 > 0.80**

the person is above the threshold.

Therefore:

**Q = λk**

**Q = 0.90 × 100**

**Q = 90**

### Person B: λ = 0.70

Because:

**0.70 ≤ 0.80**

the person is below the threshold.

The penalty therefore applies:

**Q = λk(1 − δ)**

**Q = 0.70 × 100 × (1 − 0.30)**

**Q = 0.70 × 100 × 0.70**

**Q = 49**

Without the penalty, Person B's output would have been:

**Q = 0.70 × 100 = 70**

But because the threshold has been crossed, the output is instead:

**Q = 49**

This is the key idea behind the model.

The reduction in output is **not simply proportional to the reduction in working time**.

---

## 10. Why Is the Reward Schedule Discontinuous?

Imagine gradually reducing λ.

As long as:

**λ > λ\***

the model follows:

**Q = λk**

But once λ reaches or falls below the threshold:

**λ ≤ λ\***

the model switches to:

**Q = λk(1 − δ)**

The penalty suddenly becomes active.

This means that output does not necessarily change smoothly when the threshold is crossed.

There is a **jump**.

That is why this is described as a **discontinuous reward schedule**.

### Simple Illustration

Suppose:

- k = 100
- δ = 0.30
- λ\* = 0.80

Just above the threshold:

**λ = 0.81**

so:

**Q = 0.81 × 100 = 81**

At the threshold:

**λ = 0.80**

the penalty applies:

**Q = 0.80 × 100 × 0.70 = 56**

A very small change in λ from **0.81 to 0.80** therefore produces a much larger change in Q:

**81 → 56**

This is the discontinuity.

---

## 11. What Is the Economic Intuition?

The mathematics represents the idea that some occupations disproportionately reward workers who can provide particular working patterns.

In simple terms:

> **Working 20% fewer hours does not necessarily mean earning or producing exactly 20% less.**

Some jobs may place additional value on:

- continuous hours
- availability at particular times
- long hours
- predictable availability
- being available when clients need a particular worker
- maintaining relationships with particular clients
- being difficult to substitute with another worker

Workers who cannot provide those working patterns may therefore experience a disproportionately large reduction in rewards.

---

## 12. Comparing Different Occupations

Suppose there are three occupations:

- occupation 1
- occupation 2
- occupation r

The model assumes:

**k₁ > k₂ > kᵣ**

This means that, before considering flexibility penalties:

**Occupation 1 has the highest output per unit, followed by occupation 2, followed by occupation r.**

However, suppose:

**δ₁ > δ₂**

This means occupation 1 also has a larger penalty for failing to meet its working-time requirements.

After applying the penalties, suppose:

**k₁(1 − δ₁) < k₂(1 − δ₂)**

and:

**k₂(1 − δ₂) < kᵣ**

This creates an important result.

Occupation 1 may offer the highest reward when its working-time requirements are satisfied, but it may also impose the largest penalty when those requirements are not satisfied.

Therefore:

- when working-time requirements can be met, occupation 1 may be preferable
- when greater flexibility is required, occupation 2 may become preferable
- with still greater flexibility requirements, occupation r may become preferable

In other words:

> **The occupation with the highest potential reward is not necessarily the best option for someone who requires flexibility.**

---

## 13. High-, Medium-, and Low-Penalty Jobs

The model can therefore be understood in terms of different types of jobs.

### High-Penalty Job

A high-penalty job may offer high output or pay when its working requirements are met.

However, falling below the required threshold produces a relatively large penalty.

Conceptually:

**High potential reward + high flexibility penalty**

### Medium-Penalty Job

A medium-penalty job may offer somewhat lower potential output but impose a smaller penalty when working-time requirements are not met.

Conceptually:

**Medium potential reward + medium flexibility penalty**

### Low-Penalty Job

A low-penalty job has a more linear reward structure.

The number or timing of hours worked has less effect on output per unit.

Conceptually:

**Lower potential reward + little or no flexibility penalty**

This creates a trade-off between:

**potential reward ↔ temporal flexibility**

---

## 14. A Real-World Interpretation: Lawyers and Pharmacists

Lawyers and pharmacists provide useful examples of different working-time and reward structures.

### Lawyers

Some legal work may require:

- being on call
- meeting clients at particular times
- developing long-term client relationships
- generating new business
- responding quickly to particular cases

A client may need a particular lawyer who already knows the case.

Another lawyer cannot necessarily substitute perfectly at short notice.

This makes particular hours and continuous availability more valuable.

The reward structure can therefore become **nonlinear**.

### Pharmacists

Pharmacy work may involve greater standardisation through:

- standardised procedures
- standardised medicines
- computer systems
- shared patient information
- linked records

These systems may make it easier for one qualified pharmacist to substitute for another.

The exact identity and continuous availability of a particular worker may therefore matter less.

The reward structure can consequently be closer to **linear**.

---

## 15. Linear vs. Nonlinear Pay Structures

A useful distinction is between **linear** and **nonlinear** pay structures.

### Linear Pay Structure

In a linear structure:

> Twice as many hours produce approximately twice as much reward.

For example:

| Hours | Reward |
|---:|---:|
| 10 | £200 |
| 20 | £400 |
| 30 | £600 |
| 40 | £800 |

The reward per hour remains approximately constant.

### Nonlinear Pay Structure

In a nonlinear structure, particular working arrangements receive disproportionately high rewards.

For example:

| Hours / Availability | Reward |
|---|---:|
| Low | £200 |
| Moderate | £450 |
| High | £800 |
| Very high / fully flexible | £1,400 |

Moving from high to very high availability produces a disproportionately large increase in reward.

This is the type of mechanism represented by a nonlinear or convex pay structure.

---

## 16. Regression vs. a Theoretical Economic Model

Regression models and theoretical economic models should be kept conceptually separate.

| Regression model | Theoretical piecewise model |
|---|---|
| Statistical/empirical | Theoretical |
| Uses observed data | Describes an economic mechanism |
| Estimates coefficients from data | Parameters describe assumed relationships |
| Includes sampling uncertainty | Describes what should happen under particular assumptions |
| Example: relationship between hours and earnings | Example: reward changes after crossing a working-time threshold |
| Usually contains an error term ε | Does not necessarily contain a statistical error term |

The two approaches can nevertheless complement each other.

### Theory

Economic theory might propose:

> Certain occupations disproportionately penalise workers who cannot provide particular working arrangements.

### Empirical Analysis

Regression can then investigate whether patterns consistent with that mechanism appear in observed data.

For example, researchers might investigate whether:

- earnings increase disproportionately with hours in particular occupations
- the hours–earnings relationship differs between occupations
- gender earnings gaps are larger in occupations with particular working-time requirements

So the theoretical model provides a **possible explanation**, while empirical analysis examines patterns in **observed data**.

---

## 17. Understanding Regression Output

When interpreting a regression, several quantities are particularly important.

### Regression Coefficient

The coefficient estimates the relationship between a predictor and the outcome.

For example:

**β₁ = 1.5**

might mean:

> A one-unit increase in X is associated with an average 1.5-unit increase in Y, holding the other predictors constant.

### Standard Error

The standard error describes the uncertainty in the estimated coefficient.

Smaller standard errors generally indicate more precise estimates.

### p-value

A p-value is commonly used to assess evidence against a null hypothesis such as:

**H₀: β₁ = 0**

A small p-value indicates that the observed estimate would be relatively unlikely under the null hypothesis and the assumptions of the statistical model.

However:

> **A small p-value does not tell us whether an effect is large, important, or causal.**

### Confidence Interval

A confidence interval gives a range of parameter values compatible with the data and model at the chosen confidence level.

For example:

**β₁ = 1.5, 95% CI [0.8, 2.2]**

indicates both the estimated effect and the uncertainty around it.

### R²

R² describes the proportion of variation in the outcome accounted for by the predictors in the regression model.

For example:

**R² = 0.40**

means that the model accounts for **40% of the observed variation in Y**.

It does not mean that the model is "40% correct".

---

## 18. Running Regression in R

A multiple linear regression can be estimated in R using `lm()`.

For example:

```r
model <- lm(
  wage ~ education + experience + female,
  data = df
)

summary(model)
```

Here:

- `wage` is the outcome
- `education`, `experience`, and `female` are predictors
- `df` is the dataset

### Regression With Log Wages

```r
model <- lm(
  log(wage) ~ education + experience + female,
  data = df
)

summary(model)
```

Here the dependent variable is **ln(wage)** rather than wage itself.

### Regression With an Interaction

```r
model <- lm(
  log(earnings) ~ log(hours) * female,
  data = df
)

summary(model)
```

In R:

```r
log(hours) * female
```

automatically includes:

```text
log(hours)
female
log(hours):female
```

That means the model contains:

1. the main effect of `log(hours)`
2. the main effect of `female`
3. the interaction between them

---

## 19. Running Regression in SPSS

For a standard linear regression in SPSS:

**Analyze → Regression → Linear**

Then specify:

- **Dependent:** the outcome variable, for example `wage`
- **Independent(s):** the predictors, for example `education`, `experience`, and `gender`

Important parts of the output include:

| Output | Meaning |
|---|---|
| **B** | Estimated regression coefficient |
| **Std. Error** | Uncertainty around the coefficient |
| **t** | Test statistic |
| **Sig.** | p-value |
| **95% CI** | Confidence interval for the coefficient |
| **R²** | Proportion of observed variation in the outcome accounted for by the model |

Software performs the calculations, but the most important step is still to **interpret the results in the context of the research question**.

---

# Quick Reference

| Question | Key Idea |
|---|---|
| **What does regression do?** | Models the relationship between an outcome and one or more explanatory variables. |
| **What does β₁ mean?** | The expected difference/change in Y associated with a one-unit increase in X, holding other predictors constant where applicable. |
| **What does a negative coefficient mean?** | Higher X is associated with lower predicted Y. |
| **Does regression prove causation?** | Not automatically. Causal interpretation requires additional assumptions and an appropriate research design. |
| **Why use ln(wage)?** | Among other reasons, coefficients can often be interpreted conveniently in terms of percentage changes or differences. |
| **What is an interaction?** | It asks whether the relationship between one variable and the outcome depends on another variable. |
| **Is every mathematical model a regression?** | No. An equation may instead represent a theoretical relationship. |
| **What is λ in the piecewise model?** | Fraction of full-time employment or another metric concerning when hours are worked. |
| **What is k?** | Output per unit in an occupation. |
| **What is δ?** | Reduction or penalty when the working-time threshold is not satisfied. |
| **What is λ\*?** | The threshold determining which part of the model applies. |
| **Why is the equation piecewise?** | Different mathematical rules apply under different conditions. |
| **Why is the reward schedule discontinuous?** | Crossing the threshold suddenly activates a penalty, producing a jump in output. |
| **What is a linear pay structure?** | Reward changes approximately proportionally with hours or working time. |
| **What is a nonlinear pay structure?** | Particular hours or working arrangements receive disproportionately high or low rewards. |
| **What is the main economic intuition?** | In some occupations, reduced or flexible working arrangements may carry a disproportionately large reward or pay penalty. |
| **How do theory and regression differ?** | Theory proposes a mechanism; regression can be used to investigate relationships in observed data. |
