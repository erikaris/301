
## Tutor Prep: HESU002 Student — Graphs & Comparing Categories in Excel

**Time to read:** ~5 min | **Session type:** Practical Excel skills

---

### What the Student is Asking

They want to:
1. **Create graphs in Excel** — likely starting from scratch or from a dataset
2. **Compare data across categories** — i.e., visualising how a variable differs between groups (e.g., age groups, genders, conditions)

Given their programme (Speech & Language Therapy), think clinical/health data contexts.

---

### Core Concepts to Cover

#### 1. Choosing the Right Chart Type for Comparison

| Goal | Chart Type |
|---|---|
| Compare values across categories | **Clustered Bar / Column Chart** |
| Show change over time per group | **Line Chart** |
| Compare proportions | **Stacked Bar Chart** |
| Two variables relationship | **Scatter Plot** |

For "comparing data within different categories", the **clustered column/bar chart** is almost certainly what they need.

---

#### 2. Creating a Basic Chart — Step by Step

**Example dataset to bring up:**

| Patient Group | Vocabulary Score | Comprehension Score |
|---|---|---|
| Age 5–6 | 72 | 68 |
| Age 7–8 | 81 | 79 |
| Age 9–10 | 88 | 85 |

**Steps:**
1. Enter data in Excel with headers in row 1
2. Select the entire table (including headers)
3. `Insert` → `Charts` → **Clustered Column Chart**
4. Excel auto-generates the chart with groups on the x-axis and two series (Vocabulary, Comprehension) side by side
5. Add axis labels: `Chart Design` → `Add Chart Element` → Axis Titles
6. Add a title: click the default title and retype

---

#### 3. Comparing Data Within Categories — Key Technique

**What "categories" means here:** groups like age band, sex, diagnosis type, school year.

**Clustered column chart** lets you visually compare *multiple measures across multiple groups* in one glance.

**Practical tip to show the student:**
- Make sure the data is in a **wide format** (each category = one row, each measure = one column) — Excel reads this naturally for grouped charts
- If data is in long format, they may need to reorganise it first

**Another example (more clinical):**

| Therapy Group | Pre-intervention Score | Post-intervention Score |
|---|---|---|
| Group A | 45 | 62 |
| Group B | 50 | 71 |
| Control | 48 | 51 |

→ Clustered column chart immediately shows: both therapy groups improved more than control, and Group B had the largest gain.

---

#### 4. Formatting Tips Worth Showing

- **Change colours:** click a bar → `Format Data Series` → Fill
- **Switch rows/columns:** `Chart Design` → `Switch Row/Column` (useful if groups and series are swapped)
- **Add data labels:** `Chart Design` → `Add Chart Element` → Data Labels → Outside End
- **Remove gridlines** for cleaner look: click gridline → Delete

---

### Likely Questions / Where Students Get Stuck

- *"My chart doesn't look right"* → usually a selection issue; reselect the data range carefully
- *"The categories are on the wrong axis"* → `Switch Row/Column`
- *"How do I add a new group to the chart?"* → extend the data range: right-click chart → `Select Data` → adjust range
- *"What's the difference between bar and column?"* → same chart, different orientation; column = vertical, bar = horizontal

---

### Session Plan (suggestion for ~50 min)

| Time | Activity |
|---|---|
| 0–5 min | Ask: do they have their own dataset, or work from an example? |
| 5–20 min | Build a clustered column chart together from scratch |
| 20–35 min | Format it (labels, colours, titles) |
| 35–45 min | Try a second chart type (e.g., stacked bar or line) using the same data |
| 45–50 min | Q&A, recap |

---

# 10-Minute MASH Tutor Prep

## 1. What is the student asking?

The student wrote:

> "I would like to learn more about creating graphs in Excel and how to compare data within different categories."

This is likely a **very practical Excel question**, not a complex statistics question.

The student probably wants to know:

1. Which graph to use for different types of data.
2. How to create graphs in Excel.
3. How to compare groups/categories visually.
4. How to interpret differences between groups.

Since the student is in **Speech & Language Therapy**, expect healthcare-style data rather than business or data science examples.

---

# 2. Suggested structure for the appointment

### Step 1 (2 min): Understand the assignment

Start with:

> "Could you show me the data or assignment you're working on?"

Key questions:

* What variables do you have?
* Are the categories groups of people?
* Are you comparing means, counts, percentages, or scores?
* Is this for a report, dissertation, or module assignment?

---

### Step 2 (3 min): Explain graph selection

Students often struggle because they don't know which graph matches their data.

Use this simple framework:

| Data Type                                    | Recommended Graph                    |
| -------------------------------------------- | ------------------------------------ |
| Counts/Frequencies                           | Bar chart                            |
| Percentages                                  | Bar chart                            |
| Continuous measurements by group             | Boxplot or bar chart with error bars |
| Change over time                             | Line graph                           |
| Relationship between two numerical variables | Scatterplot                          |

---

# 3. Case Example 1 (Most Likely)

## Comparing speech scores across age groups

Suppose a student has:

| Age Group   | Mean Speech Score |
| ----------- | ----------------- |
| 5-7 years   | 65                |
| 8-10 years  | 72                |
| 11-13 years | 80                |

Question:

> Which age group has the highest speech score?

### Graph

Bar chart.

Excel steps:

1. Highlight table.
2. Insert.
3. Column or Bar Chart.
4. Add chart title.
5. Label axes.

Interpretation:

> The mean speech score appears to increase with age. The 11–13 year group has the highest average score.

---

# 4. Case Example 2

## Comparing males and females

| Gender | Mean Language Score |
| ------ | ------------------- |
| Male   | 74                  |
| Female | 82                  |

Question:

> Is there a difference between genders?

Bar chart:

```
Female  ████████████████ 82
Male    ██████████████   74
```

Interpretation:

> Females achieved a higher average language score than males.

You can explain:

### Descriptive comparison

Simply describing the graph.

### Statistical comparison

Testing whether the difference is statistically significant (t-test).

Students often confuse these.

---

# 5. Case Example 3

## Comparing proportions

Suppose:

| Communication Method | Number |
| -------------------- | ------ |
| Verbal               | 45     |
| AAC Device           | 20     |
| Sign Language        | 15     |

Question:

> Which communication method is most common?

Bar chart works best.

Avoid pie charts unless specifically required.

Interpretation:

> Verbal communication was the most frequently observed method.

---

# 6. Case Example 4

## Comparing change over time

| Week | Score |
| ---- | ----- |
| 1    | 50    |
| 2    | 58    |
| 3    | 65    |
| 4    | 70    |

Question:

> Did scores improve over time?

Use:

### Line graph

Not a bar chart.

Interpretation:

> Scores showed a steady increase over the four-week period.

---

# 7. Excel Skills Worth Demonstrating

Students often need these practical skills:

### Create chart

Insert → Recommended Charts

### Change chart title

Click title → type new title

### Add axis labels

Chart Design → Add Chart Element → Axis Titles

### Change colours

Chart Design → Change Colors

### Edit axis scale

Right-click axis → Format Axis

### Save chart as image

Right-click chart → Save as Picture

---

# 8. Common Graph Mistakes

Worth mentioning briefly.

### Bad

* 3D charts
* Too many colours
* Pie charts with many categories
* Missing axis labels
* Missing units

### Good

* Simple bar charts
* Clear labels
* Descriptive title
* Consistent formatting

---

# 9. If the student asks "How do I compare categories?"

Teach this framework:

### Step 1

Look at the graph.

### Step 2

Identify highest and lowest groups.

### Step 3

Describe differences.

Example:

> The intervention group achieved the highest mean score (85), while the control group achieved the lowest mean score (70).

### Step 4

If required, perform a statistical test.

Examples:

* Two groups → t-test
* Three or more groups → ANOVA
* Two categorical variables → Chi-square

---

# 10. Likely Outcome of the Appointment

The student probably needs help with:

* Choosing the correct graph
* Making graphs in Excel
* Interpreting graphs
* Comparing categories in a report

A useful opening question:

> "Can you show me the dataset or assignment question? Then we can decide which graph is most appropriate and how to compare the categories."

This will quickly reveal whether the session is mainly **Excel skills**, **data visualisation**, or **statistical comparison**.
