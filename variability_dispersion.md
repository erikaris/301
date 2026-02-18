
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

### Key Point:

They measure variability differently.

| IQR                  | Standard Deviation    |
| -------------------- | --------------------- |
| Uses quartiles       | Uses mean             |
| Robust to outliers   | Sensitive to outliers |
| Best for skewed data | Best for normal data  |
| Used with median     | Used with mean        |

---

## 5. Mathematical Relationship (ONLY if data are normal)

There is no general formula linking IQR and SD. They are only approximately related if the data are normally distributed. 
If data are **normally distributed**:

<img src="images/IQR-1.webp" alt="Description" width="400">

$$
IQR \approx 1.35 \times SD
$$

Or:

$$
SD \approx \frac{IQR}{1.35}
$$

### How so?
The short answer:

We get **±0.674 SD** from the **standard normal distribution (Z distribution)**.

---

# Step 1: Think in Z-scores

In a normal distribution, we standardise values using:

$$
Z = \frac{X - \mu}{SD}
$$

So instead of thinking in raw units, we think in **standard deviation units**.

---

# Step 2: What does Q1 mean?

Q1 is the **25th percentile**.

That means:

$$
P(X < Q1) = 0.25
$$


In Z-score language:

[
P(Z < z_{0.25}) = 0.25
]

So we are asking:

👉 What Z-value cuts off the lowest 25% of a normal distribution?

---

# Step 3: Look at the standard normal table

If you check a Z-table (or statistical software), the Z-value that gives cumulative probability = 0.25 is:

[
z = -0.674
]

Similarly:

The Z-value for cumulative probability = 0.75 (Q3) is:

[
z = +0.674
]

Because the normal distribution is symmetric.

---

# Step 4: Convert Back to SD Units

Since Z tells us “how many SDs from the mean”:

* Q1 is 0.674 SD below the mean
* Q3 is 0.674 SD above the mean

So:

[
IQR = 0.674SD - (-0.674SD)
]

[
IQR = 1.349SD \approx 1.35SD
]

That’s where everything comes from.

---

# How This Connects to the 68–95–99.7 Rule

The empirical rule comes from specific Z-values too:

* ±1 SD → 68%
* ±2 SD → 95%
* ±3 SD → 99.7%

Similarly:

* ±0.674 SD → 50%

So the IQR is simply the SD-distance that captures 50% of the distribution.

---

# Intuitive Way to Think About It

The normal curve is perfectly symmetric.

* The median is at 0 SD.
* To capture the middle 50%, you move out equally on both sides.
* The amount you move is 0.674 SD.

That’s all it is — it comes from the probability table.

---

# How You Can Explain It in the Tutorial

You can say:

> “The values ±0.674 come from the standard normal distribution table. They are the Z-scores that leave 25% of the data in each tail. Since Z-scores represent standard deviation units, Q1 and Q3 must be 0.674 SD away from the mean in a normal distribution.”

---

If you'd like, I can also show you a super simple visual explanation you can draw in under 30 seconds during the session.


---

# The Core Insight

Both:

* ±1 SD → 68%
* ±0.674 SD → 50%

come from solving the same probability equation:

$$
P(-a < Z < a) = desired\ percentage
$$

The only difference is the probability you plug in.

---

## 6. When Do We Use Each?

### Use Median + IQR when:

* Data are skewed (income, hospital stay length, waiting time)
* Small sample size
* Outliers present

### Use Mean + SD when:

* Data approximately normal
* Large epidemiological samples
* Parametric tests (t-test, ANOVA)

---

## In a nutshell:
> “Standard deviation tells us how far values spread around the mean.
> IQR tells us how wide the middle 50% of values are.
> SD is sensitive; IQR is robust.”

