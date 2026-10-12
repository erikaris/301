# Statistics Tutorial: Normality, Correlation, t-tests and Effect Sizes

## 1. Match the question to the method

| Research question | Typical method |
|---|---|
| Are two quantitative variables associated? | Pearson or Spearman correlation |
| Do two independent groups have different mean scores? | Independent-samples t-test |
| How large is a group difference? | Mean difference and effect size |
| How precise is an estimate? | Confidence interval |

## 2. Normality

A normal distribution is approximately symmetric and bell-shaped. Assess it using histograms, Q–Q plots, skewness, excess kurtosis, and sometimes a Shapiro–Wilk test.

- Shapiro–Wilk $p<0.05$: evidence against exact normality.
- Shapiro–Wilk $p\geq0.05$: insufficient evidence against normality; **not** proof of normality.
- Skewness and excess kurtosis between $-1$ and $+1$ are informal guidelines, not a formal normality criterion.

**Key point:** A significant normality test does not automatically rule out a parametric method. Check the size and nature of the departure and the assumptions of the intended analysis.

## 3. Central Limit Theorem

Under suitable conditions, the sampling distribution of a mean becomes approximately normal as sample size grows:

$$
\operatorname{SE}(\bar{X})=\frac{\sigma}{\sqrt{n}}.
$$

The theorem does **not** say that individual observations become normal, or that every parametric test is valid whenever $n>30$.

## 4. Pearson versus Spearman correlation

| Pearson | Spearman |
|---|---|
| Describes linear association | Describes monotonic association |
| Uses original numerical scores | Uses ranks |
| Can be strongly affected by outliers | Usually less affected by extreme numerical values |

For Pearson, check quantitative scoring, approximately linear association, influential outliers, independent observational pairs and suitable inference. Marginal normality is not necessary simply to compute Pearson's $r$.

If Pearson and Spearman disagree, inspect the scatterplot and investigate why. Do not select whichever method produces a smaller p-value.

```r
plot(x, y)                                  # Inspect relationship and outliers
cor.test(x, y, method = "pearson")          # Linear correlation
cor.test(x, y, method = "spearman", exact = FALSE) # Rank correlation
```

**Correlation reporting:** Give $n$, the coefficient (such as $r=0.58$), a $95\%$ CI and the p-value. Labels such as "weak" or "moderate" are conventions, not universal clinical cut-offs. Correlation does not imply causation.

## 5. Independent-samples t-test

Used to compare means from two independent groups.

Check independence, appropriate quantitative scores, group distributions and influential outliers.

- **Student's pooled-variance t-test:** assumes equal population variances.
- **Welch's t-test:** does not assume equal population variances; often a useful default when group sizes or variances differ.

In standard SPSS independent-samples t-test output, *Equal variances assumed* corresponds to Student's test and *Equal variances not assumed* corresponds to Welch's test.

```r
# Assumes a data frame called data with numeric score and a two-level group
t.test(score ~ group, data = data, var.equal = TRUE)  # Pooled Student's test
t.test(score ~ group, data = data, var.equal = FALSE) # Welch's test
```

## 6. Effect size: Cohen's d

Cohen's $d$ is a standardised difference between two means:

$$
d=\frac{\bar{X}_1-\bar{X}_2}{s_p},
$$

where $s_p$ is the pooled standard deviation. Conventional reference values are $0.20$ (small), $0.50$ (medium) and $0.80$ (large). These are **not clinical-importance thresholds**.

Report the raw mean difference and its confidence interval as well as an appropriately defined standardised effect size.

## 7. What if $p\geq0.05$ but the effect size is not zero?

A non-significant p-value does not prove that the population difference is zero. Look at the confidence interval: does it include negligible and potentially meaningful effects? A small group can limit precision, but non-significance alone does not prove insufficient power.

## 8. Recommended reporting

**Correlation:** paired $n$, Pearson's $r$ or Spearman's $\rho$, $95\%$ CI, p-value.

**Two-group comparison:** group $n$, mean (SD), mean difference ($95\%$ CI), selected t-test, degrees of freedom, p-value and effect size.

Consider missing data, dependent observations (e.g. multiple participants from the same family), and adjustments when conducting several related hypothesis tests.

## 9. Practical checklist

- [ ] Confirm the research question and measurement scales.
- [ ] Confirm whether observations are independent.
- [ ] Inspect distributions, scatterplots and influential observations.
- [ ] Select Pearson/Spearman based on the association being investigated.
- [ ] Select the appropriate independent-samples t-test for group means.
- [ ] Report estimates, confidence intervals and p-values.
- [ ] Interpret effect sizes in context rather than treating them as clinical cut-offs.
- [ ] Consider missing data and multiple comparisons.
