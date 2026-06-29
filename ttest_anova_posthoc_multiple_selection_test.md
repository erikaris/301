# Choosing the Right Statistical Test for Biological Data

## 1. Decision Tree

```
START: How many groups are you comparing?
│
├─ 2 groups
│   │
│   ├─ Same biological unit measured twice (before/after, same animal in 2 conditions)?
│   │   → PAIRED t-test
│   │
│   └─ Different/independent biological units in each group?
│       → UNPAIRED t-test
│
└─ 3+ groups, OR multiple factors (e.g. treatment + time)
    │
    ├─ One factor only (e.g. 3 drug doses, one timepoint)
    │   → ONE-WAY ANOVA
    │
    ├─ Two factors (e.g. treatment × time, or genotype × treatment)
    │   │
    │   ├─ Each subject measured at multiple timepoints/conditions?
    │   │   → REPEATED-MEASURES TWO-WAY ANOVA
    │   │   (or MIXED-EFFECTS MODEL if timepoints are missing/unbalanced)
    │   │
    │   └─ Each subject measured only once?
    │       → ORDINARY TWO-WAY ANOVA
    │
    └─ Three factors (e.g. genotype × treatment × time)
        → THREE-WAY ANOVA
        (consider splitting into separate two-way analyses if interpretation
        gets too complex — ask your supervisor/statistician)

ANY time you make more than one comparison from the same dataset:
    → APPLY A MULTIPLE COMPARISONS CORRECTION (see Section 3)
```

---

## 2. Repeated-Measures Two-Way ANOVA — What Does It Actually Mean?

**"Repeated" = whichever factor is measured multiple times on the *same* biological unit.**

In a time-course experiment, this is usually **time**.

| | t1 | t2 | t3 |
|---|---|---|---|
| Animal 1 (Control) | ✓ | ✓ | ✓ |
| Animal 2 (Control) | ✓ | ✓ | ✓ |
| Animal 3 (Drug) | ✓ | ✓ | ✓ |
| Animal 4 (Drug) | ✓ | ✓ | ✓ |

- **Time** = within-subject factor (repeated on the same animal)
- **Treatment** = between-subject factor (each animal belongs to only one group)

This gives you **three results**:
1. Main effect of **time** — does the outcome change over time overall?
2. Main effect of **treatment** — do groups differ overall?
3. **Time × Treatment interaction** — does the *trajectory over time* differ between groups?

The interaction is usually the most biologically meaningful result — "does treatment change the time-course pattern?" — not just whether each main effect is significant.

**If you have missing timepoints** (an animal died early, a sample failed), classical repeated-measures ANOVA struggles — it typically needs complete data. A **mixed-effects model** solves this: it handles missing/unbalanced data, models the same within-subject correlation, and is now the standard approach in biology for this reason.

---

## 3. Multiple Comparisons Corrections

### What is this, and why do we do it?

When you run a single hypothesis test, you typically accept a 5% chance of a false positive (α = 0.05) — finding a "significant" difference that isn't actually real.

If you run **many** tests on the same dataset, those 5% chances add up. Test 20 independent comparisons, and you'd expect roughly 1 false positive purely by chance — even if nothing real is happening. This is the **multiple comparisons problem**.

**Why this comes up after ANOVA specifically:** the ANOVA F-test only tells you "a difference exists *somewhere* among the groups" — not which groups differ. To find that out you need pairwise comparisons, which immediately puts you back into multiple-testing territory.

**Multiple comparisons correction** = any method that adjusts your significance threshold or p-values to keep the overall false-positive rate under control when testing more than once.

### Is this the same as a "post-hoc test"?

Not quite — related, but not identical. The difference comes down to **timing/purpose** vs. **statistical mechanism**.

- **Post-hoc test** describes *when and why* you're testing: a test run *after* seeing a significant ANOVA result, exploring comparisons you didn't necessarily specify in advance. It's about timing and purpose — inherently exploratory.
- **Multiple comparisons correction** describes the *statistical fix*: the mathematical adjustment applied any time you run more than one test, regardless of when those tests were planned or whether ANOVA is involved at all.

**The relationship:** every post-hoc test *contains* a correction mechanism built in (Tukey and Dunnett are designed specifically to correct for the comparisons they make). But corrections are also used in situations that have nothing to do with "post-anything."

**Illustration 1 — pre-planned vs. exploratory, same data:**
- *Post-hoc:* ANOVA across 4 drug doses comes back significant → you then explore all 6 possible pairwise comparisons to see which differ → Tukey's HSD.
- *Not post-hoc, but still needs correction:* before collecting any data, you decide the only scientifically relevant comparisons are Low-vs-Control and High-vs-Control (2 pre-planned comparisons). You're not exploring everything — but you're still testing twice, so Bonferroni still applies to those 2 planned tests.

**Illustration 2 — no ANOVA at all:**
You measure expression of 3,000 genes in treated vs. untreated cells: 3,000 separate t-tests, no ANOVA, no "post" stage. You still need a correction (Benjamini-Hochberg/FDR) purely because you ran thousands of tests — there's no post-hoc concept here, just the multiple-testing problem.

**Summary: all post-hoc tests are a form of multiple comparisons correction, but not all multiple comparisons corrections are post-hoc tests.** Tukey/Dunnett are ANOVA-specific tools; Bonferroni/FDR are general-purpose and apply far beyond ANOVA.

### The four corrections

| Correction test name | Situation / best for | Controls | Case example |
|---|---|---|---|
| **Tukey's HSD** (post-hoc) | Comparing **every group to every other group** (all pairwise comparisons) after ANOVA | Family-wise error rate | 4 drug doses, comparing all 6 possible pairs (A-B, A-C, A-D, B-C, B-D, C-D) to map out the full pattern of differences |
| **Dunnett's test** (post-hoc) | Comparing **multiple groups to one control only**, not to each other | Family-wise error rate | Control vs. Low dose, Control vs. Medium dose, Control vs. High dose — you don't care about Low vs. Medium |
| **Bonferroni** (general-purpose) | Small number of comparisons, any context (post-hoc or not); simple and conservative | Family-wise error rate | Pre-planned set of 4 specific comparisons defined before looking at the data |
| **Benjamini-Hochberg / FDR** (general-purpose) | Large numbers of comparisons (dozens to thousands) | False discovery rate | Testing expression differences across 2,000 genes, or signal intensity across 50 imaging ROIs |

**Family-wise error rate (FWER):** the chance of getting *even one* false positive across the whole set of comparisons. Tukey, Dunnett, and Bonferroni all aim to keep this below 5%.

**False discovery rate (FDR):** the *proportion* of false positives among everything you call significant. E.g., "of everything I flagged as significant, ~5% are expected to be false positives." This is more forgiving than FWER for large comparison sets — Bonferroni would make the bar so strict with 1000+ tests that you'd miss almost everything real.

**The one-sentence rule of thumb:** choose **Tukey vs. Dunnett** based on *what* you're comparing (all pairs vs. just-vs-control); choose **Bonferroni vs. FDR** based on *how many* comparisons you're making (a handful → Bonferroni; dozens+ → FDR).

---

## 4. Biological Replicates vs. Technical Replicates

This is one of the most common sources of error in biology — worth understanding well.

- **Biological replicate** = an independent biological unit: a different animal, a different cell culture dish, a different patient sample. It captures real biological variability.
- **Technical replicate** = repeating the *same* measurement on the *same* biological sample: e.g., imaging the same dish 3 times, running the same sample through the assay twice, counting cells in 5 fields of the same well.

**Why this matters:** your statistical *n* should be the number of **biological** replicates — not the number of images, wells, or technical repeats.

❌ **Pseudoreplication** = treating technical replicates as if they were independent biological replicates. This artificially inflates your sample size and makes your statistics look far more confident than they should be.

**How to handle it correctly:**
1. Average your technical replicates *within* each biological replicate first (e.g., average all 5 image fields from one dish into a single value).
2. Use that one averaged value per biological replicate in your statistical test.
3. Your *n* = number of biological replicates (animals, dishes, patients) — not number of images/wells/technical readings.

---

## 5. Defining the Correct Baseline / Control Group

Your baseline/control is the reference condition you compare everything else against. To choose and justify it:

- It should differ from your experimental group(s) **only** in the variable you're testing — everything else (handling, timing, vehicle, batch) should be matched.
- Common choices: untreated cells, vehicle-only treatment (not "no treatment" if your drug needed a solvent), wild-type genotype, or t = 0 in a time-course.
- State explicitly in your figure legend/methods what the control is and why it's the appropriate comparator.

**Rule of thumb:** if you can't clearly say "this group differs from control only by X," your control may not be properly matched.

---

## 6. Avoiding Over-Interpretation of Multiple Pairwise Comparisons

Easy to fall into the trap of testing/showing *every possible pair* and then highlighting whichever ones turned out significant. Avoid this by:

- **Pre-specify your comparisons** based on your actual biological question, before looking at the data (e.g., "each treatment vs. control" rather than "every group vs. every other group").
- **Don't show every possible significance bracket** on a figure — only the biologically meaningful comparisons tied to your hypothesis.
- **Apply the appropriate correction** (Section 3) for however many comparisons you do make.
- **Statistical significance ≠ biological significance** — always consider effect size alongside the p-value. A tiny, significant difference may not be biologically meaningful; a large, non-significant difference may reflect low power rather than no effect.
- Avoid "p-hacking by inspection" — i.e., don't decide which comparisons to report only after seeing which ones came out significant.

---

## 7. Worked Examples (Dummy Data)

These are simplified made-up datasets to illustrate the workflow, not real results.

### Example A: Unpaired t-test
**Scenario:** You measure protein expression (arbitrary units) in 6 control mice vs. 6 drug-treated mice (different mice in each group — independent biological replicates).

| Control | Drug |
|---|---|
| 5.1, 4.8, 5.3, 4.9, 5.0, 5.2 | 7.2, 6.9, 7.5, 7.1, 6.8, 7.4 |

**R:**
```r
control <- c(5.1, 4.8, 5.3, 4.9, 5.0, 5.2)
drug    <- c(7.2, 6.9, 7.5, 7.1, 6.8, 7.4)
t.test(drug, control, var.equal = TRUE)  # unpaired, two-sample t-test
```

**SPSS:**
- Arrange data in long format: one column for `value`, one column for `group` (Control/Drug)
- `Analyze → Compare Means → Independent-Samples T Test`
- Test variable: `value`; Grouping variable: `group`

**Interpreting the output:**
- Check **Levene's test** first (R: use `var.equal = FALSE` if variances unequal; SPSS reports this automatically) — if Levene's p < 0.05, use the "equal variances not assumed" row.
- Report: t-statistic, degrees of freedom, p-value, and mean difference (with 95% CI if possible).
- Example interpretation: *"Drug-treated mice showed significantly higher protein expression than controls (t(10) = 14.2, p < 0.001)."*

---

### Example B: Paired t-test
**Scenario:** You measure tumour size in the **same** 6 mice before and after treatment (same biological unit, two timepoints).

| Mouse | Before | After |
|---|---|---|
| 1 | 12.1 | 9.8 |
| 2 | 11.5 | 9.2 |
| 3 | 13.0 | 10.5 |
| 4 | 12.4 | 9.9 |
| 5 | 11.8 | 9.4 |
| 6 | 12.7 | 10.1 |

**R:**
```r
before <- c(12.1, 11.5, 13.0, 12.4, 11.8, 12.7)
after  <- c(9.8, 9.2, 10.5, 9.9, 9.4, 10.1)
t.test(before, after, paired = TRUE)
```

**SPSS:**
- Each mouse is one row, with two columns: `Before` and `After`
- `Analyze → Compare Means → Paired-Samples T Test`
- Pair `Before` with `After`

**Interpreting the output:**
- The test is now on the **differences** within each mouse, not between two separate groups.
- Example interpretation: *"Tumour size significantly decreased after treatment (t(5) = 18.4, p < 0.001), with a mean reduction of 2.4 units."*

---

### Example C: One-way ANOVA
**Scenario:** Cell viability (%) measured across 3 independent experiments (biological replicates) for 3 drug doses: Control, Low dose, High dose.

**R:**
```r
viability <- c(95,93,94, 80,78,82, 50,48,53)
dose <- factor(rep(c("Control","Low","High"), each = 3))
model <- aov(viability ~ dose)
summary(model)
TukeyHSD(model)   # post-hoc, since comparing all groups to each other
```

**SPSS:**
- `Analyze → Compare Means → One-Way ANOVA`
- Dependent: `viability`; Factor: `dose`
- Click `Post Hoc → Tukey` (or `Dunnett` if comparing only to Control)

**Interpreting the output:**
- The ANOVA table gives an overall F-statistic and p-value — this only tells you "at least one group differs," not which ones.
- You then need the **post-hoc test** (Tukey/Dunnett) to see which specific pairs differ — this is where the multiple-comparisons correction comes in (Section 3).
- Example interpretation: *"One-way ANOVA showed a significant effect of dose on viability (F(2,6) = 245.3, p < 0.001). Tukey's post-hoc test showed both Low and High dose significantly reduced viability compared to Control (both p < 0.001)."*

---

### Example D: Repeated-measures two-way ANOVA (Time × Treatment)
**Scenario:** Tumour volume measured in the same animals at 3 timepoints (Day 0, 7, 14), comparing Control vs. Drug (4 animals per group — the time-course case from Section 2).

**R (using `afex` or base `aov` with error term):**
```r
library(afex)

df <- data.frame(
  animal    = factor(rep(1:8, each = 3)),
  treatment = factor(rep(c("Control","Drug"), each = 12)),
  time      = factor(rep(c("Day0","Day7","Day14"), times = 8)),
  volume    = c(50,55,60, 50,53,58, 50,56,61, 50,54,59,    # Control animals
                50,48,40, 50,45,35, 50,47,38, 50,46,36)     # Drug animals
)

aov_ez(id = "animal", dv = "volume", data = df,
       within = "time", between = "treatment")
```

**SPSS:**
- Use `Analyze → General Linear Model → Repeated Measures`
- Define `time` as the within-subject factor (3 levels)
- Add `treatment` as the between-subject factor
- Check **Mauchly's Test of Sphericity** in the output — if significant (p < 0.05), use the Greenhouse-Geisser corrected p-value instead of the uncorrected one

**Interpreting the output:**
- You'll get three results: main effect of `time`, main effect of `treatment`, and the **time × treatment interaction**.
- The interaction is usually the key result: *"Significant time × treatment interaction (p < 0.001) indicates the tumour growth trajectory differed between Control and Drug groups — tumours continued growing in Control but shrank in Drug-treated animals."*
- If you had missing timepoints (e.g., one animal died on Day 14), switch to a **mixed-effects model** instead:
```r
library(lme4)
library(lmerTest)
model <- lmer(volume ~ treatment * time + (1 | animal), data = df)
summary(model)
anova(model)
```

---

### Example E: Pseudoreplication — what NOT to do
**Scenario:** You image 3 fields of view from each of 3 dishes per group (Control vs. Treated), giving 9 images per group.

❌ **Wrong:** Run a t-test treating all 9 images per group as n = 9. This is pseudoreplication — your real biological n is 3 (the dishes), not 9 (the images).

✅ **Correct approach in R:**
```r
# Step 1: average the 3 images within each dish first
df_images <- data.frame(
  dish  = rep(c("D1","D2","D3"), each = 3),
  group = "Control",
  value = c(10,11,9, 12,13,11, 9,10,8)
)

library(dplyr)
df_dish <- df_images %>%
  group_by(dish, group) %>%
  summarise(mean_value = mean(value))   # now n = 3 (one row per dish)

# Step 2: run your t-test/ANOVA on df_dish, not on the raw image-level data
```

**SPSS:** Use `Data → Aggregate`, group by `dish`, and compute the mean of `value` per dish — then run your t-test on this aggregated dataset.

**Interpreting the output:** Your reported n in the figure and text should be 3 (dishes), and you'd state: *"n = 3 independent biological replicates (dishes), each averaged from 3 technical replicate images."*

---

## 8. Figure Checklist

- [ ] Control/baseline group clearly defined in the legend
- [ ] *n* = number of **biological** replicates (stated explicitly)
- [ ] Individual data points shown, not just bars/means
- [ ] Only biologically meaningful comparisons annotated (not every pair)
- [ ] Correction method for multiple comparisons stated
- [ ] Test used (e.g., "two-way repeated-measures ANOVA with Dunnett's correction") stated in the legend or methods
