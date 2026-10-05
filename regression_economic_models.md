# Regression and Piecewise Economic Models: An Accessible Guide

Regression equations and theoretical economic models can look intimidating when they contain many symbols. A useful strategy is to translate each equation into an ordinary-language question first.

This guide reviews **linear and multiple regression, log outcomes, interaction terms, and piecewise economic models**, using wages, working hours, and occupational differences as examples.

---

## 1. Regression: the basic idea

A simple linear regression can be written as:

\[
Y_i=\beta_0+\beta_1X_i+\epsilon_i
\]

The purpose is to examine how an outcome \(Y\) is related to an explanatory variable \(X\).

For example:

\[
Wage_i=\beta_0+\beta_1 Education_i+\epsilon_i
\]

where:

- \(Wage\) is the **dependent/outcome variable**
- \(Education\) is the **independent/explanatory variable**
- \(\beta_0\) is the **intercept**
- \(\beta_1\) is the **regression coefficient (slope)**
- \(\epsilon\) represents other influences on wages not captured by the model

Suppose the estimated equation is:

\[
\widehat{Wage}=8+1.5Education
\]

The coefficient 1.5 means that **one additional unit (e.g. year) of education is associated with an average increase of £1.50 in predicted hourly wage**.

The word *associated* is important. A regression coefficient does not automatically establish that education *causes* the wage difference.

---

## 2. Multiple regression

Most economic outcomes depend on more than one factor. A model could therefore be:

\[
Wage_i=
\beta_0+
\beta_1Education_i+
\beta_2Experience_i+
\beta_3Female_i+
\epsilon_i
\]

The key principle is:

> **Interpret each coefficient while holding the other variables in the model constant.**

For example, suppose:

\[
\beta_3=-2
\]

and `Female = 1` represents women while `Female = 0` represents men.

A suitable interpretation is:

> Holding education and experience constant, women are predicted to earn £2 less per hour on average than men.

This distinction is particularly useful in labour economics because a **raw pay gap** and a gap estimated after accounting for characteristics such as education and experience are not necessarily the same thing. The lecture material, for example, distinguishes the gender pay gap from equal pay and discusses education and experience as possible contributors to wage differences. Lecture 1_Differential Labour M…

---

## 3. Why economists often use log wages

Rather than modelling wages directly, economists frequently model their logarithm:

\[
\ln(Wage_i)
=
\beta_0+\beta_1X_i+\epsilon_i
\]

One advantage is that coefficients can often be interpreted in terms of **percentage differences or changes**.

For example:

\[
\ln(Wage_i)
=
\beta_0+\beta_1Female_i+\epsilon_i
\]

If:

\[
\beta_1=-0.10
\]

a useful approximation is that the group coded `Female = 1` has wages around **10% lower** than the reference group.

The labour-economics material similarly presents the difference between mean log male and female pay as an approximation to the gender pay gap. Lecture 1_Differential Labour M…

For small coefficients, the quick rule is:

\[
\text{Approximate percentage difference}\approx100\beta
\]

For larger coefficients, particularly for dummy variables, a more accurate transformation is:

\[
100(e^\beta-1)
\]

---

## 4. Interaction terms

An interaction asks:

> **Does the relationship between one variable and the outcome depend on another variable?**

Consider:

\[
Y=
\beta_0+
\beta_1X+
\beta_2Z+
\beta_3(XZ)+
\epsilon
\]

Here, \(\beta_3\) captures the interaction.

For example:

\[
\ln(Earnings)
=
\beta_0+
\beta_1\ln(Hours)+
\beta_2Female+
\beta_3[\ln(Hours)\times Female]
+\epsilon
\]

The coefficients have different roles:

- \(\beta_1\): relationship between hours and earnings for the reference group
- \(\beta_2\): difference between groups when \(\ln(Hours)=0\)
- \(\beta_3\): **difference in the hours–earnings relationship between the two groups**

Therefore, an interaction coefficient should not simply be described as “the effect of gender”. It tells us whether the **slope itself differs between groups**.

Interactions also appear in the labour-economics lecture, including interactions involving occupation, gender and log hours. Lecture 1_Differential Labour M…

---

# 5. Not every equation is a regression

A common source of confusion is assuming that every equation containing variables and parameters represents a statistical model.

Consider this model from labour economics:

\[
Q=
\begin{cases}
\lambda_i k_j, & \lambda_i>\lambda_j^*\\[4pt]
\lambda_i k_j(1-\delta_j), & \lambda_i\leq\lambda_j^*
\end{cases}
\]

This is **not a regression equation**. It is a theoretical model describing a reward/output schedule. Lecture 1_Differential Labour M…

An easy way to read it is:

> **This is an “if/else” statement written mathematically.**

There are simply two possible rules.

---

# 6. Reading the piecewise model

The symbols represent:

\[
Q = \text{output/reward}
\]

\[
0<\lambda\leq1
\]

where \(\lambda\) represents a fraction of full-time employment or another measure relating to when hours are worked.

\(k_j\) represents output per unit in occupation \(j\).

\(\lambda_j^*\) represents a **threshold** for occupation \(j\).

\(\delta_j\) represents the **reduction or penalty** that occurs below the threshold. Lecture 1_Differential Labour M…

The equation can therefore be translated as:

### Above the threshold

If

\[
\lambda_i>\lambda_j^*
\]

then:

\[
Q=\lambda_i k_j
\]

There is no penalty.

### At or below the threshold

If

\[
\lambda_i\leq\lambda_j^*
\]

then:

\[
Q=\lambda_i k_j(1-\delta_j)
\]

The additional \(1-\delta_j\) term reduces output/reward.

---

# 7. A numerical example

Suppose:

\[
k=100,\qquad
\delta=0.30,\qquad
\lambda^*=0.80
\]

### Person A: \(\lambda=0.90\)

Because:

\[
0.90>0.80
\]

the first rule applies:

\[
Q=0.90(100)=90
\]

### Person B: \(\lambda=0.70\)

Because:

\[
0.70\leq0.80
\]

the second rule applies:

\[
Q=0.70(100)(1-0.30)
\]

\[
Q=49
\]

This illustrates an important feature.

Without the penalty, Person B's output would have been:

\[
0.70(100)=70
\]

Instead, it is **49**.

The change in output is therefore not simply proportional to the change in working time. Crossing the threshold introduces an additional penalty.

---

# 8. Why is the reward schedule discontinuous?

Imagine gradually decreasing \(\lambda\).

As long as:

\[
\lambda>\lambda^*
\]

the model follows:

\[
Q=\lambda k
\]

But the moment \(\lambda\) crosses the threshold, the model switches to:

\[
Q=\lambda k(1-\delta)
\]

So output does not necessarily move smoothly from one side of the threshold to the other.

There is a **jump**.

That is why the lecture describes it as a **discontinuous reward schedule**. Lecture 1_Differential Labour M…

---

# 9. What is the economic intuition?

The mathematics represents the idea that some occupations disproportionately reward workers who can provide particular working patterns.

The accompanying theory concerns **temporal flexibility**. The lecture describes situations in which a lack of perfect substitutes between employees can create nonlinearities and connects this to convex relationships between hours and pay. Lecture 1_Differential Labour M…

In simpler terms:

> Working 20% fewer hours does not necessarily mean earning or producing exactly 20% less.

Some jobs may place additional value on:

- continuous hours
- availability at particular times
- long hours
- predictability
- being available when clients need a particular worker

Workers unable to provide those working patterns may therefore experience a disproportionately large reduction in rewards.

---

# 10. Comparing occupations

The model assumes:

\[
k_1>k_2>k_r
\]

Thus, occupation 1 initially provides the greatest output per unit, followed by occupation 2 and then occupation \(r\).

However, the penalties differ:

\[
\delta_1>\delta_2
\]

and the assumptions imply:

\[
k_1(1-\delta_1)
<
k_2(1-\delta_2)
\]

and:

\[
k_2(1-\delta_2)<k_r
\]

These relationships are specified in the theoretical model. Lecture 1_Differential Labour M…

This creates an interesting result.

**Occupation 1** can be the most rewarding when its working-time requirements are satisfied, while also having the **largest penalty** when those requirements cannot be satisfied.

Consequently, a lower-paying occupation may become preferable when flexibility is required.

---

# 11. A real-world interpretation: lawyers and pharmacists

The lecture uses lawyers and pharmacists to illustrate different pay structures.

For lawyers, being on call, meeting clients and generating new business can reduce the substitutability of workers. For pharmacists, standardised procedures, computer systems and linked records can increase substitutability. Lecture 1_Differential Labour M…

The distinction can be understood as:

**Lawyer:**  
A client may need a particular lawyer who knows their case. Another lawyer cannot necessarily substitute perfectly at short notice. Particular hours and availability can therefore be disproportionately valuable.

**Pharmacist:**  
Standardised systems and records may make it easier for one qualified worker to substitute for another. The exact identity and continuity of the worker may therefore matter less.

The theoretical model provides a mathematical way of representing this difference.

---

# 12. Regression versus a theoretical economic model

These should be kept conceptually separate.

| Regression model | Theoretical piecewise model |
|---|---|
| Statistical/empirical | Theoretical |
| Uses observed data | Describes an economic mechanism |
| Estimates coefficients | Parameters describe assumed relationships |
| Example: relationship between hours and earnings | Example: reward changes after crossing a working-time threshold |
| Usually contains an error term \(\epsilon\) | Does not necessarily contain a statistical error term |

The two can nevertheless complement each other.

**Economic theory** proposes a mechanism:

> Certain occupations penalise flexible working arrangements disproportionately.

**Empirical analysis** can then investigate whether patterns consistent with that mechanism appear in observed earnings data.

---

# 13. Running regression in R

A multiple regression can be estimated using:

```r
model <- lm(
  wage ~ education + experience + female,
  data = df
)

summary(model)
```

For log wages:

```r
model <- lm(
  log(wage) ~ education + experience + female,
  data = df
)

summary(model)
```

For an interaction:

```r
model <- lm(
  log(earnings) ~ log(hours) * female,
  data = df
)

summary(model)
```

In R,

```text
log(hours) * female
```

automatically includes the two main effects and their interaction:

```text
log(hours)
female
log(hours):female
```

---

# 14. Running regression in SPSS

For a standard linear regression:

**Analyze → Regression → Linear**

Then specify:

- **Dependent:** outcome variable, e.g. wage
- **Independent(s):** predictors, e.g. education, experience and gender

Important parts of the output include:

**B:** estimated regression coefficient  
**Std. Error:** uncertainty around that estimate  
**t and Sig.:** hypothesis test for the coefficient  
**95% CI:** range of plausible parameter values under the model  
**R²:** proportion of observed variation in the outcome accounted for by the predictors

Software produces the calculations, but interpreting the coefficients in the context of the research question remains the important part.

---

# Quick reference

| Question | Key idea |
|---|---|
| **What does regression do?** | Models the relationship between an outcome and one or more explanatory variables. |
| **What does \(\beta_1\) mean?** | Expected difference/change in Y associated with a one-unit increase in X, holding other predictors constant where applicable. |
| **What does a negative coefficient mean?** | Higher X is associated with lower predicted Y. |
| **Why use log(wage)?** | Among other reasons, it often makes economic coefficients convenient to interpret approximately as percentage changes/differences. |
| **What is an interaction?** | It asks whether the relationship between one variable and the outcome depends on another variable. |
| **Is a piecewise economic equation necessarily a regression?** | No. It may instead describe a theoretical mechanism. |
| **What is \(\lambda\) in this example?** | Fraction of full-time work or a metric concerning working hours. |
| **What is \(k\)?** | Output per unit for an occupation. |
| **What is \(\delta\)?** | Reduction/penalty when the threshold condition is not satisfied. |
| **What is \(\lambda^*\)?** | The threshold determining which part of the model applies. |
| **Why is the equation piecewise?** | Different mathematical rules apply under different conditions. |
| **Why is the schedule discontinuous?** | Crossing the threshold can suddenly activate a penalty rather than changing output smoothly. |
| **What is the main economic intuition?** | In some occupations, reduced or flexible hours may carry a disproportionately large reward/pay penalty. |
