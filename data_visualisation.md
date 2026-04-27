# DATA VISUALISATION (Quick Guide for Choosing and Designing Figures)

---

## 1. Start with the Purpose

Before making a figure, ask:

* What question am I answering?
* What do I want the reader to notice?

Common goals:

* Compare groups
* Show trends
* Show relationships
* Show distribution

---

## 2. Choose the Right Chart

### Compare groups

Use:

* Bar chart (averages)
* Boxplot (spread)

Example: Comparing performance of Device A, B, C

---

### Show trends (over time)

Use:

* Line graph

Example: Temperature over time

---

### Show relationships

Use:

* Scatter plot (+ trend line if needed)

Example: Pressure vs output voltage

---

### Show distribution

Use:

* Histogram
* Boxplot

Example: Distribution of measurement errors

---

### Show proportions

Use:

* Bar chart (preferred)

Avoid:

* Pie charts (unless very simple)

Example: Types of system failure

---

## 3. Design Rules (High Impact)

### Keep it simple

* Avoid too many lines or categories
* Split into multiple figures if needed

### Label clearly

Include:

* Axis labels (with units)
* Title
* Legend (if needed)

### Make it readable

* Clear fonts
* Works in black and white

### Be consistent

* Same style across all figures

### Avoid misleading visuals

* No 3D charts
* Do not distort axes

### Other things:
* * **Mandatory Error Bars:** Never plot a mean without a measure of uncertainty (Standard Deviation or SEM).
* **SI Units:** Every axis must have units in brackets—e.g., *Pressure ($kPa$)* or *Velocity ($m/s$)*.
* **Self-Explanatory Captions:** A reader should understand the "win" of the experiment just by reading the caption. 
    * *Weak:* "Graph of stress over time."
    * *Strong:* "Figure 4: Stress-strain relationship showing a $20\%$ increase in elasticity for the 3D-printed lattice compared to solid counterparts."

---

## 4. Link Figures to Your Report

Each figure should:

* Be introduced in the text
* Be explained clearly
* Support your argument

Example:
Instead of “Figure 1 shows the data”
Write “Figure 1 shows that Device C performs better than A and B”

---

## 5. Simple Workflow

1. Identify data type
2. Decide the goal
3. Choose chart type
4. Design clearly
5. Explain the result

---

## 6. Quick Examples

### **Goal 1: Comparison**
*How does Group A differ from Group B? (e.g., comparing two different prosthetic materials)*

When you need to show the difference between discrete categories, avoid simple bars that only show the average. You need to show the "gap" between groups.

* **bar charts**
* **box plot** Example: Strength tests of 4 different polymers across 10 trials each. It shows the consistency of the material. If one polymer has a high average but huge variance (long whiskers), it’s a bad engineering choice.
* **Grouped Bar Charts:** Best for simple comparisons of a single metric across multiple categories.
* **Dot Plots:** Excellent for small datasets where you want to show every single trial point alongside the mean.
* **Paired T-test Visuals:** If you are testing the *same* subject before and after a treatment, use lines to connect the individual data points to show the specific direction of change.


### **Goal 2: Correlation**
*How does Variable X influence Variable Y? (e.g., how sensor voltage changes with temperature)*

In MedTech, you are often looking for the "sensitivity" of a system. You need to show not just that a relationship exists, but how strong it is.

* **Scatter Plot with Regression Line:** This is the gold standard. The dots show the raw experimental noise, while the line shows the mathematical trend.
* **Confidence Bands:** Shading the area around your regression line shows the $95\%$ confidence interval, proving that your trend is statistically reliable.
* **Heatmap (Correlation Matrix):** If you have many variables (e.g., Heart Rate, SpO2, Temperature, and Movement), a heatmap uses color intensity to show which pairs have the strongest relationships.

---

### **Goal 3: Distribution**
*How consistent is the performance? (e.g., testing the reliability of a surgical robot's accuracy)*

In engineering, the "average" is often less important than the "failure rate." Distribution plots show the reader the risk and the spread of your results.

* **Box and Whisker Plots:** These provide five key summaries: the minimum, first quartile, median, third quartile, and maximum. It’s the best way to spot outliers.
* **Violin Plots:** These combine a box plot with a "density map." They are perfect for MedTech data that might have "bi-modal" distributions (two peaks), which a box plot might hide.
* **Histograms:** Best for showing the "frequency" of events (e.g., how many trials resulted in a specific error margin).

### **Goal 4: Trend or Time-based data**
* line graph. 

---

## **Strategic Data "Separation"**

To prevent your report from becoming a "wall of graphs," use these three techniques to organize your data efficiently:

1.  **Faceted Grids (Small Multiples):** If you have data for 10 different patients, don't put 10 lines on one graph. Create a grid of 10 tiny, identical graphs. It allows the reader to scan for patterns across individuals instantly.
2.  **Primary vs. Supplemental:** Move your "raw" trial data to the **Appendix**. Your main report should feature the "Synthesized" data (means, medians, and trends).
3.  **Color Coding by Significance:** Use a consistent color palette. For example, always use **Blue** for your "Control Group" and **Orange** for your "Experimental Group" across every single chart in the report.

---

## 7. Final Checklist

Before adding a figure:

* What question does it answer?
* Is this the simplest chart?
* Are axes labelled with units?
* Is it easy to read?
* Can it be simplified further?

---

## Key Takeaway

* Good visualisation is not about complexity. It is about clarity, simplicity, and helping the reader understand your results quickly.


