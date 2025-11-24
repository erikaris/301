Perfect! Let’s get you fully prepped for your 301 MASH session in just **13 minutes**. I’ll break it down step by step so you can understand, explain, and guide the student clearly.

---

## **1️⃣ Understand the Topic Yourself: Test of Repeatability**

**Definition in simple terms:**
A **Test of Repeatability** (sometimes called the **intra-class correlation coefficient, ICC**) measures **how consistent or reliable repeated measurements are for the same item, individual, or sample under the same conditions**.

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

## **2️⃣ How to Explain It to the Student**

1. **Start with a real-world analogy:**

   * “Imagine you measure the same plant’s height 5 times. If all 5 measurements are almost the same, your measurement is highly repeatable. If they vary a lot, repeatability is low.”

2. **Connect to their research:**

   * “If you are doing experiments in your PhD, calculating repeatability helps you see if your measurements are reliable enough to trust for analysis.”

3. **Link to statistical tests:**

   * The repeatability can be calculated using:

     * **ANOVA-based methods** (variance components)
     * **Intra-class correlation (ICC)** in R or SPSS
   * If their data is continuous: use ICC.
   * If binary/categorical: there are adapted methods.

---

## **3️⃣ Steps to Tackle Their Data/Problem**

1. **Ask about their dataset:**

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

## **4️⃣ How to Solve Student Issues in a Session**

**Step 1: Clarify their goal**

* “Do you just want to understand repeatability, or do you want to calculate it on your data?”

**Step 2: Show conceptually**

* Draw a quick diagram of “within-subject vs between-subject variance.”

**Step 3: Walk through calculation**

* If they have data: use R or Excel for simple variance components.
* If no data yet: do a conceptual example using small numbers.

**Step 4: Interpret & discuss implications**

* Explain what the result means for their experiment: reliability of measurement, design improvements.

---

## **5️⃣ Quick Prep Summary (to have in your head)**

| Point       | Key Notes                                                         |
| ----------- | ----------------------------------------------------------------- |
| Definition  | Measures consistency of repeated measurements on same subject     |
| Formula     | R = σ²_between / (σ²_between + σ²_within)                         |
| High R      | Reliable measurements                                             |
| Low R       | Measurement error dominates                                       |
| Methods     | ANOVA, ICC, mixed models                                          |
| Student Tip | Always check number of repeats, type of variable, and assumptions |

---

💡 **Pro Tip for tutoring:**

* Use a small example with **3 “plants” measured 3 times**. Students grasp repeatability much faster with a visual table:

| Plant | Measurement 1 | Measurement 2 | Measurement 3 |
| ----- | ------------- | ------------- | ------------- |
| A     | 10            | 11            | 10.5          |
| B     | 15            | 14.8          | 15.2          |
| C     | 8             | 9             | 8.5           |

* Then explain how **variance between plants vs variance within plants** gives repeatability.

---

If you want, I can make a **1-page “cheat sheet”** with:

* definition, formula, example table, R code, and interpretation ready for your 13-minute prep. It will make it super fast to explain in the session.

Do you want me to do that?
