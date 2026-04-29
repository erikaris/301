# Linear Regression

Use when outcome is **numeric and continuous**

### Example (clinical)

* Predict **systolic blood pressure** from:

  * age
  * BMI
  * smoking status

### Model idea

$$y = \beta_0 + \beta_1 x_1 + \beta_2 x_2 + \cdots + \epsilon$$

### How to explain coefficients

* $$β₁$$ = change in outcome for 1-unit increase in predictor

**Example interpretation**

> “Each additional year of age is associated with a 0.8 mmHg increase in systolic blood pressure.”


### Key assumptions

* Linear relationship
* Residuals roughly normal
* Independent observations

### Normality
Regression does NOT require:
1. X to be normal
2. Y to be normal

It requires residuals to be approximately normal (for small-sample inference).
