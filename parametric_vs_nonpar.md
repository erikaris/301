# Parametric vs Non-parametric / Ordinal / Paired Tests

* Check this [decision tree](https://raw.githubusercontent.com/erikaris/301/7a22e2dba773be57a89ca85d2ee1f3f8bd3b0707/stats_key.svg).

| **No.** | **Purpose / Data Type** | **Parametric Test (Normal / Interval)** | **Non-parametric / Ordinal / Robust Alternative** | **Notes** | **R script example** | **Scenario & Research Question** | **H₀ and H₁** |
| ------ | ------------------------ | --------------------------------------- | ------------------------------------------------- | --------- | --------------------- | --------------------------------- | ------------- |
| 1 | **One-sample location (interval/ratio)** | One-sample t-test | Wilcoxon signed-rank; Sign test | Wilcoxon assumes symmetric distribution; Sign test works for skewed data. | `t.test(x, mu=0)`<br>`wilcox.test(x, mu=0)` | *Scenario:* Check if mean login time differs from 5min.<br>*RQ:* Is mean login time ≠ 5? | H₀: μ = μ₀<br>H₁: μ ≠ μ₀ |
| 2 | **Two independent samples (interval/ratio, equal variances)** | Independent t-test | Mann–Whitney U; KS | Student t-test assumes equal variances. | `t.test(x,y,var.equal=TRUE)`<br>`wilcox.test(x,y)` | Compare task time between new vs old UI. | H₀: μ₁ = μ₂<br>H₁: μ₁ ≠ μ₂ |
| 3 | **Two independent samples (interval/ratio, unequal variances)** | Welch | Mann–Whitney U; KS | Welch for unequal variances. | `t.test(x,y)` | Compare exam scores between teaching methods. | H₀: μ₁ = μ₂<br>H₁: μ₁ ≠ μ₂ |
| 4 | **Two paired samples** | Paired t-test | Wilcoxon signed-rank; Sign test | Based on paired differences. | `t.test(x,y,paired=TRUE)` | Before vs after stress levels. | H₀: μ_diff = 0<br>H₁: μ_diff ≠ 0 |
| 5 | **≥3 independent groups (equal variances)** | Welch ANOVA → Tukey | Kruskal–Wallis → Dunn | KW tests medians/ranks. | `oneway.test()` | Compare satisfaction across 3 versions. | H₀: μ₁=μ₂=μ₃<br>H₁: At least one differs |
| 6 | **≥3 independent groups (unequal variances)** | One-way ANOVA → G–H | Kruskal–Wallis; permutation | KW tests medians/ranks. | `oneway.test()` | Battery life across 3 devices. | H₀: μ₁=μ₂=μ₃<br>H₁: At least one differs |
| 7 | **Repeated measures (≥3)** | Repeated-measures ANOVA | Friedman | Friedman = rank ANOVA. | `aov(...Error())` | Same users across 3 modes. | H₀: μ₁=μ₂=μ₃<br>H₁: At least one differs |
| 8 | **Two-way factorial** | Two-way ANOVA | ART; SRH | ART handles interactions. | `aov(y ~ A*B)` | Interface × device effects. | H₀: no main effects; no interaction<br>H₁: at least one exists |
| 9 | **ANCOVA** | ANCOVA | Quade; permutation | Covariate-adjusted ranking. | `lm(y ~ g + cov)` | Compare groups controlling for experience. | H₀: adjusted group means equal<br>H₁: differ |
| 10 | **Correlation** | Pearson | Spearman; Kendall | For monotonic relations. | `cor.test()` | Feature use vs retention. | H₀: ρ = 0<br>H₁: ρ ≠ 0 |
| 11 | **Regression coefficients** | t-test for slope | Robust; Theil–Sen | Robust reduces outlier influence. | `lm(y~x)` | Predict satisfaction from response time. | H₀: β₁ = 0<br>H₁: β₁ ≠ 0 |
| 12 | **Goodness-of-fit** | Chi-square | Fisher; permutation | Fisher for small n. | `chisq.test()` | Compare observed vs expected usage. | H₀: observed = expected<br>H₁: differ |
| 13 | **Paired binary data** | — | McNemar | For 2×2 paired. | `mcnemar.test()` | Correct answers pre vs post. | H₀: p_before = p_after<br>H₁: differ |
| 14 | **Ordinal, independent** | — | Mann–Whitney / KW | Rank-based. | `wilcox.test()` | Compare Likert satisfaction. | H₀: distributions equal<br>H₁: differ |
| 15 | **Ordinal, paired** | — | Wilcoxon signed-rank | Median shift. | `wilcox.test(...paired=TRUE)` | Usability rating before/after. | H₀: median_diff = 0<br>H₁: median_diff ≠ 0 |
| 16 | **Normality check** | Shapiro–Wilk, KS | — | If fail → NP tests. | `shapiro.test()` | Check if response times normal. | H₀: data follow normal distribution<br>H₁: not normal |
| 17 | **Two independent proportions (binary)** | Two-proportion z-test | Fisher; Chi-square | Large-sample approx. | `prop.test()` | Compare conversion rates. | H₀: p₁ = p₂<br>H₁: p₁ ≠ p₂ |
| 18 | **Binary outcome w/ predictors** | Logistic regression | — | Models log-odds. | `glm(...binomial)` | Predict signup based on features. | H₀: β predictors = 0<br>H₁: at least one β ≠ 0 |
| 19 | **Survival curve comparison** | Kaplan–Meier + log-rank | — | Compares survival curves. | `survdiff()` | Compare time-to-churn. | H₀: survival curves equal<br>H₁: differ |
| 20 | **Time-to-event regression** | Cox regression | — | Hazard ratio model. | `coxph()` | Predict time to failure. | H₀: β predictors = 0<br>H₁: at least one β ≠ 0 |
