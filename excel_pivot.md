# Pivot Tables in Excel – Beginner's Guide

## What is a Pivot Table?

A **pivot table** is a tool in Excel that allows large datasets to be summarised quickly without writing formulas. It can be used to answer questions such as:

* How many people belong to each group?
* What is the average value for each category?
* How do two variables compare with each other?

A pivot table does not change the original data; it only creates a summary based on the selected variables.

---

## Creating a Pivot Table

1. Select the dataset (including column headers).
2. Go to **Insert → PivotTable**.
3. Choose the data range and click **OK**.
4. A blank pivot table and the **PivotTable Fields** panel will appear.

---

## The Four Main Pivot Table Fields

### Rows

Variables placed here appear as row categories.

**Example:**

* Age Group

| Age Group |
| --------- |
| 18–29     |
| 30–39     |
| 40–49     |

---

### Columns

Variables placed here create column categories.

**Example:**

* Sex

| Age Group | Female | Male |
| --------- | ------ | ---- |
| 18–29     |        |      |
| 30–39     |        |      |

---

### Values

Variables placed here are summarised using a calculation.

Common calculations include:

* Sum
* Average
* Count
* Minimum
* Maximum

**Example:**

* Average Heart Rate

| Age Group | Average Heart Rate |
| --------- | ------------------ |
| 18–29     | 72                 |
| 30–39     | 75                 |

To change the calculation:

1. Click the drop-down arrow beside the variable in **Values**.
2. Select **Value Field Settings**.
3. Choose the required calculation (e.g., Average instead of Sum).

---

### Filters

Variables placed here allow the data to be filtered.

**Example:**

* Diabetes Status

This allows the pivot table to display:

* All participants
* Only participants with diabetes
* Only participants without diabetes

---

## Example Used During the Session

The following arrangement was used:

* **Rows:** Age Group
* **Columns:** Sex
* **Values:** Heart Rate (Average)
* **Filters:** Diabetes

This allowed us to compare average heart rates across age groups and sexes while filtering by diabetes status.

---

## Experimenting with Different Layouts

One of the strengths of pivot tables is that variables can be moved easily.

Examples:

### Option 1

* Rows: Age Group
* Columns: Sex

### Option 2

* Rows: Age Group
* Columns: Sex, Diabetes

### Option 3

* Rows: Sex
* Columns: Age Group

Changing the position of variables often provides a different perspective on the same data.

---

## Creating Charts from Pivot Tables

Pivot tables can be visualised using charts.

1. Click anywhere inside the pivot table.
2. Select **Insert → Chart**.
3. Choose a chart type (e.g., Bar Chart or Column Chart).

This allows patterns and differences between groups to be seen more easily.

---

## Using Slicers

A **slicer** is an interactive filter that can be added to a pivot table.

To add a slicer:

1. Click inside the pivot table.
2. Go to **PivotTable Analyze → Insert Slicer**.
3. Select a variable (e.g., Diabetes or Sex).

The slicer provides clickable buttons that make filtering easier and more visual.

---

## Good Practice

* Ensure the original dataset has clear column names.
* Avoid blank rows within the dataset.
* Experiment with moving variables between Rows, Columns, Values, and Filters.
* Try different summary measures (Average, Count, Sum, etc.).
* Use charts and slicers to explore the data further.
* Practise using your own datasets to build confidence and intuition.

---

## Key Takeaway

A pivot table is essentially a **flexible summary table**. Learning how to move variables between **Rows, Columns, Values, and Filters** is the key skill. The best way to learn pivot tables is through hands-on practice and experimentation with different variable combinations.
