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
**When to use this:** If Lily's research question is about *categories* of engagement ("Does the layout improve information accessibility and visual clarity?")

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

Lily asks: *"Is H2 (no difference in retention) pointless?"* 

**Answer:** It depends on her research narrative --> ask supervisor.

---



