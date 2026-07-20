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

### Step 5: How to read the output

Look for these three things in the printed summary:

1. **Pooled OR** — the single combined number. Is it below 1 (treatment looks better), above 1 (treatment looks worse), or close to 1 (no real difference)?
2. **95% Confidence Interval (CI)** — the range next to the OR. If this range does NOT include 1, the result is statistically significant.
3. **I² (heterogeneity)** — a percentage telling you how much the studies disagree with each other. Near 0% = studies agree well, pooling them is reasonable. Above about 50% = studies disagree a lot, pooling is more questionable and worth investigating further.

---

## 7. Takeaway

Zero-event studies are a genuinely tricky corner of meta-analysis, not a sign you've done something wrong. The important thing is knowing which method you used, why, and being able to explain the trade-off if asked — running two or three methods side by side and checking whether the conclusion holds up is often the most convincing approach.
