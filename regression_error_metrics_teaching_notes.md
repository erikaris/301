# Regression error metrics: MAE, SSE, MSE, RMSE

---

## 1. Start here: the residual

A model predicts a value for each hill. The **residual** (or error) is how far the guess is from the truth:

```
residual = actual time - predicted time
```

- Positive residual: the model guessed too low.
- Negative residual: the model guessed too high.

Every metric below is just a different way of summarising the residuals into one number.

---

## 2. The four metrics at a glance

| Metric | What you do | Unit | Plain meaning |
|---|---|---|---|
| **MAE** (mean absolute error) | Ignore the signs, then average | hours | The typical miss |
| **SSE** (sum of squared errors) | Square each residual, then add up | hours squared | Total penalty points |
| **MSE** (mean squared error) | SSE divided by the number of rows | hours squared | Average penalty |
| **RMSE** (root mean squared error) | Square root of MSE | hours | Average penalty, back in hours |

One line to remember: **MAE treats every miss equally. SSE, MSE and RMSE punish big misses harder.**

For all four, lower is better, and they only make sense when comparing models on the **same test set**.

---

## 3. Worked example: five test hills

| Hill | Residual | Absolute error | Squared error |
|---|---|---|---|
| A | +0.2 | 0.2 | 0.04 |
| B | -0.1 | 0.1 | 0.01 |
| C | +0.3 | 0.3 | 0.09 |
| D | -0.2 | 0.2 | 0.04 |
| E | +0.9 | 0.9 | 0.81 |
| **Sum** | | **1.7** | **0.99** |

| Metric | Calculation | Result |
|---|---|---|
| MAE | 1.7 / 5 | 0.34 hours |
| SSE | sum of squared errors | 0.99 |
| MSE | 0.99 / 5 | 0.198 |
| RMSE | square root of 0.198 | 0.445 hours |

![Residuals of five test hills around a fitted line, and how they turn into MAE, SSE, MSE and RMSE](figures/figure1_residuals_and_metrics.png)

Things to point out:

- Hill E is the big miss. Its squared error (0.81) makes up most of the SSE (0.99).
- RMSE (0.445) is larger than MAE (0.34) because squaring lets the one big miss count for more.

---

## 4. Why MAE alone is not enough

Two models, same MAE, very different behaviour.

| Hill | Model A error | Model B error |
|---|---|---|
| A | 0.3 | 0 |
| B | 0.3 | 0 |
| C | 0.3 | 0 |
| D | 0.3 | 0 |
| E | 0.3 | 1.5 |

Rough picture (one block is about 0.1 hours of error):

```
Model A:  A ###   B ###   C ###   D ###   E ###
Model B:  A       B       C       D       E ###############
```

![Model A has five small misses and Model B has one large miss, yet both have an MAE of 0.30 hours](figures/figure2_same_mae_different_rmse.png)

| Metric | Model A | Model B |
|---|---|---|
| MAE | 0.30 | 0.30 |
| SSE | 0.45 | 2.25 |
| MSE | 0.09 | 0.45 |
| RMSE | 0.30 | 0.67 |

- MAE says the two models are equally good.
- SSE, MSE and RMSE see the difference: Model B has one very large miss.

**Ask the class:** "Which model would you trust to predict a hill it has never seen?" Most pick Model A. That is exactly what RMSE sees and MAE does not.

---

## 5. Why not just settle with MAE?

You can. MAE is a valid and easy metric. The squared metrics exist for two reasons:

1. **Big misses can matter more than small ones.** If a 3-hour error is much worse than three 1-hour errors (for example when planning rescue cover for a race), squaring reflects that.
2. **Regression is fitted this way.** `LinearRegression().fit()` chooses the line that minimises SSE (least squares). Reporting SSE, MSE and RMSE matches how the model was trained.

The counterpoint to mention:

- Squaring lets one outlier dominate. Bens of Jura inflates SSE, MSE and RMSE far more than MAE. If an outlier is a one-off, MAE gives a fairer picture of the typical error.

---

## 6. How to read them together

- **Report MAE and RMSE side by side.**
- If they are **close**, the errors are fairly even across hills.
- If RMSE is **much larger** than MAE, a few predictions are far off. Look at which hills they are.
- SSE and MSE are mostly stepping stones to RMSE. MSE is useful when comparing test sets of different sizes.

---

## 7. How to explain it step by step

1. Residual: "how far off was the guess?"
2. MAE: "the average miss."
3. SSE: "square each miss as a penalty, then add up the penalty points. A miss of 1 costs 1. A miss of 3 costs 9."
4. MSE: "average the penalty, so a 5-row and a 300-row test set are comparable."
5. RMSE: "square root, so the error is in hours again."
6. Show Section 4 and ask which model they would trust.

Avoid starting with formulas or with "SSE is what regression minimises". Introduce that later, once squaring as a penalty makes sense.

---

## 8. Where this appears in the worksheet

```python
from sklearn.metrics import mean_squared_error, root_mean_squared_error
import numpy as np

mae  = np.mean(abs(residuals))
sse  = (residuals**2).sum()
mse  = mean_squared_error(actual, predicted)
rmse = root_mean_squared_error(actual, predicted)
```

In the worksheet these are computed on the 5 test hills for `model_dist`, and students repeat them for `model_climb`. The model with the lower values has the shorter residuals overall.

---

## 9. Cautions to mention

- With only **5 test hills**, these numbers are noisy. One unusual hill can swing them a lot, so treat differences between models as suggestive, not conclusive.
- Compare models only on the **same test set**.
- Training R-squared and test error answer different questions. R-squared on the training data says how well the line fits hills it has already seen. Test errors say how far off predictions will be on new hills.

---

## 10. Quick cheat sheet

| Question the student asks | Answer |
|---|---|
| "How far off am I typically?" | MAE |
| "Do I have any really bad misses?" | Compare RMSE with MAE |
| "Which model is better on this test set?" | Lower MAE and lower RMSE |
| "Why is RMSE bigger than MAE?" | Squaring weights big misses more |
| "Why is the unit of MSE odd?" | It is hours squared, so take the square root to get RMSE |
