
# From ANOVA to ANCOVA: A Practical Guide

## 1. The big picture

ANOVA and ANCOVA are much more closely related than their names sometimes suggest.

The simplest way to organise them is:

| Method | What predictors do we have? | Main idea |
|---|---|---|
| **One-way ANOVA** | 1 categorical factor | Compare means across groups |
| **Two-way ANOVA** | 2 categorical factors | Examine two factors and their interaction |
| **Three-way ANOVA** | 3 categorical factors | Examine three factors and their interactions |
| **N-way/factorial ANOVA** | N categorical factors | Generalisation to multiple factors |
| **Repeated-measures ANOVA** | Categorical within-subject factor | Compare repeated measurements from the same participants |
| **Mixed ANOVA** | Between-subject + within-subject factors | Compare groups over repeated conditions/times |
| **ANCOVA** | Categorical factor(s) + continuous covariate(s) | Compare groups while adjusting for continuous variable(s) |

A key rule is:

> **The "way" in ANOVA refers to the number of categorical factors, not simply the number of predictor variables.**

So:

- Treatment → one-way ANOVA
- Treatment + Sex → two-way ANOVA
- Treatment + Sex + Hospital → three-way ANOVA
- Treatment + Baseline cholesterol → ANCOVA
- Treatment + Sex + Baseline cholesterol → two-factor ANCOVA

---

## 2. First: what is ANOVA?

ANOVA stands for **Analysis of Variance**.

Although its name refers to variance, ANOVA is normally used to investigate **differences in means between groups**.

For example, suppose the outcome is exam score and students receive one of three teaching methods:

- Method A
- Method B
- Method C

The research question is:

> Do students taught using the three methods have the same mean exam score?

The null hypothesis is:

$$
H_0: \mu_A = \mu_B = \mu_C
$$

The alternative is:

$$
H_A: \text{not all group means are equal}
$$

Importantly, the alternative does **not** mean that every group differs from every other group. It only means that at least one difference exists.

ANOVA uses the F statistic, which essentially compares:

$$
F =
\frac{\text{variation between groups}}
{\text{variation within groups}}
$$

If between-group variation is large relative to ordinary within-group variation, this provides evidence that the group means are not all the same.

A significant omnibus ANOVA tells us that a difference exists, but not necessarily **which groups differ**. Post-hoc comparisons such as Tukey's test or planned contrasts may then be needed.

---

## 3. One-way ANOVA

### When do we use it?

Use one-way ANOVA when:

- the outcome is continuous;
- there is **one categorical factor**;
- that factor has two or more groups/levels.

For example:

**Outcome:** exam score  
**Factor:** teaching method (A, B, C)

Research question:

> Does mean exam score differ between teaching methods?

Conceptually:

$$
Y_{ij} = \mu + \tau_i + \epsilon_{ij}
$$

where:

- $Y_{ij}$ = outcome for person $j$ in group $i$
- $\mu$ = overall/reference mean
- $\tau_i$ = effect of belonging to group $i$
- $\epsilon_{ij}$ = unexplained individual variation

The null hypothesis is:

$$
H_0: \mu_A = \mu_B = \mu_C
$$

In words:

> There is no teaching-method effect.

---

## 4. Two-way ANOVA

Now suppose there are **two categorical factors**.

For example:

**Outcome:** exam score  
**Factor 1:** teaching method (A, B, C)  
**Factor 2:** school type (public, private)

This is a **two-way ANOVA**.

A typical model includes:

$$
Y =
\text{Teaching Method}
+
\text{School Type}
+
\text{Teaching Method} \times \text{School Type}
+
\epsilon
$$

There are now usually three questions.

### Main effect of teaching method

$$
H_0: \text{no teaching-method effect}
$$

In accessible language:

> Averaging across school types, are mean exam scores the same for the different teaching methods?

### Main effect of school type

$$
H_0: \text{no school-type effect}
$$

In accessible language:

> Averaging across teaching methods, are mean scores the same between school types?

### Interaction

$$
H_0: \text{no Teaching Method} \times \text{School Type interaction}
$$

This asks:

> Does the effect of teaching method depend on school type?

For example, perhaps Method A works particularly well in private schools but not in public schools.

That is an **interaction**.

---

## 5. Three-way ANOVA

Now add another categorical factor:

**Outcome:** exam score  
**Factor 1:** teaching method  
**Factor 2:** school type  
**Factor 3:** gender

This becomes a **three-way ANOVA**.

Conceptually:

$$
Y =
A + B + C
+ A \times B
+ A \times C
+ B \times C
+ A \times B \times C
+ \epsilon
$$

There can therefore be:

- three main effects;
- three two-way interactions;
- one three-way interaction.

The three-way interaction asks something like:

> Does the Teaching Method × School Type interaction itself differ across gender?

Three-way interactions can become difficult to interpret, so plots and carefully chosen comparisons become particularly important.

---

## 6. N-way or factorial ANOVA

The same principle continues.

If there are $N$ categorical factors, we can describe the design as an **N-way ANOVA** or factorial ANOVA.

The important point is:

> **The variables being counted as factors are categorical.**

Therefore, having three predictor variables does **not automatically mean three-way ANOVA**.

For example:

- Teaching method = categorical
- Gender = categorical
- Hours studied = continuous

This is **not** a three-way ANOVA.

There are two categorical factors and one continuous predictor.

That takes us towards **ANCOVA**.

---

## 7. Repeated-measures ANOVA

The ANOVAs above generally concern independent groups unless the design says otherwise.

Repeated-measures ANOVA is used when the **same participants are measured repeatedly**.

For example, blood pressure is measured at:

- baseline;
- 1 month;
- 3 months;
- 6 months.

Here, **Time** is a within-subject factor.

The research question is:

> Does mean blood pressure change over time?

The null hypothesis is broadly:

$$
H_0:
\mu_{\text{baseline}}
=
\mu_{\text{1 month}}
=
\mu_{\text{3 months}}
=
\mu_{\text{6 months}}
$$

The measurements cannot be treated as independent because measurements from the same person are related.

Repeated-measures ANOVA therefore extends the ANOVA idea to dependent/repeated observations.

In modern analyses, linear mixed-effects models are often useful alternatives, particularly for more complicated longitudinal data.

---

## 8. Mixed ANOVA

Suppose there are two treatment groups:

- Drug
- Placebo

and each patient is measured at:

- baseline;
- 1 month;
- 3 months;
- 6 months.

Now there are:

**Treatment** = between-subject factor  
**Time** = within-subject factor

This is commonly called a **mixed ANOVA** or mixed-design ANOVA.

There are three particularly interesting questions:

1. Is there a treatment effect?
2. Is there a time effect?
3. Is there a Treatment × Time interaction?

The third is often especially interesting:

> Does the pattern of change over time differ between the treatment groups?

---

## 9. So where does ANCOVA come in?

ANCOVA stands for **Analysis of Covariance**.

A useful way to remember it is:

> **ANCOVA = ANOVA + continuous covariate(s).**

More precisely, ANCOVA is a linear model containing both:

- categorical factor(s); and
- continuous explanatory variable(s), called covariates.

For example:

**Outcome:** exam score  
**Factor:** teaching method (A, B, C)  
**Covariate:** hours studied

The model could be written:

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

where:

- $Y$ = exam score;
- $\tau_i$ = teaching-method effect;
- $x$ = hours studied;
- $\beta$ = relationship between study hours and exam score.

The research question might be:

> Do exam scores differ between teaching methods **after adjusting for hours studied**?

---

## 10. What is a covariate?

A **covariate** is a variable included in the model because it may help explain variation in the outcome and we want to account for it when estimating the effect of primary interest.

In classical ANCOVA, the covariate is usually continuous.

Examples include:

- age;
- baseline cholesterol;
- baseline blood pressure;
- prior exam score;
- hours studied;
- years of experience;
- rainfall;
- income;
- temperature.

It does **not** have to be a baseline measurement.

Baseline measurements are simply very common covariates in clinical trials.

---

## 11. What does "adjusting for" a covariate mean?

Suppose we compare two teaching methods.

Students using Method B have higher exam scores than students using Method A.

But students using Method B also studied considerably longer.

A simple ANOVA asks:

> Are exam scores different between Methods A and B?

ANCOVA asks:

> Are exam scores different between Methods A and B **when comparing students with the same amount of study time?**

This is what "adjusting for hours studied" means.

It does not mean physically changing anybody's study time.

The model estimates the relationship between study time and exam score and takes that relationship into account when comparing the teaching methods.

A useful plain-English explanation is:

> **Adjusting means comparing the groups while taking another relevant variable into account.**

Or, even more simply:

> **We compare the groups at the same value of the covariate.**

---

## 12. Why isn't this simply two-way ANOVA?

Because **hours studied is continuous**.

Suppose study time is:

$$
1.5,\ 2.2,\ 3.7,\ 4.1,\ 5.8,\ 7.3,\ldots
$$

Keeping those actual values gives:

$$
\text{Exam Score}
\sim
\text{Teaching Method}
+
\text{Hours Studied}
$$

This is ANCOVA.

We *could* artificially convert hours studied into:

- Low: 0–3 hours
- Medium: 4–6 hours
- High: 7+ hours

Then both predictors would be categorical:

- Teaching method
- Study-time category

and we could conduct a two-way ANOVA.

But categorising a naturally continuous variable usually throws away information and creates arbitrary boundaries.

For example, students studying 3.9 and 4.1 hours are almost identical in terms of study time, yet an arbitrary cut-off could put them in different categories.

So the important distinction is:

> **Two-way ANOVA = two categorical factors.**

> **ANCOVA = categorical factor(s) + continuous covariate(s).**

---

## 13. Can ANCOVA have two categorical factors?

Yes.

Suppose:

**Outcome:** exam score  
**Factor 1:** teaching method  
**Factor 2:** school type  
**Covariate:** hours studied

Then:

$$
Y =
\text{Teaching Method}
+
\text{School Type}
+
\text{Teaching Method} \times \text{School Type}
+
\text{Hours Studied}
+
\epsilon
$$

This can be described as a **two-factor ANCOVA**.

So another useful way of thinking about it is:

> **Two-factor ANCOVA = two-way ANOVA + continuous covariate(s).**

Similarly, ANCOVA can contain more than one covariate.

For example:

$$
Y =
\text{Teaching Method}
+
\text{School Type}
+
\text{Hours Studied}
+
\text{Age}
+
\epsilon
$$

The important point is that **"way" counts categorical factors, not continuous covariates**.

---

## 14. ANCOVA does not require a before-and-after study

This is worth emphasising because baseline measurements are such common ANCOVA examples.

ANCOVA can be used in many settings.

| Setting | Outcome | Factor | Covariate |
|---|---|---|---|
| Education | Exam score | Teaching method | Prior attainment |
| Agriculture | Crop yield | Fertiliser | Rainfall |
| Workplace | Productivity | Working arrangement | Years of experience |
| Marketing | Spending | Advertisement type | Income |
| Manufacturing | Product strength | Manufacturing method | Material thickness |
| Sport | Race performance | Training programme | Age |
| Clinical trial | Follow-up cholesterol | Drug/placebo | Baseline cholesterol |

The general pattern is always:

> **Compare groups while accounting for a relevant continuous variable.**

---

## 15. ANCOVA hypothesis

Consider:

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

If the main interest is the group effect, the null hypothesis is essentially:

$$
H_0: \tau_i = 0
$$

for the relevant treatment contrasts.

For two groups, this means:

> **There is no difference between the groups after adjusting for the covariate.**

For example:

> There is no difference in expected exam score between Teaching Methods A and B after adjusting for prior attainment.

For several groups, the omnibus hypothesis is that there is no factor effect after accounting for the covariate.

---

## 16. Important assumptions

Standard ANOVA and ANCOVA rely on assumptions about the model and study design.

Common considerations include:

- independence of observations;
- approximately normally distributed residuals for the usual small-sample inference;
- approximately constant residual variance across relevant groups/fitted values;
- appropriate specification of factors and interactions.

ANCOVA additionally requires an appropriate relationship between the continuous covariate and outcome.

For a standard linear ANCOVA, this is usually modelled as a linear relationship.

Another important consideration is **homogeneity of regression slopes** when using the simple ANCOVA model.

For example:

$$
Y
=
\text{Treatment}
+
\beta X
+
\epsilon
$$

assumes the relationship between $X$ and $Y$ has the same slope across treatment groups.

If the relationship differs by treatment, we may need an interaction:

$$
Y
=
\text{Treatment}
+
X
+
\text{Treatment} \times X
+
\epsilon
$$

Then the effect of treatment depends on the value of the covariate.

---

## 17. Is ANOVA actually linear regression too?

**Yes.**

This is one of the most useful ideas for understanding all of this.

ANOVA, ANCOVA and ordinary linear regression can all be expressed using the **general linear model**:

$$
Y = X\beta + \epsilon
$$

The difference is mainly in the kinds of predictors contained in $X$.

### Ordinary regression with a continuous predictor

For example:

$$
Y
=
\beta_0
+
\beta_1 X
+
\epsilon
$$

or:

$$
\text{Exam Score}
=
\beta_0
+
\beta_1(\text{Hours Studied})
+
\epsilon
$$

Here, the predictor is continuous.

### ANOVA with a categorical predictor

Suppose teaching method has three categories:

- Method A
- Method B
- Method C

Regression can represent these categories using indicator/dummy variables.

If Method A is the reference category:

$$
Y
=
\beta_0
+
\beta_1 D_B
+
\beta_2 D_C
+
\epsilon
$$

where:

- $D_B = 1$ for Method B and 0 otherwise;
- $D_C = 1$ for Method C and 0 otherwise.

This is mathematically the same linear model underlying a one-way ANOVA.

So:

> **ANOVA is a linear regression model in which the explanatory variables are categorical factors.**

### ANCOVA

Now add a continuous predictor:

$$
Y
=
\beta_0
+
\beta_1 D_B
+
\beta_2 D_C
+
\beta_3(\text{Hours Studied})
+
\epsilon
$$

Now the model contains:

- categorical predictor: teaching method;
- continuous predictor: hours studied.

That is ANCOVA.

So the relationship can be summarised as:

$$
\boxed{
\text{ANOVA}
=
\text{linear model with categorical predictor(s)}
}
$$

$$
\boxed{
\text{Linear regression}
=
\text{linear model with continuous and/or categorical predictors}
}
$$

$$
\boxed{
\text{ANCOVA}
=
\text{linear model with categorical factor(s) + continuous covariate(s)}
}
$$

ANOVA, regression and ANCOVA are therefore not three completely separate mathematical worlds.

---

## 18. Why does ANOVA talk about F-tests while regression talks about coefficients?

This can make ANOVA and regression look more different than they really are.

In regression, we often focus on coefficients such as:

$$
\beta_1,\ \beta_2,\ldots
$$

In ANOVA, we often focus on an **F-test** asking whether a factor explains meaningful variation in the outcome.

But both can come from the same fitted linear model.

For example, with three teaching methods, regression can estimate:

$$
\text{Method B} - \text{Method A}
$$

and:

$$
\text{Method C} - \text{Method A}
$$

The ANOVA F-test asks the broader question:

> Is there evidence of **any teaching-method effect**?

So ANOVA and regression often provide different views or tests of the **same underlying linear model**.

---

## 19. MPS314 example: clinical trial ANCOVA

The MPS314 Medical Statistics notes define ANCOVA as analysis involving **linear regression with a mix of continuous and factor explanatory variables**.

Their main example is a randomised controlled trial comparing:

- an experimental cholesterol-lowering drug;
- a placebo.

The outcome is:

> non-HDL cholesterol after six months.

The main covariate is:

> baseline non-HDL cholesterol measured before treatment.

The ANCOVA model is:

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

where:

- $Y_{ij}$ = cholesterol after six months;
- $\tau_i$ = treatment effect;
- $x_{ij}$ = baseline cholesterol;
- $\beta$ = relationship between baseline and six-month cholesterol.

The R implementation is:

```r
lm1 <- lm(month6 ~ baseline + treatment,
          data = cholesterol_imputed)
```

For the superiority trial, the treatment hypothesis is:

$$
H_0: \tau_2 = 0
$$

versus:

$$
H_A: \tau_2 \neq 0
$$

In words:

> **$H_0$: there is no treatment effect after accounting for baseline cholesterol.**

A two-sided alternative is used even though the desired direction is a reduction in cholesterol, because evidence that the drug has a harmful effect would also be important.

---

## 20. Why adjust for baseline in an RCT if treatment was randomised?

Randomisation means that, **on average**, the treatment groups should have similar baseline characteristics.

It does **not** mean that the actual sample will have exactly identical baseline values.

More importantly, baseline cholesterol is expected to be related to cholesterol at six months.

Including baseline cholesterol therefore explains some of the variability in the six-month outcome.

That can make the treatment-effect estimate **more precise**.

This is an important point:

> **ANCOVA is not necessarily adjusting for baseline because randomisation has failed. It can use relevant baseline information to explain outcome variability and improve precision.**

In the MPS314 example, when baseline cholesterol is omitted, more variability is left in the error term. This increases the uncertainty around the estimated treatment effect.

---

## 21. ANCOVA versus analysing "change from baseline"

These are **not the same analysis**.

One approach is to calculate:

$$
\text{Change}
=
\text{Month 6}
-
\text{Baseline}
$$

and then compare change between treatment groups.

ANCOVA instead models:

$$
\text{Month 6}
=
\text{Treatment}
+
\beta(\text{Baseline})
+
\epsilon
$$

The MPS314 notes point out that using change from baseline effectively imposes a particular coefficient of 1 on baseline in the corresponding outcome model.

ANCOVA instead **estimates the baseline coefficient from the data**.

Therefore:

> **"Analyse change from baseline" and "ANCOVA adjusting for baseline" are not interchangeable approaches.**

---

## 22. Can we include several covariates?

Yes.

The MPS314 material later considers both baseline cholesterol and age:

$$
\text{Month 6}
=
\text{Treatment}
+
\beta_1(\text{Baseline})
+
\beta_2(\text{Age})
+
\epsilon
$$

In R:

```r
lm4 <- lm(month6 ~ treatment + baseline + age,
          data = cholesterol_imputed)
```

So ANCOVA is not restricted to:

> one factor + one covariate.

It can contain multiple factors and multiple covariates.

However, covariates should not simply be added because they happen to be available.

There should generally be a **good reason for expecting the covariate to affect or predict the response**, and in settings such as clinical trials these decisions would normally be considered in advance.

---

## 23. A practical decision guide

When choosing between these methods, first identify the **outcome**, then classify the explanatory variables.

| Situation | Typical method |
|---|---|
| Continuous outcome + 1 categorical factor | One-way ANOVA |
| Continuous outcome + 2 categorical factors | Two-way ANOVA |
| Continuous outcome + 3 categorical factors | Three-way ANOVA |
| Continuous outcome + N categorical factors | N-way/factorial ANOVA |
| Continuous outcome repeatedly measured on the same people | Repeated-measures ANOVA / possibly mixed model |
| Repeated measurements + between-subject factor | Mixed ANOVA / possibly mixed model |
| Continuous outcome + categorical factor(s) + continuous covariate(s) | ANCOVA |

So always ask:

### 1. What is the outcome?

For classical ANOVA/ANCOVA, usually continuous.

### 2. How many categorical factors are there?

This determines one-way, two-way, three-way, etc.

### 3. Are there continuous explanatory variables that should also be included?

If yes, we are moving into ANCOVA/general linear modelling.

### 4. Are observations independent or repeated?

If the same people are measured repeatedly, the dependence needs to be modelled appropriately.

---

## 24. The simplest way to remember everything

The progression is:

$$
\boxed{
\text{One categorical factor}
\rightarrow
\text{One-way ANOVA}
}
$$

$$
\boxed{
\text{Two categorical factors}
\rightarrow
\text{Two-way ANOVA}
}
$$

$$
\boxed{
\text{Three categorical factors}
\rightarrow
\text{Three-way ANOVA}
}
$$

$$
\boxed{
\text{N categorical factors}
\rightarrow
\text{N-way ANOVA}
}
$$

Then:

$$
\boxed{
\text{Categorical factor(s)}
+
\text{continuous covariate(s)}
\rightarrow
\text{ANCOVA}
}
$$

The most important conceptual distinction is:

> **ANOVA compares groups defined by categorical factors.**

> **ANCOVA compares groups while also accounting for one or more continuous explanatory variables.**

And underneath all of them is the same bigger idea:

$$
\boxed{
\text{ANOVA and ANCOVA are both linear models.}
}
$$

ANOVA is not fundamentally separate from linear regression. The categorical variables are represented numerically inside the regression model using indicator/dummy coding.

ANCOVA simply brings the two ideas together:

> **categorical factors + continuous predictors in the same linear model.**

That is why the statement:

> **"ANCOVA is a linear regression model containing both factor and continuous explanatory variables."**

is correct.

---

# Final takeaway

If only a few things are remembered, remember these:

1. **The outcome in classical ANOVA/ANCOVA is continuous.**
2. **A factor is categorical.**
3. **The "way" in ANOVA counts categorical factors.**
4. **One categorical factor → one-way ANOVA.**
5. **Two categorical factors → two-way ANOVA.**
6. **Three categorical factors → three-way ANOVA.**
7. **Categorical factor(s) + continuous covariate(s) → ANCOVA.**
8. **A covariate is a variable included to help account for variation in the outcome when estimating the effect of interest.**
9. **"Adjusting for $X$" means comparing groups while accounting for differences in $X$ — often thought of as comparing the groups at the same value of $X$.**
10. **ANOVA, ANCOVA and ordinary linear regression belong to the same general linear modelling framework.**

The shortest possible summary is:

> **ANOVA: categorical predictor(s).**  
> **ANCOVA: categorical predictor(s) + continuous covariate(s).**  
> **Both are linear models.**
