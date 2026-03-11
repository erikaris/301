# SPSS recoding

### Steps

1. **Transform**
2. **Recode into Different Variables**
3. Move the variable (e.g., `harm_q1`) into **Input Variable → Output Variable**
4. Create a new name (e.g., `harm_q1_recoded`)
5. Click **Change**
6. Click **Old and New Values**

Example recoding:

* Old Value: **1 through 2 → New Value: 0**
* Old Value: **3 through 5 → New Value: 1**

Click **Add** each time.

Then:

7. Continue → OK


---

# 4. Creating the scale 

If financial harm has **multiple questions**, they usually combine them.

Example variables:

```
harm1
harm2
harm3
harm4
```

Then create a **scale score**.

Steps:

1. **Transform**
2. **Compute Variable**
3. Target variable: `financial_harm_scale`
4. Numeric expression:

```
MEAN(harm1_recoded, harm2_recoded, harm3_recoded, harm4_recoded)
```

Or sum:

```
SUM(harm1_recoded, harm2_recoded, harm3_recoded, harm4_recoded)
```

Explain:

* **Mean** keeps scale consistent if some answers missing
* **Sum** adds total harm score

---

# 5. If they get the “range recoding” error

Common mistake: forgetting **Add**.

Remind them:

* Add after each rule
* Click **Change**
* Use **Different variable**, not same variable

---


