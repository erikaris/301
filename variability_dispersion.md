
# Data Variability and Measurement Metrics

## 1. Interquartile Range (IQR)

**Definition:**
[
IQR = Q3 - Q1
]

* **Q1 (25th percentile)** = value below which 25% of data fall
* **Q3 (75th percentile)** = value below which 75% of data fall
* So IQR = spread of the **middle 50%** of the data

### Interpretation example
In Public Health context:
* If BMI IQR = 4 kg/m² → the middle half of participants vary by 4 units.
* It measures **dispersion without being affected by extreme values**.

It is a **robust measure of variability**.

---

## 2. Standard Deviation (SD)

**Definition (conceptually):**
Average distance of observations from the mean.

* Uses **all data points**
* Sensitive to **outliers**
* Best for **normally distributed data**

---

### Example for IQR and SD

Use a small dataset:

Data:
2, 4, 5, 7, 8, 9, 12

### Step 1: Median

Median = 7

### Step 2: Q1

Lower half: 2, 4, 5
Q1 = 4

### Step 3: Q3

Upper half: 8, 9, 12
Q3 = 9

[
IQR = 9 - 4 = 5
]

Then explain:

* IQR only uses the **middle 50%**
* The value 12 does not strongly affect IQR
* But 12 *will* increase SD

---

## 4. Link Between IQR and Standard Deviation (Most Important Part)

There is no general fixed relationship between IQR and SD.
They are only mathematically related if the data follow a normal distribution.

## Key Point:

They measure variability differently.

| IQR                  | Standard Deviation    |
| -------------------- | --------------------- |
| Uses quartiles       | Uses mean             |
| Robust to outliers   | Sensitive to outliers |
| Best for skewed data | Best for normal data  |
| Used with median     | Used with mean        |

---

## Mathematical Relationship (ONLY if data are normal)

If data are **normally distributed**:

[
IQR \approx 1.35 \times SD
]

Or:

[
SD \approx \frac{IQR}{1.35}
]

This is true **only under normal distribution**.

This is likely what the student is confused about.

You can say:

> “There is no general formula linking IQR and SD. They are only approximately related if the data are normally distributed.”

---

# 4️⃣ When Do We Use Each? (Public Health context)

In MPH:

### Use Median + IQR when:

* Data are skewed (income, hospital stay length, waiting time)
* Small sample size
* Outliers present

### Use Mean + SD when:

* Data approximately normal
* Large epidemiological samples
* Parametric tests (t-test, ANOVA)

---

# 5️⃣ Possible Follow-Up Questions They May Ask

Be ready for:

### ❓ Why does SD change more with outliers?

Because it squares deviations.

### ❓ Can I calculate IQR in SPSS?

Yes:
Analyze → Descriptive Statistics → Explore → Tick Percentiles

### ❓ Which should I report in my assignment?

Check:

* Distribution shape
* What statistical test they’re using

---

# 6️⃣ Simple Way to Explain the Core Difference

You can say:

> “Standard deviation tells us how far values spread around the mean.
> IQR tells us how wide the middle 50% of values are.
> SD is sensitive; IQR is robust.”

That sentence alone usually clarifies everything.

---

# 7️⃣ If You Have 1 Extra Minute

Draw a boxplot:

* Box length = IQR
* Whiskers extend further
* Outliers shown separately

Explain:
→ IQR is literally the width of the box.

---

# 8️⃣ Quick Teaching Flow You Can Follow

1. Define IQR
2. Calculate IQR from small example
3. Define SD conceptually
4. Compare sensitivity to outliers
5. Explain the 1.35 relationship under normality
6. Apply to Public Health example

---

If you want, I can also give you:

* A 1-minute whiteboard explanation script
* A practice question you can give the student
* A quick SPSS demo explanation
* Or a simple visual explanation you can sketch

You’re ready 👍
