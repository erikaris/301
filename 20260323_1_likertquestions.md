# Likert Questions Analysis

## The Core Problem

Multiple *different* aspects of engagement (focus, information finding, visual appeal, etc.). 

## Option 1: Analyze Each Item Separately (Univariate Approach)

**What it is:** Run a paired Wilcoxon test (or paired t-test) for *each* engagement question independently.
**When to use this:** If the research question is about *specific* aspects of engagement ("Does the layout improve information finding?")

**Example:**
- Test 1: Does tabbed layout improve *focus*? (Wilcoxon on "focus" question)
- Test 2: Does tabbed layout improve *information finding*? (Wilcoxon on "information finding" question)
- Test 3: Does tabbed layout improve *visual appeal*? (Wilcoxon on "visual appeal" question)

**Pros:**
- Interpretable: You can say exactly which aspects improved
- Respects the ordinal nature of each item
- Honest about what the data shows

**Cons:**
- Multiple comparisons problem (3 tests = higher risk of Type I error)
- Need to apply a **Bonferroni correction** (divide α by number of tests, e.g., 0.05/3 = 0.0167)
- Requires larger sample size to maintain power

---

## Option 2: Create Subscales (Clustered Approach)

**What it is:** Group conceptually related items together, then analyze each group.
**When to use this:** If the research question is about *categories* of engagement ("Does the layout improve information accessibility and visual clarity?")

**Example:** If the Likert questions are:
- Q1: "The layout makes me focus"
- Q2: "The layout reduces distractions" ← Related to focus
- Q3: "It's easier to find information"
- Q4: "Information is well-organized" ← Related to information architecture
- Q5: "The design looks appealing"
- Q6: "The design is visually clear" ← Related to visual quality

**Then create 3 subscales:**
- **Focus subscale:** Average Q1 + Q2 (check Cronbach's α)
- **Information subscale:** Average Q3 + Q4 (check Cronbach's α)
- **Visual subscale:** Average Q5 + Q6 (check Cronbach's α)

**Run 3 paired Wilcoxon tests** (one for each subscale)

**Pros:**
- More parsimonious than individual items (fewer tests than Option 1)
- Conceptually meaningful groupings
- Reduces noise by combining related items
- Still interpretable ("visual quality improved" vs. just "Q5 improved")

**Cons:**
- Still have multiple comparisons issue (though less severe than Option 1)
- Requires defensible groupings (ideally theory-driven)
- Need adequate Cronbach's α for each subscale

---

## Option 3: Create an Overall Engagement Score. 

**What it is:** Average *all* engagement items into a single DV, even if they're conceptually different.
**When to use this:** Only if the research question is genuinely "Does engagement improve overall?" without caring about specific dimensions. **This is rare and usually not defensible.**

**Pros:**
- Simplest approach
- No multiple comparisons issue
- One clear answer: "Does overall engagement improve?"

**Cons:**
- **Loses nuance** – You can't say which aspects improved
- Interpretation is vague ("engagement" is undefined)
- Low Cronbach's α signals this is problematic
- Masks potential interactions (e.g., focus improved, but visual appeal got worse)

---

## Recommendation

1. Do a self-check:
- List all engagement Likert questions verbatim. 
  - Can they be grouped by what they measure (with reasoning and supervisor's advice). 
- What is your actual research question?
   - Which aspects of engagement does the tabbed layout improve?" → Option 1 or 2
   - Does the tabbed layout improve overall engagement?" → Option 3 (if conceptually justified)

This will guide which analysis method to recommend. 
---


## Quick Decision Tree

```
Do you have disparate engagement items?
│
├─ YES, and you care about SPECIFIC aspects → Option 1 (individual tests + Bonferroni)
│
├─ YES, and items cluster conceptually → Option 2 (subscales + check α)
│
└─ NO, items measure one construct → Option 3 (average + Wilcoxon)
```

---

# MORE DETAILS ABOUT RESEARCH ANALYSIS PLAN
## Website Layout & User Engagement Study

---

## 1. Overview of The Study

Comparing user responses to two website layouts (A: standard, B: tabbed) using Google Form questionnaire data. <br />
The analysis involves testing two hypotheses about user engagement and information retention.

### Research Hypotheses

- **H1:** The tabbed website will improve user engagement
- **H2:** Information retention will not differ significantly between layouts

---

## 2. Understanding Data Structure

From the initial notes, the Google Form questionnaire includes:

- **Demographic/control variables:** age group, qualifications, prior understanding of Huntington disease
- **Engagement Likert-scale questions** (e.g., "the layout makes me focus", "it's easier to find information")
- **Information retention questions** (need to clarify what these measure)
  > *What do you mean by information retention?
  > How did you measure information retention? Did participants answer knowledge questions after viewing each layout? If so, what was the scoring method?"*

---

## 3. Clarifying Independent & Dependent Variables

### Independent Variable (IV)

**Website Layout (categorical, 2 paired levels):** Layout A (standard) vs. Layout B (tabbed). Each participant viewed both layouts – this is **PAIRED/REPEATED MEASURES** data.

### Dependent Variables (DVs)

#### For H1 (Engagement):
- **DV = User engagement** (measured via Likert-scale questions)

#### For H2 (Information Retention):
- **DV = Information retention score** (measurement method TBD)

---

## 4. Analysis for H1: Tabbed Layout Improves Engagement

### Step 1: Define the Engagement Dependent Variable

**BEFORE any analysis, must clarify:** Do the engagement questions measure ONE construct or MULTIPLE aspects of engagement?

#### If Multiple Aspects (Recommended Approach)

- **Example engagement dimensions:** focus, ease of information finding, visual clarity, reduced distractions, etc.
- **Group conceptually related items into subscales** (e.g., Focus subscale = "layout makes me focus" + "reduces distractions")
- **For each subscale, calculate Cronbach's alpha.** If α ≥ 0.70, average the items
- **This creates 2-3 engagement subscale scores** (e.g., Focus, Information Architecture, Visual Quality)

#### If Single Construct 

- All engagement questions measure "overall engagement" ✓
- Average all items into a single engagement score
- Check Cronbach's alpha for the full set (should be ≥ 0.70)

### Step 2: Check Normality

For each engagement DV (or subscale), test normality of the **DIFFERENCE scores** (Engagement in Layout B minus Engagement in Layout A).

- **Visual method:** Create a Q-Q plot of the difference scores
- **Statistical method:** Shapiro-Wilk test (if p < 0.05 --> suggests non normality)
- **Interpretation:** If data deviate from normal line in Q-Q plot OR Shapiro-Wilk p < 0.05, normality is violated

### Step 3: Select Statistical Test

Based on normality results:

| Normality | Test to Use | When |
|-----------|------------|------|
| Approximately normal | Paired t-test | Q-Q plot close to line, Shapiro-Wilk p > 0.05 |
| Substantially violated | Wilcoxon signed-rank test | Q-Q plot deviates, Shapiro-Wilk p < 0.05 |

### Step 4: Run the Test & Interpret

#### If Using Paired t-test (in SPSS or R):

- **Output:** t-statistic, degrees of freedom (df), p-value, mean difference, 95% CI
- **Interpretation:** If p < 0.05, tabbed layout DOES improve engagement (reject null hypothesis)
- **Report:** `t(df) = X.XX, p = Y.YY` and mean difference with CI

#### If Using Wilcoxon Signed-Rank Test:

- **Output:** Z-statistic, p-value, effect size (r = Z/√N)
- **Interpretation:** If p < 0.05, tabbed layout improves engagement (reject null hypothesis)
- **Report:** `Z = X.XX, p = Y.YY, r = Z.ZZ`

---

## 5. Analysis for H2: Information Retention Does NOT Differ

This hypothesis is about finding NO DIFFERENCE (null hypothesis is true). This is valid but requires different thinking than H1.

### Understanding H2

H2 suggests: Layout (tabbed vs. standard) should NOT significantly affect how much information users retain. This might be important if the argument is *"the tabbed layout improves engagement WITHOUT sacrificing retention."*

### Analysis Steps

1. **Prepare the retention DV** the same way as engagement (check normality, select test)
2. **Run paired t-test or Wilcoxon**
3. **Interpret – but look for p > 0.05** (non-significant difference suggests retention does NOT differ)

### Important Caveat: Absence of Evidence ≠ Evidence of Absence

- A non-significant p-value (p > 0.05) does **NOT** prove retention is identical in both layouts
- It only means the sample size was insufficient to detect a difference
- **should report effect size (e.g., Cohen's d) and confidence interval** to show how similar (or dissimilar) the two layouts are
- **Better phrasing:** "No significant difference was found" rather than "retention is the same"

---

## 6. Multiple Comparisons & Significance Correction

If we decide to test multiple engagement subscales AND information retention --> run multiple tests. This increases the risk of Type I error (false positives).

### When Do We Need a Correction?

- If we have 1 engagement measure + 1 retention measure = 2 tests → **Bonferroni correction:** use α = 0.05/2 = 0.025
- If we have 3 engagement subscales + 1 retention = 4 tests → **Bonferroni:** α = 0.05/4 = 0.0125
- **Alternative:** Holm-Bonferroni is slightly less conservative and preferred by many statisticians

---

## 7. Software Choice: SPSS vs. R

### SPSS (Recommended for First-Time Users)

- Easier point-and-click interface
- **Paired t-test:** Analyze > Compare Means > Paired-Samples t-test
- **Wilcoxon:** Analyze > Nonparametric Tests > Related Samples
- **Cronbach's alpha:** Analyze > Scale > Reliability Analysis
- Good visualizations & summary tables built in

### R (More Flexible, Steeper Learning Curve)

- **Packages:** 'tidyverse' for data wrangling, 'psych' for Cronbach's alpha, 'ggplot2' for plots
- **Paired t-test:** `t.test(layout_A, layout_B, paired = TRUE)`
- **Wilcoxon:** `wilcox.test(layout_A, layout_B, paired = TRUE)`
- **Cronbach's alpha:** `alpha()` from 'psych' package

---

## 8. Addressing The Question: "Is H2 Pointless?"

*"Is H2 (no difference in retention) pointless?"* 

**Answer:** It depends on her research narrative --> ask supervisor.

---

# ANALYSIS STRATEGY GUIDE: TWO POSSIBLE SCENARIOS FOR ENGAGEMENT DV

## Overview

There are multiple Likert-scale questions intended to measure user engagement, but **we don't yet know if they all measure the same thing**. 

**The decision point:** Calculate Cronbach's α for ALL engagement Likert items together. The result will determine which strategy to follow.

---

## DECISION POINT: Cronbach's Alpha Test

### What to Do First

List ALL engagement Likert questions. Then calculate Cronbach's alpha for all of them together.

**Software:**
- **SPSS:** Analyze → Scale → Reliability Analysis (select all engagement items)
- **R:** `psych::alpha(data[c("Q1", "Q2", "Q3", ...)])`

**What the result means:**
- **α ≥ 0.70:** All items measure the SAME underlying construct → Follow **SCENARIO 1**
- **α < 0.70:** Items measure DIFFERENT aspects of engagement → Follow **SCENARIO 2**

---

# SCENARIO 1: All Likert Questions Measure the Same Thing (α ≥ 0.70)

## Interpretation

If Cronbach's alpha is ≥ 0.70, her Likert items are internally consistent. They all reliably measure a single concept: **overall user engagement**.

**Example:** If her questions are:
- "The layout makes me focus"
- "It's easier to find information"
- "I can navigate the site easily"
- "The design reduces distractions"
- "I feel engaged with the content"

→ All of these are really asking the same underlying question: *"How engaged am I with this layout?"*

## Analysis Strategy for Scenario 1

### Step 1: Create a Single Engagement Score

**Action:** Average ALL the engagement Likert items into one DV.

```
Engagement_Score = (Q1 + Q2 + Q3 + Q4 + Q5) / 5
```

For example, if all items use a 5-point Likert scale:
- Minimum score: 1 (very disengaged)
- Maximum score: 5 (very engaged)
- This averaged score becomes your single DV

### Step 2: Calculate Difference Scores

For each participant, calculate how their engagement changed from Layout A to Layout B:

```
Difference = Engagement_Score_LayoutB - Engagement_Score_LayoutA
```

### Step 3: Check Normality of Difference Scores

Test whether these difference scores are normally distributed.

**Visual inspection (Q-Q plot):**
- Create a Q-Q plot of the difference scores
- If points lie roughly on the diagonal line → Normal distribution
- If points deviate significantly → Non-normal distribution

**Statistical test (Shapiro-Wilk):**
- Null hypothesis: Data are normally distributed
- If p > 0.05 → Assume normality (fail to reject null)
- If p < 0.05 → Reject normality assumption

### Step 4: Select Your Statistical Test

| Normality Check | Test to Use | Why |
|-----------------|------------|-----|
| **Normal (p > 0.05, Q-Q plot OK)** | Paired t-test | Assumes normality; more powerful |
| **Non-normal (p < 0.05, Q-Q plot deviates)** | Wilcoxon signed-rank test | Non-parametric; doesn't assume normality |

### Step 5: Run the Test

#### Option A: Paired t-test (if normal)

**SPSS:** Analyze → Compare Means → Paired-Samples t-test
- Pair 1: Engagement_LayoutA with Engagement_LayoutB

**R:**
```r
t.test(data$Engagement_LayoutA, data$Engagement_LayoutB, paired = TRUE)
```

**Output to look for:**
- t-statistic
- df (degrees of freedom)
- p-value
- Mean difference
- 95% confidence interval
- (Calculate Cohen's d = mean difference / SD of difference)

**How to interpret:**
- **p < 0.05:** Significant difference → Tabbed layout improves engagement ✓ (supports H1)
- **p ≥ 0.05:** No significant difference → Tabbed layout does NOT significantly improve engagement

**How to report:**
```
"A paired-samples t-test revealed that user engagement was significantly higher 
for the tabbed layout (M = 4.2, SD = 0.8) compared to the standard layout 
(M = 3.8, SD = 0.9), t(45) = 2.34, p = .023, d = 0.49."
```

#### Option B: Wilcoxon Signed-Rank Test (if non-normal)

**SPSS:** Analyze → Nonparametric Tests → Related Samples
- Select your paired engagement variables

**R:**
```r
wilcox.test(data$Engagement_LayoutA, data$Engagement_LayoutB, paired = TRUE)
```

**Output to look for:**
- Z-statistic
- p-value
- Number of observations
- (Calculate effect size: r = Z / √N)

**How to interpret:**
- **p < 0.05:** Significant difference → Tabbed layout improves engagement ✓
- **p ≥ 0.05:** No significant difference

**How to report:**
```
"A Wilcoxon signed-rank test indicated that user engagement was significantly 
higher for the tabbed layout compared to the standard layout, Z = 2.45, p = .014, 
r = 0.35."
```

### Step 6: Report Effect Size and Confidence Interval

**Always include these – they tell you if the difference is meaningful:**

- **Cohen's d** (for t-test): 
  - d < 0.2 = small effect
  - d = 0.2–0.5 = small-to-medium effect
  - d = 0.5–0.8 = medium effect
  - d > 0.8 = large effect

- **r** (for Wilcoxon):
  - r < 0.1 = negligible
  - r = 0.1–0.3 = small effect
  - r = 0.3–0.5 = medium effect
  - r > 0.5 = large effect

- **95% Confidence Interval:**
  - If CI doesn't cross zero → Difference is significant
  - If CI is narrow → Estimate is precise
  - If CI is wide → Estimate is uncertain

---

## Scenario 1 Summary Table

| Component | Action | Software |
|-----------|--------|----------|
| **Calculate Cronbach's α** | If α ≥ 0.70, proceed with Scenario 1 | SPSS: Analyze → Scale → Reliability |
| **Create DV** | Average all engagement items | Calculate manually or use SPSS Compute |
| **Check normality** | Q-Q plot + Shapiro-Wilk test | SPSS: Graphs → Q-Q plot; Analyze → Descriptives → Explore |
| **Select test** | p > 0.05 → t-test; p < 0.05 → Wilcoxon | See decision table above |
| **Run test** | Compare Layout A vs. Layout B | SPSS or R (commands above) |
| **Calculate effect size** | Cohen's d (t-test) or r (Wilcoxon) | Manual calculation or online calculator |
| **Report results** | p-value, test statistic, effect size, CI | Example format provided above |

---

# SCENARIO 2: Likert Questions Measure Different Things (α < 0.70)

## Interpretation

If Cronbach's alpha is < 0.70, her Likert items are **NOT internally consistent**. They don't all measure the same construct. Instead, different items (or small groups of items) measure different aspects of engagement.

**Example:** If her questions are:
- "The layout makes me focus" ← FOCUS
- "It's easier to find information" ← INFORMATION ARCHITECTURE
- "The design looks visually appealing" ← VISUAL AESTHETICS
- "I can navigate quickly" ← NAVIGATION SPEED
- "The colors are pleasant" ← VISUAL APPEAL (again!)

→ These questions measure 4-5 *different* dimensions of user experience/engagement, not one unified "engagement" construct.

## Analysis Strategy for Scenario 2

### Step 1: Group Items Conceptually

**Action:** Identify which items go together logically and create subscales.

**Process:**
1. Read all engagement questions
2. Group them by **conceptual similarity** (not by wording)
3. Aim for 2-4 subscales (each with 2-4 items ideally)

**Example grouping:**
- **Subscale A – Focus & Attention:** "layout makes me focus", "reduces distractions"
- **Subscale B – Information Architecture:** "easier to find information", "information is well-organized", "navigation is clear"
- **Subscale C – Visual Design:** "design looks appealing", "colors are pleasant", "layout is visually clear"

### Step 2: Validate Each Subscale with Cronbach's Alpha

For **each proposed subscale**, calculate Cronbach's α separately.

**SPSS:** Analyze → Scale → Reliability Analysis (select only the items in one subscale)

**R:**
```r
psych::alpha(data[c("Q1", "Q3")])  # For subscale A
psych::alpha(data[c("Q2", "Q4", "Q5")])  # For subscale B
```

**Rule:** For each subscale, α should be ≥ 0.60 (more lenient than 0.70 because subscales have fewer items)

**If a subscale has low α:**
- Remove items that don't fit
- Or treat that item as a standalone measure
- Or combine it with another conceptually similar item

### Step 3: Create Subscale Scores

For each validated subscale, average the items together:

```
FocusScore = (Q1_focus + Q3_focus) / 2
InfoScore = (Q2_info + Q4_info + Q5_info) / 3
VisualScore = (Q6_visual + Q7_visual + Q8_visual) / 3
```

Now you have **3 separate DVs** instead of 1.

### Step 4: Check Normality for Each Subscale

Repeat the normality check (Q-Q plot + Shapiro-Wilk) **for each subscale's difference scores**.

```
FocusDifference = FocusScore_LayoutB - FocusScore_LayoutA
InfoDifference = InfoScore_LayoutB - InfoScore_LayoutA
VisualDifference = VisualScore_LayoutB - VisualScore_LayoutA
```

Result: You now have a normality decision for each subscale.

### Step 5: Run Separate Tests for Each Subscale

You'll run **one test for each subscale** – possibly using different tests if normality differs.

**Example outcome:**
- **Focus:** Normal → Use paired t-test
- **Information:** Non-normal → Use Wilcoxon
- **Visual:** Normal → Use paired t-test

#### For Subscale 1 (Focus):

**Paired t-test:**
```r
t.test(data$Focus_LayoutA, data$Focus_LayoutB, paired = TRUE)
```

**Report:** "User focus was significantly higher with the tabbed layout (M = 4.1) compared to the standard layout (M = 3.6), t(45) = 1.98, p = .050, d = 0.42."

#### For Subscale 2 (Information Architecture):

**Wilcoxon test:**
```r
wilcox.test(data$Info_LayoutA, data$Info_LayoutB, paired = TRUE)
```

**Report:** "Navigation ease showed no significant difference between layouts, Z = 1.23, p = .219, r = 0.18."

#### For Subscale 3 (Visual Design):

**Paired t-test:**
```r
t.test(data$Visual_LayoutA, data$Visual_LayoutB, paired = TRUE)
```

**Report:** "Visual design was rated significantly higher for the tabbed layout (M = 4.3) than the standard layout (M = 3.7), t(45) = 2.67, p = .010, d = 0.65."

### Step 6: Apply Multiple Comparisons Correction

**Important:** Because you're running multiple tests (one per subscale), you risk Type I error (false positives).

**Option A: Bonferroni Correction**
- You're running 3 tests → Use α = 0.05 / 3 = 0.0167
- Only p-values < 0.0167 are considered significant
- More conservative; fewer false positives

**Option B: Holm-Bonferroni Correction**
- Slightly less strict than Bonferroni
- Preferred by many statisticians
- (Details: rank p-values, adjust each with different threshold)

**Which to use?**
- If n = 3 subscales: Use Bonferroni (straightforward)
- If n > 5 subscales: Use Holm-Bonferroni or consider MANOVA instead

**How to report:**
```
"To control for multiple comparisons, a Bonferroni correction was applied, 
with significance threshold adjusted to α = 0.017 (0.05 / 3 tests)."
```

### Step 7: Summary of Results Across Subscales

Create a summary table:

| Subscale | Test Used | t or Z | p-value | Effect Size | Significant? | Direction |
|----------|-----------|--------|---------|-------------|--------------|-----------|
| Focus | t-test | 1.98 | .050 | d = 0.42 | No (after correction) | Tabbed higher |
| Information | Wilcoxon | 1.23 | .219 | r = 0.18 | No | No difference |
| Visual Design | t-test | 2.67 | .010* | d = 0.65 | **Yes** | Tabbed higher |

*p < 0.017 (Bonferroni-corrected α)

### Step 8: Interpret the Pattern

Now discuss: **Which aspects of engagement improved?**

**Example interpretation:**
```
"The tabbed layout significantly improved user focus and visual design ratings, 
but had no meaningful impact on perceived information architecture. This suggests 
that the tabbed layout is particularly effective for engagement through its visual 
presentation and attention management, but not for information organization itself."
```

---

## Scenario 2 Summary Table

| Component | Action | Software |
|-----------|--------|----------|
| **Calculate α for all items** | If α < 0.70, proceed with Scenario 2 | SPSS: Analyze → Scale → Reliability |
| **Group items conceptually** | Create 2-4 subscales based on meaning | Manual (discussion with supervisor) |
| **Validate subscales** | α ≥ 0.60 for each subscale | SPSS: Analyze → Scale → Reliability (per subscale) |
| **Create subscale scores** | Average items within each subscale | SPSS Compute or R mutate() |
| **Check normality** | Q-Q plot + Shapiro-Wilk for each subscale | SPSS Graphs & Explore |
| **Select tests** | May use different tests per subscale | See decision table above |
| **Run tests** | Compare Layout A vs. B for each subscale | 3+ paired t-tests or Wilcoxon tests |
| **Correct for multiple tests** | Apply Bonferroni (α = 0.05 / n tests) | Manual or built into R package |
| **Report results** | Create summary table of all subscales | Format shown above |
| **Interpret pattern** | Which dimensions improved? Which didn't? | Narrative discussion |

---

---

# COMPARING THE TWO SCENARIOS

## Decision Tree

```
START: Calculate Cronbach's α for ALL engagement items

├─ α ≥ 0.70 (SCENARIO 1)
│  ├─ All items measure same construct ✓
│  ├─ Create single averaged DV
│  ├─ Run ONE paired t-test or Wilcoxon
│  ├─ Report one p-value, one effect size
│  └─ Simpler, more parsimonious analysis
│
└─ α < 0.70 (SCENARIO 2)
   ├─ Items measure different dimensions
   ├─ Group into 2-4 conceptual subscales
   ├─ Run multiple tests (one per subscale)
   ├─ Apply Bonferroni correction
   ├─ Report results as pattern across dimensions
   └─ More detailed, nuanced analysis
```

## Which Scenario is Better?

### Scenario 1 Advantages
- Simpler to explain and understand
- Single clear answer: "Does engagement improve?"
- No multiple comparisons problem
- More power to detect difference

### Scenario 1 Disadvantages
- Assumes all engagement aspects are equally important
- Masks which specific aspects improved
- Less meaningful if items actually measure different things

### Scenario 2 Advantages
- Honest about complexity: engagement has multiple dimensions
- Can say "focus improved, but not information architecture"
- More actionable insights (which UI elements worked?)
- Better if theory suggests multiple constructs

### Scenario 2 Disadvantages
- More complex to explain
- Multiple comparisons reduce power
- Need higher sample size
- Requires conceptual justification for groupings

---







