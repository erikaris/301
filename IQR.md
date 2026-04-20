# Interquartile Range (IQR)
---

## What is the IQR?

The **interquartile range (IQR)** tells you how spread out the middle 50% of your data is.

Imagine lining up all your values from smallest to largest. The IQR ignores the bottom quarter and the top quarter — the extremes — and just measures the spread of what's left in the middle.

> **Plain English version:** "If I ignore the highest and lowest scores, how much do my data vary?"

This makes the IQR very useful in social science research, where you often get a few extreme responses (e.g. one very high income, one very low anxiety score) that would otherwise distort your picture of the data.

---

## Key Terms

| Term | What it means |
|------|--------------|
| **Median (Q2)** | The middle value of the whole dataset |
| **Q1** | The median of the *lower* half of the data |
| **Q3** | The median of the *upper* half of the data |
| **IQR** | Q3 − Q1 |

---

## The Five-Step Method

> **Always follow these steps in order.**

### Step 1 — Order your data
Write all values from **smallest to largest**. This is the most important step. Everything else depends on position.

### Step 2 — Find the median (Q2)
- If you have an **odd** number of values → the median is the single middle value. This value belongs to *neither* half.
- If you have an **even** number of values → average the two middle values. Split the data straight down the middle.

### Step 3 — Find Q1
Take only the **lower half** of the data (below the median) and find its median.

### Step 4 — Find Q3
Take only the **upper half** of the data (above the median) and find its median.

### Step 5 — Calculate IQR
**IQR = Q3 − Q1**

---

## Worked Examples

---

### Example 1 — Study hours (simple, 9 values)

**Context:** A researcher asks 9 students how many hours they studied last week.

**Raw data (unordered):**
`6, 2, 10, 3, 20, 7, 4, 5, 8`

**Step 1 — Order the data:**
`2, 3, 4, 5, 6, 7, 8, 10, 20`

**Step 2 — Find the median (Q2):**
9 values → odd → middle value is position 5
→ **Q2 = 6**

Lower half: `2, 3, 4, 5` | **Median** | Upper half: `7, 8, 10, 20`

**Step 3 — Find Q1:**
Lower half: `2, 3, 4, 5` → 4 values → average positions 2 and 3
→ Q1 = (3 + 4) ÷ 2 = **3.5**

**Step 4 — Find Q3:**
Upper half: `7, 8, 10, 20` → 4 values → average positions 2 and 3
→ Q3 = (8 + 10) ÷ 2 = **9**

**Step 5 — IQR:**
IQR = 9 − 3.5 = **5.5**

**What this tells us:** The middle 50% of students studied within a 5.5-hour range. The student who studied 20 hours barely affects this — that's the whole point of IQR.

---

### Example 2 — Weekly income (moderate, 11 values)

**Context:** A researcher collects weekly income (£) from 11 part-time workers to study economic inequality.

**Raw data (unordered):**
`320, 95, 480, 215, 560, 175, 390, 440, 110, 305, 260`

**Step 1 — Order the data:**
`95, 110, 175, 215, 260, 305, 320, 390, 440, 480, 560`

**Step 2 — Find the median (Q2):**
11 values → odd → middle value is position 6
→ **Q2 = £305**

Lower half: `95, 110, 175, 215, 260` | **Median** | Upper half: `320, 390, 440, 480, 560`

**Step 3 — Find Q1:**
Lower half has 5 values → middle value is position 3
→ **Q1 = £175**

**Step 4 — Find Q3:**
Upper half has 5 values → middle value is position 3
→ **Q3 = £440**

**Step 5 — IQR:**
IQR = 440 − 175 = **£265**

**What this tells us:** The middle 50% of workers earn within a £265 range of each other. If we used the full range (560 − 95 = £465), we'd get a misleading impression driven by the extremes.

---

### Example 3 — Exam anxiety scores (moderate, 12 values)

**Context:** A school counsellor records anxiety scores (0–100) for 12 students before an exam. Higher scores = more anxious.

**Raw data (unordered):**
`72, 45, 88, 33, 61, 79, 55, 92, 48, 67, 38, 74`

**Step 1 — Order the data:**
`33, 38, 45, 48, 55, 61, 67, 72, 74, 79, 88, 92`

**Step 2 — Find the median (Q2):**
12 values → even → average positions 6 and 7
→ Q2 = (61 + 67) ÷ 2 = **64**

Lower half: `33, 38, 45, 48, 55, 61` | Upper half: `67, 72, 74, 79, 88, 92`

**Step 3 — Find Q1:**
Lower half: `33, 38, 45, 48, 55, 61` → 6 values → average positions 3 and 4
→ Q1 = (45 + 48) ÷ 2 = **46.5**

**Step 4 — Find Q3:**
Upper half: `67, 72, 74, 79, 88, 92` → 6 values → average positions 3 and 4
→ Q3 = (74 + 79) ÷ 2 = **76.5**

**Step 5 — IQR:**
IQR = 76.5 − 46.5 = **30**

**What this tells us:** The middle 50% of students have anxiety scores that span 30 points. Two students score very highly (88, 92) but the IQR is unaffected by them.

---

### Example 4 — Social media use (more complex, 14 values)

**Context:** A sociologist surveys 14 teenagers about daily social media use (minutes). The data is quite spread and includes some heavy users.

**Raw data (unordered):**
`145, 30, 220, 95, 310, 60, 180, 75, 255, 110, 40, 190, 85, 135`

**Step 1 — Order the data:**
`30, 40, 60, 75, 85, 95, 110, 135, 145, 180, 190, 220, 255, 310`

**Step 2 — Find the median (Q2):**
14 values → even → average positions 7 and 8
→ Q2 = (110 + 135) ÷ 2 = **122.5 minutes**

Lower half: `30, 40, 60, 75, 85, 95, 110`
Upper half: `135, 145, 180, 190, 220, 255, 310`

**Step 3 — Find Q1:**
Lower half has 7 values → odd → middle value is position 4
→ **Q1 = 75 minutes**

**Step 4 — Find Q3:**
Upper half has 7 values → odd → middle value is position 4
→ **Q3 = 190 minutes**

**Step 5 — IQR:**
IQR = 190 − 75 = **115 minutes**

**What this tells us:** The middle 50% of teenagers use social media within a 115-minute window of each other. The two heaviest users (255, 310 minutes) are outliers but they don't distort the IQR.

---

### Example 5 — Wellbeing scores across two groups (most complex, 16 values)

**Context:** A researcher collects wellbeing scores (0–100) from 16 participants: 8 in a therapy group and 8 in a control group. They want to compare the spread of each group.

**Group A — Therapy group (unordered):**
`68, 74, 55, 82, 63, 91, 77, 70`

**Group B — Control group (unordered):**
`42, 58, 71, 35, 66, 49, 78, 53`

---

#### Group A: Therapy group

**Step 1 — Order:**
`55, 63, 68, 70, 74, 77, 82, 91`

**Step 2 — Median:**
8 values → even → (70 + 74) ÷ 2 = **72**
Lower half: `55, 63, 68, 70` | Upper half: `74, 77, 82, 91`

**Step 3 — Q1:**
(63 + 68) ÷ 2 = **65.5**

**Step 4 — Q3:**
(77 + 82) ÷ 2 = **79.5**

**Step 5 — IQR:**
79.5 − 65.5 = **14**

---

#### Group B: Control group

**Step 1 — Order:**
`35, 42, 49, 53, 58, 66, 71, 78`

**Step 2 — Median:**
8 values → even → (53 + 58) ÷ 2 = **55.5**
Lower half: `35, 42, 49, 53` | Upper half: `58, 66, 71, 78`

**Step 3 — Q1:**
(42 + 49) ÷ 2 = **45.5**

**Step 4 — Q3:**
(66 + 71) ÷ 2 = **68.5**

**Step 5 — IQR:**
68.5 − 45.5 = **23**

---

#### Comparison

| | Median | Q1 | Q3 | IQR |
|---|---|---|---|---|
| **Therapy group** | 72 | 65.5 | 79.5 | **14** |
| **Control group** | 55.5 | 45.5 | 68.5 | **23** |

**What this tells us:**
- The therapy group has a **higher median** (72 vs 55.5) — they report better wellbeing overall.
- The therapy group has a **smaller IQR** (14 vs 23) — their scores are more tightly clustered. The therapy group is more consistent.
- The control group is more spread out — some people are doing okay, others much less so.

This kind of comparison is very common in social science research. The IQR helps you talk about *consistency*, not just the average.

---

## IQR vs Range — Why does it matter?

| | Range | IQR |
|---|---|---|
| **What it measures** | Full spread (min to max) | Middle 50% spread |
| **Affected by outliers?** | Yes — heavily | No |
| **Used with** | Mean | Median |
| **Best for** | Normally distributed data | Skewed data or data with outliers |

**Rule of thumb:** If your data has outliers or is skewed (common in social science), use the **median + IQR**. If your data is evenly spread, you can use the mean + range or standard deviation.

---

## Odd vs Even — Quick Reference

| Number of values | How to find the median | What goes in each half? |
|---|---|---|
| **Odd** | Single middle value | Exclude the median; split remaining values evenly |
| **Even** | Average the two middle values | Split straight down the middle |

---

## Common Mistakes to Avoid

1. **Forgetting to order the data first** — always sort before doing anything else.
2. **Including the median in both halves** (odd n) — the middle value is excluded from both halves when n is odd.
3. **Confusing range with IQR** — range = max − min; IQR = Q3 − Q1.
4. **Forgetting to average for Q1 and Q3** when the half has an even number of values.
5. **Subtracting the wrong way** — it's always Q3 − Q1, never Q1 − Q3.

---

## Practice Questions

Try these yourself before checking with your tutor.

**Q1.** A social worker records the number of appointments missed per client across 9 clients:
`5, 1, 8, 2, 0, 4, 3, 7, 6`
Find the IQR.

**Q2.** A researcher surveys 10 people about hours of sleep per night:
`6, 9, 5, 7, 8, 4, 7, 6, 9, 5`
Find Q1, Q3, and the IQR.

**Q3 (challenge).** Two schools report students' reading ages (years):
- School A: `8, 11, 9, 13, 10, 12, 9, 11, 14, 10`
- School B: `7, 14, 9, 12, 8, 15, 10, 11, 7, 13`

Calculate the IQR for both schools. Which school has more consistent reading ages? What might this tell a researcher?

---

## Answers

**Q1:** Ordered: `0, 1, 2, 3, 4, 5, 6, 7, 8` | Q2 = 4 | Q1 = 1.5 | Q3 = 6.5 | **IQR = 5**

**Q2:** Ordered: `4, 5, 5, 6, 6, 7, 7, 8, 9, 9` | Q2 = 6.5 | Q1 = 5 | Q3 = 8 | **IQR = 3**

**Q3:**
- School A ordered: `8, 9, 9, 10, 10, 11, 11, 12, 13, 14` | Q1 = 9 | Q3 = 12 | **IQR = 3**
- School B ordered: `7, 7, 8, 9, 10, 11, 12, 13, 14, 15` | Q1 = 8 | Q3 = 13 | **IQR = 5**
- School A has a smaller IQR — more consistent reading levels. School B has greater spread, suggesting a wider mix of reading abilities, which might indicate more diverse learning needs in the classroom.

---

*Notes prepared for EDCU006 — Faculty of Social Sciences, School of Education.*
