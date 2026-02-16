A regression model that includes both fixed effects and random effects.

Fixed Effects

Effects you care about testing.

In this case:

Stimulus type (A, B, C)

You want to know:

Do stimuli differ in mean distance?

Random Effects

Sources of variability you are NOT testing, but must account for.

Here:

Participants

Because:
Each participant gives multiple ratings.

And participants differ in:

How strictly they rate

Their emotional perception

Their general use of scales

------
Absolutely — let’s make this very concrete with your **music–brand fit example** so you can picture it.

---

# **Scenario**

* Brand = **Nike**
* Stimuli = **A (fast electronic), B (slow piano), C (pop)**
* DV = **Euclidean distance** between stimulus and brand profile
* 3 participants = Alice, Bob, Carol

---

# **Case 1: Random Intercept (different baseline)**

* Each participant generally rates all stimuli higher or lower, but **reacts similarly** to stimuli.

| Participant | A Distance | B Distance | C Distance |
| ----------- | ---------- | ---------- | ---------- |
| Alice       | 2.0        | 4.0        | 3.0        |
| Bob         | 3.0        | 5.0        | 4.0        |
| Carol       | 1.5        | 3.5        | 2.5        |

* Observation:

  * Differences between stimuli are **the same across participants** (e.g., B – A = 2 units for everyone).
  * But participants’ **baseline ratings differ** (Bob tends to rate higher, Carol lower).
* **Model term:** `(1 | Participant)`

  * Accounts for different starting points (intercepts)

---

# **Case 2: Random Slope (different response to stimuli)**

* Each participant reacts **differently** to each stimulus.

| Participant | A Distance | B Distance | C Distance |
| ----------- | ---------- | ---------- | ---------- |
| Alice       | 2.0        | 4.0        | 3.0        |
| Bob         | 3.0        | 3.5        | 4.0        |
| Carol       | 1.5        | 5.0        | 2.0        |

* Observation:

  * Differences between stimuli vary by participant:

    * Alice: B – A = 2.0
    * Bob: B – A = 0.5
    * Carol: B – A = 3.5
  * Random slope `(Stimulus | Participant)` allows the **stimulus effect to vary by participant**, not just baseline.

---

# **Visual analogy**

```
Distance
^
|  Participant 1  /
|  Participant 2  \    (different slopes)
|  Participant 3  /
+-----------------> Stimulus
```

* Vertical shift → random intercept
* Tilt of line → random slope

---

# ✅ **Summary**

| Term                    | Example       | Intuition                                                                                    |                                            |
| ----------------------- | ------------- | -------------------------------------------------------------------------------------------- | ------------------------------------------ |
| Random intercept `(1    | Participant)` | All participants see Stimulus B as ~2 units farther than A, but start at different baselines | Participant baseline varies                |
| Random slope `(Stimulus | Participant)` | Some participants see big differences between stimuli, some small                            | Participant sensitivity to stimuli differs |

---

If you want, I can now **write a 1–2 sentence ready-to-explain version** of this for your student — simple and intuitive.

Do you want me to do that?
