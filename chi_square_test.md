Perfect — this is exactly how you should prepare as a tutor:
**anticipate the structure of the data before you even see it.** 👏

Let’s reason from the notes logically.

---

# 1️⃣ Why Did the Previous Tutor Suggest GLM Instead of LM?

From meeting notes:

* “why a GLM was needed over an LM”
* “chi tests”
* “use counts rather than percentages”
* “interaction terms”

This strongly suggests:

👉 Her dependent variable is **count data**
👉 Probably number of behaviours, events, or occurrences in pigeons
👉 Therefore, normal linear regression (LM) assumptions were violated

### Why LM would be wrong

LM assumes:

* Continuous outcome
* Normally distributed residuals
* Constant variance

But count data:

* Are integers (0,1,2,…)
* Often skewed
* Variance increases with mean
* Cannot go negative

So the previous tutor likely saw:

* Skewed residuals
* Non-normality
* Heteroskedasticity

→ therefore recommended **Poisson GLM**

---

# 2️⃣ What Might Her Pigeon Data Look Like?

Let’s predict realistically (Zoology project):

### Possible dependent variables:

* Number of pecks
* Number of visits to feeder
* Number of aggressive interactions
* Number of nesting attempts
* Number of offspring

### Possible predictors:

* Food type (categorical)
* Sex (male/female)
* Treatment (control vs experimental)
* Habitat type
* Temperature
* Time of day

So her dataset might look like:

| pigeon_id | sex | food_type | habitat | pecks |
| --------- | --- | --------- | ------- | ----- |
| 1         | F   | A         | urban   | 12    |
| 2         | M   | B         | rural   | 3     |
| 3         | F   | A         | urban   | 0     |

Here:

* Y = pecks (count)
* Xs = categorical predictors

This screams:

👉 Poisson regression:

```
pecks ~ sex + food_type + habitat
```

Or with interaction:

```
pecks ~ sex * food_type
```

---

# 3️⃣ How She Likely Used GLM

Most likely in R:

```r
glm(pecks ~ sex + food_type, family = poisson, data = mydata)
```

Or in SPSS:

* Analyze → Generalized Linear Models
* Distribution: Poisson
* Link: Log

---

# 4️⃣ How To Check Whether Her Model Is Right

When she shows you output, check this step-by-step:

---

## ✅ Step 1: Is the family correct?

If Y is count:

* family = poisson → good
* lm() → probably wrong

---

## ✅ Step 2: Check Overdispersion

Poisson assumption:
Mean ≈ Variance

Ask her:

```
mean(mydata$pecks)
var(mydata$pecks)
```

If:
Variance >> Mean
→ Overdispersion
→ Poisson may not fit well
→ Might need quasi-Poisson or negative binomial

You can also check:

Residual deviance / df

If this ratio >> 1 → overdispersion.

---

## ✅ Step 3: Check Interpretation

In Poisson GLM:

Coefficients are in **log scale**.

If output shows:

| Estimate | Std. Error | z value | p   |       |
| -------- | ---------- | ------- | --- | ----- |
| sexMale  | 0.69       | 0.2     | 3.4 | 0.001 |

Interpretation:

exp(0.69) ≈ 2

Meaning:
Male pigeons have **twice the expected count** compared to females.

NOT:
“increase by 0.69 pecks”

That would be wrong.

---

## ✅ Step 4: Are Interaction Terms Meaningful?

If she used:

```
pecks ~ sex * food_type
```

Check:

* Is interaction significant?
* If yes → interpret interaction, not just main effects.

Students often ignore this.

---

# 5️⃣ Why Not Just Use Percentages?

If she converted:

12 pecks out of 20 observations → 60%

Problem:

* 60% of 5 trials ≠ 60% of 100 trials
* Percentages remove information about sample size

That’s why previous tutor insisted on counts.

---

# 6️⃣ Now: What Is Chi-Square Test?

Chi-square test is used for:

👉 Testing association between **categorical variables**

It does NOT model counts with predictors.

---

## What Is Being Tested?

Null hypothesis:

> Observed frequencies = Expected frequencies under independence.

It tests:

Are two categorical variables independent?

---

# 7️⃣ Example of Chi-Square Test

Suppose she had:

| Sex    | Aggressive | Not Aggressive |
| ------ | ---------- | -------------- |
| Male   | 30         | 10             |
| Female | 15         | 25             |

Question:
Is aggression associated with sex?

Chi-square compares:
Observed counts
vs
Expected counts under independence.

If p < 0.05:
→ association exists.

---

# 8️⃣ What Is the Difference Between Chi-Square and GLM?

| Chi-square                   | GLM                               |
| ---------------------------- | --------------------------------- |
| Tests association only       | Models effect size                |
| Only categorical             | Can include continuous predictors |
| No interactions easily       | Can include interactions          |
| No adjustment for covariates | Can control for confounders       |

So:

Chi-square = simple test
GLM = regression framework

---

# 9️⃣ When Would She Use Chi-Square Instead?

If her data looked like:

| Habitat | Nesting Success (Yes/No) |

Then she could do:
Chi-square test of independence.

But if she wants:

* Adjust for temperature
* Include sex
* Test interactions

→ Use logistic regression (GLM with binomial).

---

# 🔟 What You Should Be Ready to Say in Session

You can confidently say:

> The reason GLM was suggested is likely because your response variable is count data, which violates the normality assumption required for linear regression. A Poisson GLM models count data more appropriately using a log link.

Then ask:

> Did you check for overdispersion?

That will make you sound very competent.

---

# 11️⃣ Quick Visual Summary

### If Y is:

* Continuous → LM
* Count → Poisson GLM
* Binary → Logistic GLM
* Proportion → Binomial GLM

---

If you'd like, tell me:

* What you’re most nervous about (math? interpretation? SPSS output?)
* I can give you a 5-minute “survival script” specifically for tutoring her confidently tomorrow.
