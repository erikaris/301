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

- Shapiro–Wilk $p \lt 0.05$: evidence against exact normality.
- Shapiro–Wilk $p\geq0.05$: insufficient evidence against normality; **not** proof of normality.
- Skewness and excess kurtosis between $-1$ and $+1$ are informal guidelines, not a formal normality criterion.

**Key point:** A significant normality test does not automatically rule out a parametric method. Check the size and nature of the departure and the assumptions of the intended analysis.

## 3. Central Limit Theorem

Under suitable conditions, the sampling distribution of a mean becomes approximately normal as sample size grows:

$$
\operatorname{SE}(\bar{X})=\frac{\sigma}{\sqrt{n}}.
$$

The theorem does **not** say that individual observations become normal, or that every parametric test is valid whenever $n \gt 30$.

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

**Correlation reporting:** Give $n$, the coefficient (such as $r=0.58$), a 95% CI and the p-value. Labels such as "weak" or "moderate" are conventions, not universal clinical cut-offs. Correlation does not imply causation.

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

**Correlation:** paired $n$, Pearson's $r$ or Spearman's $\rho$, 95% CI, p-value.

**Two-group comparison:** group $n$, mean (SD), mean difference (95% CI), selected t-test, degrees of freedom, p-value and effect size.

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


## 10. Questions and answers

The questions below are paraphrased from the appointment topics, rather than presented as verbatim quotations. FHS/non-FHS is retained as a study label because its full meaning has not been confirmed. All numerical examples are hypothetical.

### Q1. Are bell-shaped histograms and skewness/kurtosis between -1 and +1 enough to conclude that the subscales are normally distributed?

**Answer:** They provide reassuring descriptive evidence, but do not prove normality. Check Q–Q plots and unusual observations as well. A significant Shapiro–Wilk test can detect minor deviations with large samples. More importantly, assess the assumptions of the *planned analysis* rather than requiring every questionnaire score to be perfectly normal.

### Q2. If Shapiro–Wilk is significant, must the analysis become non-parametric?

**Answer:** No. Inspect the size and pattern of deviation. For Pearson correlation, examine linearity, influential outliers, independence and inferential assumptions. For a two-group mean comparison, inspect each group's distribution and outliers. Mild non-normality does not automatically invalidate these analyses.

### Q3. Does the Central Limit Theorem mean that a sample larger than 30 is normal? Is N = 326–337 enough to justify parametric tests?

**Answer:** No. The CLT concerns the *sampling distribution of a mean* under suitable conditions, not the distribution of individual scores. A large sample often improves the robustness of mean-based inference, but does not guarantee valid correlation inference or eliminate problems from clustering, outliers or nonlinear relationships.

### Q4. Should Pearson or Spearman be used for correlations between CEBQ and AEBQ subscales?

**Answer:** If the scores are suitable quantitative measures and the scatterplot shows an approximately linear relationship without influential outliers, Pearson is a reasonable choice. Spearman is useful for monotonic but nonlinear relationships, ranked outcomes, or as a sensitivity analysis. The choice should reflect the research question and data, not whichever p-value is smaller.

### Q5. If Pearson and Spearman produce different results, should both be reported?

**Answer:** First investigate the reason: nonlinearity, outliers, ties, or restricted ranges. Report the prespecified primary method and, when informative, a clearly labelled sensitivity analysis. Explain material differences rather than treating significance as the selection criterion.

### Q6. Can Evans' thresholds be used to describe correlation strength? Are they reliable?

**Answer:** They can be used as a *descriptive convention*, provided the source is cited and the labels are not treated as universal scientific boundaries. The actual coefficient and its confidence interval are more informative. For example, correlations of $0.39$ and $0.40$ are practically similar even if categorised differently.

| Absolute correlation | Evans-style descriptive label |
|---|---|
| 0.00–0.19 | Very weak |
| 0.20–0.39 | Weak |
| 0.40–0.59 | Moderate |
| 0.60–0.79 | Strong |
| 0.80–1.00 | Very strong |

### Q7. Which independent-samples t-test p-value should go into Table 3: 'equal variances assumed' or 'equal variances not assumed'?

**Answer:** Report the p-value from the test chosen for the analysis. In standard SPSS output, **equal variances assumed** is the pooled-variance Student's t-test, while **equal variances not assumed** is Welch's t-test. Levene's test assesses evidence of unequal variances, but selecting a row solely from a Levene p-value is not compulsory. Welch's is often a defensible default, especially with unequal group sizes and possible variance differences. Report which test was used consistently, together with the mean difference and 95% CI.

### Q8. Does the smaller FHS group ($n=43$) mean the t-test is invalid or that non-significant findings are due to low power?

**Answer:** Not automatically. Unequal group sizes do not invalidate a two-group comparison. They can reduce precision, particularly if the smaller group is variable. Examine the FHS distribution and outliers, use an appropriate variance assumption, and interpret the confidence interval. A non-significant p-value does not prove that low power caused the result. Future sample-size planning can use a substantively meaningful difference and plausible variability.

### Q9. What does Cohen's d tell us? Does a small, medium or large d indicate clinical significance?

**Answer:** Cohen's $d$ is the difference between two group means expressed in standard-deviation units:

$$
d = \frac{\bar{X}_1 - \bar{X}_2}{s_p}
$$

Benchmarks of about $0.20$, $0.50$ and $0.80$ are generic descriptive conventions, **not clinical-importance thresholds**. Clinical relevance requires subject-matter justification, preferably an established meaningful difference on the questionnaire scale. Report the raw mean difference and 95% CI as well.

### Q10. If the t-test is non-significant but Cohen's d is not zero, what should be concluded?

**Answer:** The estimate can be non-zero while its uncertainty includes zero. For example, a hypothetical mean difference of $0.18$ with 95% CI $[-0.06, 0.42]$ is compatible with no difference *and* some positive differences. Do not claim equivalence or absence of effect merely because $p \geq 0.05$.

### Q11. Should Table 3's footnote discuss Cohen's d, the small FHS sample, lack of power and the need for future larger studies?

**Answer:** Keep the **table note** factual and short: define abbreviations, the direction of the mean difference, the statistical test, the confidence interval and the effect-size measure. Put limitations about group imbalance, precision and future sample sizes in the **Discussion**, not a long table note. Do not claim inadequate power without supporting analysis.

**Example table note:** "Values are mean (SD). Mean difference is FHS minus non-FHS. Two-sided Welch's t-tests were used; 95% confidence intervals are shown. Cohen's d is the pooled-SD standardised mean difference." Adapt this to the actual method used.

### Q12. What else should be checked before finalising the analyses?

**Answer:** Confirm the meaning of FHS, scoring rules for CEBQ/AEBQ, whether observations are independent (including any family clustering), why valid sample sizes vary between 326 and 337, and whether multiple testing needs adjustment. These design and reporting issues can matter more than a significant normality test.
