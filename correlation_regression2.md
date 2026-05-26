# Correlation & Regression: A Complete Study Guide
---

## Part 1: Correlation — What Is the Relationship?

### What is correlation?

Correlation measures whether two variables tend to move together — and if so, in which direction.

Think of two variables as two people walking. Correlation asks:
- Do they walk in the **same direction** at the same time? *(positive)*
- Do they walk in **opposite directions**? *(negative)*
- Do they walk **independently**, with no pattern? *(no correlation)*

### Reading a scatterplot

A **scatterplot** is a graph where:
- The **horizontal axis (X)** shows your **predictor** (the exposure, the cause, the input)
- The **vertical axis (Y)** shows your **outcome** (the result, the thing you are trying to explain)
- Each **dot** = one person (or one observation)

```
High |        •  •
     |     •  •  •
  Y  |  •  •  •
     |  •  •
Low  |_________________
      Low      High
             X
```
*In this scatterplot, as X increases, Y also tends to increase — the dots travel upward from left to right. This is a **positive correlation**.*

---

### The Three Questions to Ask Any Scatterplot

**1. What is the DIRECTION?**
- Dots going **up-right** → **Positive correlation** (as X goes up, Y goes up)
- Dots going **down-right** → **Negative correlation** (as X goes up, Y goes down)
- Dots going **sideways with no pattern** → **No correlation**

**2. How STRONG is it?**
- Dots clustered tightly around a line → **Strong** correlation
- Dots loosely scattered → **Weak** correlation

**3. Are there any OUTLIERS?**
- A dot that sits far away from the others — worth noting, as it may affect the line

---

### Public Health Examples of Correlation

| X (Predictor) | Y (Outcome) | Direction | Why? |
|---|---|---|---|
| Cigarettes smoked per day | Risk of lung cancer | **Positive** | More smoking → higher risk |
| Hours of physical activity per week | Body mass index (BMI) | **Negative** | More exercise → lower BMI (on average) |
| Daily fruit intake | Blood pressure | **Negative** | More fruit → lower blood pressure (on average) |
| Age | Blood pressure | **Positive** | Older age → higher blood pressure (on average) |
| Shoe size | Intelligence | **None** | These things are unrelated |

> **Remember:** Correlation does NOT mean causation. Two variables can be correlated without one causing the other. In your exam, you are asked to *describe* the relationship, not explain why it exists.

---

## Part 2: The Regression Line — Summarising the Pattern

### What is the regression line?

Once you have a scatterplot full of dots, the **regression line** (also called the **line of best fit**) is the single straight line that sits as close as possible to all the dots at once.

Think of it like stretching a piece of string across your scatterplot — you position it to cut through the middle of the cloud of dots, so no section of it is too far away from any dot.

```
High |        •  •
     |     • /•  •
  Y  |  • /•  •
     |  •/  •
Low  |_________________
      Low      High
             X
```
*The line (/) runs through the middle of the dots.*

The regression line lets you:
1. **Describe the trend** — how Y changes as X changes
2. **Make predictions** — what Y value would we expect for a given X value?

---

### The Equation of the Regression Line

The regression line is described by this equation:

$$\hat{Y} = a + bX$$

Do not panic. This is just a way of writing: **"Start at a point, then follow the slope."**

| Symbol | Name | What it means in plain English |
|---|---|---|
| $\hat{Y}$ | Predicted Y | Your best estimate of the outcome value |
| $a$ | **Intercept** | The value of Y when X equals zero (where the line starts on the left) |
| $b$ | **Slope** | How much Y changes for every 1 unit increase in X |
| $X$ | Predictor | The value of the variable you are plugging in |

> **Focus point for your exam:** The examiners are most likely to ask you about **b** (the slope). This is where the "average additional increase" language comes from.

---

## Part 3: The Slope — The Most Important Part

### What does the slope actually mean?

The **slope (b)** tells you:

> *"For every **1 unit increase** in X, Y **increases (or decreases) by b**, on average."*

This is the sentence template you should memorise and use in your exam.

---

### Visualising the slope: The Staircase

Imagine the regression line as a staircase.

- **Each step to the right = 1 unit increase in X**
- **The height of that step = the slope (b)**

```
        _____
       |     |  ← Height = b (the slope)
  _____|     |
 |     |     Width = 1 unit of X
 |
```

- A **steep staircase** = large slope (Y changes a lot for each unit of X)
- A **gentle slope / nearly flat** = small slope (Y changes very little for each unit of X)
- A **staircase going downward** = negative slope (Y decreases as X increases)

---

### The Verbal Template (Use this in your exam)

Fill in the blanks:

> **"For every additional [1 unit of X], [name of Y] [increases / decreases] by [value of b], on average."**

The phrase **"on average"** is important — it acknowledges that the line is not perfect. Individual people vary. The slope describes what happens *typically*, across the whole group.

---

### Worked Examples

#### Example 1: Age and Blood Pressure

**Scenario:** A researcher studies 200 adults. They measure each person's age and systolic blood pressure (mmHg). The regression line has:
- Slope (b) = **0.8**
- Intercept (a) = 100

**Question:** Interpret the slope.

**Step-by-step:**
1. Identify X → **Age** (in years)
2. Identify Y → **Systolic blood pressure** (in mmHg)
3. Note the slope → **b = 0.8**
4. Decide direction → b is **positive**, so blood pressure **increases** with age
5. Fill in the template →

> *"For every additional year of age, systolic blood pressure increases by 0.8 mmHg, on average."*

---

#### Example 2: Alcohol and Liver Enzymes

**Scenario:** A public health study examines the relationship between weekly alcohol consumption (units) and liver enzyme levels (ALT, in U/L). The regression equation is:

$$\hat{Y} = 20 + 3.2X$$

**Question A:** Interpret the slope.

**Answer:**
> *"For every additional unit of alcohol consumed per week, liver enzyme levels increase by 3.2 U/L, on average."*

**Question B:** What is the predicted liver enzyme level for someone who drinks 10 units per week?

**Step-by-step:**
1. Write the equation: $\hat{Y} = 20 + 3.2X$
2. Plug in X = 10: $\hat{Y} = 20 + (3.2 \times 10)$
3. Calculate: $\hat{Y} = 20 + 32 = 52$
4. Answer: *"The predicted liver enzyme level is 52 U/L."*

---

#### Example 3: Exercise and BMI (Negative Slope)

**Scenario:** A study of 150 adults finds that weekly hours of exercise (X) is negatively associated with BMI (Y). The regression equation is:

$$\hat{Y} = 30 - 0.5X$$

**Question:** Interpret the slope.

**Step-by-step:**
1. Identify X → **Weekly exercise** (hours)
2. Identify Y → **BMI**
3. Note the slope → **b = −0.5** (negative!)
4. Direction → BMI **decreases** as exercise increases
5. Fill in template →

> *"For every additional hour of exercise per week, BMI decreases by 0.5, on average."*

> **Key point:** A **negative slope** does not mean the result is "bad" — it just means Y goes **down** as X goes up. In this case, that's actually a healthy pattern!

---

#### Example 4: Reading the Slope From a Graph (No Equation Given)

**Scenario:** You are shown a graph with no equation. The regression line starts at Y = 40 when X = 0, and reaches Y = 70 when X = 15.

**Question:** Estimate the slope.

**Step-by-step:**
1. Find two clear points on the line:
   - Point 1: (X = 0, Y = 40)
   - Point 2: (X = 15, Y = 70)
2. Calculate the rise (change in Y): 70 − 40 = **30**
3. Calculate the run (change in X): 15 − 0 = **15**
4. Slope = rise ÷ run = 30 ÷ 15 = **2**
5. Interpret: *"For every 1 unit increase in X, Y increases by 2, on average."*

> **Formula:** $b = \dfrac{\text{rise}}{\text{run}} = \dfrac{\text{change in Y}}{\text{change in X}}$

---

## Part 4: "Average Additional Increase" — Demystifying the Phrase

This phrase appears in exam questions and sounds complicated. It is simply **another way of saying the slope**.

| Phrase you might see | What it actually means |
|---|---|
| "The slope is 3.2" | For each 1-unit rise in X, Y changes by 3.2, on average |
| "The average additional increase is 3.2" | Same as above |
| "A one-unit increase in X is associated with a 3.2 increase in Y" | Same as above |
| "The regression coefficient is 3.2" | Same as above |

They are all asking you to interpret **b**.

---

### Why "average"?

Because people vary. Not every person who drinks one extra unit of alcohol will have exactly 3.2 more units of liver enzyme. Some will have more, some less. The regression line gives you the **average** pattern across the whole group.

Think of it this way: if you could press a button and add one more unit of alcohol to everyone's weekly intake, the liver enzymes would go up by **3.2 on average** across the whole group — even if individual people varied.

---

### Worked Exam Example Using the Full Phrase

**Question:** A study of smoking and lung function reports that "the average additional decrease in FEV1 (a measure of lung capacity) for each additional cigarette smoked per day is 5 mL." What does this mean, and what would be the regression coefficient?

**Answer:**
- The regression coefficient (slope) is **b = −5**
- The slope is **negative** because FEV1 *decreases* as cigarettes increase
- Interpretation: *"For every additional cigarette smoked per day, lung capacity (FEV1) decreases by 5 mL, on average."*

---

## Part 5: Putting It All Together — The 5-Step Exam Method

When you see a regression graph or equation in the exam, follow these five steps:

| Step | Action | Example |
|---|---|---|
| **1** | Name the axes — what is X, what is Y? | X = cigarettes/day, Y = FEV1 (lung capacity) |
| **2** | What is the direction? Does the line go up or down? | Line goes down = negative relationship |
| **3** | Find the slope value — stated in question, on graph, or calculate it | b = −5 |
| **4** | Fill in the template | "For every additional cigarette per day, FEV1 decreases by 5 mL, on average." |
| **5** | Sanity check — does this make real-world sense? | Yes. Smoking damages lungs. ✓ |

---

## Part 6: Common Exam Question Types — With Model Answers

### Type 1: "Interpret the slope"
> *A regression analysis shows that for every 1 kg/m² increase in BMI, diastolic blood pressure increases by 1.4 mmHg (b = 1.4). Interpret this finding.*

**Model answer:**
> "For every 1 kg/m² increase in BMI, diastolic blood pressure increases by 1.4 mmHg, on average. This suggests a positive association between BMI and blood pressure."

---

### Type 2: "What does this regression line tell us?"
> *A study plots daily fruit portions (X) against systolic blood pressure (Y). The line of best fit slopes downward from left to right. Interpret this graph.*

**Model answer:**
> "The downward slope indicates a negative association between fruit consumption and systolic blood pressure — that is, as daily fruit intake increases, systolic blood pressure tends to decrease. The regression line summarises this average trend across the study sample."

---

### Type 3: "Predict a value"
> *The regression equation for the relationship between age (X) and cholesterol level (Y) is: Ŷ = 150 + 1.5X. What is the predicted cholesterol for a 40-year-old?*

**Step-by-step:**
1. Write equation: Ŷ = 150 + 1.5X
2. Plug in X = 40: Ŷ = 150 + (1.5 × 40)
3. Calculate: Ŷ = 150 + 60 = **210**
4. **Answer:** "The predicted cholesterol level for a 40-year-old is 210 units."

---

### Type 4: "What is the average additional increase?"
> *A regression analysis of sodium intake (X, in grams/day) and systolic blood pressure (Y, in mmHg) produces a slope of 2.3. What is the average additional increase in blood pressure per gram of sodium?*

**Model answer:**
> "The average additional increase in systolic blood pressure for each additional gram of sodium consumed per day is 2.3 mmHg."

*(You are simply restating the slope in plain language.)*

---

## Part 7: Calculation Examples — Average Additional Increase

This is the section most likely to come up in your exam as a calculation question. There are three types. Each one uses the same core idea — the slope — but the question is phrased differently.

---

### The Core Rule

> **Total change in Y = slope (b) × number of units X has increased**

That is all the calculation ever is. Multiply the slope by however many units X changed.

---

### Calculation Type 1: "How much does Y increase if X increases by n units?"

This is the most common version. You are given the slope and asked to find the *total* change in Y for a *multi-unit* change in X.

---

**Example 1A — Blood pressure and sodium**

> A study finds that for every additional gram of sodium consumed per day, systolic blood pressure increases by 1.8 mmHg on average (b = 1.8).
>
> **How much would blood pressure increase if someone increased their sodium intake by 4 grams per day?**

**Working:**

| Step | Action | Calculation |
|---|---|---|
| 1 | Identify the slope | b = 1.8 mmHg per gram |
| 2 | Identify the change in X | ΔX = 4 grams |
| 3 | Multiply | 1.8 × 4 = **7.2 mmHg** |

**Answer:** *"If sodium intake increases by 4 grams per day, systolic blood pressure would increase by 7.2 mmHg on average."*

---

**Example 1B — Smoking and lung capacity**

> A regression analysis finds that each additional cigarette smoked per day is associated with a decrease in lung capacity (FEV1) of 5 mL on average (b = −5).
>
> **What is the expected decrease in FEV1 for someone who smokes 12 cigarettes per day compared to a non-smoker?**

**Working:**

| Step | Action | Calculation |
|---|---|---|
| 1 | Identify the slope | b = −5 mL per cigarette |
| 2 | Identify the change in X | ΔX = 12 cigarettes (from 0 to 12) |
| 3 | Multiply | −5 × 12 = **−60 mL** |

**Answer:** *"A person who smokes 12 cigarettes per day would be expected to have a lung capacity 60 mL lower than a non-smoker, on average."*

> **Note on the negative sign:** The answer is −60, meaning a *decrease* of 60. In your written answer, say "decrease by 60 mL" rather than writing a negative number — it is clearer and reads better.

---

**Example 1C — Exercise and BMI**

> A regression study finds that each additional hour of exercise per week is associated with a decrease in BMI of 0.3 kg/m² on average.
>
> **A patient currently exercises 2 hours a week. Their doctor recommends they increase to 7 hours a week. What is the expected change in BMI?**

**Working:**

| Step | Action | Calculation |
|---|---|---|
| 1 | Identify the slope | b = −0.3 kg/m² per hour |
| 2 | Identify the change in X | ΔX = 7 − 2 = **5 hours** |
| 3 | Multiply | −0.3 × 5 = **−1.5 kg/m²** |

**Answer:** *"Increasing exercise by 5 hours per week is associated with an expected decrease in BMI of 1.5 kg/m², on average."*

> **Watch out:** The question gave you two values of X (2 and 7). Always subtract to find the *change* first: 7 − 2 = 5. Then multiply by the slope.

---

### Calculation Type 2: "Predict the value of Y for a given X"

Here you use the full regression equation: **Ŷ = a + bX**

---

**Example 2A — Age and cholesterol**

> The regression equation for predicting cholesterol level (mmol/L) from age (years) is:
>
> **Ŷ = 3.0 + 0.05X**
>
> **What is the predicted cholesterol level for a 60-year-old?**

**Working:**

| Step | Action | Calculation |
|---|---|---|
| 1 | Write out the equation | Ŷ = 3.0 + 0.05X |
| 2 | Substitute X = 60 | Ŷ = 3.0 + (0.05 × 60) |
| 3 | Multiply first | 0.05 × 60 = 3.0 |
| 4 | Add | 3.0 + 3.0 = **6.0** |

**Answer:** *"The predicted cholesterol level for a 60-year-old is 6.0 mmol/L."*

---

**Example 2B — BMI and blood pressure**

> A study produces the regression equation:
>
> **Ŷ = 70 + 1.2X**
>
> Where X = BMI (kg/m²) and Y = diastolic blood pressure (mmHg).
>
> **(a) What is the predicted blood pressure for someone with a BMI of 25?**
> **(b) What is the predicted blood pressure for someone with a BMI of 30?**
> **(c) What is the difference between them?**

**Working for (a):**

Ŷ = 70 + (1.2 × 25) = 70 + 30 = **100 mmHg**

**Working for (b):**

Ŷ = 70 + (1.2 × 30) = 70 + 36 = **106 mmHg**

**Working for (c):**

106 − 100 = **6 mmHg**

> **Notice:** The difference between BMI 25 and BMI 30 is 5 units. The slope is 1.2. So: 1.2 × 5 = 6. This is exactly the same as Calculation Type 1 — the two methods always give the same answer.

---

**Example 2C — Alcohol and liver enzymes (negative intercept scenario)**

> The regression equation for alcohol units per week (X) and liver enzyme levels (ALT, U/L) is:
>
> **Ŷ = 15 + 2.5X**
>
> **What is the predicted ALT for someone who drinks 8 units per week?**

**Working:**

Ŷ = 15 + (2.5 × 8) = 15 + 20 = **35 U/L**

**Answer:** *"The predicted ALT level for someone drinking 8 units per week is 35 U/L."*

---

### Calculation Type 3: "Work backwards — find X from Y"

Occasionally an exam question gives you the predicted Y and asks you to find X. You rearrange the equation.

---

**Example 3A — What sodium intake predicts a blood pressure of 140 mmHg?**

> The regression equation is: **Ŷ = 110 + 1.5X**
>
> At what daily sodium intake (grams) is blood pressure predicted to reach 140 mmHg?

**Working:**

| Step | Action | Calculation |
|---|---|---|
| 1 | Write equation with target Y | 140 = 110 + 1.5X |
| 2 | Subtract intercept from both sides | 140 − 110 = 1.5X |
| 3 | Divide both sides by slope | 30 ÷ 1.5 = **X = 20** |

**Answer:** *"A daily sodium intake of 20 grams is predicted to be associated with a blood pressure of 140 mmHg."*

---

### The Calculation Cheat Sheet

```
╔══════════════════════════════════════════════════════════════════╗
║          CALCULATION TYPES — AVERAGE ADDITIONAL INCREASE         ║
╠══════════════════════════════════════════════════════════════════╣
║  TYPE 1: Total change in Y                                        ║
║    Change in Y = slope (b) × change in X                         ║
║    e.g. b = 1.8, ΔX = 4 → ΔY = 1.8 × 4 = 7.2                  ║
╠══════════════════════════════════════════════════════════════════╣
║  TYPE 2: Predict Y from X                                         ║
║    Ŷ = a + (b × X)                                               ║
║    e.g. Ŷ = 3.0 + (0.05 × 60) = 6.0                            ║
╠══════════════════════════════════════════════════════════════════╣
║  TYPE 3: Find X from Y (rearrange)                                ║
║    X = (Y − a) ÷ b                                               ║
║    e.g. (140 − 110) ÷ 1.5 = 20                                  ║
╠══════════════════════════════════════════════════════════════════╣
║  WATCH OUT FOR:                                                   ║
║    • Multi-unit change: subtract X values FIRST, then multiply   ║
║    • Negative slope: answer will be negative = a decrease        ║
║    • Always write units in your answer (mmHg, mL, kg/m², etc.)  ║
╚══════════════════════════════════════════════════════════════════╝
```

---

## Quick Reference Card

Cut this out mentally and bring it into the exam.

```
╔══════════════════════════════════════════════════════════════╗
║              REGRESSION QUICK REFERENCE                      ║
╠══════════════════════════════════════════════════════════════╣
║  THE EQUATION:   Ŷ = a + bX                                  ║
║    a = intercept (Y when X = 0)                              ║
║    b = slope (how much Y changes per 1-unit rise in X)       ║
╠══════════════════════════════════════════════════════════════╣
║  THE TEMPLATE:                                               ║
║  "For every additional 1 [unit of X],                        ║
║   [Y] increases/decreases by [b], on average."               ║
╠══════════════════════════════════════════════════════════════╣
║  SLOPE SIGNS:                                                ║
║   b is POSITIVE → line goes up → Y increases with X         ║
║   b is NEGATIVE → line goes down → Y decreases with X       ║
║   b is ZERO → flat line → no linear relationship            ║
╠══════════════════════════════════════════════════════════════╣
║  READING SLOPE FROM A GRAPH:                                 ║
║   Slope = rise ÷ run = (change in Y) ÷ (change in X)        ║
╠══════════════════════════════════════════════════════════════╣
║  "AVERAGE ADDITIONAL INCREASE" = THE SLOPE                   ║
╚══════════════════════════════════════════════════════════════╝
```

---

## Things to Watch Out For

| Common mistake | What to do instead |
|---|---|
| Confusing the slope with the correlation (r) | r tells you *strength and direction*; slope tells you the *rate of change in real units* |
| Forgetting "on average" | Always include it — the line is not a perfect prediction for every individual |
| Saying "causes" instead of "is associated with" | Regression shows association, not causation |
| Forgetting the units | Always include units in your interpretation (mmHg, kg, years, etc.) |
| Getting confused by negative slopes | A negative slope just means Y goes *down* as X goes *up* — fill in the template as normal, using "decreases" |

---

*Good luck tomorrow. You have got this.*
