# Statistics tutoring pack: normality, CLT, correlation and t-test reporting

Prepared Monday 12 October 2026. For the MASH statistics appointment with a part-time PhD student (ScHARR, Population Health, final year, studying remotely).

All data in this pack are simulated dummy data. None of the numbers below are the student's results.

Important note on the R code: R was not available in the environment where this pack was prepared, so the R code has not been executed. Every number in the "Output" sections was computed independently (Python, same formulas) from the CSV file `dummy_eating_data.csv` that goes with this pack. If you load that CSV in R, you should get the same numbers, give or take a last digit. Results that depend on random numbers (the bootstrap and the simulations) will differ slightly from run to run, and this is flagged where it applies.

---

## 0. How to read this in a hurry

1. Read Section 1 and Section 2 (about 3 minutes). They tell you who the student is, what they are asking, and the five points worth leading with.
2. Skim Section 11 (the final question and answer list, about 2 minutes). It is the whole session on one page.
3. Keep Sections 3 to 10 open during the session. Each one has the explanation, a worked example with dummy data, R code with a comment on every line, the output, and how to read it. SPSS steps are in Section 9.

---

## 1. Student and appointment at a glance

| Item | Detail |
|---|---|
| Programme | PhD, Health and Related Research (part-time), Population Health |
| Stage | Final year, writing statistics sections of a paper and thesis chapter |
| Location | Studying remotely from their home country (the session is probably online, so plan to share your screen) |
| Tools they seem to use | SPSS (they mention Levene's test, the "equal variances" rows and Cohen's d) and the CEBQ and AEBQ eating behaviour questionnaires |
| Advice they were given | Their tutors told them to check these statistics questions with a statistician |
| Previous appointments | The notes for Appointments 1 and 2 were blank, so this pack assumes nothing has been covered before |

Two things to ask the student at the start:

1. What does "FHS" stand for? It is not defined in the request. This pack just calls it "the FHS group" (n = 43) and "the No-FHS group".
2. I have assumed the AEBQ "SE" subscale is Slowness in Eating, and that the seven shared subscales are Enjoyment of Food (EF), Food Responsiveness (FR), Emotional Over-eating (EOE), Emotional Under-eating (EUE), Satiety Responsiveness (SR), Slowness in Eating (SE) and Food Fussiness (FF). Please confirm.

---

## 2. What the student is asking, in plain words

The student has two analyses in their paper.

Analysis A is a correlation analysis. They correlated seven matching subscales from two questionnaires (the children's CEBQ and the adult AEBQ), with N between 326 and 337 depending on missing data. They used Pearson's correlation. One AEBQ subscale (SE) looked non-normal, but they kept the parametric test because the sample is large and the Central Limit Theorem (CLT) should "hold".

Analysis B is a group comparison. They compared CEBQ subscale scores between an FHS group (n = 43) and a No-FHS group using independent t-tests, and they are building Table 3 for it.

Their questions fall into five topics:

1. Normality: is a bell-shaped histogram plus skewness and kurtosis inside plus or minus 1 an acceptable way to judge normality with a sample of about 350?
2. CLT: how reliable is the CLT for samples above 30, and does it justify using Pearson's r when one variable is non-normal?
3. Parametric versus non-parametric: they read that you can run the non-parametric test too, compare, follow the parametric result, and discuss differences. Does that apply in a paper?
4. Correlation labels: how reliable are the Evans (1996) strength labels and the p < 0.05 cut-off?
5. Table 3: which p value goes in the t-test column, and should a long Cohen's d explanation (including "p is not significant but d is small to moderate, so the study was underpowered") sit as small print under the table?

### The five points worth leading with

These are the places where the student's current wording or reasoning is exposed, in order of how much they matter.

1. The CLT argument covers the correlations (N about 330) but not the t-tests. The FHS group has only 43 people. Large total N does not rescue a small, skewed group, especially when the groups are very unequal (43 versus about 294). Section 5 shows a simulation where this inflates false positives from 5% to about 8%.
2. The "underpowered" sentence is not safe as written. A non-significant p with d of 0.20 or more does not show the study was underpowered. The honest tools are the confidence interval for d and a sensitivity power analysis (Section 8). Also, Cohen's d is a standardised effect size, not a measure of "clinical meaningfulness".
3. There are several quick fixes in the Evans sentence. The band "0.40 to 0.58" should end at 0.59 (as far as I recall the source; check the book), otherwise values such as 0.585 fall through a gap. "p 0.05" is missing its symbol. Seven or more tests need a multiplicity correction.
4. Running the non-parametric test as well is good practice. It is called a sensitivity analysis. The primary test must be chosen in advance, and both results must be reported honestly, including when they disagree.
5. For the t-test column in Table 3, use the Welch row ("Equal variances not assumed" in SPSS). That removes the need for Levene's test altogether.

---

## 3. Dummy dataset used for every example

The file `dummy_eating_data.csv` has 337 rows and 16 columns.

| Column | Meaning |
|---|---|
| `id` | Participant number |
| `group` | `FHS` (n = 43) or `No-FHS` (n = 294) |
| `cebq_EF` to `cebq_FF` | Seven CEBQ subscale scores (scale 1 to 5, steps of 0.25), no missing values |
| `aebq_EF` to `aebq_FF` | The seven matching AEBQ subscale scores, with a few missing values so that pairwise n runs from 326 to 335 |

Built-in features, so the examples have something to show:

- `aebq_SE` is deliberately right-skewed (skewness about 1.1), so it breaks the plus or minus 1 rule.
- The group difference on `cebq_FF` is real (d about 0.5).
- `cebq_EF` and `cebq_FR` have p values near 0.05 (d about 0.3), which mimics the student's borderline results.
- `cebq_EOE` has unequal variances between groups (Levene's test is significant).

### R code: set-up

```r
# Put dummy_eating_data.csv in your working folder first. Check the folder with getwd().
# Run each line in order (in RStudio: Ctrl+Enter or Cmd+Enter on each line).

# install.packages(c("e1071", "car", "pwr"))   # run ONCE if the packages are not installed yet
library(e1071)   # loads e1071, which provides skewness() and kurtosis()
library(car)     # loads car, which provides leveneTest()
library(pwr)     # loads pwr, which provides power calculations for t tests

dat <- read.csv("dummy_eating_data.csv", na.strings = "NA")   # read the file; the text NA becomes a missing value
dat$group <- factor(dat$group, levels = c("FHS", "No-FHS"))   # make group a factor with FHS first, so differences are FHS minus No-FHS
head(dat[, c("id", "group", "cebq_FF", "aebq_FF", "cebq_SE", "aebq_SE")])   # show the first six rows of six columns
table(dat$group)        # count how many participants are in each group
colSums(is.na(dat))     # count the missing values in every column
```

### Output

```
  id  group cebq_FF aebq_FF cebq_SE aebq_SE
1  1 No-FHS    1.75    1.50    2.25    2.25
2  2 No-FHS    4.25    4.75    2.75    2.75
3  3 No-FHS    4.00    3.50    3.75    2.00
4  4 No-FHS    2.75    2.25    3.00    3.75
5  5 No-FHS    2.75    2.75    3.50    2.50
6  6 No-FHS    3.00    2.50    4.00    4.25

   FHS No-FHS 
    43    294 

      id    group  cebq_EF  aebq_EF  cebq_FR  aebq_FR cebq_EOE aebq_EOE cebq_EUE aebq_EUE 
       0        0        0        3        0        5        0        2        0       11 
 cebq_SR  aebq_SR  cebq_SE  aebq_SE  cebq_FF  aebq_FF 
       0        6        0        9        0        4 
```

### How to read it

The group sizes (43 and 294) are the single most important fact for Sections 5 and 8. The missing-value counts show why n differs by subscale: the largest loss is 11 on `aebq_EUE`, so that correlation uses 326 pairs. This is exactly the "N = 326 to 337" pattern in the student's request, and the paper should state n for each correlation.

---

## 4. Question 1: is a bell-shaped histogram with skewness and kurtosis within plus or minus 1 acceptable?

### Short answer

Yes, as a practical and descriptive check, and it is better than a formal test at this sample size. But three things make it defensible: add a Q-Q plot, state and cite your thresholds before looking at the results, and remember what normality is actually needed for.

### Why this approach is reasonable

Formal tests such as Shapiro-Wilk are very sensitive when n is large. With about 350 people they reject normality for differences nobody could see in a histogram. The dummy data show this: all 14 variables get a Shapiro-Wilk p value below 0.005, even though 13 of them look fine. A "significant" result here tells you the sample is large, not that the data are badly shaped.

The z-score method (divide skewness by its standard error, flag |z| above 1.96 or 3.29) fails for the same reason. With n of 337 the standard error of skewness is only 0.13, so a skewness of 0.26 is already "significant". In the dummy data, `cebq_EOE` has skewness 0.46 and z of 3.48, but its histogram is only mildly lopsided. For samples above about 300, Kim (2013) recommends relying on the histogram plus the absolute skewness and kurtosis values rather than z-scores.

### Where plus or minus 1 sits among the conventions

| Rule | Where it comes from | How strict |
|---|---|---|
| Within plus or minus 1 | A common textbook convention | Strict. Safe, but flags mild skew in large samples |
| Skewness within plus or minus 2 and kurtosis within plus or minus 7 | Often cited to West, Finch and Curran (1995) and Kim (2013) for substantial non-normality | Lenient. Widely accepted in published work |

Check which kurtosis definition a source uses. SPSS and the R code below report excess kurtosis (a normal curve scores 0). Some sources use raw kurtosis (a normal curve scores 3). Quoting a cut-off from one definition against a value from the other is a common mistake.

An important consequence: in the dummy data, `aebq_SE` (skewness 1.12, excess kurtosis 1.16) fails the plus or minus 1 rule but would pass the plus or minus 2 and plus or minus 7 rule. So the choice of threshold changes the conclusion. The student should pick one threshold, cite it, and not switch after seeing which variable fails. Then they back it up with a sensitivity analysis (Section 6), which makes the conclusion independent of the threshold.

### What normality is actually needed for

| Analysis | What the normality assumption really concerns |
|---|---|
| Pearson correlation | A roughly linear relationship, no extreme outliers, and approximately bivariate normal data for exact p values and confidence intervals |
| Independent t-test | Each group's scores (strictly, the residuals) should be roughly normal, or the groups large enough that the sampling distribution of the mean is |
| Both | It is the sampling distribution of the statistic that has to be roughly normal, not each raw variable |

Questionnaire subscale scores are bounded (1 to 5) and move in steps (here 0.25), so they can never be exactly normal. The question is only whether they are close enough, and a histogram and Q-Q plot answer that better than a test.

### Recommended approach in four steps

1. Look: histogram with a normal curve, and a Q-Q plot.
2. Quantify: skewness and excess kurtosis, with their standard errors.
3. Decide: compare with a threshold you chose and cited in advance.
4. Check: re-run the key analysis with a robust alternative (Section 6) for any variable that is flagged.

### R code: one variable in detail

```r
x <- dat$aebq_SE                       # pick the variable to examine: the skewed AEBQ SE subscale
x <- x[!is.na(x)]                      # drop missing values so the functions below work on observed data
n <- length(x)                         # count the observed values (328 in this dataset)
m <- mean(x)                           # mean of the variable, stored for the normal curve
s <- sd(x)                             # standard deviation, stored for the normal curve
hist(x, breaks = 12, freq = FALSE,     # draw a histogram on the density scale so a curve can be added
     main = "AEBQ SE subscale",        # title above the plot
     xlab = "Subscale score (1 to 5)") # label under the x axis
curve(dnorm(x, mean = m, sd = s), add = TRUE, lwd = 2)   # overlay the normal curve with the same mean and SD
qqnorm(x)                              # Q-Q plot: observed values against what a normal variable would give
qqline(x)                              # add the reference line; points close to the line mean close to normal
g1 <- skewness(x, type = 2)            # sample skewness, formula type 2 (the same one SPSS uses)
g2 <- kurtosis(x, type = 2)            # excess kurtosis, formula type 2 (SPSS formula; 0 = normal shape)
se_g1 <- sqrt(6*n*(n-1) / ((n-2)*(n+1)*(n+3)))          # standard error of skewness (SPSS formula)
se_g2 <- 2 * se_g1 * sqrt((n^2 - 1) / ((n-3)*(n+5)))    # standard error of kurtosis (SPSS formula)
round(c(skew = g1, SE_skew = se_g1, z_skew = g1/se_g1,
        kurt = g2, SE_kurt = se_g2, z_kurt = g2/se_g2), 3)   # print all six numbers, rounded to 3 decimals
shapiro.test(x)                        # Shapiro-Wilk test, run here only to show how over-sensitive it is at this n
```

### Output

```
   skew SE_skew  z_skew    kurt SE_kurt  z_kurt 
  1.123   0.135   8.337   1.160   0.268   4.322 

	Shapiro-Wilk normality test

data:  x
W = 0.90545, p-value = 1.856e-13
```

The histogram shows a long right tail (a pile of low scores and a few high ones). The Q-Q plot curves upward at the right-hand end, away from the line.

### How to read it

- Skewness of 1.12 and excess kurtosis of 1.16 are both outside plus or minus 1. By the student's rule, this variable is flagged, which matches what they reported for SE.
- The z-scores (8.3 and 4.3) look dramatic, but do not use them for judgement at this n. They only show that the standard errors are small.
- The Shapiro-Wilk p value of 1.9e-13 agrees that normality is rejected here, but the same test also rejects normality for variables that are clearly fine (next table). So its verdict adds nothing.

### R code: all 14 variables at once

```r
vars <- grep("^(cebq|aebq)_", names(dat), value = TRUE)   # find every column whose name starts with cebq_ or aebq_
norm_tab <- do.call(rbind, lapply(vars, function(v) {     # apply the steps below to each variable and stack the rows
  x <- dat[[v]]                                           # take this variable's column
  x <- x[!is.na(x)]                                       # drop missing values
  n <- length(x)                                          # count observed values
  se1 <- sqrt(6*n*(n-1) / ((n-2)*(n+1)*(n+3)))            # standard error of skewness
  se2 <- 2 * se1 * sqrt((n^2 - 1) / ((n-3)*(n+5)))        # standard error of kurtosis
  data.frame(variable  = v,                               # one row per variable: its name
             n         = n,                               # number of observed values
             mean      = round(mean(x), 2),               # mean
             sd        = round(sd(x), 2),                 # standard deviation
             skew      = round(skewness(x, type = 2), 2), # skewness
             kurt      = round(kurtosis(x, type = 2), 2), # excess kurtosis
             z_skew    = round(skewness(x, type = 2) / se1, 2),   # skewness divided by its standard error
             z_kurt    = round(kurtosis(x, type = 2) / se2, 2),   # kurtosis divided by its standard error
             shapiro_p = signif(shapiro.test(x)$p.value, 2),      # Shapiro-Wilk p value, 2 significant digits
             beyond_1  = abs(skewness(x, type = 2)) > 1 | abs(kurtosis(x, type = 2)) > 1)  # TRUE if outside the plus or minus 1 rule
}))                                                       # end of the function and of the loop
norm_tab                                                  # print the finished table
```

### Output

| variable | n | mean | sd | skew | kurt | z_skew | z_kurt | shapiro_p | beyond_1 |
|---|---|---|---|---|---|---|---|---|---|
| cebq_EF | 337 | 3.10 | 0.74 | 0.10 | -0.13 | 0.78 | -0.49 | 2.6e-03 | FALSE |
| aebq_EF | 334 | 3.08 | 0.77 | -0.12 | -0.12 | -0.90 | -0.43 | 3.5e-03 | FALSE |
| cebq_FR | 337 | 2.46 | 0.73 | 0.13 | -0.41 | 0.97 | -1.55 | 1.7e-04 | FALSE |
| aebq_FR | 332 | 2.44 | 0.72 | 0.17 | -0.51 | 1.24 | -1.90 | 1.3e-04 | FALSE |
| cebq_EOE | 337 | 2.17 | 0.75 | 0.46 | 0.17 | 3.48 | 0.62 | 3.1e-07 | FALSE |
| aebq_EOE | 335 | 2.20 | 0.70 | 0.40 | 0.07 | 3.04 | 0.28 | 3.3e-06 | FALSE |
| cebq_EUE | 337 | 2.61 | 0.74 | -0.05 | -0.39 | -0.41 | -1.47 | 8.4e-04 | FALSE |
| aebq_EUE | 326 | 2.51 | 0.81 | 0.12 | -0.40 | 0.91 | -1.49 | 2.9e-04 | FALSE |
| cebq_SR | 337 | 2.96 | 0.62 | -0.18 | 0.14 | -1.34 | 0.53 | 2.1e-04 | FALSE |
| aebq_SR | 331 | 3.03 | 0.63 | 0.12 | -0.25 | 0.88 | -0.94 | 5.2e-04 | FALSE |
| cebq_SE | 337 | 2.83 | 0.76 | -0.02 | -0.33 | -0.19 | -1.24 | 3.8e-03 | FALSE |
| aebq_SE | 328 | 2.51 | 0.74 | 1.12 | 1.16 | 8.34 | 4.32 | 1.9e-13 | TRUE |
| cebq_FF | 337 | 2.94 | 0.77 | 0.17 | -0.06 | 1.26 | -0.23 | 2.4e-03 | FALSE |
| aebq_FF | 333 | 2.90 | 0.80 | 0.05 | -0.18 | 0.36 | -0.67 | 3.5e-03 | FALSE |

(The R console prints this as plain text with row numbers. It is shown as a table here for readability.)

### How to read it

- Only `aebq_SE` falls outside plus or minus 1 (the final column). This matches the student's finding that SE was the only non-normal subscale.
- Every shapiro_p is below 0.005, including `cebq_EF` (skewness 0.10, kurtosis -0.13), which is as close to normal as questionnaire data get. This is the cleanest way to show the student why formal tests are the wrong tool here.
- `cebq_EOE` and `aebq_EOE` have z_skew above 3, but skewness of 0.40 to 0.46. The z rule would flag them; the plus or minus 1 rule correctly would not.

### Suggested teaching move

Show the `cebq_EF` histogram and its Shapiro p of 0.0026 side by side. Ask the student: "Would you call this variable non-normal?" Most people say no, and that makes the point.

---

## 5. Question 2: how reliable is the Central Limit Theorem for samples larger than 30?

### Short answer

"n above 30" is a rule of thumb, not a guarantee. The CLT is a real theorem, but it is about the limit as n grows, and how quickly it kicks in depends on the shape of the data. For mildly skewed data, 30 is often fine. For strongly skewed or outlier-prone data, you may need hundreds. And it applies differently to the student's two analyses.

### The idea in plain words

If you repeat a study many times and calculate the mean each time, those means form their own distribution (the sampling distribution). The CLT says that for data with a finite variance, this distribution of means gets closer to a bell shape as each study gets bigger. It says nothing about the shape of the raw data, and the raw data stay skewed however large n is.

An analogy: one person's reaction time can be very skewed (mostly fast, occasionally very slow). The average reaction time of 300 people is much better behaved, because the occasional slow person is diluted. But if a few people in the sample are extreme enough, the average still gets pulled around.

### Three reasons the student's CLT argument needs care

1. The CLT is about means. Pearson's r is built from means, SDs and covariances, but the standard formulas for its p value and confidence interval assume bivariate normal data. With N of 326 to 337 and mild skew, the error in the p value is usually small (Bishara and Hittner, 2012), which supports the student's choice. But the wording "the CLT holds" is loose. A safer wording: "with a sample of this size, Pearson's r is expected to be reasonably robust to the mild skewness observed, and results were checked with Spearman's rho and bootstrap confidence intervals."
2. The t-tests have a small group. The CLT argument based on N of about 330 does not carry over to a comparison where one group has 43 people. The "effective" sample size for a two-group comparison is driven by the smaller group.
3. Unequal groups plus skew is the worst case. When a small group and a large group come from a skewed population, the Welch t-test can give more false positives than the nominal 5% (the simulation below).

### R code: how fast does the CLT work?

```r
set.seed(2026)        # fix the random seed so the simulation can be repeated exactly
reps <- 10000         # number of simulated studies per scenario
true_mean_gamma <- 4          # true mean of a gamma(shape = 4) population (skewness about 1, like the student's SE)
true_mean_lnorm <- exp(0.5)   # true mean of a lognormal(0, 1) population (skewness about 6, a very extreme case)
coverage <- function(rfun, true_mean, n) {    # define a function: how often does a 95% CI contain the true mean?
  hit <- replicate(reps, {                    # repeat the same mini-study reps times
    x <- rfun(n)                              # draw a sample of size n from the chosen population
    ci <- t.test(x)$conf.int                  # calculate the 95% t confidence interval for the mean
    ci[1] <= true_mean & true_mean <= ci[2]   # TRUE if the interval contains the true mean
  })                                          # end of the repeated mini-study
  mean(hit)                                   # share of intervals that contained the true mean (ideal: 0.95)
}                                             # end of the function
sizes <- c(10, 30, 100, 350)                  # sample sizes to compare
res <- data.frame(n = sizes,                  # start the results table with the sample sizes
  mild_skew   = sapply(sizes, function(n) coverage(function(k) rgamma(k, shape = 4), true_mean_gamma, n)),   # coverage for mildly skewed data
  strong_skew = sapply(sizes, function(n) coverage(function(k) rlnorm(k, 0, 1), true_mean_lnorm, n)))        # coverage for strongly skewed data
res                                           # print the table
```

### Output (approximate: random numbers differ slightly each run, by about plus or minus 0.005)

| n | mild skew (gamma) | strong skew (lognormal) |
|---|---|---|
| 10 | 0.937 | 0.839 |
| 30 | 0.941 | 0.885 |
| 100 | 0.950 | 0.922 |
| 350 | 0.950 | 0.939 |

### How to read it

A "95%" interval should contain the true mean 95% of the time. For mildly skewed data (like the student's SE subscale) the target is nearly met already at n of 30. For strongly skewed data, n of 30 gives only about 89% coverage, and even n of 350 is still slightly short at about 94%. So "above 30" works for mild skew and fails for strong skew. The honest answer to the student is: it depends on how skewed the data are, so look at the data rather than rely on the number 30.

### R code: the small-group problem (43 versus 294)

```r
false_pos <- function(rfun, n1, n2) {         # define a function: how often is a test "significant" when there is NO real difference?
  p <- replicate(reps, t.test(rfun(n1), rfun(n2))$p.value)   # run a Welch t-test on two samples from the SAME population and keep each p value
  mean(p < 0.05)                              # share of tests with p below 0.05 (ideal: 0.05)
}                                             # end of the function
data.frame(scenario = c("mild skew, 43 vs 294", "strong skew, 43 vs 294", "strong skew, 30 vs 30"),   # label each scenario
  false_positive_rate = c(false_pos(function(k) rgamma(k, shape = 4), 43, 294),   # mild skew, the student's group sizes
                          false_pos(function(k) rlnorm(k, 0, 1), 43, 294),        # strong skew, the student's group sizes
                          false_pos(function(k) rlnorm(k, 0, 1), 30, 30)))        # strong skew, two equal groups of 30
```

### Output (approximate)

| scenario | false positive rate |
|---|---|
| mild skew, 43 vs 294 | 0.053 |
| strong skew, 43 vs 294 | 0.082 |
| strong skew, 30 vs 30 | 0.037 |

### How to read it

With mild skew and the student's group sizes, the Welch test behaves almost perfectly (5.3% against the nominal 5%). With strong skew and very unequal groups it gives 8.2% false positives. So the risk to the t-tests depends on how skewed each subscale is within the small group. This is why the sensitivity analysis in Section 6 matters for Table 3, and why the student should look at the FHS group's histogram separately, not only at the whole sample.

### What to recommend for the paper

Do not rest the argument on "CLT holds because n is above 30". Say that the distributions were only mildly skewed (give the numbers), that Pearson's r and the Welch t-test are reasonably robust under those conditions at these sample sizes, and that Spearman, Mann-Whitney and bootstrap intervals were used as a check (Section 6).

---

## 6. Question 3: should they also run the non-parametric test, compare, and discuss differences in the paper?

### Short answer

Yes, this applies in a paper. It is called a sensitivity analysis (or robustness check), and journals and examiners like it. The advice the student found is sound, with four rules attached.

### The four rules

1. Decide the primary test in advance and say so. Parametric is a reasonable primary choice at these sample sizes (and the student should say why). The alternative is the check, not a second chance at significance.
2. Report both transparently. One sentence in the Methods and one in the Results is usually enough, with the full comparison in a supplementary table.
3. If they agree, say so briefly. If they disagree, say so plainly, do not quietly choose the one with the smaller p value, and interpret using effect sizes and confidence intervals rather than the 0.05 line.
4. Remember that the two tests ask slightly different questions. Pearson measures linear association and Spearman measures monotonic association. The Welch test compares means; the Mann-Whitney test asks whether one group tends to score higher, and it matches a comparison of means only if the two distributions have a similar shape. A difference between the tests can be a real finding about the data, not just noise.

### What to do when they disagree

| Situation | What to do |
|---|---|
| Both tests agree | Report the primary test and state that the check agreed |
| They disagree but only around p of 0.05 (for example 0.046 versus 0.061) | Report both, lead with the effect size and confidence interval, and avoid "significant versus not significant" language |
| They disagree strongly | Look for outliers, ties, and floor or ceiling effects. Consider a bootstrap interval. Report both and explain |
| Many tests, one flips | Check multiplicity first. A single borderline result among seven tests is often not worth interpreting |

### Worked example 1: seven correlations (Pearson primary, Spearman as the check)

```r
pairs <- c("EF", "FR", "EOE", "EUE", "SR", "SE", "FF")        # the seven subscales shared by the two questionnaires
cor_tab <- do.call(rbind, lapply(pairs, function(s) {          # loop over the seven pairs and stack the results
  x <- dat[[paste0("cebq_", s)]]                               # CEBQ scores for this subscale
  y <- dat[[paste0("aebq_", s)]]                               # AEBQ scores for the same subscale
  ok <- complete.cases(x, y)                                   # TRUE for participants who have both scores (pairwise deletion)
  pr <- cor.test(x[ok], y[ok], method = "pearson")             # Pearson r, with a Fisher z confidence interval and p value
  sp <- suppressWarnings(cor.test(x[ok], y[ok], method = "spearman", exact = FALSE))   # Spearman rho; exact = FALSE because scores have ties
  data.frame(subscale = s,                                     # name of the subscale
             n = sum(ok),                                      # number of complete pairs
             r = unname(pr$estimate),                          # Pearson r
             ci_low = pr$conf.int[1],                          # lower end of the 95% confidence interval
             ci_high = pr$conf.int[2],                         # upper end of the 95% confidence interval
             p_pearson = pr$p.value,                           # unadjusted p value for Pearson
             rho = unname(sp$estimate),                        # Spearman rho
             p_spearman = sp$p.value)                          # unadjusted p value for Spearman
}))                                                            # end of the function and of the loop
cor_tab$p_holm <- p.adjust(cor_tab$p_pearson, method = "holm")             # Holm adjustment across the seven Pearson tests
cor_tab$band <- cut(abs(round(cor_tab$r, 2)),                              # label each r using the REPORTED (rounded) value
                    breaks = c(0, 0.20, 0.40, 0.60, 0.80, 1),              # Evans (1996) band edges
                    right = FALSE, include.lowest = TRUE,                  # each band includes its lower edge, so 0.40 counts as moderate
                    labels = c("very weak", "weak", "moderate", "strong", "very strong"))   # the five Evans labels
out <- data.frame(subscale = cor_tab$subscale,                             # start the display table with the subscale
                  n = cor_tab$n,                                           # complete pairs
                  r = sprintf("%.2f", cor_tab$r),                          # r to two decimals
                  CI_95 = sprintf("%.2f to %.2f", cor_tab$ci_low, cor_tab$ci_high),   # confidence interval as text
                  p_holm = ifelse(cor_tab$p_holm < 0.001, "<0.001", sprintf("%.3f", cor_tab$p_holm)),   # adjusted p, in paper style
                  band = cor_tab$band,                                     # Evans label
                  rho = sprintf("%.2f", cor_tab$rho))                      # Spearman rho to two decimals
out                                                                        # print the display table
all(p.adjust(cor_tab$p_spearman, method = "holm") < 0.001)                 # TRUE if every Spearman test is also below 0.001 after Holm
```

### Output

| subscale | n | r | CI_95 | p_holm | band | rho |
|---|---|---|---|---|---|---|
| EF | 334 | 0.52 | 0.44 to 0.60 | <0.001 | moderate | 0.48 |
| FR | 332 | 0.58 | 0.50 to 0.65 | <0.001 | moderate | 0.56 |
| EOE | 335 | 0.56 | 0.48 to 0.63 | <0.001 | moderate | 0.55 |
| EUE | 326 | 0.48 | 0.39 to 0.56 | <0.001 | moderate | 0.48 |
| SR | 331 | 0.40 | 0.30 to 0.49 | <0.001 | moderate | 0.41 |
| SE | 328 | 0.42 | 0.32 to 0.50 | <0.001 | moderate | 0.40 |
| FF | 333 | 0.67 | 0.61 to 0.73 | <0.001 | strong | 0.64 |

```
[1] TRUE
```

### How to read it

- Pearson and Spearman agree closely: the largest gap is 0.04 (EF: 0.52 versus 0.48). All seven are significant under both tests, even after Holm correction. So the choice of test does not change any conclusion.
- The flagged variable (SE) gives r of 0.42 against rho of 0.40. The skewness did not matter for the conclusion. This is the evidence the student should cite for keeping Pearson, rather than the CLT alone.
- The confidence intervals are the real result. For example, the true SE correlation is plausibly anywhere from about 0.32 to 0.50.

### R code: bootstrap interval for the flagged pair

```r
set.seed(2026)                                           # fix the seed (the bootstrap uses random resampling)
ok <- complete.cases(dat$cebq_SE, dat$aebq_SE)           # participants with both SE scores
xy <- dat[ok, c("cebq_SE", "aebq_SE")]                   # keep only those two columns for those participants
boot_r <- replicate(5000, {                              # repeat the next two lines 5000 times
  i <- sample(nrow(xy), replace = TRUE)                  # resample participants with replacement
  cor(xy$cebq_SE[i], xy$aebq_SE[i])                      # Pearson r in the resampled data
})                                                       # end of the repeated block
quantile(boot_r, c(0.025, 0.975))                        # the middle 95% of bootstrap r values is the percentile interval
```

### Output (approximate: yours will differ by about 0.01)

```
     2.5%     97.5% 
0.3217     0.4988
```

### How to read it

The bootstrap interval (about 0.32 to 0.50) matches the Fisher interval from `cor.test` (0.32 to 0.50). When a robust, assumption-light method gives the same answer as the standard one, skewness is not a threat. This is the sentence the student can write in the paper.

### Worked example 2: seven t-tests (Welch primary, Mann-Whitney as the check)

```r
cebq_vars <- paste0("cebq_", c("EF", "FR", "EOE", "EUE", "SR", "SE", "FF"))   # names of the seven CEBQ columns to compare between groups
welch_p <- sapply(cebq_vars, function(v) t.test(dat[[v]] ~ dat$group)$p.value)   # Welch t-test p value for each subscale (R's default t-test)
mw_p <- sapply(cebq_vars, function(v) suppressWarnings(wilcox.test(dat[[v]] ~ dat$group, exact = FALSE)$p.value))   # Mann-Whitney p value for each subscale
holm_p <- p.adjust(welch_p, method = "holm")             # Holm adjustment across the seven Welch tests
data.frame(subscale = sub("cebq_", "", cebq_vars),       # clean subscale names for display
           welch_p = round(welch_p, 3),                  # unadjusted Welch p
           holm_p = round(holm_p, 3),                    # Holm-adjusted Welch p
           mannwhitney_p = round(mw_p, 3),               # Mann-Whitney p
           same_verdict_at_05 = (welch_p < 0.05) == (mw_p < 0.05))   # TRUE if both tests land on the same side of 0.05
```

### Output

| subscale | welch_p | holm_p | mannwhitney_p | same_verdict_at_05 |
|---|---|---|---|---|
| EF | 0.046 | 0.274 | 0.061 | FALSE |
| FR | 0.055 | 0.277 | 0.056 | TRUE |
| EOE | 0.837 | 1.000 | 0.345 | TRUE |
| EUE | 0.849 | 1.000 | 0.903 | TRUE |
| SR | 0.147 | 0.588 | 0.150 | TRUE |
| SE | 0.637 | 1.000 | 0.627 | TRUE |
| FF | 0.003 | 0.024 | 0.003 | TRUE |

### How to read it

- This reproduces the student's situation: "some of the results came different". Only EF flips (Welch 0.046, Mann-Whitney 0.061), and it flips across the 0.05 line without any real change in the evidence. The tests disagree because the p value is sitting on the boundary.
- After Holm correction the EF result is nowhere near significant (0.274). With seven tests, one p value of 0.046 is what you would expect by chance.
- FF is the only robust finding: both tests give 0.003 and it survives the correction (0.024).
- The paper should say something like: "One comparison (EF) was significant under the Welch test but not the Mann-Whitney test, and neither was significant after correction for multiple testing, so we do not interpret it."

---

## 7. Question 4: how reliable are the Evans (1996) labels and the p < 0.05 cut-off?

### Short answer

The labels are a convention, not data. They are fine as a descriptive aid if you apply them consistently and cite the source, but they are not evidence that a correlation is important. The correlation coefficient and its confidence interval are the real result.

### What to fix in the student's sentence

| Issue in the current text | Fix |
|---|---|
| "0.40 to 0.58" for moderate | Should be 0.40 to 0.59 (check against the book). With a 0.58 upper edge, a value of 0.585 falls into no band at all |
| "0.00 to 0.19 ... 0.20 and 0.39 ..." | Write the ranges consistently: "0.20 to 0.39", "0.60 to 0.79" |
| "p 0.05" | The symbol is missing: "p < 0.05" |
| One alpha of 0.05 across seven or more tests | Correct for multiple testing (Holm or Benjamini-Hochberg) and say so |
| Labels applied to unrounded or rounded r inconsistently | Decide once. In the dummy data, SR has r of 0.3983. Reported as 0.40 it is "moderate"; unrounded it falls in "weak". Classify the reported (rounded) value and say so |
| Labels shown without the numbers | Always report r with a 95% confidence interval |

### Different authors label the same r differently

| Scheme | What r of 0.42 is called |
|---|---|
| Evans (1996) | Moderate |
| Cohen (1988) | Between medium (0.30) and large (0.50) |
| Gignac and Szodorai (2016), for individual differences research | Large (they propose 0.10, 0.20 and 0.30 as small, typical and large) |

So "moderate" is one author's word, not a property of the data. The student should cite one scheme, say it is a heuristic, and interpret in the context of their field. For two different eating behaviour questionnaires measuring the same trait, correlations in the 0.4 to 0.7 range are the substantive result (they support convergent validity), whatever label is attached.

Useful extra number: r squared is the proportion of shared variance. An r of 0.42 means about 17% shared variance (0.42 squared is 0.176), which is a plain-language way of saying "moderate".

### On the 0.05 threshold

The 0.05 level is a convention. It is fine to use it, but report exact p values (or "p < 0.001"), and with these sample sizes almost any non-trivial correlation will be significant, so significance says little. The size and confidence interval carry the information. The multiple-testing correction matters: the dummy data have seven correlations, and for the t-tests seven more tests.

The code and output for banding are in Section 6 (the `band` column).

---

## 8. Question 5: Table 3 (t-tests), the p value column, and the Cohen's d note

### Part A: which values go in the "T-test for equality of means p value" column?

Short answer: the p value from the Welch row.

In SPSS, the Independent-Samples T Test output has two rows for each variable: "Equal variances assumed" and "Equal variances not assumed". The student has to pick one p value (the "Sig. (2-tailed)" column).

- Older advice is a two-step approach: run Levene's test, and if it is significant use the second row. This is why the student's table has a Levene's column.
- Current advice is to use Welch's test (the second row, "Equal variances not assumed") by default and skip Levene's test. Welch loses almost nothing when variances are equal and protects you when they are not, particularly with unequal group sizes as here (Delacre, Lakens and Leys, 2017). Pre-testing for equal variances also adds its own error rate.

The dummy EOE subscale shows what is at stake: Levene's p is 0.004 (variances clearly differ, FHS SD of 0.99 against 0.71). The Student t-test gives p of 0.79, the Welch test gives p of 0.84. Here the conclusion is the same, but with borderline results, it can change.

If the supervisor wants Levene's test kept, keep the column but make clear which row was used.

### Suggested columns for Table 3

| CEBQ subscale | FHS n | FHS mean (SD) | No-FHS n | No-FHS mean (SD) | Mean difference [95% CI] | t (df) | p | Holm-adjusted p | Cohen's d [95% CI] |
|---|---|---|---|---|---|---|---|---|---|

Changes from the student's version: the confidence interval for the mean difference, the t and df (Welch df is not a whole number), an adjusted p, and a confidence interval for d.

### R code: build the table

```r
t_tab <- do.call(rbind, lapply(cebq_vars, function(v) {      # loop over the seven CEBQ subscales and stack one row each
  a <- dat[[v]][dat$group == "FHS"]                          # scores in the FHS group
  b <- dat[[v]][dat$group == "No-FHS"]                       # scores in the No-FHS group
  n1 <- length(a)                                            # FHS group size (43)
  n2 <- length(b)                                            # No-FHS group size (294)
  lev <- leveneTest(dat[[v]] ~ dat$group, center = mean)     # Levene's test; center = mean matches the SPSS version
  w <- t.test(a, b, var.equal = FALSE)                       # Welch t-test, difference = FHS minus No-FHS
  sp <- sqrt(((n1 - 1) * var(a) + (n2 - 1) * var(b)) / (n1 + n2 - 2))   # pooled standard deviation
  d <- (mean(a) - mean(b)) / sp                              # Cohen's d (FHS minus No-FHS)
  se_d <- sqrt((n1 + n2) / (n1 * n2) + d^2 / (2 * (n1 + n2)))   # approximate standard error of d
  data.frame(subscale = sub("cebq_", "", v),                 # subscale name without the prefix
    FHS = sprintf("%.2f (%.2f)", mean(a), sd(a)),            # FHS mean (SD)
    NoFHS = sprintf("%.2f (%.2f)", mean(b), sd(b)),          # No-FHS mean (SD)
    levene_p = round(lev$`Pr(>F)`[1], 3),                    # Levene's p value
    t = round(unname(w$statistic), 2),                       # Welch t statistic
    df = round(unname(w$parameter), 1),                      # Welch degrees of freedom
    p = w$p.value,                                           # unadjusted Welch p value
    mean_diff = sprintf("%.2f [%.2f, %.2f]", unname(w$estimate[1] - w$estimate[2]), w$conf.int[1], w$conf.int[2]),   # mean difference with 95% CI
    d_CI = sprintf("%.2f [%.2f, %.2f]", d, d - 1.96 * se_d, d + 1.96 * se_d))   # Cohen's d with an approximate 95% CI
}))                                                          # end of the function and of the loop
t_tab$p_holm <- sprintf("%.3f", p.adjust(t_tab$p, method = "holm"))   # Holm-adjusted p across the seven tests, as text
t_tab$p <- sprintf("%.3f", t_tab$p)                          # format the unadjusted p as text with 3 decimals
t_tab                                                        # print the table
```

### Output

| subscale | FHS mean (SD) | No-FHS mean (SD) | Levene p | t | df | p | p_holm | mean diff [95% CI] | d [95% CI] |
|---|---|---|---|---|---|---|---|---|---|
| EF | 2.88 (0.73) | 3.13 (0.74) | 0.966 | -2.04 | 55.6 | 0.046 | 0.274 | -0.24 [-0.48, -0.00] | -0.33 [-0.65, -0.01] |
| FR | 2.66 (0.69) | 2.43 (0.73) | 0.893 | 1.96 | 56.4 | 0.055 | 0.277 | 0.22 [-0.01, 0.45] | 0.31 [-0.01, 0.63] |
| EOE | 2.15 (0.99) | 2.18 (0.71) | 0.004 | -0.21 | 48.4 | 0.837 | 1.000 | -0.03 [-0.35, 0.28] | -0.04 [-0.36, 0.28] |
| EUE | 2.63 (0.77) | 2.61 (0.73) | 0.888 | 0.19 | 53.7 | 0.849 | 1.000 | 0.02 [-0.23, 0.28] | 0.03 [-0.29, 0.35] |
| SR | 2.83 (0.62) | 2.98 (0.62) | 0.929 | -1.47 | 54.8 | 0.147 | 0.588 | -0.15 [-0.35, 0.05] | -0.24 [-0.56, 0.08] |
| SE | 2.78 (0.69) | 2.84 (0.77) | 0.245 | -0.47 | 58.2 | 0.637 | 1.000 | -0.05 [-0.28, 0.18] | -0.07 [-0.39, 0.25] |
| FF | 3.27 (0.76) | 2.90 (0.76) | 0.759 | 3.05 | 55.3 | 0.003 | 0.024 | 0.38 [0.13, 0.62] | 0.49 [0.17, 0.82] |

(The group sizes are 43 and 294 for every row. The d interval uses a simple approximation; the `effectsize` package, for example `effectsize::cohens_d()`, uses a slightly different method and may differ in the second decimal.)

### How to read it

- Note the df values (about 55, not 335). Welch's df is driven by the small group, which shows the effective information is much smaller than N of 337.
- Only FF is clearly different: d of 0.49, interval 0.17 to 0.82, and it survives Holm correction (0.024).
- EF looks significant (p of 0.046) but the interval for the difference runs almost to zero and the adjusted p is 0.274. It is not a finding.
- FR (p of 0.055, d of 0.31) is the "non-significant but small to moderate" case the student is worried about. The interval for d runs from about -0.01 to 0.63. That is the honest picture, discussed next.

### Part B: should the Cohen's d explanation be small print under the table?

Short answer: a short footnote giving the source and the cut-offs is fine. The long text in the student's draft should be changed and moved into the Discussion.

Problems with the current text:

| Statement in the draft | Problem | Fix |
|---|---|---|
| "Cohen's d indicates how clinically meaningful the difference is" | d is a standardised effect size (the difference in units of SD). It says nothing about clinical meaning, which needs an outcome-specific benchmark (for example a minimal important difference) | "Cohen's d is the standardised mean difference" |
| "Values less than 0.2 indicate a virtually imperceptible difference" | Not Cohen's wording. Cohen called 0.2 "small" and gave no label below it | Say "below the conventional small benchmark" or leave it out |
| "When p is 0.05 or more but d is 0.20 or more, it can indicate the study was underpowered" | Not safe. A non-zero observed d occurs by chance, especially in a group of 43. Judging power from the observed effect (observed power) is circular and widely criticised (Hoenig and Heisey, 2001) | Use the confidence interval for d, and a sensitivity power analysis (below) |
| The explanation sitting under the table | Interpretation does not belong in table notes | Keep the footnote to definitions, and put interpretation in the Discussion |

### The better tool: a sensitivity power analysis

It answers: "with 43 and 294 people, what is the smallest effect this study could reliably detect?"

```r
pwr.t2n.test(n1 = 43, n2 = 294, sig.level = 0.05, power = 0.80)   # solve for d: the smallest effect detectable with 80% power (d is left out on purpose)
sapply(c(0.2, 0.3, 0.5), function(d) pwr.t2n.test(n1 = 43, n2 = 294, d = d, sig.level = 0.05)$power)   # power for three plausible effect sizes
ceiling(pwr.t.test(d = 0.3, power = 0.80, sig.level = 0.05, type = "two.sample")$n)   # people PER GROUP needed for d = 0.3 with equal groups
ceiling(pwr.t.test(d = 0.2, power = 0.80, sig.level = 0.05, type = "two.sample")$n)   # people PER GROUP needed for d = 0.2 with equal groups
```

### Output

```
     t test power calculation 

             n1 = 43
             n2 = 294
              d = 0.4587315
      sig.level = 0.05
          power = 0.8
    alternative = two.sided

[1] 0.2308347 0.4492331 0.8629465
[1] 176
[1] 394
```

(The first block is the standard `pwr` layout; the value of d may differ in the last digits.)

### How to read it

- With 43 and 294 people the study had 80% power only for effects of about d of 0.46 or larger.
- If the true effect were d of 0.3, power would be about 45%, so a non-significant result would be the more likely outcome. At d of 0.2, power is about 23%. At d of 0.5, it is about 86%.
- Detecting d of 0.3 with equal groups would need about 176 per group. For d of 0.2, about 394 per group.
- So the claim the student wants to make ("a small FHS group may have limited the ability to detect differences") is correct, but it should rest on this calculation and on the confidence intervals, not on the observed d.

### Bootstrap check for the one significant result

```r
set.seed(2026)                                            # fix the seed for the resampling
a <- dat$cebq_FF[dat$group == "FHS"]                      # FF scores in the FHS group
b <- dat$cebq_FF[dat$group == "No-FHS"]                   # FF scores in the No-FHS group
boot_d <- replicate(5000, mean(sample(a, replace = TRUE)) - mean(sample(b, replace = TRUE)))   # resample each group separately and take the difference in means
quantile(boot_d, c(0.025, 0.975))                         # percentile 95% bootstrap interval for the mean difference
```

### Output (approximate: yours will differ by about 0.01)

```
     2.5%     97.5% 
   0.1394    0.6093
```

The bootstrap interval (0.14 to 0.61) is close to the Welch interval (0.13 to 0.62), so the FF result does not depend on normality assumptions.

---

## 9. SPSS steps

### Normality (Question 1)

1. Analyze, Descriptive Statistics, Explore.
2. Move the variable to Dependent List. Leave Factor List empty, or add the group variable to check each group separately (recommended for the FHS group).
3. Statistics button: tick Descriptives. Plots button: tick Histogram and "Normality plots with tests".
4. OK. Read skewness and kurtosis, with their standard errors, in the Descriptives table. SPSS reports excess kurtosis. The histogram and Normal Q-Q plot come after the tests table. Ignore the Shapiro-Wilk and Kolmogorov-Smirnov rows for judgement at this n.

### Correlations: Pearson and Spearman (Question 3)

1. Analyze, Correlate, Bivariate.
2. Move both variables of a pair into Variables (or move all, to get a matrix).
3. Tick Pearson and Spearman. Leave Two-tailed selected.
4. Options: choose "Exclude cases pairwise" if you want the largest n per pair, and say so in the paper.
5. For confidence intervals, use the Bootstrap button (needs the Bootstrapping module, tick Perform bootstrapping, 5000 samples, BCa). Some recent versions also offer a confidence interval option inside this dialog; check which version you have.
6. SPSS does not adjust for multiple testing in this dialog. Apply Bonferroni by hand (0.05 divided by the number of tests), or use the Holm method in R.

### Independent t-test and Mann-Whitney (Questions 3 and 5)

1. Analyze, Compare Means, Independent-Samples T Test.
2. Test Variable(s): the subscales. Grouping Variable: group. Click Define Groups and enter the two codes.
3. Options: leave the interval at 95%. In recent versions, tick "Estimate effect sizes" to get Cohen's d with a confidence interval.
4. In the output, use the row "Equal variances not assumed" for Sig. (2-tailed), the t, the df and the confidence interval of the difference. Ignore the Levene's test columns if you use Welch by default.
5. Mann-Whitney: Analyze, Nonparametric Tests, Independent Samples (or Legacy Dialogs, 2 Independent Samples, and tick Mann-Whitney U).

### Sensitivity power analysis

SPSS has no simple tool for this. Use G*Power (free): Test family "t tests", statistical test "Means: Difference between two independent means (two groups)", type of power analysis "Sensitivity: Compute required effect size". Enter alpha 0.05, power 0.80, sample size group 1 as 43, group 2 as 294. It returns the minimum detectable d (about 0.46 for these dummy group sizes).

---

## 10. Suggested wording for the paper

These are starting points. Adapt the numbers and the names to the student's real results. They avoid em dashes, long stacked sentences, and wording that over-claims.

### Methods: normality and choice of tests

"Distributions were inspected using histograms and Q-Q plots, and skewness and excess kurtosis were calculated for every subscale. Formal normality tests were not used for decisions because they reject normality for trivial departures in samples of this size (Field, 2018). Absolute skewness and excess kurtosis values below 1 were taken to indicate no meaningful departure from normality. One subscale (AEBQ SE) exceeded this value (skewness 1.12, kurtosis 1.16). Pearson's correlation and Welch's t-test were specified as the primary analyses because both are reasonably robust to mild skewness at these sample sizes. To check this, Spearman's rank correlation, the Mann-Whitney test and bootstrap confidence intervals were also computed."

### Methods: multiple testing and effect sizes

"Seven correlations and seven group comparisons were tested. P values were adjusted within each family using the Holm method. Correlation strength was described using the bands of Evans (1996), applied to coefficients rounded to two decimals. Standardised mean differences are reported as Cohen's d, interpreted using the conventional benchmarks (Cohen, 1988), together with 95% confidence intervals."

### Results: correlations

"Pearson correlations between matched CEBQ and AEBQ subscales ranged from r = 0.40 to 0.67 (all Holm-adjusted p < 0.001; Table X). Six were moderate and one (Food Fussiness) was strong. Spearman coefficients were within 0.04 of the Pearson coefficients, and the bootstrap interval for the AEBQ SE pair (0.32 to 0.50) matched the Fisher interval, so the skewness of that subscale did not change the conclusions."

### Results: when parametric and non-parametric tests disagree

"For Enjoyment of Food, the Welch test gave p = 0.046 and the Mann-Whitney test gave p = 0.061. Neither result remained significant after adjustment for multiple testing (adjusted p = 0.274), so this difference is not interpreted."

### Table 3 footnote

"Note. FHS = [define]. Differences are FHS minus No-FHS. Welch's t-test was used for all comparisons. Cohen's d is the standardised mean difference (pooled SD); values of 0.20, 0.50 and 0.80 are conventionally described as small, medium and large (Cohen, 1988). CI = confidence interval. Adjusted p values use the Holm method across the seven comparisons."

### Discussion or limitations: small group

"The FHS group was small (n = 43). With this group size and 294 participants in the comparison group, the study had 80% power only for standardised differences of about d = 0.46 or larger. For Food Responsiveness, the FHS group scored higher on average (d = 0.31, 95% CI -0.01 to 0.63, p = 0.055). The interval is compatible with no difference and with a moderate difference, so the data are inconclusive for smaller effects. Studies with larger FHS samples are needed to estimate differences of this size."

---

## 11. Final list: what the student asked, and the answer

1. Is a bell-shaped histogram plus skewness and kurtosis within plus or minus 1 acceptable for judging normality at n of about 350?
   Yes, as a practical check, and better than a formal test at this size. Add a Q-Q plot, cite your thresholds, choose them before seeing the results, and back them up with a sensitivity analysis. Plus or minus 1 is strict; plus or minus 2 (skewness) and plus or minus 7 (kurtosis) is also commonly cited.

2. Can they justify Pearson's r for a non-normal subscale (SE) because the sample is large and the CLT holds?
   Partly. With N of about 330 and mild skew, Pearson's r is reasonably robust. But "the CLT holds" is loose wording and the CLT concerns means, not r. Say instead that the sample is large and the skew mild, and show that Spearman and a bootstrap interval agree.

3. How reliable is the CLT for samples above 30?
   "30" is a rule of thumb. It works for mildly skewed data and fails for strongly skewed data (a simulation gave about 89% coverage for a nominal 95% interval at n of 30 under strong skew). Look at the shape of the data instead of relying on the number.

4. Does the CLT argument also cover the t-tests?
   No. The FHS group has only 43 people, and the groups are very unequal. Check the shape of the scores within the FHS group, and use Welch's test.

5. Should they run the non-parametric test as well and discuss differences in the paper?
   Yes. It is a sensitivity analysis. Decide the primary test in advance, report both, say plainly when they disagree, and interpret with effect sizes and confidence intervals rather than the 0.05 line.

6. Is it right to just follow the parametric test because it is robust?
   Reasonable as a default for the large-sample correlations. It is not automatic for the t-tests with n of 43, so justify it, show the check, and be open about any disagreement.

7. How reliable are the Evans (1996) correlation labels and the p < 0.05 cut-off?
   They are conventions, not data. Fix the "0.40 to 0.58" band (should end at 0.59, check the book), add the missing symbol in "p < 0.05", adjust for multiple tests, and report r with its confidence interval. Different authors label the same r differently.

8. Which p value goes in the t-test column of Table 3?
   The Welch row ("Equal variances not assumed" in SPSS). Then Levene's test is not needed. Add the mean difference with its confidence interval, t, df, adjusted p, and d with its interval.

9. Should the Cohen's d explanation go as small print under the table?
   A short footnote giving the source and cut-offs, yes. The long explanation, no. Move interpretation to the Discussion. Also correct it: d is a standardised effect size, not "clinical meaningfulness".

10. Does a non-significant p with d of 0.20 or more mean the study was underpowered?
    Not by itself. Use the confidence interval for d and a sensitivity power analysis. In the dummy example, 43 versus 294 people gives 80% power only for d of about 0.46 or larger.

11. Can they recommend a larger FHS group in future studies?
    Yes, as a limitation and recommendation, supported by the power calculation. Avoid implying that a non-significant result is "really" a difference.

---

## 12. References, and what was not verified

References (listed from memory; please check volume and page details before quoting them to the student):

- Bishara, A. J., and Hittner, J. B. (2012). Testing the significance of a correlation with nonnormal data: Comparison of Pearson, Spearman, transformation, and resampling approaches. Psychological Methods, 17(3), 399-417.
- Cohen, J. (1988). Statistical Power Analysis for the Behavioral Sciences (2nd ed.). Lawrence Erlbaum.
- Delacre, M., Lakens, D., and Leys, C. (2017). Why psychologists should by default use Welch's t-test instead of Student's t-test. International Review of Social Psychology, 30(1), 92-101.
- Evans, J. D. (1996). Straightforward Statistics for the Behavioral Sciences. Brooks/Cole.
- Field, A. (2018). Discovering Statistics Using IBM SPSS Statistics (5th ed.). SAGE.
- Gignac, G. E., and Szodorai, E. T. (2016). Effect size guidelines for individual differences researchers. Personality and Individual Differences, 102, 74-78.
- Hoenig, J. M., and Heisey, D. M. (2001). The abuse of power: The pervasive fallacy of power calculations for data analysis. The American Statistician, 55(1), 19-24.
- Kim, H.-Y. (2013). Statistical notes for clinical researchers: Assessing normal distribution (2) using skewness and kurtosis. Restorative Dentistry and Endodontics, 38(1), 52-54.
- Lumley, T., Diehr, P., Emerson, S., and Chen, L. (2002). The importance of the normality assumption in large public health data sets. Annual Review of Public Health, 23, 151-169. (Useful further reading on the large-sample argument.)
- West, S. G., Finch, J. F., and Curran, P. J. (1995). Structural equation models with nonnormal variables: Problems and remedies. In R. H. Hoyle (Ed.), Structural Equation Modeling: Concepts, Issues, and Applications (pp. 56-75). Sage.

What was and was not checked in this pack:

- Not searched online. No web search was run while preparing this, so the references and the quoted rules of thumb come from memory. I am fairly confident of them, but treat the exact band edges in Evans (1996) and the kurtosis definition used by West et al. and Kim as things to confirm against the sources.
- R code not executed. R was not installed here. The output was computed in Python from the same CSV using the same formulas, so tiny differences in a last digit are possible. The bootstrap and simulation results are approximate by nature.
- The dummy results are invented. Nothing here describes the student's real data, and the real data may behave differently (for example, they may have more or fewer flagged subscales).
- Statistical content was reviewed from three angles: as a supportive assistant (what the student needs to hear first), as a supervisor (is the reasoning right), and as an examiner (what could be attacked). The overall verdict: the student's approach is sound in outline, but three statements (the CLT justification for the t-tests, the "underpowered" sentence, and the Evans band typo) would draw criticism as currently written, and each has a concrete fix above.
