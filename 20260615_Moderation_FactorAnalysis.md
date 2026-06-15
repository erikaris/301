# Multiple Regression with Moderation & Factor Analysis
**MASH Statistics Tutoring | MSc Business & Organisational Psychology | June 2026**

---

## Overview

This guide uses a single running example throughout — a workplace wellbeing study — so you can see how the same dataset is used for different analyses.

**Topics covered:**
1. Mediation analysis — what it is, how to run it, how to interpret the output
2. Moderation analysis — extracting intercept and slope values from SPSS output
3. Sketching a simple slopes graph from moderation output
4. Factor analysis — understanding each section of the SPSS output

---

## The Dummy Dataset: Workplace Wellbeing Study

**Scenario:** A researcher surveys 150 employees about their work experience. The research question is: *does high workload lead to burnout, and how?*

**Variables:**

| Variable | Label | Scale |
|---|---|---|
| Workload | X — the predictor | 1–10 (1 = very low, 10 = very high) |
| Burnout | Y — the outcome | 1–10 (1 = not at all, 10 = completely burned out) |
| Coping ability | M — potential mediator | 1–10 (1 = very poor, 10 = very good) |
| Social support | W — potential moderator | 1–10 (1 = no support, 10 = very high support) |

**Ten sample rows (full dataset n = 150):**

| Participant | Workload (X) | Coping (M) | Social Support (W) | Burnout (Y) |
|---|---|---|---|---|
| 1 | 8 | 3 | 2 | 8 |
| 2 | 6 | 5 | 4 | 6 |
| 3 | 9 | 2 | 1 | 9 |
| 4 | 4 | 7 | 8 | 3 |
| 5 | 7 | 4 | 3 | 7 |
| 6 | 3 | 8 | 9 | 2 |
| 7 | 8 | 3 | 5 | 7 |
| 8 | 5 | 6 | 6 | 4 |
| 9 | 9 | 2 | 2 | 9 |
| 10 | 2 | 9 | 10 | 1 |

**Pattern to notice:** High workload + low coping + low social support tends to go with high burnout. This is deliberate — it makes the mediation and moderation effects clear.

---

## Part A: Mediation Analysis

### What is mediation?

Mediation asks: *why* does X affect Y? It proposes that X affects Y **indirectly**, by first influencing a middle variable M (the mediator), which then influences Y.

**Our example:**
> Workload (X) → Coping ability (M) → Burnout (Y)

The argument is: high workload reduces your ability to cope, and poor coping leads to burnout. Coping is the *mechanism* that explains *why* workload causes burnout.

```
X ──────────────────────────────► Y
(Workload)    direct effect    (Burnout)
     │                              ▲
     │                              │
     ▼          indirect            │
   Coping ────────────────────────►
   (M)         (via coping)
```

- **Direct effect:** the effect of X on Y that does not go through M (path c')
- **Indirect effect:** X → M → Y (path a × b) — this is the mediation
- **Total effect:** direct + indirect (path c)

---

### How to run mediation in SPSS (PROCESS Macro)

PROCESS is an add-on for SPSS written by Andrew Hayes. If it is installed, you will find it under:

```
Analyze → Regression → PROCESS (by Andrew Hayes)
```

**Settings:**
- Y (outcome): Burnout
- X (predictor): Workload
- M (mediator): Coping
- Model number: **Model 4** (simple mediation)
- Tick: **Bootstrap samples = 5000**
- Tick: **Show total effect model**
- Click OK

> If PROCESS is not available, you can run mediation manually using three separate regression steps (the Baron & Kenny approach — see the note at the end of this section).

---

### Reading the PROCESS output

PROCESS produces output in several blocks. Here is what each one means, using our example.

---

#### Block 1: Total Effect of X on Y (path c)

```
Model Summary
R = .71   R² = .50   F(1, 148) = 149.30   p < .001

Coefficients
                B        SE       t        p
(Constant)    1.08     0.38    2.84    .005
Workload      0.74     0.06   12.30   <.001
```

**How to read this:**

- Workload significantly predicts burnout (p < .001) before we account for coping
- For every 1-point increase in workload, burnout increases by **0.74 points** on average
- This is the **total effect** (c path) — it includes both direct and indirect effects combined

---

#### Block 2: Effect of X on M (path a)

```
Model Summary
R = .78   R² = .61   F(1, 148) = 231.50   p < .001

Coefficients
                B        SE       t        p
(Constant)    9.92     0.37   26.81   <.001
Workload     −0.81     0.05  −15.21   <.001
```

**How to read this:**

- Workload significantly predicts coping (p < .001)
- For every 1-point increase in workload, coping ability decreases by **0.81 points**
- This is the **a path** — the first step of the indirect effect
- The negative sign makes sense: more workload = worse coping

---

#### Block 3: Effect of M on Y, controlling for X (path b), and direct effect of X (path c')

```
Model Summary
R = .89   R² = .79   F(2, 147) = 278.40   p < .001

Coefficients
                B        SE       t        p
(Constant)    5.43     0.48   11.31   <.001
Workload      0.31     0.07    4.43   <.001
Coping       −0.53     0.06   −8.83   <.001
```

**How to read this:**

- **Coping (b path):** For every 1-point increase in coping, burnout decreases by **0.53 points**, controlling for workload (p < .001) ✓
- **Workload direct effect (c' path):** For every 1-point increase in workload, burnout increases by **0.31 points**, *after accounting for coping* (p < .001)
- Compare this to the total effect (0.74): workload's effect dropped from 0.74 to 0.31 when we added coping — this suggests coping is absorbing some of the effect

---

#### Block 4: The Indirect Effect (a × b) — the key result

```
Indirect effect of Workload on Burnout via Coping

         Effect     Boot SE     LLCI      ULCI
Coping   0.4293      0.0621    0.3121    0.5581
```

**How to read this:**

- The indirect effect = a × b = (−0.81) × (−0.53) = **0.43**
- The **95% bootstrapped confidence interval** is [0.31, 0.56]
- Because this interval **does not contain zero**, the indirect effect is statistically significant
- This confirms that coping **mediates** the relationship between workload and burnout

> This is the number that tells you mediation is real. If the CI crosses zero, there is no significant mediation.

---

#### Putting it all together

| Path | Effect | Meaning |
|---|---|---|
| Total effect (c) | 0.74 | How much workload affects burnout overall |
| a path | −0.81 | How much workload reduces coping |
| b path | −0.53 | How much coping reduces burnout (controlling for workload) |
| Indirect effect (a × b) | 0.43 | How much of workload's effect on burnout goes *via* coping |
| Direct effect (c') | 0.31 | How much workload still affects burnout *after* accounting for coping |

**Conclusion:** There is **partial mediation**. Workload affects burnout both directly (c' = 0.31) and indirectly through reduced coping (indirect = 0.43). Coping explains about 58% of the total effect (0.43 / 0.74 = 58%).

---

### Why is M a mediator here and not just another predictor?

Because the claim is about **sequence and mechanism**: workload comes first, it causes a drop in coping, and that drop causes burnout. The three variables are in a causal chain.

If we just said "both workload and coping independently predict burnout," we would add them both as predictors (both as X variables). The mediation model makes the stronger claim that coping is the *pathway* through which workload operates.

---

### Baron & Kenny approach (if PROCESS is not available)

Run three separate regressions manually:

1. Regress Y (Burnout) on X (Workload) → check X is significant *(path c)*
2. Regress M (Coping) on X (Workload) → check X is significant *(path a)*
3. Regress Y (Burnout) on both X and M → check M is significant *(path b)*, and check X's coefficient drops compared to step 1 *(path c')*

If X's coefficient in step 3 drops to zero = **full mediation**. If it drops but remains significant = **partial mediation**.

---

## Part B: Moderation Analysis — Intercept and Slope Values

### What is moderation? (and why is it different from mediation?)

Moderation asks: *for whom, or under what conditions* does X affect Y? It does not propose a causal chain. Instead, it asks whether the **strength** of the X → Y relationship changes depending on a third variable W.

**Our example:**
> Does workload (X) predict burnout (Y)? And does social support (W) change how strong that effect is?

**The key difference from mediation:**
- Mediation: workload → coping → burnout (coping is *in the middle*, explaining the mechanism)
- Moderation: social support doesn't sit between workload and burnout — it sits *alongside* and changes the slope

---

### The moderation equation

> **Ŷ = b₀ + b₁X + b₂W + b₃(X × W)**

| Term | What it means |
|---|---|
| b₀ (Constant) | Intercept — predicted Y when X = 0 and W = 0 |
| b₁ | Slope for X when W = 0 |
| b₂ | Slope for W when X = 0 |
| b₃ | The interaction term — this is the moderation effect |

b₃ is what you are testing. If it is significant, moderation is confirmed.

---

### How to run moderation in SPSS (PROCESS Macro)

```
Analyze → Regression → PROCESS (by Andrew Hayes)
  Y: Burnout
  X: Workload
  W (moderator): Social Support
  Model number: Model 1
  Tick: Generate data for visualising interactions
  Tick: Plot interactions
  Click OK
```

---

### Q1: How do you calculate intercept and slope values from SPSS output?

PROCESS produces a Coefficients table. Here is what ours looks like:

```
Outcome: Burnout (Y)

Model Summary
R = .87   R² = .76   F(3, 146) = 153.40   p < .001

Coefficients
                          B        SE       t        p
(Constant)              1.52     0.41    3.71    <.001
Workload (X)            0.82     0.07   11.71    <.001
Social Support (W)     −0.29     0.06   −4.83    <.001
Workload × Support     −0.09     0.01   −9.00    <.001
```

**Extracting the values:**

| Value to find | Where in SPSS | Our number |
|---|---|---|
| b₀ (intercept) | (Constant) row → B column | **1.52** |
| b₁ (slope for X) | Workload row → B column | **0.82** |
| b₂ (slope for W) | Social Support row → B column | **−0.29** |
| b₃ (interaction) | Workload × Support row → B column | **−0.09** |

**Our full equation:**
> Ŷ = 1.52 + 0.82(Workload) − 0.29(Support) − 0.09(Workload × Support)

**Checking for moderation:** The interaction term b₃ = −0.09 is significant (p < .001), so **moderation is confirmed**. Social support changes how strongly workload affects burnout.

The negative sign on b₃ means: as social support increases, the positive effect of workload on burnout gets weaker. In other words, support buffers the impact of workload.

---

### Q2: How do you sketch the simple slopes graph?

The simple slopes graph shows the X → Y relationship separately for low, mean, and high levels of W. Each level becomes one line.

**Step 1: Get descriptive statistics for W (Social Support)**

From SPSS Descriptives output:
> Mean of W = 5.0, SD of W = 2.0

**Step 2: Define three levels of W**
- Low W = mean − 1 SD = 5.0 − 2.0 = **3.0**
- Mean W = **5.0**
- High W = mean + 1 SD = 5.0 + 2.0 = **7.0**

**Step 3: Substitute each W value into the equation and simplify to a line in X**

**Low support (W = 3):**
```
Ŷ = 1.52 + 0.82X − 0.29(3) − 0.09X(3)
  = 1.52 − 0.87 + (0.82 − 0.27)X
  = 0.65 + 0.55X
```

**Mean support (W = 5):**
```
Ŷ = 1.52 + 0.82X − 0.29(5) − 0.09X(5)
  = 1.52 − 1.45 + (0.82 − 0.45)X
  = 0.07 + 0.37X
```

**High support (W = 7):**
```
Ŷ = 1.52 + 0.82X − 0.29(7) − 0.09X(7)
  = 1.52 − 2.03 + (0.82 − 0.63)X
  = −0.51 + 0.19X
```

**Step 4: Pick two X values and calculate Ŷ**

Using X = 2 (low workload) and X = 8 (high workload):

| W Level | X = 2 | X = 8 | Slope |
|---|---|---|---|
| Low Support (W = 3) | 0.65 + 0.55(2) = **1.75** | 0.65 + 0.55(8) = **5.05** | 0.55 — steepest |
| Mean Support (W = 5) | 0.07 + 0.37(2) = **0.81** | 0.07 + 0.37(8) = **3.03** | 0.37 — moderate |
| High Support (W = 7) | −0.51 + 0.19(2) = **−0.13** | −0.51 + 0.19(8) = **1.01** | 0.19 — shallowest |

**Step 5: Sketch the graph**

```
Burnout (Y)
   5 |                                    * Low Support
     |                               *
   4 |                          *
     |                +---------+
   3 |           *              |         * Mean Support
     |      *                   |    *
   2 |                     *
     |              *
   1 |         *                          * High Support
     |    *
   0 +----+----+----+----+----+----+----+---→
        1    2    3    4    5    6    7    8
                    Workload (X)
```

- X-axis: Workload
- Y-axis: Burnout
- Three lines, each labelled by support level
- **Steeper slope = stronger effect of workload on burnout**

**Interpretation:** When social support is low, workload has a much stronger positive effect on burnout (slope = 0.55). When support is high, the effect is present but much weaker (slope = 0.19). Social support is acting as a buffer. This is what the interaction term told us numerically — now we can see it visually.

---

### Shortcut: PROCESS output directly

If PROCESS was run with the "plot" option ticked, look for a section in the output called:

```
Data for visualising the conditional effect of X on Y
```

This will give you a ready-made table of X values, W levels, and predicted Y values — you can paste these straight into Excel and plot without doing any of the manual calculations above.

---

## Part C: Factor Analysis Output

### What is factor analysis?

Factor analysis looks at a set of measured variables (e.g., survey items) and asks: do some of these cluster together, suggesting they are all measuring the same underlying construct (a **factor**)?

**Our example:** The workplace wellbeing survey included 8 attitude items. We want to know whether they group into underlying factors.

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

We might guess items 1–4 measure *engagement* and items 5–8 measure *autonomy*. Factor analysis tests whether the data support this.

---

### How to run factor analysis in SPSS

```
Analyze → Dimension Reduction → Factor

Move all 8 items into the Variables box

Extraction tab:
  Method: Principal Components
  Analyse: Correlation matrix
  Extract: Eigenvalues over 1
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

#### Section 1: KMO and Bartlett's Test

```
KMO and Bartlett's Test

Kaiser-Meyer-Olkin Measure of Sampling Adequacy     .847
Bartlett's Test of Sphericity   Approx. Chi-Square  634.21
                                df                  28
                                Sig.                <.001
```

**How to read this:**

| Statistic | Our value | What it means |
|---|---|---|
| KMO | .847 | Well above .60 — excellent. The variables are correlated enough to factor. |
| Bartlett's Sig. | < .001 | Significant — confirms meaningful correlations exist in the data. |

> ✓ Both tests pass. We can proceed with factor analysis.

---

#### Section 2: Communalities

```
Communalities

                        Initial     Extraction
Item 1 (enthusiastic)   1.000         .812
Item 2 (absorbed)       1.000         .791
Item 3 (time flies)     1.000         .763
Item 4 (energised)      1.000         .834
Item 5 (decide how)     1.000         .808
Item 6 (free to org.)   1.000         .779
Item 7 (in control)     1.000         .821
Item 8 (own decisions)  1.000         .796
```

**How to read this:**

The Extraction column is what matters. It shows what proportion of each item's variance is captured by the extracted factors.

- All values here are above .75 — very good
- If a value were below .30, that item is not well represented and may need to be removed

> ✓ All items are well captured by the solution.

---

#### Section 3: Total Variance Explained

```
Total Variance Explained

Component   Eigenvalue   % of Variance   Cumulative %
    1          4.21          52.6            52.6
    2          1.98          24.8            77.4
    3          0.43           5.4            82.8
    4          0.31           3.9            86.7
    ...
```

**How to read this:**

| Term | Our value | What it means |
|---|---|---|
| Component 1 eigenvalue | 4.21 | Above 1 → retain this factor |
| Component 2 eigenvalue | 1.98 | Above 1 → retain this factor |
| Component 3 eigenvalue | 0.43 | Below 1 → do not retain |
| Cumulative % (2 factors) | 77.4% | Two factors together explain 77.4% of the total variance — very good |

> ✓ Retain 2 factors. Together they explain 77.4% of variance, which is excellent.

---

#### Section 4: Scree Plot

The scree plot would show:

```
Eigenvalue
  4 |*
    |
  3 |
    |
  2 |  *
    |      \
  1 |        * ─ ─ ─ ─ ─ ─ (line flattens here)
    |
  0 +────────────────────────→
       1    2    3    4    5    Component
```

The **elbow** is between components 2 and 3 — the line drops sharply then flattens. This confirms: retain 2 factors.

> ✓ Scree plot agrees with the eigenvalue criterion. Retain 2 factors.

---

#### Section 5: Rotated Component Matrix *(the most important table)*

```
Rotated Component Matrix

                        Component 1   Component 2
Item 1 (enthusiastic)      .887
Item 2 (absorbed)          .874
Item 3 (time flies)        .856
Item 4 (energised)         .902
Item 5 (decide how)                      .884
Item 6 (free to org.)                    .867
Item 7 (in control)                      .893
Item 8 (own decisions)                   .878

(Loadings below .30 suppressed)
```

**How to read this:**

- Each number is a **factor loading** — the correlation between that item and that factor
- Items 1–4 all load strongly on Component 1 (loadings .85–.90) and not on Component 2
- Items 5–8 all load strongly on Component 2 (loadings .86–.89) and not on Component 1
- This is a very clean pattern — each item belongs clearly to one factor

**To name the factors:**
- Component 1: Items about enthusiasm, absorption, energy, time flying → **Work Engagement**
- Component 2: Items about freedom to decide, organise, control → **Job Autonomy**

> ✓ Two clear factors emerge: Work Engagement and Job Autonomy.

---

#### Summary: what to report

| What | What to write |
|---|---|
| KMO | KMO = .847, indicating excellent sampling adequacy |
| Bartlett's test | χ²(28) = 634.21, p < .001, confirming sufficient correlations |
| Number of factors | Two factors retained based on eigenvalues > 1 and the scree plot |
| Variance explained | The two-factor solution explained 77.4% of total variance |
| Factor 1 | Work Engagement — items 1–4, loadings .856–.902 |
| Factor 2 | Job Autonomy — items 5–8, loadings .867–.893 |

---

## Part D: Mediation vs Moderation — Side-by-Side

| | Mediation | Moderation |
|---|---|---|
| Question | *Why* does X affect Y? | *When / for whom* does X affect Y? |
| Third variable role | Mediator M is in the causal chain | Moderator W sits alongside and changes the slope |
| Our example | Workload → Coping → Burnout | Workload → Burnout, buffered by Social Support |
| Model | X → M → Y | Ŷ = b₀ + b₁X + b₂W + b₃(X×W) |
| PROCESS model | Model 4 | Model 1 |
| Key test | Indirect effect CI does not include zero | b₃ is significant (p < .05) |
| Key output | Indirect effect = a × b = 0.43, 95% CI [0.31, 0.56] | b₃ = −0.09, p < .001 |

### Is mediation just double (or triple) regression?

In the classic **Baron & Kenny** approach, yes — it runs three separate regressions:

1. X → Y (does X predict the outcome?)
2. X → M (does X predict the mediator?)
3. X + M → Y (does M predict Y, while X's effect reduces?)

The "double regression" framing refers to steps 2 and 3 being the core tests. But modern practice uses **PROCESS with bootstrapping**, which estimates the indirect effect (a × b) as a single quantity and builds a confidence interval around it. This is more robust because it does not require each individual path to be significant — only the combined indirect effect needs to be.

---

*Prepared for MASH tutoring session — June 2026 | MGTT001 MSc Business & Organisational Psychology | University of Sheffield*
