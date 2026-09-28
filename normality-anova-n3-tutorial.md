# Normality, Equal Variances, and ANOVA When You Only Have Three Replicates

## TL;DR

If you're running ANOVA on biological data with only three replicates per group, here's the short version: normality tests barely have any power at n=3, so a "pass" doesn't mean your data are normal, it usually just means the test never had a real chance to catch a problem. When a normality test and a variance test disagree, don't flip a coin: lean on the test that doesn't itself assume normality (Levene's, not Bartlett's). And for the actual group comparison, Welch's ANOVA is the safer everyday default over standard ANOVA when you're this unsure about equal variances, with Kruskal-Wallis kept in reserve for data that are clearly, visibly non-normal rather than reached for automatically just because your sample size is small.

## The situation

Anyone running ANOVA on small biological datasets runs into some version of this: every group has just **three biological repeats (n=3)**. That number, three, does a lot of work, because it sits right at the edge of what classical statistical tests can handle. Three linked questions tend to come up, and they build on each other:

1. How does having only n=3 per group affect the validity and power of normality tests like Shapiro-Wilk? **Answer:** it wrecks their power. At n=3, Shapiro-Wilk almost never detects non-normality even when it's really there (a simulation below catches it only 7% of the time), so a "pass" is not proof the data are normal, just a test with no real chance to fail.
2. When the normality test and the homogeneity-of-variance (homoscedasticity) test disagree on the same dataset, which one should guide the choice of analysis? **Answer:** neither one blindly, use judgement. But between the two common variance tests specifically, trust Levene's over Bartlett's when normality is uncertain, since Bartlett's own result depends on the normality assumption that's in question.
3. Given all this, which test is actually the most appropriate: standard ANOVA, a variant of ANOVA, or a non-parametric alternative? **Answer:** Welch's ANOVA, as the everyday default when variances might be unequal. Standard ANOVA is riskier here because it assumes equal variances; Kruskal-Wallis should be kept for clearly non-normal data, not used automatically just because n is small.

## Core idea to land first

With only three data points per group, a normality test almost never has the power to catch non-normality, even when it's really there. So a non-significant Shapiro-Wilk result at n=3 isn't evidence that your data are normal. Most of the time it just means the test never had a real chance of flagging anything in the first place ([Towards Data Science](https://towardsdatascience.com/stop-testing-for-normality-dba96bb73f90/)). What this means in practice: don't let a single test's p-value make this decision for you. Combine it with a visual check and a bit of reasoning about what you're actually measuring.

## 1. Why n=3 breaks normality testing

Think about what a normality test is actually trying to do: tell the difference between "this looks a bit odd just by chance" and "this is genuinely not normally distributed." That's a hard job with only three numbers to work from. Three points can almost always be explained away by *some* normal curve, so the test simply doesn't have much statistical power to work with.

### Demonstration: simulated power of Shapiro-Wilk

Data were drawn 5000 times from a clearly non-normal distribution (exponential, i.e. strongly skewed) at three sample sizes, and the proportion of samples in which Shapiro-Wilk correctly flagged non-normality (p < 0.05) was recorded.

```
n=3:  detects non-normality in 7.0% of samples
n=10: detects non-normality in 45.5% of samples
n=30: detects non-normality in 97.1% of samples
```

Look at what happened here: the underlying data were genuinely, strongly non-normal in every single one of the 5000 simulated samples, and yet Shapiro-Wilk only caught it 7% of the time at n=3. That's barely better than a coin flip catching it by accident. This is the single most important point to take away: a non-significant Shapiro-Wilk at n=3 tells you almost nothing, a pattern well documented outside formal papers too ([Towards Data Science](https://towardsdatascience.com/stop-testing-for-normality-dba96bb73f90/)).

R code for the demonstration (each line commented):

```r
set.seed(1)  # fix the random seed so the simulation is reproducible

sim_power <- function(n, nsim = 5000) {
  # replicate() repeats the block inside {} nsim times and collects the results
  rejects <- replicate(nsim, {
    x <- rexp(n)                     # draw n values from an exponential distribution (skewed, non-normal)
    shapiro.test(x)$p.value < 0.05   # TRUE if Shapiro-Wilk correctly detects non-normality at alpha = 0.05
  })
  mean(rejects)  # proportion of the 5000 simulated samples where non-normality was correctly detected = empirical power
}

p3  <- sim_power(3)   # statistical power of the test at n=3
p10 <- sim_power(10)
p30 <- sim_power(30)
```

## 2. Worked example: 3 groups, n=3 each

### Dummy dataset

```
   group      response
1  Control     5.10
2  Control     5.45
3  Control     4.98
4  TreatmentA  7.85
5  TreatmentA  8.20
6  TreatmentA  7.40
7  TreatmentB  6.30
8  TreatmentB  9.10
9  TreatmentB  5.95
```

Group means and SDs:

```
       group response.mean response.sd
1    Control     5.177       0.244
2 TreatmentA     7.817       0.401
3 TreatmentB     7.117       1.727
```

Note TreatmentB has one higher value (9.10) than its two replicates, a realistic pattern in biology (one replicate behaves oddly) that inflates its variance relative to the other two groups. This was built in deliberately so normality and homogeneity tests can be compared on a dataset that stresses both.

### R code, full pipeline, one line at a time

```r
set.seed(2026)  # reproducibility

# Build the dataset: 3 groups, 3 biological repeats each (9 rows total)
group <- factor(rep(c("Control", "TreatmentA", "TreatmentB"), each = 3))
response <- c(
  5.10, 5.45, 4.98,      # Control replicates
  7.85, 8.20, 7.40,      # TreatmentA replicates
  6.30, 9.10, 5.95       # TreatmentB replicates (note the outlying 9.10)
)
dat <- data.frame(group, response)  # combine into one data frame, the standard R shape for ANOVA

# Fit the one-way ANOVA model once, so its residuals can be reused for diagnostics
mod <- aov(response ~ group, data = dat)   # response modelled as a function of group
```

#### Step A: normality, per group vs on residuals

```r
# Per-group Shapiro-Wilk (what most people try first)
for (g in levels(dat$group)) {          # loop over each of the 3 group labels
  x <- dat$response[dat$group == g]     # subset the 3 values belonging to that group
  st <- shapiro.test(x)                 # run Shapiro-Wilk on just those 3 points
  cat(sprintf("%s: W = %.3f, p = %.3f\n", g, st$statistic, st$p.value))
}
```

Output:
```
Control:    W = 0.926, p = 0.474
TreatmentA: W = 0.995, p = 0.862
TreatmentB: W = 0.832, p = 0.194
```

```r
# The more defensible approach: test normality of the RESIDUALS of the fitted model,
# not each group separately. ANOVA's normality assumption is about the residuals, and
# pooling residuals across all groups gives more data points (n=9 instead of n=3) to test.
shapiro.test(residuals(mod))
```

Output:
```
W = 0.90116, p-value = 0.2588
```

None of these tests reject normality here, but given what you just saw about power, that's weak evidence at best, even after pooling to n=9. The residuals-based version above is the more defensible one to lean on: the normality assumption in ANOVA is really about the residuals of the fitted model, not each group's raw values checked one at a time ([The Analysis Factor](https://www.theanalysisfactor.com/checking-normality-anova-model/)). Pair that result with a QQ plot (`qqnorm(residuals(mod)); qqline(residuals(mod))`) and a dose of judgement: ask yourself whether the thing you're measuring is plausibly normal (most continuous physiological measurements are; most counts or proportions aren't), rather than resting the whole decision on one p-value.

#### Step B: homogeneity of variance, two tests that can disagree

```r
# Levene's test (median-centred), implemented in base R since the `car` package is not
# always installed. Levene's test is a robust choice because it does not itself assume
# normality of the raw data.
levene_test <- function(y, group) {
  group <- factor(group)
  # for each observation, compute |value - median of its own group|
  centered <- ave(y, group, FUN = function(x) abs(x - median(x)))
  # an ANOVA on these absolute deviations tests whether spread differs by group
  fit <- lm(centered ~ group)
  anova(fit)
}
levene_test(dat$response, dat$group)

# Bartlett's test: the classical alternative, but IT ASSUMES the raw data are normal,
# which is exactly the assumption already in question here.
bartlett.test(response ~ group, data = dat)
```

Output:
```
Levene's test (median-based):
          Df Sum Sq Mean Sq F value Pr(>F)
group      2 1.4238 0.71188  0.8843 0.4607
Residuals  6 4.8299 0.80499

Bartlett's test:
Bartlett's K-squared = 6.1356, df = 2, p-value = 0.04652
```

Here's exactly the kind of disagreement that shows up in practice: Levene says p = 0.46 (variances look fine), Bartlett says p = 0.047 (variances look significantly different). That's not a contradiction you resolve by picking whichever answer you like better, it comes down to the two tests making different assumptions. Bartlett's test is well known to be highly sensitive to non-normality, so when normality is uncertain (as it always is at n=3), Bartlett's p-value becomes unreliable, and a single unusual replicate, TreatmentB's 9.10 here, can trigger a false alarm rather than reflect a genuine difference in spread. Levene's test holds up much better under exactly that kind of uncertainty ([Datanovia](https://www.datanovia.com/en/lessons/homogeneity-of-variance-test-in-r/)). The teaching takeaway: when normality is in doubt, trust Levene over Bartlett, and don't treat either p-value alone as the final word at this sample size, look at the group standard deviations directly (0.24, 0.40, 1.73 above) and ask whether a 7x difference in spread is biologically plausible.

#### Step C: the actual group comparison, three candidate tests, side by side

```r
# 1. Standard one-way ANOVA: assumes normal residuals AND equal variances across groups
summary(mod)

# 2. Welch's ANOVA: same null hypothesis (are the group means equal?) but does NOT
#    assume equal variances -- recommended whenever homogeneity is doubtful, as here
oneway.test(response ~ group, data = dat, var.equal = FALSE)

# 3. Kruskal-Wallis: a non-parametric alternative that replaces raw values with their
#    ranks, so it does not assume normality OR any particular distribution shape at all
kruskal.test(response ~ group, data = dat)
```

Output:
```
Standard ANOVA:
            Df Sum Sq Mean Sq F value Pr(>F)
group        2 11.223   5.612   5.259 0.0479 *
Residuals    6  6.403   1.067

Welch's ANOVA:
F = 40.186, num df = 2.000, denom df = 3.358, p-value = 0.004516

Kruskal-Wallis:
chi-squared = 5.6, df = 2, p-value = 0.06081
```

So what do you do with three disagreeing answers? Standard ANOVA sits right at the edge of significance (p = 0.048), and it's actually the least trustworthy of the three here, because it explicitly assumes the equal variances that Bartlett's test is questioning. Welch's ANOVA, which doesn't need that assumption, gives the strongest and most defensible result (p = 0.0045). Kruskal-Wallis, which throws away the actual values and only uses ranks, isn't significant at n=9 (p = 0.061), with just three points per group there simply aren't enough possible rank orderings for it to have much power. That's the practical answer to "which test is most appropriate": for small, possibly-unequal-variance groups, Welch's ANOVA is generally the safer everyday default over standard ANOVA ([Statistics By Jim](https://statisticsbyjim.com/anova/welchs-anova-compared-to-classic-one-way-anova/)), and Kruskal-Wallis is best kept in reserve for when non-normality is clear and visible rather than reached for automatically just because n is small ([Minitab Support](https://support.minitab.com/en-us/minitab/help-and-how-to/statistics/nonparametrics/how-to/kruskal-wallis-test/before-you-start/data-considerations/)).

```r
# Post-hoc pairwise comparisons if the omnibus test (ANOVA or Welch) is significant
TukeyHSD(mod)
```

Output:
```
                       diff         lwr      upr     p adj
TreatmentA-Control     2.64  0.05207831 5.227922 0.0463493
TreatmentB-Control     1.94 -0.64792169 4.527922 0.1317417
TreatmentB-TreatmentA -0.70 -3.28792169 1.887922 0.6997787
```

Note: `TukeyHSD` also assumes equal variances (it is the post-hoc test that pairs with standard ANOVA). If Welch's ANOVA is used as the main test, the matching post-hoc is `pairwise.t.test(..., pool.sd = FALSE)` or Games-Howell, not Tukey HSD.

## 3. Decision framework

1. Start by just looking at the data: plot it as a strip or dot plot showing all three points per group, not a bar chart hiding them behind an average. Ask yourself whether the thing you're measuring has any plausible reason to be skewed, bounded, or count-like, biological reasoning beats a p-value here.
2. Run the normality check on the ANOVA residuals pooled together, not per group, three points per group is too few to test on its own. And treat a non-significant result at this n as inconclusive, not as proof of normality.
3. When normality is uncertain, reach for Levene's test over Bartlett's, since Bartlett's own validity depends on the normality you're not sure about in the first place.
4. Default to Welch's ANOVA (or Welch's t-test for two groups) instead of the standard version whenever variances look even moderately unequal. It costs you almost nothing if variances turn out to be equal after all, and it protects you when they aren't.
5. Save Kruskal-Wallis (or Mann-Whitney for two groups) for when non-normality is clear and visible, strong skew, obvious outliers, ordinal or count data, rather than reaching for it automatically just because n is small. With only three points per group, it has very little power of its own.
6. Whatever you choose, say so plainly in the methods: with n=3 per group, formal normality and homogeneity tests are known to be underpowered, and the choice of test was informed by the tests themselves, the residual diagnostics, and the nature of the measurement, not just one p-value.

## 4. SPSS notes

- Normality: Analyze > Descriptive Statistics > Explore > Plots > tick "Normality plots with tests" gives Shapiro-Wilk plus a QQ plot in one step.
- Homogeneity: Analyze > Compare Means > One-Way ANOVA > Options > tick "Homogeneity of variance test" gives Levene's test directly (SPSS's default there is already the more robust median-based Levene variant).
- Welch's ANOVA: same One-Way ANOVA dialog > Options > tick "Welch", SPSS reports it alongside the standard ANOVA table automatically, useful for showing both side by side.
- Kruskal-Wallis: Analyze > Nonparametric Tests > Legacy Dialogs > K Independent Samples.
- Post-hoc when Welch is used: in the One-Way ANOVA Options, the "Games-Howell" post-hoc test (under Post Hoc, unequal variances section) is the SPSS equivalent of Welch-compatible pairwise comparisons; Tukey is only valid alongside the standard (equal-variance) ANOVA.

## 5. Anticipated follow-up questions

- "Should I just always use Kruskal-Wallis to be safe with n=3?" No: it discards information (exact values become ranks) and has low power at small n; it is not a universally "safer" default, only appropriate when normality is genuinely doubtful.
- "Can I increase n after the fact if my test is not significant?" No, that is a form of optional stopping / p-hacking; sample size should be decided before analysis (or via a pre-registered stopping rule), not based on how the first result looks.
- "What if I have a two-way design with n=3 per cell?" Same logic extends: test normality on the model residuals (more degrees of freedom available), check Levene per factor combination, and consider whether a mixed-effects model is more appropriate if there is a repeated or blocking structure (e.g. batch effects across biological repeats).

## Further reading

1. [Stop Testing for Normality](https://towardsdatascience.com/stop-testing-for-normality-dba96bb73f90/), Towards Data Science. Shows that Shapiro-Wilk can return a non-significant p-value on visibly non-normal small-sample data, because formal normality tests are underpowered to detect major deviations at small n.
2. [Checking the Normality Assumption for an ANOVA Model](https://www.theanalysisfactor.com/checking-normality-anova-model/), The Analysis Factor. Explains that ANOVA's normality assumption concerns the model residuals, not each group's raw data checked in isolation.
3. [Homogeneity of Variance Test in R: Levene & Bartlett](https://www.datanovia.com/en/lessons/homogeneity-of-variance-test-in-r/), Datanovia. Compares the two tests directly: Bartlett's test assumes normal data and is sensitive to departures from it, while Levene's test is robust to non-normality and is generally preferred when that assumption is in doubt.
4. [Benefits of Welch's ANOVA Compared to the Classic One-Way ANOVA](https://statisticsbyjim.com/anova/welchs-anova-compared-to-classic-one-way-anova/), Statistics By Jim. Argues Welch's ANOVA can be used as the default one-way ANOVA, since it controls the false-positive rate correctly whether or not variances are equal, at little cost to power.
5. [Kruskal-Wallis Test: Data Considerations](https://support.minitab.com/en-us/minitab/help-and-how-to/statistics/nonparametrics/how-to/kruskal-wallis-test/before-you-start/data-considerations/), Minitab Support. Notes the test needs a reasonable number of observations per group for reliable results and, like other rank-based tests, generally has less power than the matching parametric test.
