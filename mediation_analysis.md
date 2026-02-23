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

# **Checking Assumptions in Mediation: What to Test**

Remember: mediation involves **two regressions**:

1. **Model 1:** M = aX
2. **Model 2:** Y = c’X + bM

Most assumptions are **regression assumptions**, and the key point:

> **You do NOT test X, M, or Y directly for normality or linearity. You test the residuals from the regression models.**

---

## **1. Missing Data**

* **Test:** All variables (X, M, Y)
* **Why:** Regression cannot handle missing data unless using imputation.
* **SPSS:**

  * Analyze → Descriptive Statistics → Frequencies → check % missing
* **R:**

  ```r
  summary(data)
  sapply(data, function(x) sum(is.na(x)))
  ```

---

## **2. Outliers**

* **Test:** Residuals from each regression
* **SPSS:**

  1. Analyze → Regression → Linear

     * Model 1: DV = M, IV = X
     * Model 2: DV = Y, IV = X + M
  2. Save → Standardized Residuals, Cook’s Distance, Leverage
  3. Inspect columns: |ZRESID| > 3, Cook’s D > 1, high leverage
* **R:**

  ```r
  model1 <- lm(M ~ X, data = data)
  model2 <- lm(Y ~ X + M, data = data)
  plot(rstandard(model1)) # residuals for M
  plot(rstandard(model2)) # residuals for Y
  ```

---

## **3. Linearity**

* **Test:** Relationship between predictors and outcome

  * Model 1: X → M
  * Model 2: X + M → Y
* **SPSS:**

  * Plot ZRESID vs ZPRED (saved from regression)
  * Look for random scatter; curved/funnel → violation
* **R:**

  ```r
  plot(fitted(model1), resid(model1)) # X → M
  abline(h=0, col="red")
  plot(fitted(model2), resid(model2)) # X+M → Y
  abline(h=0, col="red")
  ```

---

## **4. Homoscedasticity**

* **Test:** Variance of residuals across predicted values

  * Model 1: M regression residuals
  * Model 2: Y regression residuals
* **SPSS:** Same ZRESID vs ZPRED plots as linearity
* **R:** Same plots; check for “funnel shape”

---

## **5. Normality of Residuals**

* **Test:** Residuals only (ZRESID)

  * Model 1: residuals from M = X
  * Model 2: residuals from Y = X + M
* **SPSS:**

  1. Save ZRESID from each regression
  2. Analyze → Descriptives → Explore → Plots → Histogram & Normality plots
* **R:**

  ```r
  hist(resid(model1))
  qqnorm(resid(model1)); qqline(resid(model1))
  shapiro.test(resid(model1))  # optional, not critical if N>100 or bootstrapping
  hist(resid(model2))
  qqnorm(resid(model2)); qqline(resid(model2))
  shapiro.test(resid(model2))
  ```

> **Important:** You **do not** test X, M, or Y themselves for normality — only residuals.

---

## **6. Multicollinearity (only in model 2, if multiple mediators)**

* **Test:** Predictors in Y = X + M1 + M2
* **SPSS:**

  * Regression → Statistics → Collinearity diagnostics → check VIF (<5), Tolerance (>0.2)
* **R:**

  ```r
  library(car)
  vif(model2)
  ```

---

## **7. Independence of Residuals**

* **Test:** Model 2 residuals
* **SPSS:** Durbin-Watson in regression output (acceptable: 1.5–2.5)
* **R:**

  ```r
  dwtest(model2) # requires lmtest package
  ```

---

# **Quick Reference Table: Which Variable / Residual to Test**

| Assumption        | Model   | What to Check            | SPSS / R                   |
| ----------------- | ------- | ------------------------ | -------------------------- |
| Missing data      | Both    | X, M, Y                  | Frequencies / summary()    |
| Outliers          | Model 1 | residuals M              | ZRESID / rstandard(model1) |
| Outliers          | Model 2 | residuals Y              | ZRESID / rstandard(model2) |
| Linearity         | Model 1 | residuals M vs predicted | Plot ZRESID vs ZPRED       |
| Linearity         | Model 2 | residuals Y vs predicted | Plot ZRESID vs ZPRED       |
| Homoscedasticity  | Both    | residuals vs predicted   | Same plots                 |
| Normality         | Both    | residuals                | Histogram, Q-Q plot        |
| Multicollinearity | Model 2 | predictors X + M(s)      | VIF/Tolerance              |
| Independence      | Model 2 | residuals Y              | Durbin-Watson              |

---

**Key Teaching Point to Emphasize:**

> “In mediation, you **never test the original variables** for regression assumptions. Always test the **residuals** from each regression model. The first model (M ~ X) has its own residuals, the second model (Y ~ X + M) has its residuals. Normality, linearity, homoscedasticity are all about these residuals, not X, M, or Y themselves.”

---




