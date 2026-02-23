# **Mediation Analysis: Summary**

Mediation analysis is a statistical technique used to examine whether the effect of an independent variable (**X**) on a dependent variable (**Y**) is transmitted through one or more intermediary variables called **mediators (M)**. It allows researchers to test **how** or **why** a particular relationship occurs.

---

### **Key Concepts**

1. **Direct effect (c’):**
   The effect of X on Y **not explained** by the mediator(s).

2. **Indirect effect (a × b):**
   The portion of the effect of X on Y that **operates through the mediator**.

   * a = effect of X on M
   * b = effect of M on Y

3. **Total effect (c):**
   The sum of direct and indirect effects:
   c = c’ + (a × b)

4. **Multiple Mediation:**
   When more than one mediator is included, the model estimates **parallel indirect pathways**.

---

### **Assumptions**

Mediation analysis relies on standard **regression assumptions** (linearity, homoscedasticity, no multicollinearity, normality of residuals) and **conceptual assumptions** (temporal ordering, no omitted confounders).

---

### **Modern Approach**

* Bootstrapping (e.g., 5000 resamples) is commonly used to estimate confidence intervals for indirect effects.
* Bootstrapping relaxes the assumption of normally distributed indirect effects.

---

### **Interpretation Example (Psychology)**

> For example, a study might test whether academic stress (X) affects depression (Y) through rumination (M1) and sleep quality (M2). Mediation analysis allows researchers to quantify how much of the effect of stress on depression is explained by these psychological processes.

---

Absolutely — let’s make a **concise, report-ready summary** of mediation assumptions and how to check them in SPSS. You can copy-paste this into a methods/results section.

---

# **Assumptions for Mediation Analysis and How to Test Them (SPSS)**

Mediation analysis is regression-based, so assumptions are primarily the standard **linear regression assumptions**, plus conceptual checks.

---

## **1. Missing Data**

**Assumption:** Minimal missing data; missingness is random.

**SPSS Check:**

* Analyze → Descriptive Statistics → Frequencies
* Inspect % missing per variable.
* If <5%, listwise deletion is acceptable.

---

## **2. Outliers**

**Assumption:** No extreme cases that distort results.

**SPSS Check:**

1. Run regression: Analyze → Regression → Linear

   * DV = Y, IVs = X + M(s)
   * Save → Standardized Residuals, Cook’s Distance, Leverage
2. Inspect columns:

   * Standardized residuals > ±3
   * Cook’s D > 1
   * High leverage points

---

## **3. Linearity**

**Assumption:** Relationship between predictors (X, M) and outcome (Y) is linear.

**SPSS Check:**

* Plot Standardized Predicted Values (ZPRED) vs Standardized Residuals (ZRESID)
* Random scatter → OK
* Curved/funnel pattern → violation

---

## **4. Homoscedasticity**

**Assumption:** Equal variance of residuals across predicted values.

**SPSS Check:**

* Use same plot as linearity (ZPRED vs ZRESID)
* Look for consistent spread (no funneling).

---

## **5. Normality of Residuals**

**Assumption:** Residuals (errors) are approximately normally distributed.

> **Important:** Do **not** test X, M, or Y directly.

**SPSS Check:**

1. Save ZRESID (standardized residuals) from regression
2. Analyze → Descriptive Statistics → Explore → Plots → Histogram & Normality plots with tests
3. Check:

   * Histogram roughly bell-shaped
   * Q–Q plot points near diagonal line

**Note:** With bootstrapping (e.g., PROCESS macro), minor deviations are acceptable.

---

## **6. Multicollinearity**

**Assumption:** Predictors (X + M(s)) are not too highly correlated.

**SPSS Check:**

* Regression → Statistics → Collinearity diagnostics
* Check VIF (<5, ideally <3) and Tolerance (>0.2)

---

## **7. Independence of Residuals**

**Assumption:** Residuals are independent.

**SPSS Check:**

* Durbin-Watson statistic in regression output (acceptable range: 1.5–2.5)

---

## **8. Conceptual Assumptions**

1. **Temporal order:** X → M → Y

   * Cross-sectional data limits causal claims → phrase as “consistent with mediation”
2. **No omitted confounders:** No unmeasured variables affect both M and Y, or X and M

---

# **Summary Table for Report**

| Assumption                | How Checked in SPSS                        | Notes                                      |
| ------------------------- | ------------------------------------------ | ------------------------------------------ |
| Missing data              | Frequencies                                | <5% missing is acceptable                  |
| Outliers                  | Standardized residuals, Cook’s D, leverage | Remove/run sensitivity analysis if extreme |
| Linearity                 | ZRESID vs ZPRED plot                       | Random scatter = ok                        |
| Homoscedasticity          | ZRESID vs ZPRED plot                       | Even spread across predicted values        |
| Normality of residuals    | Histogram + Q–Q plot of ZRESID             | Minor deviations ok with bootstrapping     |
| Multicollinearity         | VIF <5, Tolerance >0.2                     | Critical in multiple mediation             |
| Independence of residuals | Durbin-Watson 1.5–2.5                      | Usually ok in cross-sectional data         |
| Conceptual                | Temporal order & no confounders            | Report in method section                   |

---

# **Example Write-Up for a Report**

> Prior to conducting the mediation analysis, assumptions of multiple regression were examined. Scatterplots of standardized predicted values versus standardized residuals indicated linear relationships and homoscedasticity. Standardized residuals were inspected for outliers (none exceeded ±3), and Cook’s Distance and leverage values were within acceptable limits. Multicollinearity among predictors was low (VIF < 3). Normality of residuals was assessed via histograms and Q–Q plots, with no substantial deviations observed. Given the use of bootstrapped confidence intervals (5000 samples), minor deviations from normality were not considered problematic. Conceptually, the mediation model assumes temporal order (X → M → Y) and no unmeasured confounders affecting the relationships.

---


