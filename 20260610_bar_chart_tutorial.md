# Plotting Clustered & Stacked Bar Charts
*A step-by-step guide using Excel and SPSS | MMedSci Vision & Strabismus*

---

## 1. What are these charts for?

Your data shows the age distribution (as percentages) of two patient groups — Group A and Group B — alongside 100-case random samples drawn from each. The goal of your chart is to visually compare whether the random sample is representative of the original group.

**Which chart type should you use?**

| Chart type | When to use it |
|---|---|
| **Clustered bar** ✅ | Best for this data. Bars are placed side by side at each age, so you can directly compare Original vs Sampled. |
| Stacked bar | Better when parts sum to 100% (e.g. one group broken down by category). Less useful here — your four columns are independent percentages and do not add up to 100% together. |

> **Recommendation:** Use a clustered bar chart as your primary figure.

---

## 2. Your Data

Enter or paste this table into Excel or SPSS. Each row is one age group (0–17 years).

| Age | Orig. A (%) | Sampled A (%) | Orig. B (%) | Sampled B (%) |
|-----|-------------|---------------|-------------|---------------|
| 0   | 2           | 0             | 1           | 0             |
| 1   | 6           | 5             | 5           | 7             |
| 2   | 7           | 10            | 6           | 5             |
| 3   | 9           | 7             | 9           | 11            |
| 4   | 10          | 12            | 10          | 10            |
| 5   | 16          | 16            | 15          | 13            |
| 6   | 18          | 17            | 15          | 12            |
| 7   | 12          | 13            | 12          | 14            |
| 8   | 8           | 7             | 10          | 4             |
| 9   | 3           | 4             | 6           | 9             |
| 10  | 3           | 3             | 3           | 3             |
| 11  | 1           | 0             | 2           | 2             |
| 12  | 1           | 0             | 3           | 5             |
| 13  | 1           | 4             | 1           | 1             |
| 14  | 1           | 0             | 1           | 2             |
| 15  | 1           | 2             | 2           | 1             |
| 16  | 1           | 0             | 1           | 0             |
| 17  | 0           | 0             | 1           | 1             |

> ⚠️ **Note:** Make sure Age is treated as a category label, not a continuous number. In Excel, format the Age column as text or set it explicitly as the axis label range. In SPSS, set its measurement level to *Ordinal*.

---

## 3. Clustered Bar Chart in Excel

### Steps

**1. Enter your data**
Paste the five columns (Age, Orig A, Sampled A, Orig B, Sampled B) into a blank spreadsheet starting at cell A1. Row 1 = headers, Rows 2–19 = data.

**2. Select all data**
Click A1 and drag to E19 to select all 19 rows and 5 columns including headers.

**3. Insert the chart**
Go to **Insert → Charts → Clustered Column** (vertical bars). Excel will automatically create one series per data column.

**4. Set Age as axis labels**
If Age appears as a data series rather than axis labels: right-click the chart → **Select Data** → under *Horizontal (Category) Axis Labels*, click **Edit**, then select the Age column (A2:A19).

**5. Add titles and labels**
Click the chart → use the **+** button (Chart Elements) to add Axis Titles and a Chart Title. Label the X-axis *Age (years)* and the Y-axis *Percentage (%)*.

**6. Adjust bar width**
Right-click any bar → **Format Data Series** → reduce Gap Width to around 50–100% for better readability with 18 age groups.

**7. Optional: switch to stacked**
Right-click the chart → **Change Chart Type** → choose *Stacked Bar* or *100% Stacked Bar*. Note the interpretation changes — see Section 1.

> 💡 **Tip:** If you only want to compare Group A (original vs sampled), select just columns A, B, C before inserting the chart. You can add Series D and E later via *Select Data*.

---

## 4. Clustered Bar Chart in SPSS

### Important: wide vs long format

Your data is currently in **wide format** — each condition is a separate column. SPSS Chart Builder works best with **long format**, where there is one column for the percentage value and one column for a grouping variable. You have two options:

- **Option A (Quick):** Use the Legacy Dialogs route — SPSS can handle wide format for simple charts.
- **Option B (Recommended):** Restructure to long format first, then use Chart Builder for full control.

---

### Option A — Quick method (wide format, Legacy Dialogs)

**1. Enter your data**
Type or paste your five columns into SPSS Data View. In Variable View, set Age as *Ordinal* and the four percentage columns as *Scale*.

**2. Open Legacy Dialogs**
Go to **Graphs → Legacy Dialogs → Bar...**

**3. Choose chart type**
Select **Clustered**. Under *Data in Chart Are*, choose **Summaries of separate variables**. Click **Define**.

**4. Assign variables**
Move your four percentage variables into the *Bars Represent* box. Move Age into the *Category Axis* box.

**5. Run and edit**
Click **OK**. Double-click the chart in the Output Viewer to open **Chart Editor**, where you can change colours, add labels, and adjust axes.

---

### Option B — Restructure to long format first (recommended)

Long format means each row is one observation: Age + Group + Percentage.

**1. Restructure the data**
Go to **Data → Restructure → Restructure selected variables into cases**. Set Age as the fixed variable. Select all four percentage columns as Measure variables. Assign a new grouping variable name (e.g. `Group`). Click **Finish**.

**2. Open Chart Builder**
Go to **Graphs → Chart Builder**. Choose *Bar* from the gallery and drag the **Clustered Bar** icon onto the canvas.

**3. Assign axes**
Drag Age to the X-axis, Percentage to the Y-axis, and Group to the *Cluster on X* box.

**4. Set statistic**
In the Element Properties panel, set Statistic to **Value**. Click **Apply**.

**5. Run and edit**
Click **OK**. Double-click the chart to open Chart Editor for formatting.

> ⚠️ **Note:** SPSS may assign arbitrary numeric codes to your Group variable after restructuring. Go to Variable View and add Value Labels (e.g. 1 = Original A, 2 = Sampled A) so the legend reads correctly.

---

## 5. Interpreting Your Chart

Once your chart is produced, consider these questions when writing up your findings:

- **Do the sampled bars closely follow the original bars at each age?** If yes, the sample is broadly representative.
- **Where are the largest discrepancies?** Look especially at the tails (ages 0, 13–17), where small absolute differences can appear large as percentages.
- **Both groups peak around ages 5–7.** This is clinically relevant — it aligns with the typical age of strabismus presentation and screening programmes.
- **A perfectly representative sample** would show bars of equal height for Original vs Sampled at every age. Minor variation is expected with n = 100.

> 💡 **Tip:** If you need to report this statistically, a chi-square goodness-of-fit test can formally test whether the sampled distribution differs significantly from the original.

---

## 6. Common Problems and Fixes

| Problem | Fix |
|---|---|
| Age is plotted as a data series, not on the X-axis | **Excel:** right-click → Select Data → edit axis labels, select A2:A19. **SPSS:** ensure Age is in the Category Axis box, not the Bars box. |
| Legend shows unhelpful names like VAR001 | Double-click chart → Chart Editor → double-click the legend entry to rename. Or rename variables before plotting. |
| Bars are too thin or crowded | Reduce Gap Width (Excel) or adjust bar spacing in Chart Editor (SPSS). |
| Chart shows counts not percentages | Your data is already in percentage form, so the chart should display correctly. Check the Y-axis label reads %. |
| SPSS stacked bars sum to more than 100% | Expected — your four columns are independent percentages, not parts of one whole. Use clustered instead. |

---

*Prepared for MASH Statistics Tutorial | University of Sheffield*
