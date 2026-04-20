# Binary Logistic Regression in SPSS
### A Student Guide for Social Science Researchers

---

## Contents

1. [What is Binary Logistic Regression?](#1-what-is-binary-logistic-regression)
2. [When Should You Use It?](#2-when-should-you-use-it)
3. [Key Concepts and Terminology](#3-key-concepts-and-terminology)
4. [Assumptions — and How to Check Them](#4-assumptions--and-how-to-check-them)
5. [Running the Analysis in SPSS — Step by Step](#5-running-the-analysis-in-spss--step-by-step)
6. [Reading and Interpreting Your Output](#6-reading-and-interpreting-your-output)
7. [Worked Case Example: Voting Behaviour](#7-worked-case-example-voting-behaviour)
8. [Common Problems and How to Fix Them](#8-common-problems-and-how-to-fix-them)
9. [Writing Up Your Results](#9-writing-up-your-results)
10. [Quick Reference Summary](#10-quick-reference-summary)
11. [$Exp(B)$ Interpretation](# 11. $Exp(B)$ Interpretation)

---

## 1. What is Binary Logistic Regression?

Binary logistic regression is a statistical technique used to **predict the probability of a binary outcome** — that is, an outcome with exactly two categories — based on one or more predictor variables.

Think of it as asking: *"Given what we know about a person, how likely are they to be in one group rather than the other?"*

The outcome variable (also called the dependent variable) must be binary:

| Outcome | Example coding |
|---|---|
| Voted / Did not vote | 1 = voted, 0 = did not vote |
| Employed / Unemployed | 1 = employed, 0 = unemployed |
| University attended / Not attended | 1 = attended, 0 = did not attend |
| Homeowner / Renter | 1 = homeowner, 0 = renter |

The predictor variables (independent variables) can be **categorical** (e.g. social class, gender, ethnicity) or **continuous** (e.g. age, income, years of education).

> **Why not just use linear regression?**
> Linear regression assumes a continuous outcome and can produce predicted values below 0 or above 1 — which makes no sense as a probability. Logistic regression mathematically constrains predictions to the 0–1 range using a special transformation called the **logit function**. This makes it the appropriate choice for binary outcomes.

---

## 2. When Should You Use It?

Use binary logistic regression when:

- Your dependent variable has **exactly two categories** (yes/no, present/absent, group A/group B)
- You want to understand which factors **predict or explain** group membership
- You want to **control for multiple variables** at once (i.e., hold other factors constant)
- You are interested in the **strength and direction** of each predictor's effect

### Sociological examples

- Does social class predict whether someone votes in a general election, after controlling for age and gender?
- Do gender and ethnicity predict the likelihood of experiencing workplace discrimination?
- Does parental education level predict whether a young person attends university?
- Does neighbourhood deprivation predict whether someone reports poor mental health?

---

## 3. Key Concepts and Terminology

Before running the analysis, you need to understand a few core concepts. These will appear in your SPSS output and you must be able to explain them.

### 3.1 Probability and Odds

**Probability** is what most people are familiar with: a value between 0 and 1 representing how likely an event is. If 60 out of 100 respondents voted, the probability of voting is 0.60.

**Odds** are a different way of expressing the same thing:

$$\text{Odds} = \frac{\text{Probability of event}}{\text{Probability of non-event}} = \frac{p}{1-p}$$

If the probability of voting is 0.60:

$$\text{Odds} = \frac{0.60}{1 - 0.60} = \frac{0.60}{0.40} = 1.5$$

This means: for every person who did not vote, 1.5 people voted. Odds greater than 1 = event is more likely than not. Odds less than 1 = event is less likely than not.

### 3.2 Log-Odds (Logit)

Logistic regression works with the **natural logarithm of the odds**, called the **log-odds** or **logit**:

$$\text{Log-odds} = \ln\left(\frac{p}{1-p}\right)$$

The log-odds can range from negative infinity to positive infinity, which is why it can be modelled with a linear equation. The **B coefficient** in your SPSS output is the log-odds — it is not very intuitive to interpret directly.

### 3.3 Odds Ratio — Exp(B)

The **odds ratio** is what you will interpret in practice. In SPSS output, it appears as **Exp(B)** (the exponentiated B coefficient).

The odds ratio tells you: *"How do the odds of the outcome change when the predictor increases by one unit (for continuous variables) or changes from one category to the reference category (for categorical variables)?"*

| Exp(B) value | Interpretation |
|---|---|
| > 1 | Predictor **increases** the odds of the outcome |
| = 1 | Predictor has **no effect** on the odds |
| < 1 | Predictor **decreases** the odds of the outcome |

**Example:** An Exp(B) of 2.5 for social class (professional vs. working class) means professional-class respondents have **2.5 times the odds** of voting compared to working-class respondents.

An Exp(B) of 0.4 would mean the group has **60% lower odds** (i.e., 1 − 0.4 = 0.6, so 60% lower).

### 3.4 Reference Category

For **categorical predictors**, one category is set as the **reference category** — this is the comparison point. All Exp(B) values for that variable are interpreted relative to the reference group.

For example, if gender is a predictor with "Male" as the reference:
- Exp(B) = 1.8 for Female means women have 1.8 times the odds of the outcome **compared to men**

Choosing your reference category thoughtfully is important. It is usually the largest group, the most theoretically meaningful baseline, or the group you want to compare others to.

---

## 4. Assumptions — and How to Check Them

Binary logistic regression has fewer assumptions than linear regression, but violations can seriously distort your results. Always check these before interpreting your output.

---

### Assumption 1: Binary Dependent Variable

**What it means:** Your outcome variable must have exactly two categories.

**How to check:** Run `Analyze → Descriptive Statistics → Frequencies` on your DV. Confirm only two values appear.

**What if violated:** If your DV has more than two categories, you need **multinomial logistic regression** instead.

---

### Assumption 2: Independence of Observations

**What it means:** Each case (row in your dataset) must be from a different, independent individual. One person's outcome should not influence another's.

**How to check:** This is usually a matter of research design, not statistical testing. Ask yourself: are there repeated measurements of the same individual? Are cases clustered (e.g. students within schools, residents within neighbourhoods)?

**What if violated:** Clustered data requires multilevel (hierarchical) logistic regression. Repeated measures require a different approach entirely.

---

### Assumption 3: No Multicollinearity

**What it means:** Your predictor variables should not be so strongly correlated with each other that the model cannot distinguish their individual effects. Very high correlations between predictors cause unstable, unreliable coefficient estimates.

**How to check:** SPSS does not produce Variance Inflation Factors (VIF) directly from logistic regression. Instead:

1. Run `Analyze → Regression → Linear` with the same predictors (even though you are not actually doing linear regression)
2. Click `Statistics` → tick `Collinearity diagnostics`
3. In the Coefficients table, check the **Tolerance** and **VIF** columns

**Thresholds:**
- VIF > 10 = serious multicollinearity problem
- Tolerance < 0.10 = serious multicollinearity problem
- VIF between 5–10 = worth investigating

---

### Assumption 4: Linearity of the Log-Odds (Continuous Predictors Only)

**What it means:** For any **continuous** predictor variable, the relationship between that variable and the log-odds of the outcome must be linear.

**How to check — the Box-Tidwell procedure:**

1. Compute a new variable: the interaction between each continuous IV and its natural log
   - `Transform → Compute Variable`
   - New variable name: e.g. `age_ln_age`
   - Numeric expression: `age * LN(age)`
2. Re-run the logistic regression including both the original continuous variable and this new interaction term
3. If the interaction term is **statistically significant (p < .05)**, the linearity assumption is violated for that predictor

**What if violated:** Consider transforming the predictor (e.g. log transformation), categorising it into groups, or using a non-linear modelling approach.

> **Note:** This assumption only applies to continuous predictors. Categorical predictors (entered as dummy variables) are exempt.

---

### Assumption 5: No Influential Outliers

**What it means:** Extreme cases (outliers) can have a disproportionate influence on the model estimates, pulling the coefficients away from the true population values.

**How to check:**

1. When running your logistic regression, click `Save`
2. Tick **Standardised residuals**, **Cook's distance**, and **Leverage values** — these will be added as new columns in your dataset
3. Check the new variables:
   - **Standardised residuals** beyond ±3 are potentially problematic cases
   - **Cook's distance** values greater than 1 indicate a highly influential case
   - **Leverage** values greater than 2–3 times the average leverage are worth examining

**What to do:** Examine the flagged cases. Do not automatically delete them. Investigate whether they represent data entry errors, or whether they are genuine but unusual cases. If genuine, report them as a limitation.

---

### Assumption 6: Adequate Sample Size

**What it means:** Logistic regression requires a sufficient number of cases — especially cases in the less common outcome category — to produce reliable estimates.

**Rule of thumb:** At least **10 events per predictor variable** (EPP), where "events" refers to the number of cases in the **smaller** of the two outcome categories.

**Example:** If you have 5 predictor variables and your outcome is voting (30% voted, 70% did not), you need at least 5 × 10 = 50 people who voted. In practice, aiming for 100+ cases in each category is more robust.

**What if violated:** Small samples lead to wide confidence intervals, unstable estimates, and inflated Type I or Type II error rates. Consider reducing the number of predictors, or collecting more data.

---

## 5. Running the Analysis in SPSS — Step by Step

### Before you begin: prepare your variables

**Step 1 — Code your outcome variable correctly**

Your DV must be a **numeric variable** coded as 0 and 1 before SPSS will accept it in logistic regression. SPSS predicts membership in the **higher-coded** category, so:
- 1 = the outcome you are trying to predict (e.g. 1 = voted)
- 0 = the comparison group (e.g. 0 = did not vote)

Your data may arrive in one of three states. Identify which applies to you and follow the appropriate steps below.

---

#### Situation A: DV is a string variable (text labels, e.g. "Voted" / "Did not vote")

SPSS cannot run logistic regression on a string variable at all — it will not even appear in the variable list when you open the Binary Logistic dialog. You must convert it to a numeric variable first.

**How to do it in SPSS:**

1. `Transform → Automatic Recode`
2. Move your string DV into the **Variable → New Name** box and give the new variable a name (e.g. `voted_numeric`)
3. Click **Add New Name**, then **OK**

SPSS will create a new numeric variable and assign numbers to each text value alphabetically. It will also produce a table in the output showing you exactly which text label was assigned which number.

> **Critical:** After running Automatic Recode, always check the output table to confirm which value received which number. Alphabetical ordering means "Did not vote" would be coded 1 and "Voted" would be coded 2 — which is the wrong way around for your purposes (SPSS will predict the higher value, so it would predict "Voted" = 2, which is correct here, but this will not always work in your favour).

**After recoding, confirm and correct the direction if needed:**

Run `Analyze → Descriptive Statistics → Frequencies` on your new numeric variable to see the coding. If the values are back to front, recode them using the steps in Situation C below.

---

#### Situation B: DV is numeric but not coded 0 and 1 (e.g. 1 = did not vote, 2 = voted)

SPSS will accept this and will predict the **higher-coded** category (in this case, 2 = voted). This may or may not be the outcome you intend to predict.

**How to check:** After running the analysis, look at the **Dependent Variable Encoding** table at the very top of the output. It lists which original value SPSS has treated as 0 (reference) and which as 1 (predicted). If it is the wrong way around, recode using the steps in Situation C.

---

#### Situation C: DV needs to be recoded manually into 0 and 1

Use this if your coding is back to front, or if you want explicit control over which category is 0 and which is 1.

**How to do it in SPSS:**

1. `Transform → Recode into Different Variables`
2. Move your existing DV into the **Input Variable → Output Variable** box
3. Give the new variable a name in the **Output Variable: Name** field (e.g. `voted_recode`) and click **Change**
4. Click **Old and New Values**
5. Assign your values one at a time:
   - Old value: `1` (or whatever your "no" category is) → New value: `0` → click **Add**
   - Old value: `2` (or whatever your "yes" category is) → New value: `1` → click **Add**
6. Click **Continue**, then **OK**

> Always use **Recode into Different Variables** rather than **Recode into Same Variables**. This preserves your original variable so you can check your work and trace back any errors.

**After recoding**, run `Analyze → Descriptive Statistics → Frequencies` on the new variable to confirm 0 and 1 appear with the correct group labels and frequencies before proceeding.

---

Once your DV is a numeric variable coded 0 and 1, check it with `Analyze → Descriptive Statistics → Frequencies` and confirm your coding before proceeding.

**Step 2 — Identify your predictor types**

Before running, know which predictors are:
- **Continuous** (e.g. age in years, income in £) — enter these as covariates
- **Categorical** (e.g. gender, social class) — enter these as covariates too, but you must flag them using the `Categorical` button (see Step 6 below)

---

### Running the analysis

**Step 3 — Open the logistic regression dialog**

`Analyze → Regression → Binary Logistic`

**Step 4 — Assign your variables**

- Move your **DV** (binary outcome) to the **Dependent** box
- Move all your **IVs** (predictors) to the **Covariates** box

**Step 5 — Choose your method**

Leave the method as **Enter** (the default) unless you have a specific reason to use a stepwise approach. Enter forces all predictors into the model at once and is the most appropriate for theory-driven research.

> Stepwise methods (Forward or Backward) are data-driven and exploratory. They are generally not recommended for confirmatory sociological research because they capitalise on chance and make replication difficult.

**Step 6 — Declare categorical predictors**

This step is critical and often missed.

1. Click the **Categorical...** button
2. Move all your **categorical** predictors from the Covariates box into the **Categorical Covariates** box
3. For each categorical variable, set the **Reference Category**:
   - **First** = SPSS uses the lowest-coded category as reference
   - **Last** = SPSS uses the highest-coded category as reference
   - You can change which is "first" or "last" through your variable coding
4. Click **Change** to apply, then **Continue**

SPSS will automatically create dummy variables for you. You can verify this was applied correctly by checking the **Categorical Variables Codings** table in your output.

**Step 7 — Request statistics**

Click **Options...**

Tick the following:
- **Hosmer-Lemeshow goodness of fit** (essential for testing model fit)
- **CI for Exp(B): 95%** (essential for reporting)
- **Classification plots** (useful for visualising model accuracy)
- **At each step** under Display

Click **Continue**.

**Step 8 — Save diagnostic variables**

Click **Save...**

Tick:
- **Standardised residuals**
- **Cook's distance**
- **Leverage values**

These will appear as new variables in your dataset for assumption checking.

Click **Continue**, then **OK** to run the analysis.

---

## 6. Reading and Interpreting Your Output

SPSS produces several tables in sequence. Work through them in order.

---

### Table 1: Case Processing Summary

This simply tells you how many cases were included in the analysis and how many were excluded (usually due to missing data). Check this matches your expected sample size.

---

### Table 2: Dependent Variable Encoding

Confirms that SPSS has correctly identified which value is being predicted (the reference = 0, predicted = 1). Always check this before interpreting results.

---

### Table 3: Categorical Variables Codings

Lists your categorical predictors and shows:
- How many respondents are in each category
- Which category is the reference (shown as Parameter coding = 0)
- What dummy variables SPSS has created

> **If your categorical predictors do not appear in this table**, it means you did not use the `Categorical` button — SPSS treated them as continuous. Go back and re-run the analysis correctly.

**Example output:**

```
Social Class          Frequency    Parameter coding (1)
  Working class           243              0
  Professional class      157              1
```

This tells you "working class" is the reference category, and the coefficient for social class in the main output refers to professional class vs. working class.

---

### Table 4: Block 0 — Beginning Block (Intercept only)

This is the **null model** — a model with no predictors, only the intercept. It classifies every case into whichever group is most frequent.

You do not interpret this in detail, but it is the baseline against which your full model will be compared.

---

### Table 5: Omnibus Tests of Model Coefficients

This is the **first and most important check of model fit**.

| Column | What it means |
|---|---|
| Chi-square | How much the model improves on the null model |
| df | Degrees of freedom (number of predictors) |
| Sig. | p-value |

**Interpretation:** A significant p-value (p < .05) tells you that your model as a whole fits the data significantly better than the null model — i.e., your predictors collectively improve prediction.

**If this is not significant**, stop and reconsider your model. Adding or changing predictors may be necessary.

---

### Table 6: Model Summary

| Statistic | What it means |
|---|---|
| -2 Log likelihood | Overall model fit (lower = better fit) |
| Cox & Snell R² | Pseudo-R² (not a true R²; treat as a rough guide) |
| **Nagelkerke R²** | **The preferred pseudo-R²** — reports approximate variance explained |

**Nagelkerke R² benchmarks (rough guidelines):**

| Value | Interpretation |
|---|---|
| 0.10–0.20 | Weak |
| 0.20–0.40 | Moderate |
| 0.40–0.60 | Substantial |
| > 0.60 | Strong |

> **Important caveat:** These are pseudo-R² statistics. They are not directly comparable to R² in linear regression, and different researchers use different thresholds. Always report the value and let readers judge — do not claim you have "explained" a precise percentage of variance.

---

### Table 7: Hosmer and Lemeshow Test

This test checks whether the **model's predicted probabilities match the observed frequencies** across subgroups of the sample.

Unlike most statistical tests, **you want a non-significant result here** (p > .05).

| Result | Interpretation |
|---|---|
| p > .05 (non-significant) | Good model fit — predicted probabilities match observed outcomes |
| p < .05 (significant) | Poor model fit — model is not fitting well in some regions |

> A significant Hosmer-Lemeshow is not necessarily fatal — it may indicate a missing interaction term, a non-linear relationship, or an important unincluded variable. You should acknowledge it as a limitation and consider whether model modifications are warranted.

---

### Table 8: Classification Table

Shows how accurately the model classifies cases into the two outcome groups.

```
                         Predicted
                    Did not vote    Voted     % Correct
Observed  Did not vote    189          21        90.0
          Voted            28         162        85.3
                                Overall %  87.8
```

**Interpretation:** The model correctly classified 90.0% of non-voters and 85.3% of voters, with an overall accuracy of 87.8%.

> **Watch out for class imbalance.** If 90% of your sample are non-voters, a model that predicts "did not vote" for everyone will achieve 90% accuracy without learning anything. Always check accuracy separately for each group. A good model should do substantially better than just predicting the majority class for every case.

---

### Table 9: Variables in the Equation — The Main Results Table

This is the core output. For each predictor, SPSS reports:

| Column | What it is | What it tells you |
|---|---|---|
| **B** | Log-odds coefficient | Direction of effect (+ or −), but not intuitive to interpret |
| **S.E.** | Standard error of B | Precision of the estimate |
| **Wald** | Test statistic (B / SE)² | Used to compute the significance of each predictor |
| **df** | Degrees of freedom | |
| **Sig.** | p-value | Whether predictor is statistically significant |
| **Exp(B)** | **Odds ratio** | **The key interpretable statistic** |
| **95% C.I. for Exp(B)** | Confidence interval | Range of plausible odds ratios |

**How to read each predictor:**

1. Check **Sig.**: if p < .05, the predictor is statistically significant
2. Read **Exp(B)**: the direction and magnitude of the effect
3. Check **95% CI for Exp(B)**: if this range does not cross 1, the result is significant (consistent with the p-value)

**Interpreting Exp(B) — the golden rule:**

- Exp(B) > 1: the predictor **increases** the odds of the outcome
- Exp(B) < 1: the predictor **decreases** the odds of the outcome
- "1.00 more" → multiply the odds by Exp(B)
- "Lower odds by X%" → calculate (1 − Exp(B)) × 100

**Example interpretations:**

| Exp(B) | How to say it |
|---|---|
| 2.5 | "...had 2.5 times the odds of the outcome" |
| 0.4 | "...had 60% lower odds of the outcome (Exp(B) = 0.40)" |
| 1.0 | "No significant difference in odds" |
| 3.8 | "...were 3.8 times as likely to [outcome]" |

---

## 7. Worked Case Example: Voting Behaviour

### Research question

Does social class predict the likelihood of voting in a general election, controlling for age and gender?

### Variables

| Variable | Role | Type | Coding |
|---|---|---|---|
| Voted | Dependent variable | Binary | 1 = voted, 0 = did not vote |
| Social class | Predictor | Categorical | 1 = working class (reference), 2 = professional class |
| Age | Predictor | Continuous | Age in years |
| Gender | Predictor | Categorical | 0 = male (reference), 1 = female |

### Sample output: Variables in the Equation

| | B | S.E. | Wald | df | Sig. | Exp(B) | 95% CI Lower | 95% CI Upper |
|---|---|---|---|---|---|---|---|---|
| Social class (professional) | 1.163 | 0.287 | 16.44 | 1 | .000 | **3.20** | 1.83 | 5.60 |
| Age | 0.042 | 0.011 | 14.57 | 1 | .000 | **1.04** | 1.02 | 1.07 |
| Gender (female) | 0.218 | 0.231 | 0.89 | 1 | .345 | **1.24** | 0.79 | 1.95 |
| Constant | −3.441 | 0.573 | 36.08 | 1 | .000 | 0.032 | | |

### Interpretation of each predictor

**Social class:**
> Professional-class respondents had significantly higher odds of voting compared to working-class respondents (Exp(B) = 3.20, 95% CI [1.83, 5.60], p < .001). After controlling for age and gender, professional-class respondents had 3.2 times the odds of voting.

**Age:**
> Age was a significant positive predictor of voting (Exp(B) = 1.04, 95% CI [1.02, 1.07], p < .001). For each additional year of age, the odds of voting increased by approximately 4%.

**Gender:**
> Gender was not a significant predictor of voting behaviour (Exp(B) = 1.24, 95% CI [0.79, 1.95], p = .345). There was no statistically significant difference in the odds of voting between men and women once social class and age were controlled for.

### Model fit

Assume the following from the output:

| Statistic | Value | Interpretation |
|---|---|---|
| Omnibus test | χ²(3) = 47.2, p < .001 | Model significantly better than null |
| Nagelkerke R² | .28 | Moderate — model explains approximately 28% of variance |
| Hosmer-Lemeshow | χ²(8) = 6.3, p = .614 | Good fit — no significant discrepancy |
| Overall classification | 81.4% | Model correctly classifies 81.4% of cases |

---

## 8. Common Problems and How to Fix Them

### Problem 1: Complete or Quasi-Complete Separation

**What it looks like:** Extremely large B coefficients (e.g. B = 20.5), very large standard errors, and a warning in your output about "a singular matrix" or "the solution did not converge."

**What it means:** One predictor (or combination of predictors) perfectly — or near-perfectly — predicts the outcome. The model cannot estimate a coefficient because the likelihood function never converges.

**Example:** If every professional-class respondent in your dataset voted and no working-class respondent did, SPSS cannot estimate the odds ratio — it would technically be infinite.

**How to fix it:**
- Collapse categories within the problematic variable
- Remove the problematic predictor from the model
- Consider Firth logistic regression (not available in base SPSS — requires R or Stata)

---

### Problem 2: Categorical Predictors Treated as Continuous

**What it looks like:** Your categorical variable appears in the Variables in the Equation table as a single line (e.g. "Social_class") rather than as separate dummy variable lines (e.g. "Social_class(1)", "Social_class(2)"). The Categorical Variables Codings table is missing it.

**What it means:** You did not use the `Categorical` button. SPSS treated the variable as continuous and assigned a linear slope to it — which is meaningless for a nominal or ordinal variable.

**How to fix it:** Re-run the analysis and use the `Categorical` button to declare all categorical predictors. Set the reference category explicitly.

---

### Problem 3: Exp(B) is in the Wrong Direction

**What it looks like:** You expected professional class to increase the odds of voting, but Exp(B) is less than 1.

**What it means:** The reference category is probably not what you think. A result "less than 1" means the group listed has *lower* odds than the reference. If the reference is professional class, then working class has Exp(B) = 0.31 — meaning working class has 69% lower odds — which is mathematically the same as professional class having 3.2 times the odds (1/0.31 = 3.2).

**How to fix it:** Check the Categorical Variables Codings table to confirm which group is the reference. Recode your variable if needed so the reference category is theoretically appropriate.

---

### Problem 4: Model is Significant but Hosmer-Lemeshow is Also Significant

**What it looks like:** The Omnibus test is significant (good), but the Hosmer-Lemeshow test is also significant (p < .05) — indicating poor fit.

**What it means:** The model explains some variance but does not accurately predict outcomes across all subgroups. This could indicate a missing interaction term, non-linearity in a continuous predictor, or an important unmeasured variable.

**What to do:**
- Test for interaction effects between predictors
- Apply the Box-Tidwell test to check linearity of continuous predictors
- Consider adding theoretically relevant variables
- Report this as a limitation in your write-up

---

### Problem 5: Very Low Nagelkerke R²

**What it looks like:** R² = 0.04 or similar — the model explains very little variance.

**What it means:** Your predictors are weak predictors of the outcome, or there are important variables missing from the model. In social science research, low R² values are common and not automatically a problem — social behaviour is complex and many factors are unmeasured.

**What to do:** Do not panic. Interpret significant predictors as meaningful even with a low R². Acknowledge the low R² and discuss what factors might be unaccounted for in your model.

---

### Problem 6: Non-Linearity in a Continuous Predictor (Box-Tidwell Significant)

**What it looks like:** When you add the `age × ln(age)` interaction term to the model, it is statistically significant (p < .05).

**What it means:** The effect of age on the log-odds of voting is not linear — it may increase rapidly at first then plateau, or there may be a U-shaped relationship.

**How to fix it:**
- Transform age (e.g. take the natural log of age)
- Categorise age into meaningful groups (e.g. 18–30, 31–50, 51+) and enter as a categorical predictor
- Include a quadratic term (age²) in the model

---

## 9. Writing Up Your Results

A clear write-up follows a structured order. Below is a template with the key elements.

### Paragraph 1: Introduce the model and check overall fit

> A binary logistic regression was conducted to examine the extent to which social class, age, and gender predicted the likelihood of voting in the 2019 general election. The model contained three predictors and was statistically significant (χ²(3) = 47.2, p < .001), indicating that the set of predictors reliably distinguished voters from non-voters. The Nagelkerke R² indicated that the model accounted for approximately 28% of the variance in voting behaviour. The Hosmer-Lemeshow test indicated an acceptable model fit (χ²(8) = 6.3, p = .614). The model correctly classified 81.4% of cases.

### Paragraph 2: Report each predictor

> Social class was a significant predictor of voting (Wald = 16.44, p < .001). Professional-class respondents had significantly higher odds of voting than working-class respondents (Exp(B) = 3.20, 95% CI [1.83, 5.60]), indicating that professional-class respondents had 3.2 times the odds of voting, controlling for age and gender. Age was also a significant predictor (Wald = 14.57, p < .001), with each additional year of age associated with a 4% increase in the odds of voting (Exp(B) = 1.04, 95% CI [1.02, 1.07]). Gender was not a significant predictor of voting behaviour (Wald = 0.89, p = .345; Exp(B) = 1.24, 95% CI [0.79, 1.95]).

### Things to always include when reporting

- The overall model chi-square, degrees of freedom, and p-value
- Nagelkerke R²
- Hosmer-Lemeshow result
- Overall classification accuracy
- For each significant predictor: Wald statistic, p-value, Exp(B), and 95% CI
- The reference category for each categorical predictor
- Whether assumptions were met (or violated, and how you addressed it)

---

## 10. Quick Reference Summary

### Assumption checklist

| Assumption | Check with | Pass / Fail indicator |
|---|---|---|
| Binary DV | Frequencies | Exactly 2 values |
| Independence | Research design | Not repeated measures or clustered |
| No multicollinearity | Linear regression VIF | VIF < 10, Tolerance > 0.10 |
| Linearity of log-odds | Box-Tidwell test | Interaction term p > .05 |
| No influential outliers | Cook's distance, Std. residuals | Cook's < 1; residuals within ±3 |
| Adequate sample size | Count events per predictor | ≥ 10 events per predictor |

### Output interpretation cheat sheet

| Output table | What to look at | Want / Threshold |
|---|---|---|
| Omnibus tests | Sig. | p < .05 (significant = good) |
| Model Summary | Nagelkerke R² | Higher is better; report it |
| Hosmer-Lemeshow | Sig. | p > .05 (non-significant = good) |
| Classification table | Overall % correct | Higher is better |
| Variables in the Equation | Exp(B) and its 95% CI | CI should not cross 1 if significant |

### Exp(B) interpretation guide

| Exp(B) | What to say |
|---|---|
| 4.00 | "...had 4 times the odds of [outcome]" |
| 2.50 | "...had 2.5 times the odds of [outcome]" |
| 1.04 | "...associated with a 4% increase in odds per one-unit increase" |
| 0.70 | "...had 30% lower odds of [outcome]" |
| 0.40 | "...had 60% lower odds of [outcome]" |

---
## 11. $Exp(B)$ Interpretation
To say $Exp(B) = 2.5$ in percentage terms, you describe the **increase** in odds relative to the reference group.

An $Exp(B)$ of **2.5** means the group has **150% higher odds** (or a 150% increase in odds) compared to the reference group.

### The Calculation
To get the percentage, you subtract 1 from the $Exp(B)$ and multiply by 100:
$$(2.5 - 1) \times 100 = 150\%$$

### How to phrase it correctly
Depending on your audience, you can use three different ways to say the same thing:

* **The "Times" way (Easiest):** "Professional-class respondents have **2.5 times the odds** of voting."
* **The "Percentage Increase" way:** "Professional-class respondents have **150% higher odds** of voting."
* **The "Comparison" way:** "The odds of voting are **150% greater** for the professional class than for the working class."

---

### Why is it 150% and not 250%?
Think of it like a price increase:
* If a product costs **1.0**, that is your baseline (100%).
* If the price becomes **2.5**, it has increased by **1.5**. 
* An increase of **1.5** is a **150% increase**.

### Summary Table for Interpretation
| $Exp(B)$ | Interpretation in "Times" | Interpretation in % |
| :--- | :--- | :--- |
| **3.0** | 3 times the odds | 200% increase |
| **2.5** | 2.5 times the odds | **150% increase** |
| **1.1** | 1.1 times the odds | 10% increase |
| **1.0** | Same odds | 0% change (Baseline) |
| **0.4** | 0.4 times the odds | 60% decrease |

Does this 150% increase make sense in the context of your specific research project?

---
