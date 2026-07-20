# Comparing Two Groups — Tutoring Reference

## Step 1: Ask these questions first
1. **Independent or paired?**
   - Independent: two different sets of subjects/units in each group
   - Paired: same subjects measured twice (before/after, two conditions)
2. **What's the outcome variable?** Continuous, count, proportion, ordinal?
3. **Roughly how many observations per group?** (affects test choice for small n)
4. **What's the actual research question?** ("Are the groups different?" vs "how much different?")

## Step 2: Decision tree

**First branch on Q1 (independent vs paired), then on Q2 (outcome type).**

```
Q1: Independent or paired?
│
├── INDEPENDENT (two different sets of subjects/units)
│   │
│   ├─ Q2: Outcome is CONTINUOUS
│   │   ├─ Residuals ~normal, variances similar (Levene p>.05)
│   │   │     → Independent-samples t-test
│   │   ├─ Residuals ~normal, variances unequal (Levene p<.05)
│   │   │     → Welch's t-test
│   │   └─ Residuals not normal / small n (n<~15 per group)
│   │         → Mann-Whitney U test (rank-based)
│   │
│   ├─ Q2: Outcome is ORDINAL (ranked categories, e.g. Likert scale)
│   │     → Mann-Whitney U test
│   │     (means aren't meaningful for ordinal data — always rank-based here,
│   │      regardless of sample size)
│   │
│   ├─ Q2: Outcome is CATEGORICAL / COUNT (e.g. pass/fail, choice A vs B)
│   │   ├─ Expected cell counts all ≥5 → Chi-square test of independence
│   │   └─ Any expected cell count <5 (small n) → Fisher's exact test
│   │
│   └─ Q2: Outcome is a RATE/PROPORTION with covariates to control for
│         → Logistic regression (binary outcome) or Poisson/GLM (count
│           outcome) instead of a simple two-sample test
│
└── PAIRED (same subjects/units measured twice, e.g. before/after)
    │
    ├─ Q2: Outcome is CONTINUOUS
    │   ├─ Differences (A − B) ~normal → Paired t-test
    │   └─ Differences not normal / small n → Wilcoxon signed-rank test
    │
    ├─ Q2: Outcome is ORDINAL
    │     → Wilcoxon signed-rank test
    │
    ├─ Q2: Outcome is CATEGORICAL (binary, e.g. yes/no before vs after)
    │     → McNemar's test
    │
    └─ Q2: Outcome is a COUNT with repeated measures / covariates
          → Repeated-measures GLM / mixed model instead of a simple test
```

**Sample size rule of thumb (applies across all branches above):**
- Small n (roughly <15 per group, or <10 pairs) → normality is hard to check
  reliably and parametric tests are less robust → default to the
  non-parametric option (Mann-Whitney / Wilcoxon / Fisher's) unless there's
  strong reason (e.g. known population) to assume normality.
- Larger n → Central Limit Theorem gives some robustness to mild non-normality,
  so parametric tests (t-test) are usually fine even if residuals aren't
  perfectly normal.
- Very small n either way (e.g. n<5 per group) → results will be
  underpowered regardless of test chosen. Options for handling this:
  - **Exact tests**: use the exact (not asymptotic) version of the test where
    available — Fisher's exact test for categorical data, or the exact
    variant of Mann-Whitney/Wilcoxon for continuous/ordinal data (e.g.
    `scipy.stats.mannwhitneyu(..., method="exact")`). These compute the
    p-value from the actual permutation distribution of the data rather than
    a large-sample approximation, so they remain valid at small n.
  - **Descriptive statistics + CI**: report the mean (or median) of each
    group, the difference between them, and a confidence interval for that
    difference — a range of plausible values for the true difference, at a
    chosen confidence level (typically 95%). This is reported alongside, or
    sometimes instead of, a formal hypothesis test, since a CI at small n
    will usually be wide enough on its own to show the estimate is
    imprecise, which is informative in itself.
  - **Bootstrap CI**: a CI for the difference calculated by resampling the
    observed data (with replacement) thousands of times, recomputing the
    difference each time, and taking the 2.5th/97.5th percentiles of that
    distribution as the interval bounds. It doesn't assume normality, which
    makes it a useful supplement — or alternative — to a t-test-based CI when
    n is small and the normality assumption is shaky.
  - Both exact tests and bootstrap CIs address the *validity* of the p-value/CI
    at small n, but neither fixes low statistical power — a genuine effect
    can still go undetected with too few observations. This is a design
    limitation to note explicitly in the write-up.

## Step 2b: Match the test to the actual research question

The tree above answers *"is there a difference?"* On its own that's often not
enough — check what the student actually wants to know:

| Research question | What to report / add |
|---|---|
| "Is there a difference at all?" | p-value from the appropriate test above |
| "How big is the difference?" | Effect size (Cohen's d / rank-biserial r) + CI for the difference — the test alone doesn't answer this |
| "Is the difference large enough to matter practically?" | Compare CI/effect size against a pre-defined meaningful threshold, not just p<0.05 |
| "Which direction / does group A outperform B?" | One-tailed vs two-tailed test — but only justify one-tailed if there's a genuine prior directional hypothesis |
| "Can I predict outcome from group + other variables?" | Move beyond a simple two-group test into regression/GLM (see covariate branches above) |

Key teaching point: significance (p-value) answers "is there a difference,"
while effect size + CI answers "how much" — a student asking about
"differentiating between 2 groups" is often really after both, so it's worth
asking them directly which one matters more for their write-up.

**Quick summary table**

| Outcome type | Independent samples | Paired samples |
|---|---|---|
| Continuous, normal residuals, equal variance | Independent t-test | Paired t-test |
| Continuous, normal residuals, unequal variance | Welch's t-test | — |
| Continuous, non-normal / small n | Mann-Whitney U | Wilcoxon signed-rank |
| Ordinal | Mann-Whitney U | Wilcoxon signed-rank |
| Categorical / binary | Chi-square (or Fisher's if small n) | McNemar's test |
| Count/rate with covariates | Poisson/GLM or logistic regression | Repeated-measures GLM |

## Step 3: Key conceptual point (worth emphasising)
A two-group t-test is mathematically a **special case of linear regression**
with one binary (dummy-coded) predictor. This connects directly to prior
linear model work:

- Model: `outcome ~ group`
- The t-test's "normality assumption" is about the **residuals** (or, for a
  paired test, the **differences**) — not the raw outcome values split by
  group.
- Checking residual normality: fit the model, extract residuals, then
  QQ-plot / Shapiro-Wilk on those residuals — same procedure as for
  multi-group ANOVA/regression work.

## Step 4: Assumption checks (in order)
1. **Independence of observations** — design question, not testable from data
2. **Normality of residuals (or differences, if paired)** — QQ plot, Shapiro-Wilk
3. **Homogeneity of variance** (independent case only) — Levene's test
   - If violated → use Welch's t-test (unequal variances), not standard t-test
4. If assumptions fail badly → non-parametric alternative (Mann-Whitney / Wilcoxon)

## Step 5: Reporting results
Always report together, not p-value alone:
- Mean difference (or median difference for non-parametric)
- Confidence interval for the difference
- Effect size: **Cohen's d** = (mean1 − mean2) / pooled SD
  - ~0.2 small, ~0.5 medium, ~0.8 large (rule of thumb, not gospel)
- p-value

## Step 5b: Assumption-checking script

Run this before choosing/running the actual test — it checks normality of
residuals (independent case) or differences (paired case), plus variance
equality for the independent case.

```python
import scipy.stats as stats
import numpy as np
import matplotlib.pyplot as plt

# group_a, group_b = arrays/lists of observations

def check_assumptions_independent(group_a, group_b):
    """Assumption checks for an independent two-group comparison."""
    group_a, group_b = np.asarray(group_a), np.asarray(group_b)

    # 1. Normality of residuals: for each group, residual = value - group mean
    resid_a = group_a - group_a.mean()
    resid_b = group_b - group_b.mean()
    residuals = np.concatenate([resid_a, resid_b])

    shapiro_stat, shapiro_p = stats.shapiro(residuals)
    print(f"Shapiro-Wilk on residuals: W={shapiro_stat:.3f}, p={shapiro_p:.4f}")
    print("  -> residuals look normal" if shapiro_p > 0.05
          else "  -> residuals deviate from normal (consider Mann-Whitney U)")

    # 2. QQ plot of residuals (visual check, more reliable for small n)
    stats.probplot(residuals, dist="norm", plot=plt)
    plt.title("QQ plot of residuals")
    plt.show()

    # 3. Equality of variance
    levene_stat, levene_p = stats.levene(group_a, group_b)
    print(f"Levene's test: stat={levene_stat:.3f}, p={levene_p:.4f}")
    print("  -> variances similar, use standard t-test" if levene_p > 0.05
          else "  -> variances differ, use Welch's t-test")

    return {"shapiro_p": shapiro_p, "levene_p": levene_p}


def check_assumptions_paired(group_a, group_b):
    """Assumption checks for a paired two-group comparison."""
    group_a, group_b = np.asarray(group_a), np.asarray(group_b)
    diffs = group_a - group_b

    shapiro_stat, shapiro_p = stats.shapiro(diffs)
    print(f"Shapiro-Wilk on differences: W={shapiro_stat:.3f}, p={shapiro_p:.4f}")
    print("  -> differences look normal, use paired t-test" if shapiro_p > 0.05
          else "  -> differences not normal, use Wilcoxon signed-rank test")

    stats.probplot(diffs, dist="norm", plot=plt)
    plt.title("QQ plot of paired differences")
    plt.show()

    return {"shapiro_p": shapiro_p}
```

**Reading the output with the student:**
- Shapiro-Wilk p > 0.05 → fail to reject normality → parametric test okay
- Shapiro-Wilk p < 0.05 → evidence against normality → lean non-parametric
- Note: Shapiro-Wilk is underpowered at small n (may not flag real
  non-normality) and overpowered at large n (flags trivial deviations) —
  always look at the QQ plot too, not just the p-value
- Levene's p > 0.05 → variances similar → standard t-test
- Levene's p < 0.05 → variances differ → Welch's t-test

## Step 6: Worked example (generic, adaptable)
**Scenario:** Comparing a continuous outcome between two independent groups
(e.g., completion time between two interface designs).

```python
import scipy.stats as stats
import numpy as np

# group_a, group_b = arrays of observations

# 1. Check variance equality
levene_stat, levene_p = stats.levene(group_a, group_b)

# 2. Choose test based on Levene's result
if levene_p > 0.05:
    t_stat, p_val = stats.ttest_ind(group_a, group_b, equal_var=True)
else:
    t_stat, p_val = stats.ttest_ind(group_a, group_b, equal_var=False)  # Welch's

# 3. Effect size (Cohen's d)
def cohens_d(a, b):
    pooled_sd = np.sqrt(((len(a)-1)*np.var(a, ddof=1) + (len(b)-1)*np.var(b, ddof=1))
                         / (len(a) + len(b) - 2))
    return (np.mean(a) - np.mean(b)) / pooled_sd

d = cohens_d(group_a, group_b)
```

**Paired version:**
```python
diffs = group_a - group_b  # same subjects, two conditions
shapiro_stat, shapiro_p = stats.shapiro(diffs)

if shapiro_p > 0.05:
    t_stat, p_val = stats.ttest_rel(group_a, group_b)
else:
    w_stat, p_val = stats.wilcoxon(group_a, group_b)
```

## Step 7: Visualisation
Error bar plot (mean ± SE or ± 95% CI) is the standard way to show a two-group
comparison — same style used for ANOVA group comparisons, just with two bars
instead of several.

## Common misconceptions to watch for
- Thinking normality applies to the *raw grouped data* rather than residuals/differences
- Running independent t-test on paired data (inflates apparent significance)
- Reporting p-value with no effect size or CI
- Assuming "not significant" = "no difference" (underpowered studies)
