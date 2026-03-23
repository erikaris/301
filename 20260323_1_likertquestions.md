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
