
## **Understand the Topic Yourself: Test of Repeatability**

**Definition in simple terms:**
A **Test of Repeatability** (sometimes called the **intra-class correlation coefficient, ICC**) measures **how consistent or reliable repeated measurements are for the same item, individual, or sample under the same conditions**.
> Repeatability measures how consistent repeated measurements are for the same subject/sample.
> High repeatability → measurements are reliable; Low → large measurement error.

* Example in animal & plant science:

  * Measuring the **height of the same plant multiple times** or measuring **enzyme activity in the same sample repeatedly**.
  * You want to see **how much variation comes from the sample itself vs. measurement error**.

**Key points to remember:**

* Repeatability = proportion of total variation due to **true differences between subjects**.
* High repeatability → the measurement is reliable.
* Low repeatability → large measurement error, data may be noisy.

**Formula (basic concept):**

[
\text{Repeatability (R)} = \frac{\text{Variance between subjects}}{\text{Variance between subjects + Variance within subjects}}
]

* “Between subjects” → real differences between plants, animals, samples.
* “Within subjects” → measurement error, environmental noise.

---

## **How to understand it better**

1. Imagine you measure the same plant’s height 5 times. If all 5 measurements are almost the same, your measurement is highly repeatable. If they vary a lot, repeatability is low.
2. Calculating repeatability helps you see if your measurements are reliable enough to trust for analysis.
3. The repeatability can be calculated using:
     * **ANOVA-based methods** (variance components)
     * **Intra-class correlation (ICC)** in R or SPSS
   * If the data is continuous: use ICC.
   * If binary/categorical: there are adapted methods.

---

## **Steps to Tackle Data/Problem**

1. **Ask about the dataset:**

   * Number of subjects (plants, animals, samples)?
   * Number of repeated measurements per subject?
   * Type of variable: continuous, categorical, or ordinal?

2. **Choose a method:**

   * **Continuous data:** ANOVA variance components or ICC.
   * **Binary/categorical:** use generalized linear mixed models to estimate repeatability.

3. **Calculate repeatability (if in R):**

   ```R
   library(rptR)
   # Example: for a continuous trait 'height' measured on 'plantID'
   rpt(height ~ (1|plantID), grname="plantID", data=yourdata, datatype="Gaussian", nboot=1000, npermut=0)
   ```

4. **Interpret results:**

   * R = 0 → no repeatability (all variation is noise)
   * R = 1 → perfect repeatability (all variation is true differences)
   * Usually, R > 0.7 is considered high.
     
---

## **Quick Prep Summary (to have in your head)**

| Point       | Key Notes                                                         |
| ----------- | ----------------------------------------------------------------- |
| Definition  | Measures consistency of repeated measurements on same subject     |
| Formula     | R = σ²_between / (σ²_between + σ²_within)                         |
| High R      | Reliable measurements                                             |
| Low R       | Measurement error dominates                                       |
| Methods     | ANOVA, ICC, mixed models                                          |
| Student Tip | Always check number of repeats, type of variable, and assumptions |

---

### ** Example Dataset (3 plants measured 3 times)**

| PlantID | Measurement |
| ------- | ----------- |
| A       | 10          |
| A       | 11          |
| A       | 10.5        |
| B       | 15          |
| B       | 14.8        |
| B       | 15.2        |
| C       | 8           |
| C       | 9           |
| C       | 8.5         |

* **Between-subject variance:** differences between A, B, C
* **Within-subject variance:** variation among repeated measures for each plant

---

### ** How to Calculate in R**

**Step 1: Prepare data**

```R
# Install if not already
install.packages("rptR")
library(rptR)

# Example dataset
data <- data.frame(
  PlantID = rep(c("A", "B", "C"), each=3),
  Height = c(10,11,10.5,15,14.8,15.2,8,9,8.5)
)

# Calculate repeatability
rpt_result <- rpt(Height ~ (1|PlantID), grname="PlantID",
                  data=data, datatype="Gaussian", nboot=1000, npermut=0)
print(rpt_result)
```

**Step 2: Interpretation**

* Look at `R` value:

  * R ~ 0 → low repeatability (high measurement error)
  * R ~ 1 → high repeatability (measurements consistent)
* Confidence intervals indicate uncertainty.

---

### ** How to Calculate in SPSS**

**Step 1: Organize data**

* Two columns:

  * `PlantID` (Subject ID)
  * `Height` (Measurement)
* Each row = 1 measurement

**Step 2: Run ICC**

1. Go to **Analyze → Scale → Reliability Analysis**
2. Click **Statistics → Intraclass Correlation Coefficient (ICC)**
3. Select **“Two-way mixed”** or **“Two-way random”**, depending on your design
4. Click **OK**

**Step 3: Interpretation**

* ICC value = Repeatability
* > 0.7 → good repeatability
* <0.5 → poor repeatability

---
# Intepreting ICC

## **1. ICC ≈ 0.7 or higher → Good Repeatability**

**Interpretation:**

* Measurements are consistent; most variation comes from **true differences between subjects**.
* Your measurement method is reliable.

**Action:**

* You can proceed with your analysis confidently.
* Use the repeated measurements as they are in further statistical models.
* No major changes needed to measurement protocol.

**Example:**

* Plant heights measured 3 times → almost same each time for each plant → high ICC.
* Can trust the measured values for analysis or modeling.

---

## **2. ICC between ~0.5 – 0.7 → Moderate Repeatability**

**Interpretation:**

* Measurements are **somewhat reliable**, but there’s noticeable **measurement error**.

**Action:**

* Consider **improving measurement consistency**:

  * Use the same instrument or protocol more carefully
  * Train measurers
  * Increase number of repeats to reduce noise
* You can still use data but **acknowledge some uncertainty** in your analysis.

**Example:**

* Plant height measured by multiple lab members → slight variation.
* Could standardize method or take more repeats per plant.

---

## **3. ICC < 0.5 → Poor Repeatability**

**Interpretation:**

* Most of the variation comes from **measurement error** rather than true differences.
* Current measurements are **not reliable**.

**Action:**

* **Do not trust these measurements** for analysis yet.
* Investigate **sources of error**:

  * Different measurers or instruments
  * Inconsistent experimental protocol
  * Environmental factors affecting measurements
* **Increase repeats** or **standardize protocol** before proceeding.

**Example:**

* Enzyme activity measured inconsistently between replicates → need stricter lab protocol or better instruments.

---

## **ICC Calculation in SPSS**
* In SPSS, the ICC can be computed with different **models**, depending on the assumptions about your raters/measurements.

---

## ** Two-Way Models in SPSS**

* **Two-way** = both **subjects** and **raters/measurements** are considered as factors.
* It considers variability due to **both subjects** and **raters/measurements** in the ANOVA.

Now, the difference lies in **whether raters/measurements are random or fixed**.

---

### **A) Two-Way Random (ICC[2])**

* Assumes **both subjects and raters are random samples** from a larger population.
* Use this if you want to **generalize the ICC to other raters**.
* Example: You measured plant height using **different students as raters**, and you want to generalize to any student.

**Interpretation:** The ICC tells you **reliability that could apply to other raters**, not just the ones in your dataset.

---

### **B) Two-Way Mixed (ICC[3])**

* Assumes **subjects are random**, but **raters are fixed** (i.e., specific raters of interest).
* Use this if you only care about **these specific raters**.
* Example: You measured plant height with **just your lab technician**, and you only care about **this technician’s measurements**.

**Interpretation:** The ICC tells you **reliability for the specific raters in your study**, not generalizable beyond them.

---

## **3️⃣ Quick Summary Table**

| Model          | Subjects | Raters/Measurements | Use Case                                       |
| -------------- | -------- | ------------------- | ---------------------------------------------- |
| Two-way random | Random   | Random              | Generalize to other raters                     |
| Two-way mixed  | Random   | Fixed               | Only interested in these raters                |
| One-way random | Random   | N/A                 | When each subject measured by different raters |

---




