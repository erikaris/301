# Mediation, Moderation, & Factor Analysis
---

## Overview

This guide uses a single running example — a workplace wellbeing study — throughout all three topics.

**Topics covered:**
1. Mediation vs moderation — what question each one is asking, and how they differ
2. Moderation analysis — how to run it, read the SPSS output, and answer your assignment questions
3. Factor analysis — how to understand each section of the SPSS output

---

## The Dummy Dataset: Workplace Wellbeing Study

**Scenario:** A researcher surveys 150 employees. The research question is: *does high workload lead to burnout, and does social support change that relationship?*

**Variables:**

| Variable | Role | Scale |
|---|---|---|
| Workload | X — the predictor | 1–10 (1 = very low, 10 = very high) |
| Social Support | W — the moderator | 1–10 (1 = no support, 10 = very high support) |
| Burnout | Y — the outcome | 1–10 (1 = not burned out, 10 = completely burned out) |
| Coping Ability | M — used only in the mediation example | 1–10 (1 = very poor, 10 = very good) |

**Ten sample rows (full dataset n = 150):**

| Participant | Workload (X) | Social Support (W) | Coping (M) | Burnout (Y) |
|---|---|---|---|---|
| 1 | 8 | 2 | 3 | 8 |
| 2 | 6 | 4 | 5 | 6 |
| 3 | 9 | 1 | 2 | 9 |
| 4 | 4 | 8 | 7 | 3 |
| 5 | 7 | 3 | 4 | 7 |
| 6 | 3 | 9 | 8 | 2 |
| 7 | 8 | 5 | 3 | 7 |
| 8 | 5 | 6 | 6 | 4 |
| 9 | 9 | 2 | 2 | 9 |
| 10 | 2 | 10 | 9 | 1 |

**Pattern to notice:** High workload + low social support consistently goes with high burnout. People with high support seem protected even when workload is high. This is exactly what moderation captures.

---

## Part A: Mediation vs Moderation — What Is the Difference?

These two are very commonly confused because both involve three variables. The difference is entirely in the **question you are asking**.

A useful way to remember it:
- **Mediation** asks *why* — it is about explaining a mechanism
- **Moderation** asks *when* or *for whom* — it is about identifying conditions

---

### The comparison, step by step

Rather than a dense table, here is the comparison broken into plain questions.

---

**1. What is the core question?**

| | |
|---|---|
| **Mediation** | *Why* does X lead to Y? What is happening in between? |
| **Moderation** | *Does the effect of X on Y change depending on a third variable?* |

---

**2. What does the third variable actually do?**

| | |
|---|---|
| **Mediation** | The third variable M **carries** the effect. X first affects M, and M then affects Y. M is a stepping stone. |
| **Moderation** | The third variable W **changes the strength** of the effect. It does not sit in between X and Y — it sits alongside and turns the dial up or down. |

---

**3. Where does the third variable sit in the diagram?**

**Mediation — M sits in the middle:**

```
X ──────────────────────────────► Y
(Workload)    direct effect    (Burnout)
     │                              ▲
     └──► Coping (M) ──────────────┘
            indirect effect
```

**Moderation — W sits above, changing the arrow:**

```
         Social Support (W)
                │
                │ makes arrow stronger or weaker
                ▼
X ══════════════════════════════► Y
(Workload)                     (Burnout)
```

---

**4. What exactly are you testing?**

| | |
|---|---|
| **Mediation** | Whether the indirect path (X → M → Y) is statistically significant |
| **Moderation** | Whether the interaction term (X × W) in the regression is statistically significant |

---

**5. Research question examples using our dummy dataset**

This is where the difference becomes most concrete. Same variables, completely different questions:

| | Mediation | Moderation |
|---|---|---|
| **Research question** | Does workload lead to burnout *because* it wears down employees' ability to cope? | Does workload lead to burnout, and is this effect *worse for employees with low social support*? |
| **What you are claiming** | Coping is the *reason why* workload causes burnout — it is the pathway | Social support *changes how strongly* workload causes burnout — it is a condition |
| **Third variable** | Coping (M) — it explains the mechanism | Social Support (W) — it sets the condition |
| **If true, it means...** | Remove the workload, coping recovers, and burnout drops. The effect *travels through* coping. | Give employees more social support and the damage of workload on burnout is reduced. The relationship between X and Y itself changes. |
| **Diagram** | X → Coping → Y | W sitting above the X → Y arrow, changing its slope |

---

**6. One-line summary**

> **Mediation:** "Workload causes burnout *because* it destroys coping ability."
>
> **Moderation:** "Workload causes burnout, *but less so* when social support is high."

---

## Part B: Moderation Analysis

### What moderation is testing

We are testing whether social support (W) moderates the relationship between workload (X) and burnout (Y).

In plain English: *is the effect of workload on burnout different depending on how much social support someone has?*

We test this by adding an **interaction term** — workload multiplied by social support — to the regression model. If this term is significant, moderation is confirmed.

---

### The moderation equation

> **Ŷ = b₀ + b₁X + b₂W + b₃(X × W)**

| Term | Name | What it means |
|---|---|---|
| b₀ | Intercept (Constant) | Predicted burnout when workload = 0 and social support = 0 |
| b₁ | Slope for X | Effect of workload on burnout when social support = 0 |
| b₂ | Slope for W | Effect of social support on burnout when workload = 0 |
| b₃ | Interaction term | How much the slope of X changes for each 1-unit increase in W |

b₃ is the key number. It tells you whether moderation exists.

---

### How to run moderation in SPSS

**If you have the PROCESS macro (Hayes):**

```
Analyze → Regression → PROCESS (by Andrew Hayes)
  Y (outcome):     Burnout
  X (predictor):   Workload
  W (moderator):   Social Support
  Model number:    1
  Options: tick "Generate data for visualising interactions"
  Options: tick "Plot interactions"
  Click OK
```

**If you do not have PROCESS — manual method:**

```
Step 1: Compute the interaction term
  Transform → Compute Variable
  Target Variable: Workload_x_Support
  Numeric Expression: Workload * Social_Support
  Click OK

Step 2: Run the regression
  Analyze → Regression → Linear
  Dependent: Burnout
  Independent(s): Workload, Social_Support, Workload_x_Support
  Click OK
```

---

### Q1: How do you calculate intercept and slope values from SPSS output?

After running the analysis, SPSS produces a **Coefficients table**. Here is what ours looks like:

```
─────────────────────────────────────────────────────────────────────
Outcome variable: Burnout (Y)

Model Summary
R = .87    R² = .76    F(3, 146) = 153.40    p < .001
─────────────────────────────────────────────────────────────────────
Coefficients

                              B        SE        t        p
─────────────────────────────────────────────────────────────────────
(Constant)                 1.52      0.41      3.71    <.001
Workload (X)               0.82      0.07     11.71    <.001
Social Support (W)        −0.29      0.06     −4.83    <.001
Workload × Support        −0.09      0.01     −9.00    <.001
─────────────────────────────────────────────────────────────────────
```

**How to extract each value:**

| Value | Where to look in SPSS | Our number |
|---|---|---|
| b₀ — intercept | (Constant) row → B column | **1.52** |
| b₁ — slope for X | Workload row → B column | **0.82** |
| b₂ — slope for W | Social Support row → B column | **−0.29** |
| b₃ — interaction | Workload × Support row → B column | **−0.09** |

**The full equation:**

> Ŷ = 1.52 + 0.82(Workload) − 0.29(Support) − 0.09(Workload × Support)

---

### Interpreting the output

**Does moderation exist?**

Look at the interaction term row:
- b₃ = −0.09, p < .001
- The p-value is below .05, so **yes, moderation is confirmed**

**What does b₃ = −0.09 mean?**

For every 1-point increase in social support, the slope of workload on burnout decreases by 0.09. In other words, higher support gradually weakens how much workload drives burnout. Social support is buffering the effect.

**What does the overall model tell us?**

- R² = .76 — the model explains 76% of the variance in burnout
- The model is significant: F(3, 146) = 153.40, p < .001

---

### Q2: How do you sketch a simple slopes graph?

A simple slopes graph shows the X → Y relationship at three levels of W (low, mean, high). Each level becomes one line on the graph. Diverging lines confirm the interaction visually.

---

**Step 1: Get the mean and SD of W from SPSS**

```
Analyze → Descriptive Statistics → Descriptives
  Move Social Support into the Variables box
  Click OK
```

From the output:
> Mean of W (Social Support) = 5.0,  SD = 2.0

---

**Step 2: Define the three levels of W**

| Level | Calculation | Value |
|---|---|---|
| Low W | Mean − 1 SD | 5.0 − 2.0 = **3.0** |
| Mean W | Mean | **5.0** |
| High W | Mean + 1 SD | 5.0 + 2.0 = **7.0** |

---

**Step 3: Substitute each W value into the equation and simplify**

Take the full equation: Ŷ = 1.52 + 0.82X − 0.29W − 0.09(X × W)

Plug in each W value and collect terms in X:

**Low support (W = 3.0):**
```
Ŷ = 1.52 + 0.82X − 0.29(3) − 0.09X(3)
  = 1.52 − 0.87 + (0.82 − 0.27)X
  = 0.65 + 0.55X
```

**Mean support (W = 5.0):**
```
Ŷ = 1.52 + 0.82X − 0.29(5) − 0.09X(5)
  = 1.52 − 1.45 + (0.82 − 0.45)X
  = 0.07 + 0.37X
```

**High support (W = 7.0):**
```
Ŷ = 1.52 + 0.82X − 0.29(7) − 0.09X(7)
  = 1.52 − 2.03 + (0.82 − 0.63)X
  = −0.51 + 0.19X
```

Each simplified equation is now one line on the graph.

---

**Step 4: Calculate plotting points**

Pick two X values — one low, one high. Use X = 2 and X = 8.

| W Level | X = 2 (low workload) | X = 8 (high workload) | Slope |
|---|---|---|---|
| Low Support (W = 3) | 0.65 + 0.55(2) = **1.75** | 0.65 + 0.55(8) = **5.05** | 0.55 |
| Mean Support (W = 5) | 0.07 + 0.37(2) = **0.81** | 0.07 + 0.37(8) = **3.03** | 0.37 |
| High Support (W = 7) | −0.51 + 0.19(2) = **−0.13** | −0.51 + 0.19(8) = **1.01** | 0.19 |

---

**Step 5: Plot the graph**

- X-axis: Workload (your predictor)
- Y-axis: Burnout (your outcome)
- Draw one line per row in the table above, using your two points
- Label each line by support level

```
Burnout
   6 |
     |                                        ● Low Support (W=3)
   5 |                                    ●
     |
   4 |
     |
   3 |                                ●        ● Mean Support (W=5)
     |
   2 |             ●
     |
   1 |  ●                                      ● High Support (W=7)
     |      ●
   0 |
     +----+----+----+----+----+----+----+----→
          2                             8
                      Workload (X)

     ● = Low Support    ● = Mean Support    ● = High Support
```

---

**Step 6: Interpret the graph**

- All three lines slope upward — workload increases burnout at every level of support
- But the slopes differ: **steeper = stronger effect**
  - Low support: slope = 0.55 (workload has the biggest effect on burnout)
  - Mean support: slope = 0.37
  - High support: slope = 0.19 (workload has the smallest effect on burnout)
- The lines diverge — they fan out — which is the visual signature of an interaction effect

> **Conclusion:** Social support moderates the relationship between workload and burnout. When support is high, burnout stays relatively low even at high workloads. When support is low, burnout rises sharply as workload increases. This matches what b₃ = −0.09 told us numerically.

---

### Shortcut: PROCESS output

If you ticked "Generate data for visualising interactions" in PROCESS, the output will include a ready-made table:

```
Data for visualising the conditional effect of X on Y

W (Social Support)   X (Workload)   Ŷ (Burnout)
       3.00               2            1.75
       3.00               8            5.05
       5.00               2            0.81
       5.00               8            3.03
       7.00               2           −0.13
       7.00               8            1.01
```

These are exactly the numbers from Step 4 above — PROCESS calculated them automatically. You can paste this table straight into Excel and plot without any manual calculation.

---

## Part C: Factor Analysis Output

### What is factor analysis?

Factor analysis looks at a set of measured variables (e.g., survey items) and asks: do some of these cluster together, suggesting they are all measuring the same underlying construct (a **factor**)?

**Our example:** The workplace wellbeing survey included 8 attitude items. We want to know whether they group into meaningful factors.

**The 8 items:**

| Item | Question |
|---|---|
| Item 1 | "I feel enthusiastic about my work" |
| Item 2 | "I am absorbed in what I do at work" |
| Item 3 | "Time flies when I am working" |
| Item 4 | "I feel energised by my job" |
| Item 5 | "I can decide how to do my work" |
| Item 6 | "I have freedom to organise my tasks" |
| Item 7 | "I am in control of my workload" |
| Item 8 | "I can make my own decisions at work" |

---

### How to run factor analysis in SPSS

```
Analyze → Dimension Reduction → Factor

Move all 8 items into the Variables box

Extraction tab:
  Method: Principal Components
  Extract based on: Eigenvalues over 1
  Tick: Scree plot

Rotation tab:
  Method: Varimax
  Tick: Rotated solution

Options tab:
  Tick: Suppress small coefficients
  Absolute value below: 0.30

Click OK
```

---

### Q3: How do you understand the key components of the SPSS output?

---

#### Section 1: KMO and Bartlett's Test — *Is factor analysis appropriate?*

```
─────────────────────────────────────────────────────────
KMO and Bartlett's Test

Kaiser-Meyer-Olkin Measure of Sampling Adequacy    .847

Bartlett's Test of Sphericity
  Approx. Chi-Square                              634.21
  df                                                  28
  Sig.                                             <.001
─────────────────────────────────────────────────────────
```

| Statistic | Our value | What to look for | Verdict |
|---|---|---|---|
| KMO | .847 | > .60 (ideally > .80) | ✓ Excellent |
| Bartlett's Sig. | < .001 | Must be < .05 | ✓ Pass |

Think of this as a green light before you trust anything else in the output. Both must pass for factor analysis to be appropriate.

---

#### Section 2: Communalities — *How well is each item captured?*

```
─────────────────────────────────────────────────────
Communalities

                          Initial    Extraction
Item 1 (enthusiastic)     1.000        .812
Item 2 (absorbed)         1.000        .791
Item 3 (time flies)       1.000        .763
Item 4 (energised)        1.000        .834
Item 5 (decide how)       1.000        .808
Item 6 (free to org.)     1.000        .779
Item 7 (in control)       1.000        .821
Item 8 (own decisions)    1.000        .796
─────────────────────────────────────────────────────
```

The **Extraction** column is what matters. It shows how much of each item's variance is explained by the extracted factors.

- All values here range from .76 to .83 — all well above .30
- If a value were below .30, that item is poorly represented and may need to be dropped

> ✓ All items are well captured by the solution.

---

#### Section 3: Total Variance Explained — *How many factors to keep?*

```
─────────────────────────────────────────────────────────────────────
Total Variance Explained

Component   Eigenvalue   % of Variance   Cumulative %
    1          4.21          52.6            52.6
    2          1.98          24.8            77.4
    3          0.43           5.4            82.8
    4          0.31           3.9            86.7
    5          0.27           3.4            90.1
   ...
─────────────────────────────────────────────────────────────────────
```

**How to read this:**

| Component | Eigenvalue | Retain? | Reason |
|---|---|---|---|
| 1 | 4.21 | ✓ Yes | Above 1 |
| 2 | 1.98 | ✓ Yes | Above 1 |
| 3 | 0.43 | ✗ No | Below 1 |

Two factors retained. Together they explain **77.4% of total variance** — very good.

> The rule of thumb (eigenvalue > 1) is called the **Kaiser criterion**. Use it together with the scree plot — if they agree, you can be confident.

---

#### Section 4: Scree Plot — *Visual check on how many factors to keep*

```
Eigenvalue
  4.5 |
      | *
  4.0 |
      |
  3.0 |
      |
  2.0 |   *
      |      \
  1.0 |        * ─ ─ ─ ─ ─ ─ ─ (levels off here)
      |
  0.0 +─────────────────────────────────→ Component
          1    2    3    4    5    6
```

Look for the **elbow** — the point where the line sharply changes direction and flattens out. Everything above the elbow is retained.

Here the elbow is between components 2 and 3. Retain 2 factors.

> ✓ Scree plot agrees with the Kaiser criterion. Retain 2 factors.

---

#### Section 5: Rotated Component Matrix — *The most important table*

```
─────────────────────────────────────────────────────────
Rotated Component Matrix

                          Component 1   Component 2
Item 1 (enthusiastic)        .887
Item 2 (absorbed)            .874
Item 3 (time flies)          .856
Item 4 (energised)           .902
Item 5 (decide how)                         .884
Item 6 (free to org.)                       .867
Item 7 (in control)                         .893
Item 8 (own decisions)                      .878

(Loadings below .30 suppressed)
─────────────────────────────────────────────────────────
```

**How to read this:**

- Each number is a **factor loading** — the correlation between that item and that factor
- Loadings of |.40| or above are typically considered meaningful
- Items 1–4 load strongly on Component 1 only
- Items 5–8 load strongly on Component 2 only
- This is a very clean pattern — each item belongs clearly to one factor

**To name the factors**, look at what the high-loading items have in common:
- Component 1 — enthusiasm, absorption, energy, time flying → **Work Engagement**
- Component 2 — freedom to decide, organise, control → **Job Autonomy**

> ✓ Two clean factors: Work Engagement (items 1–4) and Job Autonomy (items 5–8).

---

#### What to report from factor analysis

| What | Example write-up |
|---|---|
| KMO | KMO = .847, indicating excellent sampling adequacy |
| Bartlett's test | χ²(28) = 634.21, p < .001, confirming sufficient intercorrelations |
| Number of factors | Two factors retained based on eigenvalues > 1, confirmed by scree plot |
| Variance explained | The two-factor solution explained 77.4% of total variance |
| Factor 1 | Work Engagement — items 1–4, loadings .856–.902 |
| Factor 2 | Job Autonomy — items 5–8, loadings .867–.893 |

---

*Prepared by [Erika Siregar (@erikaris)](https://github.com/erikaris) for MASH tutoring session | University of Sheffield*
