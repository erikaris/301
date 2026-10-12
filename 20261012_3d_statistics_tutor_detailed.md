# Statistics Tutoring Guide: Normality, Pearson vs Spearman Correlation, Independent t-tests, Effect Sizes and Reporting Results

Session context: PhD student in Health and Related Research (SCHARR), working on statistical analysis and thesis chapter writing.

Main objective: Help the student decide whether their statistical methods are appropriate, understand potentially conflicting results, and report findings correctly in their PhD thesis and publications.

## 1. Quick preparation: What should you tell the student?

The student's questions concern five interconnected statistical issues.

| Topic                       | Student's question                                                             | Your main advice                                                                                                                  |
| --------------------------- | ------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------- |
| Normality                   | Are bell-shaped histograms and skewness/kurtosis between −1 and +1 sufficient? | Reasonable preliminary checks, but not definitive. Check Q–Q plots, outliers and the assumptions relevant to each analysis.       |
| Central Limit Theorem (CLT) | Does a sample size above 30 justify parametric tests?                          | No universal threshold. The CLT concerns sampling distributions, not the distribution of the original observations.               |
| Pearson vs Spearman         | Which should be reported if the results differ?                                | Choose based on the research question, relationship shape and assumptions, not whichever gives a significant result.              |
| Correlation strength        | Are Evans' thresholds reliable?                                                | Useful descriptive conventions, not universal scientific standards. Report actual coefficients, confidence intervals and context. |
| Independent t-tests         | Which p-values and Cohen's d values should be included?                        | Usually report Welch's t-test, group means/SDs, mean difference, 95% CI, p-value and an appropriate effect size.                  |

The most important methodological point: The student's justification for using Pearson correlation based solely on the CLT and a sample size above 300 is incomplete.

A large sample can make certain inferential procedures more robust, but it does not automatically make Pearson correlation appropriate for every relationship.

## 2. How to begin the tutoring session

You could say:

> From your appointment request, I understand that you're mainly looking for reassurance about your statistical choices and how to justify them in your thesis. You've already carried out normality checks, Pearson correlations and independent t-tests, but you're unsure how to interpret conflicting results and report effect sizes.
>
> I suggest we start by looking at the distributions and scatterplots, then discuss Pearson versus Spearman, and finally review your t-test results and how to present them in your tables.

Before giving specific recommendations, establish four things:

1. Are the CEBQ and AEBQ subscale scores calculated as averages or sums of multiple Likert-type items?
2. Are the CEBQ and AEBQ scores paired observations from the same participants, or are they child–parent pairs? Are any observations clustered within families?
3. Does FHS mean family history of something, and are FHS and non-FHS independent groups?
4. What are the actual scatterplots, group sizes, standard deviations, p-values and confidence intervals?

These questions matter because the statistical method depends on how the data were collected, not just their distribution.

# Part I. Understanding normality

## 3. What does normality mean?

A normal distribution is a continuous, symmetric, bell-shaped probability distribution.

For example, suppose we measure a continuous health-related score in 350 participants. If the distribution is approximately normal, most observations are near the mean and fewer are found towards the extremes.

### 3.1 How to assess normality

| Method            | What it tells us                                          | Limitation                                      |
| ----------------- | --------------------------------------------------------- | ----------------------------------------------- |
| Histogram         | General distribution shape, skewness and unusual values   | Appearance depends on bin width                 |
| Q–Q plot          | Whether observed quantiles resemble a normal distribution | Requires judgement                              |
| Skewness          | Degree of asymmetry                                       | Doesn't identify every departure from normality |
| Excess kurtosis   | Tail behaviour and extremity relative to normal           | Not a direct measure of normality               |
| Shapiro–Wilk test | Tests the null hypothesis of normality                    | Sensitive to small deviations in large samples  |

For a normal distribution, skewness and excess kurtosis are both zero. Note that ordinary Pearson kurtosis is 3, not zero.

Values between −1 and +1 are sometimes used as practical guidelines, but these are not formal acceptance criteria.

### 3.2 Example: AEBQ subscale

Suppose 330 participants have the following scores:

| Statistic            | Example |
| -------------------- | ------- |
| N                    | 330     |
| Mean                 | 3.20    |
| SD                   | 0.65    |
| Skewness             | −0.42   |
| Excess kurtosis      | 0.35    |
| Shapiro–Wilk p-value | 0.012   |

How should we interpret this?

- The histogram might look reasonably symmetric.
- Skewness of −0.42 suggests mild left skewness.
- Excess kurtosis of 0.35 suggests a relatively small departure from normal kurtosis.
- Shapiro–Wilk is statistically significant, suggesting evidence against exact normality.

Conclusion: The distribution is not exactly normal according to Shapiro–Wilk, but the departure might be minor for the intended analysis.

A statistically significant normality test does not automatically mean that a parametric method is inappropriate.

### 3.3 R implementation

```

# Generate reproducible example data
set.seed(123)

# Create 330 approximately normal subscale scores
scores <- rnorm(330, mean = 3.2, sd = 0.65)

# Keep scores within a hypothetical 1–5 scale
scores <- pmin(pmax(scores, 1), 5)

# Display descriptive statistics
summary(scores)
sd(scores)

# Plot histogram
hist(scores,
     main = "Distribution of AEBQ scores",
     xlab = "AEBQ subscale score",
     breaks = 20)

# Generate a normal Q-Q plot
qqnorm(scores)

# Add the reference line
qqline(scores)

# Perform Shapiro-Wilk normality test
shapiro.test(scores)

# Install the package once if needed
# install.packages("moments")

# Load the moments package
library(moments)

# Calculate skewness
skewness(scores)

# Calculate excess kurtosis
kurtosis(scores) - 3

```

The numerical summary above is illustrative, not the verified output of this particular simulation.

### SPSS implementation

1. Select Analyze → Descriptive Statistics → Explore.
2. Move the subscale variable into Dependent List.
3. Select Plots.
4. Tick Histogram and Normality plots with tests.
5. Run the analysis and inspect the histogram, Q–Q plot and Shapiro–Wilk test.
6. For skewness and kurtosis, examine the descriptive statistics in the output.

What to tell the student: Your current approach is a reasonable descriptive starting point. However, I would add Q–Q plots and inspect outliers. More importantly, I would check the assumptions for each statistical procedure rather than deciding whether all variables are normal using a single rule.

# Part II. The Central Limit Theorem

## 4. Does N greater than 30 guarantee normality?

No.

The Central Limit Theorem (CLT) says that, under suitable conditions, the sampling distribution of a standardised sample mean approaches a normal distribution as sample size increases.

For independent, identically distributed observations with finite population variance:

\\[ \bar X=\frac{1}{n}\sum\_{i=1}^{n}X_i \\]

and

\\[ \frac{\bar X-\mu}{\sigma/\sqrt n} \xrightarrow{d}N(0,1). \\]

Here:

- \\(\bar X\\) is the sample mean.
- \\(\mu\\) is the population mean.
- \\(\sigma\\) is the population standard deviation.
- \\(n\\) is the sample size.
- \\(\sigma/\sqrt n\\) is the standard error of the mean.

The theorem describes the behaviour of sample means, not the original individual scores.

## 4.1 Example: Highly skewed population

Imagine that waiting times at a clinic are strongly right-skewed. Most patients wait briefly, but a few wait much longer.

Original observations

Right-skewed population

Repeated sample means

Approximately normal sampling distribution

Suppose we repeatedly collect samples of 50 patients and calculate their mean waiting time.

The distribution of those sample means can be approximately normal even though individual waiting times remain skewed.

### 4.2 Is 30 a magic number?

No. The required sample size depends on factors including:

- How strongly skewed or heavy-tailed the population is.
- Whether observations are independent.
- Whether the population variance is finite.
- Whether extreme outliers dominate the sample.
- Which statistic is being analysed.

A sample of 30 may be sufficient for some distributions and inadequate for others.

### 4.3 R demonstration

```

# Set seed so the results can be reproduced
set.seed(123)

# Generate 100,000 skewed population observations
population <- rexp(100000, rate = 1)

# Plot the original population distribution
hist(population,
     breaks = 50,
     main = "Original skewed population",
     xlab = "Observed value")

# Function to generate 5,000 sample means
simulate_means <- function(n) {

  # Repeat the sampling process 5,000 times
  replicate(5000, {

    # Randomly select n observations
    sample_values <- sample(population, n)

    # Calculate their mean
    mean(sample_values)
  })
}

# Generate sampling distributions for different sizes
means_5 <- simulate_means(5)
means_30 <- simulate_means(30)
means_100 <- simulate_means(100)

# Plot each sampling distribution
hist(means_5, main = "Sample means: n = 5")
hist(means_30, main = "Sample means: n = 30")
hist(means_100, main = "Sample means: n = 100")

```

The histograms should become progressively more symmetric and concentrated around the population mean as sample size increases.

## 4.4 Does the CLT justify Pearson correlation?

Not by itself.

Pearson correlation is not simply a sample mean. Its sampling behaviour depends on the joint distribution of two variables, their variances and their relationship.

For Pearson correlation, check:

- Are the variables quantitative and suitable for Pearson correlation?
- Is the relationship approximately linear?
- Are there influential outliers?
- Are the observations independent?
- Is the variability reasonably consistent across the range of values?
- Are the confidence intervals and p-values reliable under the observed data conditions?

At N around 330, Pearson correlation may be a perfectly reasonable choice for mildly non-normal subscale scores.

However, the justification should be based on the observed relationship and the analysis assumptions, not only the CLT.

Suggested explanation to the student: A large sample makes Pearson correlation inference less sensitive to some departures from normality, but it does not protect against a strongly nonlinear relationship or influential outliers.

# Part III. Pearson versus Spearman correlation

## 5. What is the difference?

The student is comparing seven corresponding subscales from two eating-behaviour questionnaires:

- CEBQ: Children's Eating Behaviour Questionnaire.
- AEBQ: Adult Eating Behaviour Questionnaire.

The research question appears to be whether scores on corresponding child and adult eating-behaviour subscales are associated.

Two common correlation methods are Pearson's \\(r\\) and Spearman's \\(\rho\\).

| Feature                                             | Pearson                                                                               | Spearman                                                       |
| --------------------------------------------------- | ------------------------------------------------------------------------------------- | -------------------------------------------------------------- |
| Measures                                            | Linear association                                                                    | Monotonic association                                          |
| Uses                                                | Actual numerical values                                                               | Ranks                                                          |
| Suitable for                                        | Quantitative variables with approximately linear relationships                        | Ordinal data or quantitative data with monotonic relationships |
| Sensitivity to outliers                             | Often high                                                                            | Usually less sensitive to extreme numerical values             |
| Requires both variables to be normally distributed? | Not for calculating \\(r\\); distributional assumptions affect conventional inference | No                                                             |
| Main limitation                                     | Can miss nonlinear associations                                                       | Can miss non-monotonic associations                            |

A monotonic relationship means that as one variable increases, the other generally increases or generally decreases, but not necessarily at a constant rate.

Linear relationship

Both Pearson and Spearman can detect the positive association.

Nonlinear, monotonic relationship

Spearman may describe the association more appropriately.

## 5.1 Example: Pearson correlation

Suppose the following scores are obtained from 330 paired observations:

| Variable      | Mean | SD   |
| ------------- | ---- | ---- |
| CEBQ subscale | 3.10 | 0.70 |
| AEBQ subscale | 3.25 | 0.65 |

An illustrative Pearson correlation result:

| Statistic   | Result       |
| ----------- | ------------ |
| N           | 330          |
| Pearson's r | 0.58         |
| 95% CI      | [0.51, 0.65] |
| p-value     | <0.001       |

### Interpretation

A correlation of 0.58 indicates a moderately strong positive linear relationship.

Higher CEBQ scores tend to be associated with higher AEBQ scores.

The p-value provides evidence against the null hypothesis that the population correlation is zero, under the test assumptions.

The confidence interval suggests that the population correlation is plausibly between approximately 0.51 and 0.65.

Importantly, correlation does not imply causation. We cannot conclude that children's eating behaviour causes adults' eating behaviour or vice versa.

## 5.2 R implementation: Pearson and Spearman

The following example generates reproducible dummy data.

```

# Set a seed to reproduce the same random values
set.seed(123)

# Define the number of paired observations
n <- 330

# Generate hypothetical CEBQ scores
CEBQ <- rnorm(n, mean = 3.1, sd = 0.7)

# Generate AEBQ scores associated with CEBQ
AEBQ <- 1.2 + 0.65 * CEBQ +
        rnorm(n, mean = 0, sd = 0.6)

# Store the scores in a data frame
data <- data.frame(CEBQ, AEBQ)

# Inspect the first six observations
head(data)

# Create a scatterplot
plot(data$CEBQ, data$AEBQ,
     xlab = "CEBQ subscale",
     ylab = "AEBQ subscale",
     main = "CEBQ and AEBQ association")

# Add the fitted linear regression line
abline(lm(AEBQ ~ CEBQ, data = data),
       col = "blue", lwd = 2)

# Calculate Pearson correlation with CI and p-value
pearson_result <- cor.test(
  data$CEBQ,
  data$AEBQ,
  method = "pearson"
)

# Display Pearson results
pearson_result

# Calculate Spearman rank correlation
spearman_result <- cor.test(
  data$CEBQ,
  data$AEBQ,
  method = "spearman",
  exact = FALSE
)

# Display Spearman results
spearman_result

```

### Example Pearson output

```

Pearson's product-moment correlation

t = 12.87
df = 328
p-value < 2.2e-16

95 percent confidence interval:
 0.49  0.64

sample estimates:
 cor
 0.58

```

Illustrative output, rounded for teaching; it is not a verbatim result from running the code.

### How is the Pearson coefficient calculated?

\\[ r= \frac{\sum\_{i=1}^{n}(x_i-\bar{x})(y_i-\bar{y})} {\sqrt{\sum\_{i=1}^{n}(x_i-\bar{x})^2 \sum\_{i=1}^{n}(y_i-\bar{y})^2}} \\]

The numerator measures whether deviations from the mean of X tend to move together with deviations from the mean of Y.

The denominator standardises that relationship using the variability of both variables.

Consequently, the coefficient always falls between −1 and +1.

The conventional Pearson significance test uses:

\\[ t=r\sqrt{\frac{n-2}{1-r^2}} \\]

with \\(n-2\\) degrees of freedom, under the usual independent-observation, bivariate-normal null model.

## 5.3 What if Pearson and Spearman give different results?

Consider this hypothetical comparison:

| Test     | Coefficient | p-value |
| -------- | ----------- | ------- |
| Pearson  | 0.18        | 0.001   |
| Spearman | 0.34        | <0.001  |

Both are statistically significant, but their strengths differ.

This could arise because the relationship is monotonic but nonlinear, or because influential observations affect Pearson more strongly.

Another possible result:

| Test     | Coefficient | p-value |
| -------- | ----------- | ------- |
| Pearson  | 0.10        | 0.070   |
| Spearman | 0.16        | 0.004   |

Here, Spearman detects evidence of a monotonic relationship, while Pearson does not provide strong evidence of a linear relationship.

This does not mean that one test is automatically correct and the other is wrong.

What should the student do?

1. Inspect the scatterplot.
2. Check whether the relationship is linear or merely monotonic.
3. Identify influential outliers.
4. Determine whether the scores should be treated as quantitative or ordinal.
5. Select the method that best answers the intended research question.

For averaged multi-item questionnaire subscales with many possible values, Pearson correlation is commonly used, provided the relationship is reasonably linear and influential outliers are not problematic.

## 5.4 Should both methods be reported in a publication?

Not necessarily.

If Pearson was the planned primary analysis and its use is defensible, it can remain the primary analysis.

Spearman can be used as a sensitivity analysis to assess whether the conclusions are robust to using a rank-based method.

If results differ materially, explain the difference rather than hiding it or automatically switching methods.

For example, the student could write:

Pearson's correlation coefficients were calculated to examine the associations between corresponding CEBQ and AEBQ subscales. Scatterplots were inspected to assess linearity and identify potentially influential observations. Spearman's rank correlations were also calculated as sensitivity analyses. Where the results differed materially, these differences were examined in relation to the distribution of scores and the shape of the associations.

Use this wording only if those checks and analyses were actually conducted.

### SPSS implementation

Pearson and Spearman correlations:

1. Select Analyze → Correlate → Bivariate.
2. Move the relevant CEBQ and AEBQ variables into the Variables box.
3. Select Pearson and/or Spearman.
4. Select Two-tailed unless a one-tailed test was justified in advance.
5. Run the analysis.
6. Review the correlation coefficients, p-values and sample sizes.

SPSS produces a correlation matrix, so select the seven corresponding CEBQ–AEBQ pairs when interpreting the results. A full matrix also contains other pairwise correlations that may not be part of the research question.

# Part IV. Interpreting correlation strength

## 6. Are Evans' (1996) thresholds reliable?

The student proposes the following interpretation:

| Absolute correlation | Conventional description |
| -------------------- | ------------------------ |
| 0.00–0.19            | Very weak                |
| 0.20–0.39            | Weak                     |
| 0.40–0.59            | Moderate                 |
| 0.60–0.79            | Strong                   |
| 0.80–1.00            | Very strong              |

These are commonly cited descriptive guidelines, not universally validated thresholds for clinical or behavioural importance.

Note that the student's quoted upper boundary of 0.58 for the moderate category should be checked against the original source; the conventional Evans classification usually extends to 0.59.

### Why are the thresholds limited?

Consider two studies:

- Study A finds \\(r=0.38\\), described as weak.
- Study B finds \\(r=0.41\\), described as moderate.

There is very little substantive difference between these two correlations.

A categorical label should not make the results appear more different than they actually are.

Similarly, a correlation of 0.20 might be scientifically meaningful in one field and relatively unimportant in another.

Recommendation: Report the numerical coefficient, confidence interval, sample size and p-value. Use strength labels cautiously and consistently.

For seven planned corresponding subscale correlations, also consider multiple testing.

With seven tests at \\(\alpha=0.05\\), the probability of at least one false positive under seven independent true null hypotheses is:

\\[ 1-(1-0.05)^7\approx 0.302 \\]

That is approximately 30.2%.

The independence assumption is unlikely to hold exactly for related questionnaire subscales, but the calculation illustrates why multiplicity matters.

### R: Adjusting seven p-values

```

# Example p-values from seven correlations
p_values <- c(
  0.001, 0.008, 0.021, 0.038,
  0.046, 0.120, 0.310
)

# Bonferroni adjustment:
# Controls family-wise error rate
p.adjust(p_values, method = "bonferroni")

# Holm adjustment:
# Also controls family-wise error rate
# Usually less conservative than Bonferroni
p.adjust(p_values, method = "holm")

# Benjamini-Hochberg adjustment:
# Controls false discovery rate under suitable conditions
p.adjust(p_values, method = "BH")

```

Holm adjustment is a reasonable option when the seven correlations form one confirmatory family of hypotheses. For exploratory analysis, the Benjamini–Hochberg approach may be considered.

The appropriate strategy depends on the study's aims and analysis plan.

# Part V. Independent-samples t-tests: FHS versus non-FHS

## 7. What is the student trying to test?

The student has compared CEBQ subscale scores between two groups:

- FHS group: approximately 43 participants.
- Non-FHS group: approximately 280–300 participants.

The research question is:

Do participants in the FHS and non-FHS groups have different mean CEBQ subscale scores?

An independent-samples t-test is appropriate when comparing means from two independent groups, subject to relevant assumptions.

### 7.1 Student's proposed table

The student currently has these columns:

| Column                   | Keep?    | Recommendation                                                        |
| ------------------------ | -------- | --------------------------------------------------------------------- |
| CEBQ subscale            | Yes      | Identify the outcome                                                  |
| FHS (n)                  | Yes      | Report valid N per subscale                                           |
| FHS mean (SD)            | Yes      | Report descriptive statistics                                         |
| Non-FHS (n)              | Yes      | Report valid N                                                        |
| Non-FHS mean (SD)        | Yes      | Report descriptive statistics                                         |
| Levene's test p-value    | Optional | Usually unnecessary in the main results table                         |
| t-test p-value           | Yes      | Report the selected test's p-value                                    |
| Cohen's d                | Yes      | Report an effect size, preferably with a CI                           |
| Mean difference (95% CI) | Add      | Important for interpreting the magnitude and precision of differences |

I would recommend Welch's independent-samples t-test as a reasonable default because the groups are considerably unequal in size.

Welch's test does not assume equal population variances.

## 8. Student's concern: Levene's test and which t-test p-value to report

SPSS normally displays two rows for independent-samples t-tests:

1. Equal variances assumed.
2. Equal variances not assumed.

A common teaching rule is:

- Levene's p ≥ 0.05: use the first row.
- Levene's p < 0.05: use the second row.

However, this two-stage decision procedure is not necessary and can be problematic.

Levene's test may fail to detect meaningful variance differences, especially with a small group.

Better recommendation: Use Welch's t-test consistently rather than selecting the test according to Levene's p-value.

This is particularly sensible when group sizes are approximately 43 versus 287.

### 8.1 Example with dummy data

Suppose we observe:

| Statistic | FHS  | Non-FHS |
| --------- | ---- | ------- |
| N         | 43   | 287     |
| Mean      | 3.50 | 3.20    |
| SD        | 0.80 | 0.70    |

The observed mean difference is:

\\[ \bar X\_{\mathrm{FHS}}-\bar X\_{\mathrm{nonFHS}} =3.50-3.20=0.30 \\]

The standard error for Welch's test is:

\\[ SE= \sqrt{\frac{s_1^2}{n_1}+\frac{s_2^2}{n_2}} \\]

Substituting the values:

\\[ SE= \sqrt{\frac{0.80^2}{43}+\frac{0.70^2}{287}} \\]

\\[ SE\approx0.1289 \\]

The t-statistic is:

\\[ t=\frac{0.30}{0.1289}\approx2.33 \\]

Welch's degrees of freedom are approximately 52.1, giving a two-sided p-value around 0.024.

The 95% confidence interval for the mean difference is approximately:

\\[ [0.041,\ 0.559] \\]

### Interpretation

The FHS group scored, on average, 0.30 points higher than the non-FHS group.

The confidence interval suggests that the population mean difference could plausibly range from approximately 0.04 to 0.56 points.

The result provides evidence of a difference between the group means at the unadjusted 5% significance level.

However, whether a 0.30-point difference is clinically or practically important depends on the questionnaire, its scale and the research context.

These results are hypothetical, not the student's actual findings.

## 9. R implementation: Welch's t-test

```

# Set seed for reproducibility
set.seed(123)

# Generate dummy FHS group scores
FHS <- rnorm(
  n = 43,
  mean = 3.5,
  sd = 0.8
)

# Generate dummy non-FHS group scores
nonFHS <- rnorm(
  n = 287,
  mean = 3.2,
  sd = 0.7
)

# Combine the scores into one variable
score <- c(FHS, nonFHS)

# Create group labels
group <- factor(
  c(rep("FHS", 43), rep("Non-FHS", 287)),
  levels = c("FHS", "Non-FHS")
)

# Create the data frame
data <- data.frame(group, score)

# Calculate group sample sizes
table(data$group)

# Calculate group means
aggregate(score ~ group, data, mean)

# Calculate group standard deviations
aggregate(score ~ group, data, sd)

# Plot distributions for each group
boxplot(score ~ group,
        data = data,
        xlab = "Group",
        ylab = "CEBQ score",
        main = "CEBQ scores by FHS status")

# Run Welch's independent-samples t-test
# var.equal = FALSE means variances are not
# assumed to be equal
result <- t.test(
  score ~ group,
  data = data,
  var.equal = FALSE
)

# Display the complete result
result

```

### Illustrative output

```

Welch Two Sample t-test

t = 2.33
df = 52.1
p-value = 0.024

95 percent confidence interval:
 0.041  0.559

sample estimates:
 mean in group FHS      3.50
 mean in group Non-FHS  3.20

```

This is a worked example based on the summary statistics above. The seeded simulation in the R code will produce somewhat different results.

### How to interpret each line

| Output                | Interpretation                                                       |
| --------------------- | -------------------------------------------------------------------- |
| t = 2.33              | The estimated mean difference is 2.33 standard errors away from zero |
| df = 52.1             | Welch-adjusted degrees of freedom                                    |
| p = 0.024             | Evidence against equal population means under the test assumptions   |
| 95% CI [0.041, 0.559] | Plausible range for the population mean difference                   |
| Mean FHS = 3.50       | Average score in FHS group                                           |
| Mean non-FHS = 3.20   | Average score in comparison group                                    |

Notice that the degrees of freedom are not simply \\(n_1+n_2-2\\), because Welch's test uses an adjustment for unequal variances.

## 9.1 SPSS implementation

1. Select Analyze → Compare Means → Independent-Samples T Test.
2. Move the CEBQ subscale into Test Variable(s).
3. Move FHS status into Grouping Variable.
4. Select Define Groups and enter the two group codes.
5. Run the test.
6. In the output, use the Equal variances not assumed row for Welch's t-test.
7. Record the t-statistic, degrees of freedom, two-sided p-value, mean difference and 95% confidence interval.

The exact interface varies by SPSS version. Some versions also provide effect-size estimates directly.

### What if the groups have unequal variances?

Welch's test is designed for this situation.

However, it does not automatically solve every other problem. Check for influential outliers, strongly skewed distributions and whether the groups are genuinely independent.

If the FHS group contains only 43 participants and has severe skewness or extreme outliers, additional sensitivity analysis may be useful.

# Part VI. Cohen's d and practical significance

## 10. What is Cohen's d?

Cohen's d is a standardised measure of the difference between two group means.

For two independent groups, a common definition is:

\\[ d=\frac{\bar X_1-\bar X_2}{s_p} \\]

where the pooled standard deviation is:

\\[ s_p= \sqrt{ \frac{(n_1-1)s_1^2+(n_2-1)s_2^2} {n_1+n_2-2} } \\]

It expresses the mean difference in standard deviation units.

### Example

Using the previous hypothetical data:

\\[ n_1=43,\quad n_2=287 \\]

\\[ \bar X_1=3.50,\quad \bar X_2=3.20 \\]

\\[ s_1=0.80,\quad s_2=0.70 \\]

The pooled standard deviation is approximately:

\\[ s_p=0.7135 \\]

Therefore:

\\[ d=\frac{0.30}{0.7135}\approx0.42 \\]

The FHS mean is approximately 0.42 pooled standard deviations higher than the non-FHS mean.

## 10.1 Conventional Cohen's d guidelines

| Absolute d  | Conventional description |
| ----------- | ------------------------ |
| Around 0.20 | Small                    |
| Around 0.50 | Medium                   |
| Around 0.80 | Large                    |

These are rough conventions, not validated clinical thresholds.

A difference of 0.20 standard deviations is not automatically clinically meaningful, and a difference below 0.20 is not automatically imperceptible.

Clinical significance and statistical effect size are different concepts.

Clinical importance should be evaluated using subject-specific evidence, validated thresholds or a justified minimally important difference where available.

## 10.2 Cohen's d versus Hedges' g

Because the FHS group is relatively small, Hedges' g may be worth considering.

Hedges' g applies a small-sample bias correction to Cohen's d.

\\[ g=J(df)\times d \\]

An approximate correction is:

\\[ J(df)\approx1-\frac{3}{4df-1} \\]

For the usual pooled-SD estimator:

\\[ df=n_1+n_2-2 \\]

In this example, Cohen's d and Hedges' g will be very similar.

A further distinction is important: Welch's t-test and conventional pooled-SD Cohen's d do not make identical variance assumptions.

Welch's test can be used for inference about the mean difference while an effect-size definition is chosen and explained separately. If variances are substantially unequal, a standardisation based on a reference-group SD or another justified effect-size measure may be more meaningful.

The raw mean difference and its confidence interval should remain prominent.

## 10.3 R implementation: Effect size

```

# Install effectsize once if necessary
# install.packages("effectsize")

# Load the package
library(effectsize)

# Calculate Cohen's d using pooled SD
d_result <- cohens_d(
  score ~ group,
  data = data,
  pooled_sd = TRUE,
  ci = 0.95
)

# Display Cohen's d and its confidence interval
d_result

# Calculate Hedges' g
g_result <- hedges_g(
  score ~ group,
  data = data,
  pooled_sd = TRUE,
  ci = 0.95
)

# Display Hedges' g and its confidence interval
g_result

# Calculate the unstandardised mean difference
mean(FHS) - mean(nonFHS)

# Calculate group standard deviations
sd(FHS)
sd(nonFHS)

```

### Illustrative effect-size output

```

Cohen's d = 0.42
95% CI approximately [0.10, 0.74]

Hedges' g = 0.42
95% CI approximately [0.10, 0.74]

```

Approximate illustrative intervals; actual output depends on the data and interval-estimation method.

### Interpretation

The estimated standardised difference is small to moderate under conventional Cohen guidelines.

However, the confidence interval is fairly wide, reflecting uncertainty in the effect-size estimate.

It would be inappropriate to claim that the difference is clinically meaningful based solely on Cohen's d.

# Part VII. Non-significant p-values with non-zero effect sizes

## 11. What if p ≥ 0.05 but Cohen's d is 0.20 or greater?

This is one of the student's most important questions.

Suppose the analysis gives:

| Statistic                  | Hypothetical result |
| -------------------------- | ------------------- |
| FHS n                      | 43                  |
| Non-FHS n                  | 287                 |
| Mean difference            | 0.18                |
| Cohen's d                  | 0.25                |
| p-value                    | 0.130               |
| 95% CI for mean difference | [−0.06, 0.42]       |

The result is not statistically significant at the 5% level.

However, the estimated effect size is not zero.

### Does this mean the study was underpowered?

Possibly, but not necessarily.

A non-significant result accompanied by a small-to-moderate effect-size estimate does not prove that insufficient power caused the result.

Several explanations are possible:

- The true effect may be small or zero.
- Sampling variability may have produced the observed estimate.
- The study may have limited precision because the FHS group is small.
- The confidence interval may include both negligible and potentially meaningful differences.

The confidence interval is more informative than a binary significant/non-significant label.

In this example, the interval includes zero and positive differences up to 0.42.

Therefore, the data do not establish a difference, but they also do not exclude some potentially meaningful positive differences.

### 11.1 Why is the smaller group important?

For Welch's t-test:

\\[ SE=\sqrt{\frac{s_1^2}{n_1}+\frac{s_2^2}{n_2}} \\]

Even if the non-FHS group is very large, the FHS group's contribution to uncertainty remains substantial when \\(n_1=43\\).

Increasing the already-large group further may improve precision less than increasing the smaller group.

### 11.2 R: Explore sample size and statistical power

Use prospective power calculations to understand the design implications of plausible effect sizes.

```

# Calculate approximate power for a two-sample t-test
# using the actual unequal group sizes

power.t.test(
  n = NULL,
  delta = 0.30,
  sd = 0.75,
  sig.level = 0.05,
  power = 0.80,
  type = "two.sample",
  alternative = "two.sided"
)

# Note:
# This calculates equal group size requirements.
# It does not model the existing unequal allocation.

# Install pwr once if necessary
# install.packages("pwr")

# Load pwr
library(pwr)

# Approximate power for 43 vs 287 participants
# with an assumed standardised effect d = 0.30
pwr.t2n.test(
  n1 = 43,
  n2 = 287,
  d = 0.30,
  sig.level = 0.05,
  alternative = "two.sided"
)

# Calculate approximate power for a larger FHS group
pwr.t2n.test(
  n1 = 100,
  n2 = 287,
  d = 0.30,
  sig.level = 0.05,
  alternative = "two.sided"
)

```

These are planning calculations using a conventional t-test model. They are not exact Welch power calculations.

Avoid using post-hoc power calculated from the observed effect as the main explanation for a non-significant finding. It adds little beyond the observed p-value.

Instead, discuss sample size, effect estimates and confidence intervals.

## 11.3 What should the student write in the discussion?

Although the observed effect sizes suggested possible differences between the FHS and non-FHS groups, some comparisons did not reach statistical significance. The relatively small FHS group may have limited the precision of the estimates and the study's ability to detect smaller differences. These findings should therefore be interpreted cautiously, with consideration of the effect sizes and their confidence intervals. Future studies with larger and more balanced groups may help to provide more precise estimates.

This is preferable to stating that the study was definitely underpowered.

# Part VIII. How to present the results in a thesis or journal article

## 12. Recommended table format

I would simplify the student's proposed Table 3.

Table 3. Comparison of CEBQ subscale scores between FHS and non-FHS groups

| CEBQ subscale          | FHS n, Mean (SD) | Non-FHS n, Mean (SD) | Mean difference (95% CI) | p     | Cohen's d |
| ---------------------- | ---------------- | -------------------- | ------------------------ | ----- | --------- |
| Food responsiveness    | 43, 3.50 (0.80)  | 287, 3.20 (0.70)     | 0.30 (0.04, 0.56)        | 0.024 | 0.42      |
| Enjoyment of food      | 42, 3.80 (0.65)  | 284, 3.70 (0.60)     | 0.10 (−0.11, 0.31)       | 0.35  | 0.16      |
| Satiety responsiveness | 43, 2.80 (0.70)  | 286, 2.95 (0.75)     | −0.15 (−0.38, 0.08)      | 0.20  | −0.20     |

Illustrative values only. The first row is based on the earlier worked example; the remaining rows are hypothetical and not calculated from data.

Suggested table note:

Note. Values are presented as mean (standard deviation). Mean differences were calculated as FHS minus non-FHS. Between-group comparisons were performed using Welch's independent-samples t-test. Cohen's d represents the standardised mean difference calculated using the pooled standard deviation. All tests were two-sided. Confidence intervals are presented at the 95% level.

If the student is testing seven CEBQ subscales, clarify whether the p-values are unadjusted or adjusted for multiple comparisons.

Do not put the entire Cohen's d interpretation paragraph beneath the table. It is unnecessarily long and makes unsupported claims about clinical significance.

A short definition of Cohen's d in the table note, followed by a cautious interpretation in the main text, is more appropriate.

## 12.1 How to report a t-test in the results chapter

An independent-samples Welch's t-test was conducted to compare food responsiveness scores between participants in the FHS and non-FHS groups. The FHS group (n = 43, M = 3.50, SD = 0.80) had a higher mean score than the non-FHS group (n = 287, M = 3.20, SD = 0.70). The estimated mean difference was 0.30 points (95% CI [0.04, 0.56]), t(52.1) = 2.33, p = .024. The standardised mean difference was d = 0.42. The practical importance of this difference should be considered in relation to the scale and existing evidence.

All numerical results here are hypothetical.

# Part IX. Additional statistical issues worth discussing

## 13. Are the questionnaire subscale scores appropriate for parametric tests?

CEBQ and AEBQ subscales are commonly calculated from multiple questionnaire items.

Individual Likert-type items are ordinal, but averaged multi-item subscale scores are frequently treated as approximately continuous in applied health research.

Whether that treatment is reasonable depends on:

- Number of items and possible score values.
- Distribution of subscale scores.
- Floor and ceiling effects.
- Reliability and measurement properties.
- Research question and intended interpretation.

It is not necessary to abandon parametric methods simply because the original questionnaire items use Likert response categories.

However, averaged scores with many ties, severe ceiling effects or unusual distributions deserve additional scrutiny.

## 14. Are the CEBQ and AEBQ measurements independent?

This is particularly important.

If one adult and one child belong to each family, the paired adult–child observations are the units being correlated.

Pearson correlation can examine the association across these paired observations.

However, if multiple children belong to the same family, observations may be clustered and ordinary correlation p-values may be too optimistic.

Similarly, the independent-samples t-test assumes that observations in different groups are independent.

If several children from the same household are included, a mixed-effects model or another cluster-aware method may be required.

Ask the student: Does each family contribute exactly one child and one adult, or can families contribute multiple observations?

## 15. What about missing data?

The student reports N varying from 326 to 337.

This suggests different amounts of missing data across subscales.

Ask whether the analysis uses:

- Pairwise complete observations.
- Listwise deletion.
- Questionnaire-specific missing-item rules.
- Imputation.

For each correlation, report the number of complete paired observations.

For each t-test, report the valid number of participants in each group.

It may also be useful to describe the extent and patterns of missingness.

## 16. Should they conduct sensitivity analyses?

Yes, selectively, when there is a substantive reason.

For correlations, comparing Pearson and Spearman can help assess whether findings depend on numerical values versus ranks.

For mean comparisons, possible sensitivity analyses include:

- Welch's t-test as the primary analysis.
- Inspection of group distributions and influential observations.
- A robust or permutation-based approach when appropriate.
- A Mann–Whitney U test if the research question concerns rank-based differences rather than means.

Remember that Mann–Whitney U does not generally test equality of means. Its interpretation depends on the distributions and additional assumptions.

Do not recommend conducting every available test simply to find agreement.

# Part X. Complete R workflow for seven questionnaire subscales

This example assumes a CSV dataset containing corresponding CEBQ and AEBQ subscale variables, along with FHS group membership.

Suppose the file has these columns:

`FHS`, `CEBQ_1` through `CEBQ_7`, and `AEBQ_1` through `AEBQ_7`.

## 17. R script

```

# ==================================================
# 1. IMPORT DATA
# ==================================================

# Read the CSV file
data <- read.csv("questionnaire_data.csv")

# Inspect variable names
names(data)

# Inspect the structure
str(data)

# Convert FHS status to a factor
data$FHS <- factor(
  data$FHS,
  levels = c("FHS", "Non-FHS")
)

# ==================================================
# 2. DEFINE THE SEVEN CORRESPONDING SUBSCALES
# ==================================================

# Replace these placeholders with actual names
cebq_vars <- paste0("CEBQ_", 1:7)
aebq_vars <- paste0("AEBQ_", 1:7)

# ==================================================
# 3. DESCRIPTIVE STATISTICS
# ==================================================

# Install packages if needed
# install.packages(c("dplyr", "moments"))

library(dplyr)
library(moments)

# Examine each CEBQ subscale
for (variable in cebq_vars) {

  # Extract scores
  x <- data[[variable]]

  # Remove missing values
  x <- x[!is.na(x)]

  # Print variable name
  cat("\nVariable:", variable, "\n")

  # Print sample size
  cat("N:", length(x), "\n")

  # Print mean
  cat("Mean:", mean(x), "\n")

  # Print standard deviation
  cat("SD:", sd(x), "\n")

  # Print skewness
  cat("Skewness:", skewness(x), "\n")

  # Print excess kurtosis
  cat("Excess kurtosis:",
      kurtosis(x) - 3, "\n")

  # Plot histogram
  hist(x, main = variable, xlab = "Score")

  # Plot normal Q-Q plot
  qqnorm(x, main = paste("Q-Q:", variable))

  # Add reference line
  qqline(x)
}

# ==================================================
# 4. CORRELATIONS FOR SEVEN MATCHED SUBSCALES
# ==================================================

# Create an empty results data frame
cor_results <- data.frame()

# Loop over seven pairs
for (i in seq_along(cebq_vars)) {

  # Extract CEBQ scores
  x <- data[[cebq_vars[i]]]

  # Extract matching AEBQ scores
  y <- data[[aebq_vars[i]]]

  # Keep observations with both scores available
  valid <- complete.cases(x, y)

  # Run Pearson correlation
  pearson <- cor.test(
    x[valid],
    y[valid],
    method = "pearson"
  )

  # Run Spearman correlation
  spearman <- cor.test(
    x[valid],
    y[valid],
    method = "spearman",
    exact = FALSE
  )

  # Store results
  cor_results <- rbind(
    cor_results,
    data.frame(
      subscale = i,
      n = sum(valid),
      pearson_r = unname(pearson$estimate),
      pearson_p = pearson$p.value,
      pearson_CI_low = pearson$conf.int[1],
      pearson_CI_high = pearson$conf.int[2],
      spearman_rho = unname(spearman$estimate),
      spearman_p = spearman$p.value
    )
  )
}

# Adjust the seven primary Pearson p-values
cor_results$pearson_p_holm <- p.adjust(
  cor_results$pearson_p,
  method = "holm"
)

# Display correlation results
print(cor_results)

# ==================================================
# 5. WELCH T-TESTS FOR SEVEN CEBQ SUBSCALES
# ==================================================

# Create an empty results data frame
ttest_results <- data.frame()

# Loop through seven subscales
for (variable in cebq_vars) {

  # Extract the current score and group
  temp <- data.frame(
    score = data[[variable]],
    FHS = data$FHS
  )

  # Remove rows missing either value
  temp <- na.omit(temp)

  # Extract the two groups
  x <- temp$score[temp$FHS == "FHS"]
  y <- temp$score[temp$FHS == "Non-FHS"]

  # Run Welch's t-test
  test <- t.test(
    x,
    y,
    var.equal = FALSE
  )

  # Calculate pooled SD for conventional Cohen's d
  pooled_sd <- sqrt(
    ((length(x) - 1) * var(x) +
     (length(y) - 1) * var(y)) /
    (length(x) + length(y) - 2)
  )

  # Calculate Cohen's d
  d <- (mean(x) - mean(y)) / pooled_sd

  # Store results
  ttest_results <- rbind(
    ttest_results,
    data.frame(
      subscale = variable,
      n_FHS = length(x),
      mean_FHS = mean(x),
      sd_FHS = sd(x),
      n_nonFHS = length(y),
      mean_nonFHS = mean(y),
      sd_nonFHS = sd(y),
      mean_difference = mean(x) - mean(y),
      CI_low = test$conf.int[1],
      CI_high = test$conf.int[2],
      t = unname(test$statistic),
      df = unname(test$parameter),
      p = test$p.value,
      cohens_d = d
    )
  )
}

# Adjust p-values for seven comparisons
ttest_results$p_holm <- p.adjust(
  ttest_results$p,
  method = "holm"
)

# Display results
print(ttest_results)

# ==================================================
# 6. EXPORT RESULTS
# ==================================================

# Save correlation results to CSV
write.csv(
  cor_results,
  "correlation_results.csv",
  row.names = FALSE
)

# Save t-test results to CSV
write.csv(
  ttest_results,
  "ttest_results.csv",
  row.names = FALSE
)

```

This script assumes numeric scores, correctly matched subscales, independent observational units and valid group labels. It does not automatically assess scatterplot shape, outliers or questionnaire validity.

# Part XI. Suggested 14-minute tutoring preparation and session priorities

Because you only have 14 minutes to prepare, focus on the decisions the student actually needs to make.

Preparation checklist

0 of 5 completed

Reset

2 min

&#x20;— Understand the seven CEBQ–AEBQ paired correlations and FHS comparison.

3 min

&#x20;— Review normality, CLT and why Pearson needs more than a sample-size justification.

3 min

&#x20;— Review Pearson versus Spearman and how to handle differing results.

3 min

&#x20;— Review Welch's t-test, Cohen's d and confidence intervals.

3 min

&#x20;— Prepare recommendations for thesis tables and reporting.

During the actual appointment, prioritise reviewing the student's real SPSS output and plots over running hypothetical examples.

# Part XII. Student's questions and straightforward answers

This is the most useful section to keep open during the tutoring session.

| Student asks                                                                                          | What you should tell them                                                                                                                                                        |
| ----------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1. Is a bell-shaped histogram plus skewness/kurtosis between −1 and +1 enough to establish normality? | It is a reasonable initial assessment, but not definitive. Include Q–Q plots and outlier checks. Exact normality is not always necessary.                                        |
| 2. Is the CLT reliable for N > 30?                                                                    | The CLT is an asymptotic theorem, not a rule that all samples above 30 are normal. Its usefulness depends on the distribution and assumptions.                                   |
| 3. Can I use Pearson correlation with N = 326–337 even if one subscale is non-normal?                 | Potentially yes, especially with mild non-normality, but check linearity, influential outliers and independence. Large N alone is not sufficient justification.                  |
| 4. Should I also run Spearman correlation?                                                            | It can be a useful sensitivity analysis, particularly when there are concerns about outliers, ranks or nonlinear monotonic relationships.                                        |
| 5. What if Pearson and Spearman give different results?                                               | Investigate the scatterplot and differences between the methods. Do not automatically choose Pearson or whichever is significant.                                                |
| 6. Should I report both methods in my paper?                                                          | Report the primary method and any materially informative sensitivity analysis. Explain meaningful disagreements transparently.                                                   |
| 7. Are Evans' correlation thresholds reliable?                                                        | They are descriptive conventions, not universal standards. Prioritise the actual coefficient, 95% CI and subject-matter interpretation.                                          |
| 8. Should I adjust for seven correlation tests?                                                       | Consider multiplicity because seven tests increase false-positive risk. The method depends on whether the analyses are confirmatory or exploratory.                              |
| 9. Which t-test p-value should I report from SPSS?                                                    | Welch's equal-variances-not-assumed result is a sensible default for the unequal group sizes. Report its two-sided p-value.                                                      |
| 10. Should Levene's p-value appear in the table?                                                      | Usually not necessary if Welch's t-test is used consistently.                                                                                                                    |
| 11. Should Cohen's d be reported?                                                                     | Yes, if standardised mean differences are useful. Also report the raw mean difference and 95% CI.                                                                                |
| 12. Does Cohen's d show clinical significance?                                                        | No. It describes the standardised magnitude of a difference, not clinical importance.                                                                                            |
| 13. Should I explain all Cohen's d thresholds in a table footnote?                                    | No. A brief definition is enough. Interpret effect sizes in the main text when relevant.                                                                                         |
| 14. What if p ≥ 0.05 but d ≥ 0.20?                                                                    | The estimated difference may be non-zero but imprecise. A non-significant result does not establish that there is no difference. Examine the confidence interval.                |
| 15. Can I say the small FHS group caused low statistical power?                                       | You can say it may have limited precision and power, but the results alone do not establish that insufficient power caused non-significance.                                     |
| 16. Should I recommend larger FHS samples in future research?                                         | Yes, if justified by the research aims and feasibility. More balanced groups can improve precision.                                                                              |
| 17. What should my final t-test table contain?                                                        | Subscale, group N, mean (SD), mean difference (95% CI), p-value and effect size.                                                                                                 |
| 18. What is the most important improvement to my analysis?                                            | Make sure the method answers the research question, check the assumptions that actually matter, and interpret effect sizes and uncertainty rather than relying only on p-values. |

## Final advice to give the student

The student's overall approach is not necessarily incorrect. Pearson correlations and independent-samples t-tests may both be appropriate for this study.

The areas that most need improvement are the statistical justification and reporting, especially:

- Avoid using N > 30 or the CLT as a blanket justification for parametric tests.
- Examine scatterplots and influential observations before deciding between Pearson and Spearman.
- Use Welch's t-test consistently for the unequal groups if the data and design support it.
- Report confidence intervals alongside p-values and effect sizes.
- Avoid equating Cohen's d thresholds with clinical importance.
- Interpret non-significant findings cautiously, particularly given the smaller FHS group.
- Consider multiple comparisons across the seven subscales.

One final question worth asking during the appointment: Is the student primarily trying to demonstrate associations between corresponding adult and child eating-behaviour subscales, or to demonstrate agreement between the questionnaires?

If the objective is association, correlation may be suitable. If the objective is agreement or interchangeability, correlation alone is insufficient, and the analysis may need to be reconsidered.
