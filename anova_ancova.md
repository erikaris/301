
## 1. The big picture

ANOVA and ANCOVA are much more closely related than their names sometimes suggest.

The table below gives the overall picture before looking at each method in more detail.

| Method | Predictors / design | Example | Model / formula | Null hypothesis ($H_0$) | Alternative hypothesis ($H_1$) |
|---|---|---|---|---|---|
| **One-way ANOVA** | 1 categorical factor | Do exam scores differ between Teaching Methods A, B and C? | $Y = \mu + A + \epsilon$ | $H_0: \mu_A = \mu_B = \mu_C$ | $H_1:$ at least one group mean differs |
| **Two-way ANOVA** | 2 categorical factors | Do exam scores differ by Teaching Method and School Type? | $Y = \mu + A + B + A\times B + \epsilon$ | $H_0^A:$ no effect of A; $H_0^B:$ no effect of B; $H_0^{AB}:$ no interaction | $H_1^A:$ A has an effect; $H_1^B:$ B has an effect; $H_1^{AB}:$ there is an interaction |
| **Three-way ANOVA** | 3 categorical factors | Do exam scores differ by Teaching Method, School Type and Gender? | $Y = \mu + A + B + C + A\times B + A\times C + B\times C + A\times B\times C + \epsilon$ | Separate $H_0$s for the 3 main effects and all interactions | Corresponding $H_1:$ the relevant main effect or interaction exists |
| **N-way / factorial ANOVA** | N categorical factors | Do exam scores differ according to several categorical factors? | $Y = \mu + \text{main effects} + \text{interactions} + \epsilon$ | No relevant factor effect or interaction | At least one relevant factor effect or interaction exists |
| **Repeated-measures ANOVA** | 1 or more within-subject categorical factors | Does mean blood pressure change at baseline, 1, 3 and 6 months in the same patients? | $Y = \mu + \text{Time} + \text{subject-related variation} + \epsilon$ | $H_0: \mu_{\text{baseline}} = \mu_{\text{1m}} = \mu_{\text{3m}} = \mu_{\text{6m}}$ | $H_1:$ at least one time-point mean differs |
| **Mixed ANOVA** | Between-subject factor(s) + within-subject factor(s) | Does blood pressure change over time differently for Drug vs Placebo? | $Y = \mu + \text{Treatment} + \text{Time} + \text{Treatment}\times\text{Time} + \text{subject-related variation} + \epsilon$ | Separate $H_0$s: no Treatment effect; no Time effect; no Treatment × Time interaction | Corresponding $H_1:$ Treatment effect, Time effect and/or interaction exists |
| **ANCOVA** | Categorical factor(s) + continuous covariate(s) | Does 6-month cholesterol differ between Drug and Placebo after adjusting for baseline cholesterol? | $Y_{ij} = \mu + \tau_i + \beta x_{ij} + \epsilon_{ij}$ | $H_0: \tau_i = 0$; no treatment/group effect after adjusting for the covariate | $H_1: \tau_i \neq 0$; a treatment/group effect remains after adjusting for the covariate |
| **Two-factor ANCOVA** | 2 categorical factors + continuous covariate(s) | Does exam score differ by Teaching Method and School Type after adjusting for prior attainment? | $Y = \mu + A + B + A\times B + \beta X + \epsilon$ | Separate $H_0$s for A, B and A × B after adjusting for $X$ | Corresponding $H_1:$ the relevant adjusted effect or interaction exists |

### The progression

The first four methods follow a very simple progression:

$$
\text{1 categorical factor}
\rightarrow
\text{One-way ANOVA}
$$

$$
\text{2 categorical factors}
\rightarrow
\text{Two-way ANOVA}
$$

$$
\text{3 categorical factors}
\rightarrow
\text{Three-way ANOVA}
$$

$$
\text{N categorical factors}
\rightarrow
\text{N-way ANOVA}
$$

The important rule is:

> **The "way" in ANOVA counts categorical factors, not the total number of predictor variables.**

Repeated-measures and mixed ANOVA are slightly different extensions because they describe the **structure of the observations**:

- **Repeated-measures ANOVA** → the same participants are measured repeatedly.
- **Mixed ANOVA** → combines between-subject and within-subject factors.

ANCOVA extends the ANOVA framework in another direction:

$$
\text{Categorical factor(s)}
+
\text{continuous covariate(s)}
\rightarrow
\text{ANCOVA}
$$

For example:

$$
\text{Treatment}
+
\text{Baseline cholesterol}
\rightarrow
\text{ANCOVA}
$$

because Treatment is categorical and baseline cholesterol is continuous.

But:

$$
\text{Treatment}
+
\text{Sex}
\rightarrow
\text{Two-way ANOVA}
$$

because both Treatment and Sex are categorical.

And:

$$
\text{Treatment}
+
\text{Sex}
+
\text{Baseline cholesterol}
\rightarrow
\text{Two-factor ANCOVA}
$$

because there are **two categorical factors plus one continuous covariate**.

### One important point about the hypotheses

For **one-way ANOVA**, there is usually one main omnibus hypothesis:

$$
H_0: \mu_1 = \mu_2 = \cdots = \mu_k
$$

versus:

$$
H_1: \text{not all population means are equal}
$$

Once there are multiple factors, however, there is **not just one $H_0$ and one $H_1$ for the whole analysis**. We normally test separate hypotheses for the main effects and interactions.

For example, in a two-way ANOVA with Teaching Method and School Type:

- $H_0^A$: no Teaching Method effect;
- $H_0^B$: no School Type effect;
- $H_0^{AB}$: no Teaching Method × School Type interaction.

This same idea extends to three-way and higher-order ANOVA.

For ANCOVA, if Treatment is the main factor of interest, the central question becomes:

> **Is there still a treatment/group difference after accounting for the continuous covariate?**

In the MPS314 clinical-trial example:

$$
Y_{ij}
=
\mu
+
\tau_i
+
\beta x_{ij}
+
\epsilon_{ij}
$$

and the treatment hypothesis is:

$$
H_0: \tau_2 = 0
$$

versus:

$$
H_1: \tau_2 \neq 0
$$

In plain English:

> **$H_0$:** no treatment effect after adjusting for baseline cholesterol.  
> **$H_1$:** there is a treatment effect after adjusting for baseline cholesterol.
