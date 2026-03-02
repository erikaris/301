
# 1️⃣ First: What Is a GLM? (Accessible Explanation)

Start simple:

> A **General Linear Model (LM)** is standard regression — it assumes the outcome is **continuous** and normally distributed.
> A **Generalised Linear Model (GLM)** is a flexible version that allows different types of outcome variables.

Think of it like this:

| If your outcome is…     | Use                | Example                 |
| ----------------------- | ------------------ | ----------------------- |
| Continuous (normal-ish) | **LM**             | Weight, height          |
| Counts                  | **GLM (Poisson)**  | Number of pecks         |
| Binary (0/1)            | **GLM (Logistic)** | Survived vs died        |
| Proportions             | **GLM (Binomial)** | Successes out of trials |

So:

> LM is a special case of GLM.

---

# 2️⃣ Why Do someone might use GLM Instead of LM?

When:

* they have **count data** --> they probably need **Poisson regression** (a type of GLM)
* They discussed using **counts instead of percentages**
* They discussed **chi-square tests**
* They discussed **interaction terms**


Because:

* Counts are not normally distributed
* They’re discrete
* They’re often skewed
* Variance increases with the mean

LM assumes:

* Normal errors
* Constant variance
* Continuous outcome

Count data violates that → use GLM.

---

# 3️⃣ How to Explain GLM in Simple Terms

You can say:

> A GLM has three components:
>
> 1. **Random component** – what distribution the outcome follows (Normal, Poisson, Binomial)
> 2. **Systematic component** – the predictors (X variables)
> 3. **Link function** – connects predictors to the expected value of Y

Then simplify:

* LM → identity link
* Logistic regression → logit link
* Poisson regression → log link

---

# 4️⃣ What You Should Ask Her Immediately

Start with these:

1. What is your dependent variable?

   * Continuous?
   * Count?
   * Proportion?
   * Binary?

2. Are you modelling:

   * Number of events?
   * Probability of success?
   * Rate?

3. Are there repeated measures? (Important for independence)

4. What model did you actually run in R/SPSS?

   * lm()?
   * glm(family = poisson)?
   * glm(family = binomial)?

5. Did you check:

   * Overdispersion?
   * Residuals?
   * Interaction terms?

---

# 5️⃣ Very Likely Scenario (Based on Notes)

She probably:

* Has pigeon behaviour counts
* Originally tried chi-square
* Was told regression is more appropriate
* Needs GLM (Poisson)

So you should prepare to explain:

## 📌 When to Use Poisson Regression

Use when:

* Y = count
* Observations independent
* Mean ≈ variance (Poisson assumption)

If variance >> mean → overdispersion → maybe use:

* Quasi-Poisson
* Negative binomial

---

# 6️⃣ Difference Between Chi-Square and GLM

She previously discussed chi-square.

You can explain:

| Chi-square                           | GLM                             |
| ------------------------------------ | ------------------------------- |
| Compares observed vs expected counts | Models counts with predictors   |
| Categorical association              | Regression framework            |
| No covariates easily                 | Can include multiple predictors |

So:

> Chi-square is simpler but limited.
> GLM allows modelling effects and interactions.

---

# 7️⃣ Interaction Terms (They Discussed This)

Interaction means:

> Does the effect of X1 depend on X2?

Example:

Number of pecks ~ Food type * Sex

Means:

* Effect of food
* Effect of sex
* Food × sex interaction

Important in ecology/zoology.

---

# 8️⃣ What You Need to Check in Her Model

When she shows you output:

### ✔ Step 1: Check family

Is it:

```r
glm(y ~ x1 + x2, family = poisson)
```

or did she incorrectly use:

```r
lm(y ~ x1 + x2)
```

---

### ✔ Step 2: Check Overdispersion

In Poisson:
Mean ≈ Variance.

Ask:

* What is mean of Y?
* What is variance of Y?

If variance much larger → overdispersion → Poisson may be inappropriate.

---

### ✔ Step 3: Interpret Coefficients Correctly

Poisson uses log link.

So coefficients are in **log scale**.

To interpret:

exp(coefficient)

This gives:

* Multiplicative effect
* Rate ratio

Students often misinterpret this.

---

# 9️⃣ Simple Way to Explain Log Link

If β = 0.7

exp(0.7) ≈ 2.01

Interpretation:

> A one-unit increase in X doubles the expected count.

Not:

> increases by 0.7

That would be wrong.

---

# 🔟 What If She Actually Needed LM?

If her outcome is:

* Body mass
* Wing length
* Continuous measurement

Then LM is correct.

So first step = clarify outcome variable.

---

# 11️⃣ 5-Minute Teaching Script You Can Use

You can say:

> A generalised linear model is just a flexible regression model that lets us use different types of outcome distributions.
> If your outcome is continuous and normal → LM.
> If it’s count data → Poisson GLM.
> If it’s binary → Logistic GLM.
>
> The key is matching the distribution of the outcome to the correct model family.

That alone already makes you sound confident.

---

# 12️⃣ Likely Weak Points You Should Be Ready For

* Why not just use percentages?
  → Because percentages lose information about sample size.
* Why not chi-square?
  → **Doesn’t allow multiple predictors or interactions**.
* What is overdispersion?
  → Variance larger than mean in count data.
* How to check model fit?
  → Residual deviance vs degrees of freedom.

---

