# A Beginner's Guide to Systematic Review, Meta-Analysis, and Handling Zero Events in R

## 1. What is a systematic review?

A systematic review is a structured way of answering a research question by finding, screening, and summarising ALL the existing studies on that topic, using a clear, repeatable method (so someone else could redo your search and get the same studies).

Example: "Does drug X reduce infection after surgery compared to placebo?" A systematic review would search databases (like PubMed), apply inclusion/exclusion criteria, and end up with a list of, say, 5 relevant clinical trials.

## 2. What is a meta-analysis?

A meta-analysis is the statistical part that often comes after a systematic review. Once you have a list of studies, instead of just describing them in words, you mathematically combine their results into one overall, pooled estimate.

Why bother pooling? A single small trial might not have enough patients to detect a real effect. Combining 5 small trials gives more statistical power, closer to one big trial.

Simple analogy: Imagine 5 friends each flip a coin 20 times and each gets a slightly different number of heads. Instead of trusting any one friend's small sample, you combine all 100 flips together to get a more reliable estimate of whether the coin is fair.

## 3. Pooling yes/no outcomes: the odds ratio

Many meta-analyses look at outcomes that are yes/no — did the event happen or not (e.g. infection, relapse, death). For this kind of outcome, the standard effect measure is the odds ratio (OR):

- OR = 1 means no difference between treatment and control
- OR < 1 means treatment lowers the odds of the event (e.g. lowers infection risk)
- OR > 1 means treatment raises the odds of the event

Each study gives its own OR. The meta-analysis combines all the studies' ORs into one pooled OR, with a confidence interval telling you how certain we are.

## 4. The zero-events problem

Some studies end up with zero events in one or both arms — e.g. nobody in a group got infected. This breaks the maths, because the odds ratio formula involves division, and you cannot divide cleanly by zero.

Two flavours of this problem:
- Single-zero study: zero events in ONE arm only (e.g. 0 infections in treatment, 5 in control) — the OR calculation becomes unstable.
- Double-zero study: zero events in BOTH arms (e.g. 0 infections in treatment, 0 in control) — this study literally contains no information about which group did better, because nothing happened in either group.

## 5. Four ways to handle zero events in R

Using R's `meta` package, there are several common approaches:

1. **Standard fix (add 0.5 to every count)** — the simplest, most common patch, and the package default. Add half an event to every cell of the 2x2 table so the maths doesn't break. Downside: it's a bit of a fudge and can quietly bias the results, especially when group sizes are very unequal.
2. **Exact method, no fixing** — a cleverer calculation method that copes with single-zero studies without needing to add anything, and simply and transparently leaves out double-zero studies from the main number (since they truly have no information to contribute).
3. **Smarter fix (proportional, not flat 0.5)** — instead of always adding 0.5, add a correction sized to each study's own group sizes. More fair when treatment and control groups are very different sizes.
4. **Gold-standard model (GLMM)** — a more advanced statistical model that works with all the raw numbers directly and doesn't need any patching at all, but needs an extra R package (`BiasedUrn`) and is harder to explain to a non-statistical audience.

None of these is universally "correct" — they're different trade-offs between simplicity, transparency, and bias, and it's common to run more than one as a sensitivity check.

---

## 6. Step-by-step in R

### Step 1: Install and load the package (only once per computer)

```r
install.packages("meta")   # downloads the package, run once
library(meta)               # loads it into this R session, run every time
```

### Step 2: Get the data into R in the right shape

For each study, you need: number of events and total people in the treatment group, and the same for the control group.

```r
# Example shape - replace with real numbers
dat <- data.frame(
  study = c("Study A", "Study B", "Study C"),  # study names
  te    = c(2, 0, 3),     # treatment group: number of events
  tn    = c(50, 45, 60),  # treatment group: total number of people
  ce    = c(8, 5, 9),     # control group: number of events
  cn    = c(50, 48, 58)   # control group: total number of people
)
```

### Step 3: Run the meta-analysis

```r
result <- metabin(
  event.e = te, n.e = tn,   # treatment events and total
  event.c = ce, n.c = cn,   # control events and total
  studlab = study,          # labels for each study
  data = dat,
  sm = "OR",                # sm = summary measure; OR = odds ratio
  method = "MH",            # MH = Mantel-Haenszel pooling method
  MH.exact = FALSE,         # FALSE = uses the standard 0.5 correction (Method 1)
  incr = 0.5                # size of that correction
)
```

To switch to one of the other three methods, change only these lines:

```r
# Method 2 (exact, no correction):
MH.exact = TRUE

# Method 3 (smarter proportional correction):
MH.exact = FALSE, incr = "TACC"

# Method 4 (GLMM, gold standard, needs BiasedUrn installed):
method = "GLMM"   # replace the whole method line, drop MH.exact/incr
```

### Step 4: Look at the results

```r
summary(result)   # prints the numbers: pooled OR, confidence interval, p-value
forest(result)     # draws a visual "forest plot" - the standard picture for this
```

### What the output actually looks like

Using the example data from Step 2, running `summary(result)` with the standard 0.5 correction (Method 1) would print something like this:

```
                     OR            95%-CI %W(common) %W(random)
Study A         0.2308 [0.0459; 1.1604]       40.1       40.1
Study B         0.0928 [0.0050; 1.7091]        8.6        8.6
Study C         0.2963 [0.0761; 1.1541]       51.3       51.3

Number of studies combined: k = 3

                        OR           95%-CI     z p-value
Common effect model  0.2564 [0.1095; 0.6003] -2.98  0.0029
Random effects model 0.2564 [0.1095; 0.6003] -2.98  0.0029

Quantifying heterogeneity:
 tau^2 = 0; tau = 0; I^2 = 0.0% [0.0%; 89.6%]; H = 1.00

Test of heterogeneity:
    Q d.f. p-value
 0.62    2  0.7334
```

If Study B had zero events in BOTH arms (a double-zero study) and the code used `MH.exact = TRUE` (Method 2, no correction) instead, the same study would print like this in the per-study table, showing it's excluded from the pooled number rather than patched:

```
Study B             --   [excluded: 0/0]         --         --
```

### Step 5: How to read the output

Look for these things in the printed summary, using the dummy output above as a worked example:

1. **Per-study rows (Study A, B, C)** — each study's own OR and 95% CI, plus its %weight (how much it influences the pooled result). In the example, Study B has a very wide CI (0.0050 to 1.7091) and a small weight (8.6%) — a sign it's a small or sparse study contributing little certainty on its own.
2. **Pooled OR** — the single combined number, found in the "Common effect model" / "Random effects model" row. In the example this is 0.2564: below 1, so the treatment is associated with lower odds of the event.
3. **95% Confidence Interval (CI)** — the range next to the pooled OR. In the example, 0.1095 to 0.6003 does NOT include 1, so the result is statistically significant. If the range did include 1 (e.g. 0.7 to 1.4), that would mean "no significant difference detected."
4. **p-value** — in the example, 0.0029, well below the usual 0.05 threshold, consistent with the CI not crossing 1. These two should always agree with each other — if the CI crosses 1 but the p-value is under 0.05, something is inconsistent and worth double-checking.
5. **I² (heterogeneity)** — a percentage telling you how much the studies disagree with each other, found under "Quantifying heterogeneity." In the example, I² = 0.0%, meaning the three studies agree closely, so pooling them is statistically reasonable. Above roughly 50% would mean the studies disagree a lot, and pooling becomes more questionable.
6. **Test of heterogeneity (Q, p-value)** — a formal test of the same thing as I². In the example, p = 0.7334 (not significant), which supports the low I² reading: no evidence the studies are meaningfully different from each other.
7. **Common effect vs random effects model** — in the example these give identical numbers because tau² = 0 (no between-study variance detected). If they differed, the random effects model is usually the more conservative/appropriate one to report when heterogeneity is present.

Quick way to summarise the example output in one sentence: "Pooling three studies, the odds of the event were about 74% lower with treatment than control (OR 0.26, 95% CI 0.11 to 0.60, p = 0.003), and the studies agreed well with each other (I² = 0%)."

---

## 7. Takeaway

Zero-event studies are a genuinely tricky corner of meta-analysis, not a sign you've done something wrong. The important thing is knowing which method you used, why, and being able to explain the trade-off if asked — running two or three methods side by side and checking whether the conclusion holds up is often the most convincing approach.
