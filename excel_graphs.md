
## Excel 101: Graphs & Comparing Categories in Excel

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

# 9. "How do I compare categories?"

The framework:

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
