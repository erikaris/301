
# **“Do you know what makes data ‘paired’?”**

Data are **paired** when **each observation in one group can be logically linked to exactly one observation in the other group**, forming *pairs*.

The pairing creates dependence — the two values within a pair are *not independent*.

Mathematically:
Each pair ( (X_{i1}, X_{i2}) ) belongs to the same unit or matched unit.

---

# **What does “paired samples” mean?**

A **paired sample** consists of **two related measurements** for each unit (person/subject/matched entity).
The analysis is based on the **difference** within each pair:

[
d_i = X_{i1} - X_{i2}
]

The paired t-test examines whether the **mean of these differences** is zero.

---

# **Examples of paired samples**

### **1. Classic before/after on the same person**

* Weight before vs after a diet
* Blood pressure before vs after medication

This is the most common, but **not the only** type.

---

# ✅ **2. Same person, two conditions (not necessarily time-based)**

* Reaction time under caffeine vs without caffeine
* Heart rate lying down vs standing
* Test score under two different exam conditions

**Key point:**
Same individual measured twice under two conditions = paired.

---

# **3. Matched pairs (not the same person)**

Two different individuals are matched because they share important characteristics.
Then one is assigned to each group.

Examples:

* **Twin studies:** one twin receives treatment, the other is control.
* **Matched case–control studies:** Each patient with a disease is matched to a healthy control of same age, sex, and location. Compare outcome (e.g., cholesterol, blood pressure).
* **Educational studies:** Students matched on prior achievement: one assigned to new teaching method, one to standard method. Compare test scores.
* **Household / paired relationships** Compare husbands and wives on dietary habits, or parents and children on activity levels.
* **Experimental units** Pairs of plots of land with similar soil characteristics: one gets fertiliser, one does not.

---

# **4. Two measurements from the same experimental unit**

Not human-based:

* Pollution measured at the same location on two days
* Soil nutrient readings from the same plot pre- and post-fertiliser
* Machine output tested with two different settings
* Pain score from the same animal before and after treatment

---

# **5. “Natural” pairings**

Paired by nature, not by experiment:

* Left-hand vs right-hand grip strength (paired within the same person)
* Heart rate of mother–infant pairs
* Measurements on two eyes of the same patient
* Husband–wife income comparisons (paired by household)

---

# Is This Paired or Not Paired?

### **Example 1: Blood Pressure Before and After Medication**

* Measure BP for 30 patients before starting a drug and after 4 weeks.
  **Paired?** ✅ (same patient measured twice)

---

### **Example 2: Reaction Time Under Two Conditions**

* 25 students perform a reaction-time test **once with caffeine and once without**.
  **Paired?** ✅ (same person under two conditions)

---

### **Example 3: Comparing Two Different Groups**

* 50 men and 50 women complete a memory test once.
  **Paired?** ❌ (different people, independent groups)

---

### **Example 4: Twin Study**

* Twin A gets treatment, twin B does not. Measure outcome in both twins.
  **Paired?** ✅ (matched individuals)

---

### **Example 5: Heart Rate on Left vs Right Arm**

* Measure HR simultaneously on left and right arm for 20 patients.
  **Paired?** ✅ (same patient, two measurements)

---

### **Example 6: Classroom Test Scores**

* Class A vs Class B take the same exam. Each student only in one class.
  **Paired?** ❌ (students in different groups)

---

### **Example 7: Soil Nutrients**

* Measure nutrient levels in soil **before and after fertiliser** on the same plots.
  **Paired?** ✅ (same experimental unit measured twice)

---

### **Example 8: Comparing Hospitals**

* Hospital X vs Hospital Y: compare average patient recovery times.
  **Paired?** ❌ (different hospitals, independent groups)

---

### **Example 9: Eye Pressure**

* Measure intraocular pressure in **left and right eye** of each patient.
  **Paired?** ✅ (two measurements per patient)

---

### **Example 10: Matched Case-Control Study**

* Each patient with a disease is matched to a healthy control by age/sex. Measure cholesterol.
  **Paired?** ✅ (matched pairs)

---

# Is This Paired or Not Paired? (With a Twist)

### **1. Blood Pressure in Two Hospitals**

* Hospital A: 50 patients measured once
* Hospital B: 50 patients measured once

**Tricky twist:**

* If the 50 patients in A are *age- and sex-matched* to the 50 in B → **paired**
* If random patients → **independent**

---

### **2. Student Test Scores**

* Compare pre-test and post-test scores for 30 students.

**Tricky twist:**

* If the *same students* do pre and post → **paired**
* If post-test is taken by a *different group of 30 students* → **independent**

---

### **3. Left vs Right Eye**

* Measure eye pressure in patients.

**Tricky twist:**

* If each patient contributes *both eyes* → **paired**
* If one group is left eyes and another group is right eyes from *different patients* → **independent**

---

### **4. Twin Study**

* Twin A gets treatment, Twin B does not.

**Tricky twist:**

* If you **compare within twin pairs** → **paired**
* If you treat all treated twins vs all untreated twins as two groups (ignoring pairing) → **independent** (less powerful)

---

### **5. Diet Intervention**

* Compare weight loss in adults who try diet A vs diet B.

**Tricky twist:**

* If individuals are **matched on BMI, age, sex**, and one gets diet A, one gets diet B → **paired**
* If participants are randomly assigned without matching → **independent**

---

### **6. Blood Sugar Measurements**

* Measure blood sugar at 8 AM and 2 PM in patients.

**Tricky twist:**

* If measurements are on the *same patients* → **paired**
* If 8 AM group is different from 2 PM group → **independent**

---

### **7. Patient Satisfaction**

* Compare satisfaction for telemedicine vs face-to-face appointments.

**Tricky twist:**

* If *same patients experience both types* → **paired**
* If one group only did telemedicine, the other only face-to-face → **independent**

---



