# Linear Regression vs Logistic Regression vs Survival Analysis

# The big picture (teach this first — 1 minute)

Frame everything around **outcome type**:

| Outcome type     | Method              | Example                 |
| ---------------- | ------------------- | ----------------------- |
| Continuous       | Linear regression   | Blood pressure          |
| Binary (yes/no)  | Logistic regression | Disease (yes/no)        |
| Time until event | Survival analysis   | Time to death / relapse |


---


# Compare the three (this is gold in teaching)

| Feature | Linear     | Logistic       | Survival      |
| ------- | ---------- | -------------- | ------------- |
| Outcome | Continuous | Binary         | Time-to-event |
| Output  | β (change) | Odds ratio     | Hazard ratio  |
| Example | BP level   | Disease yes/no | Time to death |

---

# Simple case walkthrough

### Case 1: Blood pressure study

* Outcome: systolic BP
  → **Linear regression**

### Case 2: Diabetes diagnosis

* Outcome: yes/no
  → **Logistic regression**

### Case 3: Cancer survival

* Outcome: time until death
  → **Survival analysis**

---

