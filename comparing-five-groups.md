# Comparing Five Groups: Five Questions to Ask Before You Pick a Test

Students often arrive with a sentence like "I want to test the significance between five samples." That is a good start, but it does not yet point to one test. Five short questions do. Each one below comes with "if this, then that" scenarios you can follow.

---

## Question 1: What kind of outcome did you measure?

**If it is continuous** (strength, temperature, time, weight):
Go to the ANOVA family. Check the assumptions in Question 3, then choose between standard ANOVA, Welch's ANOVA and Kruskal-Wallis.
*Example: hardness of five alloy mixes.*

**If it is ordinal** (ratings, Likert scales, severity grades):
Use Kruskal-Wallis. The gaps between ranks are not guaranteed to be equal, so means are hard to defend. Follow with Dunn's test.
*Example: satisfaction scored 1 to 5 across five service centres.*

**If it is categorical** (pass/fail, yes/no, category membership):
Use a chi-square test of independence on the 5 x k table. If more than about 20% of expected counts fall below 5, switch to an exact test (Fisher-Freeman-Halton). Follow up with pairwise comparisons using a Holm or Bonferroni correction.
*Example: proportion of components that fail under five coatings.*

**If it is a count** (defects per batch, events per day):
Counts are rarely normal, especially when small. Use Poisson regression, or negative binomial regression if the variance is much larger than the mean.
*Example: number of cracks per weld under five procedures.*

**If it is time until something happens** (time to failure, time to recovery):
Use survival methods, such as the log-rank test across the five groups. Standard ANOVA ignores censored observations.

---

## Question 2: Are the five samples independent or related?

**If different units sit in each group** (five separate sets of specimens, people or machines):
The groups are independent. Use one-way ANOVA or Kruskal-Wallis.

**If the same units were measured under all five conditions:**
The groups are repeated measures. Use repeated-measures ANOVA, or Friedman if the data are non-normal or ordinal. In SPSS, check Mauchly's test of sphericity and use Greenhouse-Geisser if it is violated.
*Example: one sensor tested at five temperatures.*

**If units were matched or blocked** (one specimen from each batch assigned to each condition):
Treat the batch as a block. Use a randomised block design (two-way ANOVA with block as a factor) or Friedman.

**If each unit was measured several times within a single group** (ten readings from each specimen):
The readings are not independent. Treating them as independent is called pseudoreplication and inflates significance. Average within units first, or use a mixed-effects model with unit as a random effect.

**If some repeated measurements are missing:**
Repeated-measures ANOVA drops the whole unit. A mixed-effects model keeps the available data and is usually the better choice.

---

## Question 3: How many observations are in each group?

**If group sizes are roughly equal and moderate (about 15 or more each):**
ANOVA is fairly robust to mild non-normality. Check variances with Levene's test and residuals with a Q-Q plot.

**If group sizes are unequal:**
Unequal sizes make the test more sensitive to unequal variances.
- If variances look similar, use ANOVA with Tukey-Kramer (R's `TukeyHSD` handles this).
- If variances differ, use Welch's ANOVA with Games-Howell. This is the most defensible option.

**If groups are small (below about 5 to 8 each):**
Normality tests have very little power, so a non-significant Shapiro-Wilk result proves little. Use the Q-Q plot, think about what the data-generating process suggests, and consider Kruskal-Wallis or a permutation test. Report effect sizes with confidence intervals, and say plainly that power is limited.

**If groups are very large (hundreds or more):**
Tiny, practically meaningless differences will come out significant. Lead with the effect size and interpret its size in context.

**If the assumptions fail and you are unsure which fallback to use:**
Welch's ANOVA is a sensible default for continuous data. It does not require equal variances and loses little when they are equal.

---

## Question 4: What is the design behind the five groups?

**If it is one factor with five levels** (five materials, five doses):
Use one-way ANOVA or its alternative, as above.

**If the five groups come from crossing two factors** (for example 2 x 2 plus a control):
Two options. Analyse all five as a one-way design and use planned contrasts, or analyse the 2 x 2 part as a two-way ANOVA (checking the interaction first) and compare the control separately. Decide before looking at the data, and say which you chose.

**If the levels are ordered** (increasing dose, temperature or load):
Ask whether the trend is the question. If so, use a linear contrast or trend test (Jonckheere-Terpstra for non-parametric data). This is more powerful than a general "do any groups differ" test.

**If one group is a control or reference:**
See Question 5. Dunnett's test is built for this.

**If other variables could affect the outcome** (batch, operator, initial size):
Include them as covariates (ANCOVA) or blocks. Leaving them out can hide a real effect or create a false one.

---

## Question 5: What do you want to conclude?

**If the goal is "is there any difference at all?":**
The omnibus test answers this. Stop there if nothing else is needed.
- Significant: at least one group differs. It does not say which.
- Not significant: there is no evidence of a difference. That is not the same as evidence of no difference, especially with small samples.

**If the goal is "which groups differ from each other?":**
Run post-hoc tests after a significant omnibus result.
- ANOVA with equal variances: Tukey HSD.
- Unequal variances: Games-Howell.
- Kruskal-Wallis: Dunn's test with Holm.

**If the goal is "which treatments differ from a control?":**
Use Dunnett's test. It makes only 4 comparisons instead of 10, so it has more power than Tukey for this purpose.

**If you had specific comparisons in mind before collecting data:**
Use planned contrasts. They need fewer corrections, but they must be genuinely planned and stated in advance.

**If you are tempted to run all 10 pairwise t-tests instead:**
Do not. At alpha = 0.05 each, the chance of at least one false positive is about 1 - 0.95^10, roughly 40%. Use an omnibus test plus a corrected post-hoc procedure.

---

## Quick decision path for continuous, independent data

1. Check independence in the design.
2. Fit the model and inspect residuals with a Q-Q plot.
3. Run Levene's test.
4. Choose ANOVA, Welch's ANOVA or Kruskal-Wallis.
5. Add the matching post-hoc test.
6. Report the statistic, degrees of freedom, p-value, effect size and a confidence interval.

---

## Appendix A: SPSS steps

**One-way ANOVA (independent groups)**
1. Data format: one column for the outcome, one column for group (coded 1 to 5).
2. `Analyze > Compare Means > One-Way ANOVA`.
3. Outcome into *Dependent List*, group into *Factor*.
4. **Post Hoc**: tick *Tukey*, and *Games-Howell* if variances differ.
5. **Options**: tick *Descriptive*, *Homogeneity of variance test* and *Welch*.
6. If Levene's p > .05, read the standard ANOVA row. Otherwise read the Welch row.
7. Residual normality: `Analyze > General Linear Model > Univariate`, Save standardized residuals, then `Analyze > Descriptive Statistics > Explore > Plots > Normality plots with tests`.

**Kruskal-Wallis**
1. `Analyze > Nonparametric Tests > Independent Samples`.
2. Objective: *Customize analysis*. Outcome as Test Field, group as Groups.
3. Settings > Customize tests > *Kruskal-Wallis 1-way ANOVA (k samples)*, multiple comparisons: *All pairwise*.
4. Double-click the output to see adjusted pairwise p-values.

**Repeated measures**
- RM-ANOVA: `Analyze > General Linear Model > Repeated Measures`. Define a factor with 5 levels and check Mauchly's test.
- Friedman: `Analyze > Nonparametric Tests > Related Samples`.

*Menu labels vary slightly between SPSS versions. Check against the version you use.*

---

## Appendix B: R code

```r
# Long format: columns "value" and "group"
df$group <- factor(df$group)

# Assumptions
fit <- aov(value ~ group, data = df)
shapiro.test(residuals(fit))
qqnorm(residuals(fit)); qqline(residuals(fit))
car::leveneTest(value ~ group, data = df)

# One-way ANOVA + Tukey
summary(fit)
TukeyHSD(fit)

# Welch's ANOVA + Games-Howell
oneway.test(value ~ group, data = df, var.equal = FALSE)
rstatix::games_howell_test(df, value ~ group)

# Effect size
effectsize::eta_squared(fit)

# Kruskal-Wallis + Dunn
kruskal.test(value ~ group, data = df)
rstatix::dunn_test(df, value ~ group, p.adjust.method = "holm")
rstatix::kruskal_effsize(df, value ~ group)

# Control comparison (Dunnett)
# multcomp::glht(fit, linfct = multcomp::mcp(group = "Dunnett"))

# Repeated measures (id = unit)
# rstatix::anova_test(df, dv = value, wid = id, within = group)
# friedman.test(value ~ group | id, data = df)

boxplot(value ~ group, data = df)
```

---

## What to write up

State the test, the assumptions you checked and how, the correction method for multiple comparisons, and the effect size. A reader should be able to repeat your analysis from those four items.
