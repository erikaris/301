
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

```math
Y_{ij} = \mu + \tau_i + \beta x_{ij} + \epsilon_{ij}
```

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


---
Yes. Forget the MPS314 example and think of **ANCOVA in general**.

A common ANCOVA model is:

$$
Y_{ij} = \mu + \tau_i + \beta x_{ij} + \epsilon_{ij}
$$

In plain English:

> **Outcome = overall/reference level + group effect + effect of the covariate + unexplained variation**

| Symbol | General meaning | Simple explanation |
|---|---|---|
| $Y_{ij}$ | Outcome | The value we are trying to explain or predict |
| $\mu$ | Intercept / reference level | The starting/reference value of the outcome |
| $\tau_i$ | Group/factor effect | How much group $i$ differs from the reference group |
| $\beta$ | Covariate coefficient | How strongly the covariate is related to the outcome |
| $x_{ij}$ | Covariate value | The actual value of the covariate for observation $j$ in group $i$ |
| $\epsilon_{ij}$ | Error/residual | Variation in the outcome that the model cannot explain |

For example, imagine:

- **Outcome:** exam score
- **Group:** Teaching Method A or B
- **Covariate:** prior test score

Then:

```math
\text{Exam score} = \text{reference level} + \text{teaching-method effect} + \text{effect of prior score} + \text{unexplained variation}
```

### What are $i$ and $j$?

They are simply indexes:

- $i$ tells us **which group**
- $j$ tells us **which person/observation within that group**

So $Y_{ij}$ means:

> the outcome for observation $j$ in group $i$.

### $\mu$ — the reference level

$\mu$ is the **intercept**.

It represents the expected outcome for the **reference group when the covariate is 0**.

For example, if:

$$
\mu = 50
$$

the model's starting/reference value is 50.

Sometimes $x=0$ is not meaningful in real life, so $\mu$ may not have an interesting practical interpretation. It is still needed mathematically.

### $\tau_i$ — the group effect

$\tau_i$ tells us how group $i$ differs from the reference group **after accounting for the covariate**.

Suppose Group A is the reference:

$$
\tau_A=0
$$

and:

$$
\tau_B=5
$$

Then Group B's expected outcome is **5 units higher than Group A's**, when comparing observations with the same value of the covariate.

This is usually the part we're especially interested in when ANCOVA is being used to compare groups.

### $\beta$ — the covariate effect

$\beta$ tells us how the outcome changes as the continuous covariate changes.

For example:

$$
\beta=2
$$

means:

> For every 1-unit increase in $x$, the expected outcome increases by 2 units, holding group constant.

So if $x$ is prior test score, $\beta$ describes the relationship between prior score and final score.

### $x_{ij}$ — the actual covariate value

$x_{ij}$ is simply the covariate value for a particular observation.

For example:

$$
x_{ij}=10
$$

and if:

$$
\beta=2
$$

then the contribution from the covariate is:

$$
\beta x_{ij}=2(10)=20
$$

### $\epsilon_{ij}$ — what we can't explain

$\epsilon_{ij}$ is the **error/residual**.

Even if two people:

- belong to the same group, and
- have exactly the same covariate value,

they probably won't have exactly the same outcome.

There are always other factors we haven't included in our model.

$\epsilon$ represents this **unexplained individual variation**.

---

So the easiest way to read:

$$
Y_{ij} = \mu + \tau_i + \beta x_{ij} + \epsilon_{ij}
$$

is:

> **What happened = starting point + group effect + covariate effect + everything else.**

And this also explains the main ANCOVA hypothesis:

$$
H_0:\text{no group effect after adjusting for the covariate}
$$

versus

$$
H_1:\text{there is a group effect after adjusting for the covariate}
$$

For two groups, if Group 1 is the reference, this can be written:

$$
H_0:\tau_2=0
$$

versus:

$$
H_1:\tau_2\neq0
$$

So **$\tau$ is the key parameter for the group comparison**, while **$\beta$ describes the relationship between the covariate and outcome**.
