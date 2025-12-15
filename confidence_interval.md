
# Confidence Intervals — Tutorial Notes

## 1. What is a Confidence Interval?

A **confidence interval (CI)** is a range of values that gives **plausible values** for an unknown population parameter (like a mean, proportion, or effect size) based on sample data.

> **Key idea:** A CI combines an estimate with how uncertain that estimate is.

---

## 2. General Form and Critical Value Explanation

All confidence intervals follow this structure:

[
$\text{Estimate} ;\pm; (\text{critical value}) \times (\text{standard error})$
]

* **Estimate** → our best guess of the true value (mean, proportion, OR, etc.)
* **Standard error** → how much this estimate might vary from sample to sample
* **Critical value** → controls how confident we are about the interval

### Understanding the Critical Value (Easy Explanation)

Think of the estimate as the **bullseye on a target**. The CI is like a **safety zone around the bullseye**.

* The **standard error** is how shaky your hand is when aiming.
* The **critical value** is how much extra space you allow around the bullseye to be confident you hit the target.

For example:

* A **critical value of 1.96** in a 95% CI means we go **1.96 “shaky hand units”** above and below the estimate. This ensures that if we kept taking samples, **95 out of 100 times the true value would land inside this range**.

* Higher confidence (like 99%) → bigger critical value → wider safety zone

* Lower confidence (like 90%) → smaller critical value → narrower safety zone

### Common Critical Values

| Confidence Level | Critical Value |
| ---------------- | -------------- |
| 90%              | 1.645          |
| 95%              | 1.96           |
| 99%              | 2.576          |

**Analogy:** Imagine throwing darts at a board. The bullseye is your sample estimate. The CI is the circle around the bullseye that likely contains the true population value. A bigger circle (larger critical value) gives you more confidence that the true value is inside.

### Margin of Error

Everything after ± is called the **margin of error**:
[
\text{Margin of Error} = (\text{critical value}) \times (\text{standard error})
]

* Larger critical value → wider CI
* Smaller critical value → narrower CI

> **Intuition:** The estimate is the center, the standard error is the shake or uncertainty, and the critical value stretches the interval to capture the true value most of the time.

---

## 3. What Does “95% Confidence” Mean?

A **95% confidence interval** means:

> If we repeated the study many times, about **95% of the intervals** we calculate would contain the true population value.

🚫 It does **not** mean:

* There is a 95% probability that the true value lies in *this* interval

---

## 4. Common Types Used in Public Health

### (a) Mean Confidence Interval

Used for outcomes like blood pressure, BMI, age.

[
\bar{x} \pm t \times \frac{s}{\sqrt{n}}
]

* Uses **t-distribution** when population SD is unknown
* Larger sample size → narrower CI

### (b) Proportion Confidence Interval

Used for prevalence, risk, percentages.

[
\hat{p} \pm z \times \sqrt{\frac{\hat{p}(1-\hat{p})}{n}}
]

### (c) Ratios (Odds Ratio, Relative Risk, Hazard Ratio)

* Interpreted around **1**, not 0
* **1 = no association**

---

## 5. Confidence Intervals vs Hypothesis Tests

### Hypothesis Testing (HT)

* Starts with a **null hypothesis** (e.g. no difference, no association)
* Produces a **p-value**
* Leads to a **binary decision**: reject or fail to reject the null
* Limitation: only tells if significant, not magnitude or precision

### Confidence Intervals (CI)

* Provide a **range of plausible values** for the parameter
* Show **effect size** and **uncertainty**
* Allow assessment of both **statistical significance** and **practical importance**

### How CI and Hypothesis Tests Complement Each Other

At a 95% confidence level:

* CI excludes null → p < 0.05 → significant
* CI includes null → p ≥ 0.05 → not significant

> CI shows all parameter values that would *not* be rejected by a hypothesis test.

---

## 6. Statistical Significance Using Confidence Intervals

### Null values:

* Differences → 0
* Ratios (OR, RR, HR) → 1

| CI includes null value? | Conclusion                    |
| ----------------------- | ----------------------------- |
| Yes                     | Not statistically significant |
| No                      | Statistically significant     |

---

## 7. Examples of Confidence Intervals and Interpretation

### Example 1: Mean Difference

95% CI: (−2.1, 4.5) mmHg → includes 0 → not significant

### Example 2: Mean Estimate

95% CI: (26.5, 28.1) → estimate = 27.3 → plausible range

### Example 3: Proportion

95% CI: (15%, 21%) → estimate = 18%

### Example 4: Odds Ratio

OR = 1.6, 95% CI: (1.2, 2.4) → excludes 1 → significant

### Example 5: Relative Risk

RR = 0.85, 95% CI: (0.65, 1.12) → includes 1 → not significant

---

## 8. What Affects CI Width?

Wider when:

* Confidence level higher
* Sample size small
* Data variability high
  Narrower when:
* Sample size larger
* Data variability low

---

## 9. One-Sentence Takeaway

> A confidence interval provides a range of plausible values for a population parameter, showing both the estimated effect and its uncertainty, and complements hypothesis testing by indicating statistical significance and effect size.
