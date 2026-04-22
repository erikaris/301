
# What Is Chi-Square Test?

There are 2 types of Chi-Square Test:
1. Testing the association between categorical variables (test of independence/contingency table) --> Are these two variables associated?
2. Goodness of fit --> Does this variable follow a specific distribution?

They’re closely related but **not the same test**—they answer different questions.

---

# Big picture difference

## 1) Chi-square *goodness-of-fit* (GOF)

**One variable only**

* Question:

  > “Does this variable follow a specific distribution?”

* You compare:

  * **Observed counts** vs **expected counts (you define)**

---

## 2) Chi-square *test of independence* (contingency table)

**Two categorical variables**

* Question:

  > “Are these two variables associated?”

* You compare:

  * **Observed counts** vs **expected counts (calculated from data)**

---

## Side-by-side

| Feature         | GOF                                    | Contingency table                  |
| --------------- | -------------------------------------- | ---------------------------------- |
| Variables       | 1 categorical                          | 2 categorical                      |
| Goal            | Fit to expected distribution           | Test association                   |
| Expected counts | Pre-specified                          | Computed from table                |
| Example         | “Are eye colours equally distributed?” | “Is eye colour related to gender?” |

---

## Case examples (use in session)

### Goodness-of-fit

**Question:**
Are patients equally distributed across severity levels?

* DV: Severity → Mild / Moderate / Severe
* Expected: 33% each

Test if observed differs from expected

---

### Contingency table (independence test)

**Question:**
Is treatment related to outcome?

* Variable 1: Treatment (A / B)
* Variable 2: Outcome (Improved / Not improved)

This is the **classic chi-square test students use most**

---

## Why they feel similar

Both use:

* χ² statistic
* p-value
* comparison of observed vs expected

That’s why some people might think they are the same—but the **source of expected counts is different**

---

## Quick way to decide (teach this)

Ask:

> “Do I have one variable or two?”

* **One → GOF**
* **Two → contingency table**

---

## SPSS difference

### GOF

* Analyze → Nonparametric Tests → Legacy Dialogs → Chi-square

### Contingency

* Analyze → Descriptive Statistics → Crosstabs

  * Tick **Chi-square**

---

## Common student mistakes

* Using GOF when they actually have **two variables**
* Forgetting to define expected proportions in GOF
* Not checking expected counts ≥ 5 (applies to both)

---

## One-line summary (good for teaching)

> “Goodness-of-fit tests one variable against a theoretical distribution, while the chi-square test of independence checks whether two categorical variables are related.”

---


## Chi-Square test for Association:

Testing association between **categorical variables**

It does NOT model counts with predictors.

> “In statistics, we say two variables are associated if the pattern in the data is unlikely to occur by chance. For categorical variables, chi-square tests whether counts differ from what we would expect if the variables were independent. We don’t say ‘relationship’ because chi-square does not tell us about cause or strength, only whether there is evidence of a systematic pattern.”


---

### What Is Being Tested?

Null hypothesis:

> Observed frequencies = Expected frequencies under independence.

It tests:

Are two categorical variables independent?

---

#### Example of Chi-Square Test

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

### What Is the Difference Between Chi-Square and GLM?

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

### When Would She Use Chi-Square Instead?

If the data looked like (only has 1 dependent variable)

| Habitat | Nesting Success (Yes/No) |

Then we could do:
Chi-square test of independence.

But if we want:

* Adjust for temperature
* Include sex
* Test interactions

→ Use logistic regression (GLM with binomial).


### Quick Visual Summary

#### If Y is:

* Continuous → LM
* Count → Poisson GLM
* Binary → Logistic GLM
* Proportion → Binomial GLM

---

# Observed vs Expected Counts: The Core Idea

* **Observed counts** = what you actually recorded in your data
* **Expected counts** = what you would expect **if there were no association between variables**

> The chi-square test asks:
> *Are the observed counts close enough to what we’d expect by chance, or is there evidence of a real association?*

---

# How Expected Counts Are Calculated

Suppose you have a 2×2 table:

|              | Aggressive | Not Aggressive | Row total |
| ------------ | ---------- | -------------- | --------- |
| Male         | 30         | 10             | 40        |
| Female       | 15         | 25             | 40        |
| Column total | 45         | 35             | 80        |

**Step 1: Compute expected counts for each cell**

Formula:

$$
\text{Expected count} = \frac{(\text{Row total} \times \text{Column total})}{\text{Grand total}}
$$

---

### Example

* Male & Aggressive:
  $$
  E = \frac{40 \times 45}{80} = 22.5
  $$

* Male & Not Aggressive:
  $$
  E = \frac{40 \times 35}{80} = 17.5
  $$

* Female & Aggressive:
  [
  E = \frac{40 \times 45}{80} = 22.5
  ]

* Female & Not Aggressive:
  [
  E = \frac{40 \times 35}{80} = 17.5
  ]

---

# Compare Observed to Expected

|        | Aggressive         | Not Aggressive |
| ------ | ------------------ | -------------- |
| Male   | 30 (O) vs 22.5 (E) | 10 vs 17.5     |
| Female | 15 vs 22.5         | 25 vs 17.5     |

* Large differences → possible association
* Small differences → consistent with independence

---

# Chi-Square Statistic

Formula:

[
\chi^2 = \sum \frac{(O - E)^2}{E}
]

Where:

* O = observed count
* E = expected count

> Measures “distance” between observed and expected counts.

Then:

* Compare χ² to chi-square distribution with (rows-1)×(columns-1) degrees of freedom
* Gives p-value

p < 0.05 → reject null → evidence of association

---

# Intuitive Way to Explain

* Think of expected counts as **what would happen if nothing mattered** (e.g., aggression not related to sex)
* Observed counts = **what actually happened**
* Chi-square = measures how far reality is from “chance expectation”

> Big difference → suggests a real effect

---

# Quick Case Example (Zoology)

**Research question:** Is aggression associated with sex in pigeons?

* Observed data (actual counts):

| Sex    | Aggressive | Not Aggressive |
| ------ | ---------- | -------------- |
| Male   | 30         | 10             |
| Female | 15         | 25             |

* Expected counts (under null hypothesis of no association):

| Sex    | Aggressive | Not Aggressive |
| ------ | ---------- | -------------- |
| Male   | 22.5       | 17.5           |
| Female | 22.5       | 17.5           |

* χ² statistic =
  [
  \frac{(30-22.5)^2}{22.5} + \frac{(10-17.5)^2}{17.5} + \frac{(15-22.5)^2}{22.5} + \frac{(25-17.5)^2}{17.5} \approx 14.29
  ]

* Compare to chi-square table with df=(2-1)*(2-1)=1 → p < 0.001

* Interpretation: Aggression **is associated with sex**

---

Key Takeaway:

> Comparing observed vs expected counts = asking “Do the patterns we see in the data differ significantly from what we’d expect if the variables were independent?”

---

