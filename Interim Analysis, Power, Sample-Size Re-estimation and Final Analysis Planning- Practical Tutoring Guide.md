# Using Pilot and Interim Data to Review Power, Sample Size and the Final Analysis Plan

## Introduction

Researchers often reach a point part-way through a study where some data have been collected, but recruitment or follow-up is not yet complete. At this stage, common questions include:

- Is the original sample size still appropriate?
- Is the study adequately powered?
- Can the data collected so far be used to revise the sample-size calculation?
- What should be examined during an interim analysis?
- Can the observed effect from the current data be used for a new power calculation?
- What statistical method should be used for the final analysis?

These questions are related, but they are not the same.

A useful way to approach the problem is:

```text
Understand the study design
        ↓
Identify the primary research question and outcome
        ↓
Reconstruct the original sample-size calculation
        ↓
Determine the purpose of the pilot/interim analysis
        ↓
Examine the accumulating data appropriately
        ↓
Review the assumptions behind the original calculation
        ↓
Consider sample-size re-estimation if appropriate
        ↓
Specify the final statistical analysis
        ↓
Complete the study
        ↓
Perform the final analysis
```

The central principle is that **sample size should be connected to the research question, primary outcome, effect of interest and planned statistical analysis**. It should not simply be increased or decreased according to whether an interim p-value is statistically significant.

---

# 1. External pilot study or internal pilot?

Before using preliminary data for power or sample-size planning, establish where the data came from.

## External pilot study

An **external pilot** is conducted separately from the main study.

For example:

```text
Pilot study
N = 30
     ↓
Estimate useful design parameters
     ↓
Design main study
     ↓
Recruit a new main-study sample
```

Pilot data may provide estimates of:

- standard deviation;
- event rate;
- within-person correlation;
- dropout;
- recruitment rate;
- feasibility of measurements.

These estimates can help plan the main study.

---

## Internal pilot

An **internal pilot** consists of participants who are already part of the main study.

For example:

```text
Planned study N = 60

First 30 participants
        ↓
Internal pilot/interim review
        ↓
Continue recruitment
        ↓
Final study sample
```

Under an appropriately designed procedure, the internal-pilot participants may remain part of the final analysis.

However, because the same participants contribute to both the interim assessment and final study, changes based on the interim data require more care.

---

# 2. What is an interim analysis?

An interim analysis is an examination of specified aspects of a study **before data collection is complete**.

The term can refer to several quite different activities.

## Descriptive or feasibility review

This may examine:

- recruitment;
- dropout;
- missing data;
- data quality;
- variability;
- event rates;
- feasibility of collecting planned variables.

## Sample-size re-estimation

The interim data may be used to examine whether assumptions underlying the original sample-size calculation remain reasonable.

For example:

> The original calculation assumed SD = 6. Does the accumulating data suggest that variability is substantially different?

## Formal interim hypothesis testing

The study may formally test a treatment or group difference before recruitment is complete.

For example:

> Is Treatment A already superior to Treatment B?

This is different from simply examining variability or missingness. Repeated formal testing of the primary hypothesis can affect the overall Type I error and usually requires an appropriate sequential design.

Therefore, before analysing interim data, establish:

> **What was the interim analysis intended to assess?**

---

# 3. Start with the original sample-size calculation

Before calculating a new sample size, reconstruct the original calculation.

Useful sources include:

- study protocol;
- statistical analysis plan;
- ethics application;
- grant application;
- previous statistical report;
- thesis/research proposal.

For a continuous two-group outcome, an original calculation might have been based on:

| Parameter | Assumption |
|---|---:|
| Clinically meaningful difference | 5 points |
| Standard deviation | 6 |
| Significance level | 0.05 |
| Desired power | 80% |
| Required complete sample | approximately 46 |
| Expected attrition | 20% |
| Recruitment target | approximately 58–60 |

The important question is then:

> **Are the assumptions that generated the original sample size still reasonable?**

---

# 4. What determines statistical power?

Statistical power is the probability of detecting an effect of a specified size when that effect exists, under the assumptions used in the calculation.

For a simple comparison, power depends on quantities such as:

```text
Effect to detect
       +
Variability
       +
Sample size
       +
Significance level
       ↓
Statistical power
```

Therefore, knowing only the number of participants is not enough to determine whether a study is adequately powered.

---

# 5. Two different power questions

It is important to distinguish two common questions.

## Question A: What power will a particular sample size provide?

Suppose:

\[
N=60
\]

is fixed.

The question becomes:

> What power does N = 60 provide for detecting a specified clinically meaningful effect?

Here, **power is the unknown quantity**.

---

## Question B: How many participants are required?

Suppose:

\[
Power=80\%
\]

is the target.

The question becomes:

> How many participants are required to detect the specified effect with 80% power?

Here, **sample size is the unknown quantity**.

These are different calculations.

---

# 6. Where should the effect size come from?

A sample-size calculation requires an effect worth detecting.

For a continuous outcome this may be expressed as:

\[
\Delta = \mu_1-\mu_2
\]

For example:

\[
\Delta=5
\]

points.

Ideally, the target difference should have a **clinical or scientific interpretation**.

Possible sources include:

- a recognised minimum clinically important difference (MCID);
- previous research;
- systematic reviews;
- clinical expertise;
- a scientifically meaningful threshold.

The target effect should not automatically be whatever difference happens to appear in a small pilot or interim sample.

---

# 7. Worked example: continuous outcome

Consider a hypothetical study comparing two treatments.

## Study design

- two independent treatment groups;
- continuous symptom score as the primary outcome;
- baseline and six-month measurements;
- planned total recruitment = 60;
- interim review after approximately 30 participants.

Suppose the original calculation assumed:

\[
\Delta=5
\]

\[
SD=6
\]

\[
\alpha=.05
\]

\[
Power=.80
\]

The standardised effect is:

\[
d=\frac{\Delta}{SD}
\]

Therefore:

\[
d=\frac{5}{6}=0.83
\]

---

# 8. Reconstructing the original calculation in R

```r
power.t.test(
    delta = 5,
    sd = 6,
    sig.level = 0.05,
    power = 0.80,
    type = "two.sample",
    alternative = "two.sided"
)
```

This gives approximately:

```text
n ≈ 23 participants per group
```

Therefore approximately:

\[
N=46
\]

complete participants are required.

If 20% attrition is expected:

\[
N_{\text{recruit}}
=
\frac{46}{1-0.20}
\]

\[
N_{\text{recruit}}
=
57.5
\]

Therefore a recruitment target of approximately **58–60 participants** is reasonable under these assumptions.

---

# 9. What should be examined at the interim stage?

Start descriptively rather than immediately testing the primary hypothesis.

Useful quantities include:

1. number recruited;
2. number completing relevant follow-up;
3. number with the primary outcome available;
4. missing data;
5. dropout;
6. descriptive statistics;
7. variability or event rates;
8. outcome distributions;
9. data-quality problems;
10. whether the observed data structure matches the planned analysis.

---

# 10. Example interim data

Suppose 30 participants have entered the study.

For the primary follow-up outcome:

| Group | Available N | Mean | SD |
|---|---:|---:|---:|
| Control | 14 | 47.8 | 8.7 |
| Treatment | 13 | 43.6 | 9.2 |

Three participants do not currently have a follow-up measurement.

Before treating these observations as missing or dropout, establish why.

For example:

```text
30 recruited
    │
    ├── 27 completed relevant follow-up
    ├── 2 have not yet reached follow-up
    └── 1 withdrew
```

Only the withdrawal represents confirmed attrition at this point.

Participants who have not yet reached their scheduled follow-up should not automatically be classified as dropouts.

---

# 11. Using interim data to examine variability

Suppose the original sample-size calculation assumed:

\[
SD=6
\]

but the accumulating data suggest variability closer to:

\[
SD\approx9
\]

This difference matters.

Originally:

\[
d=\frac{5}{6}=0.83
\]

Using SD = 9:

\[
d=\frac{5}{9}=0.56
\]

The clinically meaningful difference has not changed.

Instead, the outcome appears more variable.

More variability makes the same effect harder to detect.

---

# 12. Illustrative sample-size re-estimation

Keeping the target difference at 5 but using SD = 9:

```r
power.t.test(
    delta = 5,
    sd = 9,
    sig.level = 0.05,
    power = 0.80,
    type = "two.sample",
    alternative = "two.sided"
)
```

This gives approximately:

\[
n\approx52
\]

per group, or approximately:

\[
N\approx104
\]

complete participants.

Compare the calculations:

| Parameter | Original calculation | Updated illustration |
|---|---:|---:|
| Clinically meaningful difference | 5 | 5 |
| SD | 6 | 9 |
| Alpha | .05 | .05 |
| Desired power | 80% | 80% |
| Approximate N per group | 23 | 52 |
| Approximate complete N | 46 | 104 |

This illustrates an important principle:

> **A change in the estimated variability can substantially change the sample size required to detect the same clinically meaningful effect.**

---

# 13. Does an updated calculation automatically become the new recruitment target?

No.

An interim estimate based on a relatively small sample is itself uncertain.

For example, an SD of 9 observed in an early sample does not establish that the population SD is exactly 9.

Before changing the recruitment target, consider:

- whether sample-size re-estimation was planned;
- whether the interim estimate is sufficiently reliable;
- whether the procedure being used is appropriate for the study design;
- whether treatment allocation has been examined;
- whether changing the sample size requires protocol or ethics documentation;
- whether specialist statistical advice is appropriate.

The calculation can show the **implication of an assumption** without automatically determining the final sample size.

---

# 14. Calculating power for the existing planned sample

Instead of changing N, another useful question is:

> If the original sample size is retained, what power would it provide under the revised assumptions?

Suppose:

- 30 participants per group;
- total N = 60;
- target difference = 5;
- SD = 9;
- alpha = .05.

In R:

```r
power.t.test(
    n = 30,
    delta = 5,
    sd = 9,
    sig.level = 0.05,
    type = "two.sample",
    alternative = "two.sided"
)
```

This answers:

> **What power would N = 60 provide for detecting a five-point difference if the SD were 9?**

Compare this with:

```r
power.t.test(
    delta = 5,
    sd = 9,
    sig.level = 0.05,
    power = 0.80,
    type = "two.sample",
    alternative = "two.sided"
)
```

which answers:

> **How many participants would be required for 80% power?**

---

# 15. Why not simply use the observed interim treatment effect?

Suppose the accumulating data show:

\[
\bar X_{Control}=47.8
\]

and:

\[
\bar X_{Treatment}=43.6
\]

The observed difference is:

\[
47.8-43.6=4.2
\]

It may be tempting to replace the original target difference of 5 with 4.2 in the power calculation.

This should not be done automatically.

The estimated treatment effect from a small interim sample can be unstable.

As additional participants are recruited, the estimate may change considerably.

The more important question is:

> **What effect was the study intended to be able to detect?**

That effect should have scientific or clinical justification.

---

# 16. Why a non-significant interim result does not automatically mean the study is underpowered

Avoid the reasoning:

```text
Interim p > .05
       ↓
Study is underpowered
       ↓
Increase sample size
```

A non-significant result can occur because:

- the true effect is zero;
- the true effect is small;
- variability is high;
- the sample is small;
- the estimate is imprecise;
- or some combination of these factors.

Therefore:

> **A non-significant interim p-value does not by itself demonstrate insufficient power.**

---

# 17. Why observed/post-hoc power is usually not the answer

Suppose an interim analysis produces:

\[
p=.22
\]

It may seem useful to calculate the “observed power” based on the observed treatment effect.

However, observed power calculated from the same dataset is strongly related to the observed effect and p-value and generally adds little useful information.

It is usually more informative to examine:

- the effect estimate;
- confidence interval;
- clinically meaningful effect;
- original design assumptions;
- uncertainty around the estimate.

---

# 18. Binary outcomes

Not all studies have continuous outcomes.

Suppose the primary outcome is:

> postoperative complication: yes/no.

The sample-size calculation may depend on expected **event proportions** rather than an SD.

For example, the original design may have assumed:

\[
P_{Control}=0.40
\]

and:

\[
P_{Treatment}=0.15
\]

Suppose the interim data contain:

```text
30 participants with relevant follow-up

8 complications
22 without complications
```

The observed overall event rate is:

\[
\hat p=\frac{8}{30}=0.267
\]

or:

\[
26.7\%
\]

This information can help assess whether the original event-rate assumptions appear plausible.

However, an event rate estimated from only 30 participants is uncertain and should not automatically replace the original assumptions.

The power calculation must also correspond to the actual comparison being planned.

---

# 19. Dropout and attrition

Suppose a study requires 100 analysable participants.

If 10% attrition is expected:

\[
N_{\text{recruit}}
=
\frac{100}{1-.10}
=
111.1
\]

Therefore approximately 112 participants may need to be recruited.

If expected attrition is 20%:

\[
N_{\text{recruit}}
=
\frac{100}{1-.20}
=
125
\]

Thus, changes in expected attrition can alter the **recruitment target** even when the required number of analysable participants remains unchanged.

---

# 20. Missing data and dropout are not necessarily the same thing

Suppose:

```text
30 participants recruited

30 baseline measurements
27 follow-up measurements
25 biomarker measurements
```

This does not automatically mean five participants dropped out.

Missing observations may arise because:

- follow-up has not yet occurred;
- a participant withdrew;
- a participant was lost to follow-up;
- a measurement failed;
- a variable was not collected;
- there was a data-entry problem.

Understanding **why** data are missing is more informative than simply calculating a percentage.

---

# 21. Repeated measurements

Suppose each participant is measured at:

```text
Baseline
1 month
3 months
6 months
```

The observations within each participant are correlated.

For example:

| Patient | Time | Score |
|---|---|---:|
| 1 | Baseline | 55 |
| 1 | 1 month | 49 |
| 1 | 3 months | 43 |
| 1 | 6 months | 39 |
| 2 | Baseline | 48 |
| 2 | 1 month | 46 |
| 2 | 3 months | 42 |
| 2 | 6 months | 40 |

These measurements should not be treated as independent observations.

Depending on the research question and design, the final analysis may require:

- a repeated-measures approach;
- a mixed-effects model;
- another longitudinal model.

The sample-size calculation should ideally correspond to the planned primary analysis.

---

# 22. Planning the final statistical analysis

Power/sample-size planning and final-analysis planning are related but separate tasks.

A useful workflow is:

```text
PRIMARY RESEARCH QUESTION
          ↓
PRIMARY OUTCOME
          ↓
OUTCOME TYPE
          ↓
STUDY DESIGN
          ↓
INDEPENDENT OR REPEATED OBSERVATIONS?
          ↓
BASELINE MEASUREMENT?
          ↓
PRESPECIFIED COVARIATES?
          ↓
MISSING-DATA STRATEGY?
          ↓
APPROPRIATE STATISTICAL MODEL
```

The final statistical method should not be chosen according to which analysis produces the smallest p-value in the preliminary data.

---

# 23. Identify the primary outcome

The first question is:

> **What is the primary outcome?**

Common possibilities include:

### Continuous outcomes

Examples:

- blood pressure;
- symptom score;
- biomarker concentration;
- quality-of-life score.

### Binary outcomes

Examples:

- complication: yes/no;
- disease recurrence: yes/no;
- treatment response: yes/no.

### Count outcomes

Examples:

- number of hospital admissions;
- number of adverse events.

### Time-to-event outcomes

Examples:

- time until death;
- time until recurrence;
- time until discharge.

### Repeated outcomes

Examples:

- symptom score measured at several follow-up visits.

The outcome type is one of the major determinants of the statistical model.

---

# 24. Identify the primary comparison

Examples include:

```text
Treatment A versus Treatment B
```

```text
Before versus after treatment
```

```text
Difference in change over time between two groups
```

```text
Association between an exposure and an outcome
```

These represent different statistical questions and may require different analyses.

---

# 25. General analysis guide

| Study/outcome | Possible analysis |
|---|---|
| Continuous outcome, two independent groups | Independent t-test / linear regression |
| Continuous follow-up with baseline adjustment | Linear regression / ANCOVA framework |
| Continuous paired before/after data | Paired t-test or corresponding model |
| Continuous outcome, more than two independent groups | ANOVA / linear regression |
| Binary outcome | Chi-square/Fisher's exact test / logistic regression |
| Binary outcome with predictors | Logistic regression |
| Count outcome | Poisson/negative-binomial model where appropriate |
| Repeated measurements | Mixed-effects/longitudinal model |
| Time-to-event outcome | Kaplan-Meier methods / Cox regression |
| Continuous outcome with several predictors | Multiple linear regression |

This table is a starting point rather than an automatic decision rule.

---

# 26. Example: baseline-adjusted continuous outcome

Suppose a study compares two treatments and measures symptom severity at baseline and six months.

A possible model is:

\[
Y_{followup}
=
\beta_0
+
\beta_1Treatment
+
\beta_2Y_{baseline}
+
\epsilon
\]

In R:

```r
model <- lm(
    followup ~ treatment + baseline,
    data = final_data
)

summary(model)
```

Here, the treatment coefficient represents the estimated treatment-group difference in the follow-up outcome after accounting for baseline outcome, conditional on the model.

---

# 27. Why adjust for baseline?

Suppose participants enter the study with different baseline symptom scores.

A simple model:

\[
Followup\sim Treatment
\]

does not use information about baseline symptom severity.

A baseline-adjusted model:

\[
Followup\sim Treatment+Baseline
\]

accounts for this baseline information.

Whether baseline adjustment should form the primary analysis should ideally be decided before examining the final treatment results.

---

# 28. Example: binary outcome

Suppose:

```text
Complication

0 = No
1 = Yes
```

For a simple two-group comparison, possibilities include:

- chi-square test;
- Fisher's exact test where appropriate.

For an adjusted analysis:

```r
model <- glm(
    complication ~ treatment + age + baseline_severity,
    family = binomial,
    data = final_data
)

summary(model)
```

This is a logistic regression model.

---

# 29. What can preliminary data tell us about the final analysis?

Pilot or interim data can reveal whether the planned analysis is feasible.

Useful questions include:

- Are all required variables actually being collected?
- Is there substantial missing data?
- Are some outcome categories extremely rare?
- Are there enough events to support the intended model?
- Are there obvious data errors?
- Are there extreme outliers?
- Are there strong floor or ceiling effects?
- Is the outcome distribution very different from what was anticipated?
- Are repeated measurements structured as expected?

For example, suppose the proposed final model is:

```text
Complication ~ Treatment + Age + Sex +
               BMI + Smoking + Disease Severity
```

but the preliminary data contain only three complications.

This raises concerns about whether a model containing many parameters will be supportable by the eventual number of events.

The preliminary data therefore provide useful **design information** without needing to search for significant effects.

---

# 30. Descriptive exploration in SPSS

For a continuous outcome:

**Analyze → Descriptive Statistics → Explore**

Use:

- primary outcome → **Dependent List**
- group → **Factor List**, where relevant.

Useful plots include:

- histogram;
- boxplot;
- QQ plot.

Review:

- N;
- mean;
- standard deviation;
- range;
- unusual observations;
- missing observations.

---

# 31. Missing data in SPSS

Useful starting points include:

**Analyze → Descriptive Statistics → Frequencies**

or other suitable descriptive procedures.

Determine:

- how many observations are available;
- which variables have missing data;
- whether missingness is concentrated in particular measurements;
- why data are missing where this information is available.

---

# 32. Descriptive exploration in R

Sample size by group:

```r
table(data$group)
```

Missing observations:

```r
colSums(is.na(data))
```

Percentage missing:

```r
colMeans(is.na(data)) * 100
```

Group descriptive statistics:

```r
library(dplyr)

data %>%
    group_by(group) %>%
    summarise(
        n = sum(!is.na(followup)),
        mean = mean(followup, na.rm = TRUE),
        sd = sd(followup, na.rm = TRUE)
    )
```

Visual exploration:

```r
hist(data$followup)

qqnorm(data$followup)
qqline(data$followup)

boxplot(followup ~ group, data = data)
```

---

# 33. What about normality?

Avoid using a normality test mechanically as:

```text
Shapiro-Wilk p > .05
→ normal

Shapiro-Wilk p < .05
→ not normal
```

With small samples, normality tests may have limited ability to detect departures from normality.

Instead, consider:

- QQ plots;
- histograms;
- boxplots;
- extreme observations;
- scientific understanding of the measurement;
- model residual diagnostics where appropriate.

For many models, the relevant assumptions concern the **model residuals/errors**, rather than requiring the raw outcome itself to be perfectly normally distributed.

---

# 34. Formal interim hypothesis testing

Suppose a study plans:

```text
Interim:
test the primary hypothesis

Later:
test the same primary hypothesis again
```

Each test creates an opportunity to reject the null hypothesis.

Repeated testing using the usual significance threshold can inflate the overall Type I error.

Formal sequential designs may use approaches such as:

- O'Brien-Fleming boundaries;
- Pocock boundaries;
- alpha-spending methods.

If formal interim efficacy or futility testing was planned, the prespecified procedure should be followed.

An ordinary p-value calculated halfway through the study should not automatically be treated as if it were the final analysis.

---

# 35. Can internal-pilot participants remain in the final analysis?

Potentially, yes.

Conceptually:

```text
Initial participants
        ↓
Internal pilot
        ↓
Review prespecified design assumptions
        ↓
Continue recruitment
        ↓
Additional participants
        ↓
Final dataset
        ↓
Initial + later participants
        ↓
Final analysis
```

Whether this is statistically appropriate depends on how the internal-pilot and sample-size re-estimation procedures were designed.

---

# 36. Common mistakes

## Mistake 1: increasing N because the interim result is not significant

Avoid:

```text
p > .05
   ↓
Need more participants
```

Sample-size decisions should not simply be driven by whether the accumulating treatment comparison has crossed .05.

---

## Mistake 2: calculating observed power after a non-significant result

Observed power generally adds little information beyond the observed effect and p-value.

Focus instead on the effect estimate, confidence interval and original design assumptions.

---

## Mistake 3: using the observed interim effect automatically

A treatment difference observed in a small preliminary sample can be unstable.

The target effect should have scientific or clinical justification.

---

## Mistake 4: changing the primary outcome

Avoid changing the primary outcome simply because another outcome appears more favourable in the preliminary data.

---

## Mistake 5: choosing whichever statistical model gives significance

For example:

```text
Model A: p = .08
Model B: p = .04

Therefore choose Model B
```

This is not a sound basis for selecting the primary analysis.

---

## Mistake 6: selecting covariates only according to p-values

Avoid:

```text
Age significant → include
Sex not significant → remove
BMI significant → include
```

Covariate selection should primarily reflect the study design, scientific rationale and prespecified analysis plan.

---

# 37. A practical review table

When reviewing an ongoing study, it can be useful to construct the following table:

| Parameter | Original assumption | Preliminary/interim information | Question |
|---|---:|---:|---|
| Primary outcome | ? | ? | Is it clearly defined? |
| Clinically meaningful effect | ? | Do not automatically replace | Is the original target still scientifically meaningful? |
| SD/event rate | ? | ? | Is the original assumption plausible? |
| Alpha | ? | Usually unchanged | What was prespecified? |
| Desired power | ? | Usually unchanged | 80%, 90%, etc.? |
| Expected dropout | ? | ? | Is attrition higher/lower than expected? |
| Required complete N | ? | ? | Is formal re-estimation appropriate? |
| Recruitment target | ? | ? | Does attrition change recruitment needs? |
| Primary analysis | ? | ? | Does it match the research question and data structure? |

This separates **assumptions** from **observations** and helps prevent the interim analysis from becoming a search for significant results.

---

# 38. Practical workflow

## Step 1: Define the study

Identify:

```text
Primary research question
Primary outcome
Study design
Primary comparison
```

## Step 2: Recover the original power calculation

Identify:

```text
Target effect
SD / event rate / other nuisance parameter
Alpha
Desired power
Expected dropout
Required complete N
Recruitment target
```

## Step 3: Determine the purpose of the preliminary analysis

Was it intended to assess:

```text
Variability?
Event rate?
Dropout?
Recruitment?
Sample-size requirements?
Data quality?
Formal efficacy/futility?
```

## Step 4: Examine the preliminary data appropriately

Check:

```text
Available N
Follow-up completion
Missingness
Dropout
SD/event rate
Data distribution
Data quality
Data structure
```

## Step 5: Compare observations with assumptions

For example:

```text
Original SD = 6

Preliminary SD ≈ 9
```

or:

```text
Expected attrition = 10%

Observed eligible attrition ≈ 20%
```

## Step 6: Consider sample-size re-estimation

If appropriate to the design, examine how changes in relevant nuisance parameters affect the required sample size.

Do not automatically replace the clinically meaningful effect with the observed preliminary treatment difference.

## Step 7: Confirm the final analysis plan

Determine:

```text
Outcome type
Primary comparison
Independent / paired / repeated observations
Baseline adjustment
Prespecified covariates
Missing-data strategy
Primary statistical model
```

## Step 8: Document the plan

Where possible, specify the primary analysis before the final outcome data are analysed.

---

# 39. Frequently asked questions

## “I have collected half of my planned sample. Am I adequately powered?”

Not enough information is available from the recruitment fraction alone.

The original target effect, variability/event rate, alpha, desired power and analysis design are needed.

---

## “Can preliminary data be used to recalculate the required sample size?”

Potentially.

Pilot or interim data may provide information about nuisance parameters such as variability, event rate or attrition. Whether formal sample-size re-estimation is appropriate depends on the study design and how the preliminary data were obtained.

---

## “The interim result is not statistically significant. Does that mean more participants are needed?”

No.

A non-significant result alone does not establish that the study is underpowered.

---

## “Should the observed interim effect be used in the new power calculation?”

Not automatically.

The observed effect may be unstable. The target effect should ideally represent a scientifically or clinically meaningful effect.

---

## “What if the observed SD is much larger than originally expected?”

Greater variability generally reduces the ability to detect the same effect. This may increase the required sample size.

Whether the recruitment target should actually change depends on the study design and the planned sample-size reassessment procedure.

---

## “What if dropout is higher than expected?”

A higher dropout rate may increase the number of participants that need to be recruited to achieve the required number of analysable participants.

---

## “Should observed/post-hoc power be calculated?”

Usually it provides little additional information when calculated from the observed effect in the same dataset.

Effect estimates, confidence intervals and the original design assumptions are generally more useful.

---

## “How should the final statistical analysis be selected?”

Start with:

1. the primary research question;
2. primary outcome;
3. study design;
4. independence or repeated observations;
5. baseline measurements;
6. prespecified covariates;
7. missing-data considerations.

Then select a model appropriate to that structure.

Do not select the final model according to which analysis produces the most favourable p-value.

---

# 40. Key takeaways

### 1. Power cannot be determined from sample size alone.

Knowing that a study has collected 30 of 60 participants does not tell us whether it is adequately powered.

### 2. Recover the original sample-size assumptions first.

Understand why the original target sample was chosen before performing a new calculation.

### 3. Preliminary data can inform useful nuisance parameters.

Depending on the design, these may include:

- SD;
- event rate;
- correlation;
- dropout;
- missingness.

### 4. Do not automatically use the observed preliminary treatment effect.

The target effect should have clinical or scientific justification.

### 5. A non-significant interim result does not automatically imply insufficient power.

Do not simply recruit more participants because \(p>.05\).

### 6. Sample-size re-estimation and interim hypothesis testing are different.

Reassessing variability is not the same as formally testing the treatment effect halfway through the study.

### 7. The final analysis should follow the research question and study design.

It should not be selected according to which model produces the smallest p-value.

### 8. Power planning and final-analysis planning should agree.

The power calculation should ideally correspond to the study's primary outcome, comparison and planned statistical model.

---

# Final conceptual framework

The entire process can be summarised as:

```text
WHAT IS THE RESEARCH QUESTION?
              ↓
WHAT IS THE PRIMARY OUTCOME?
              ↓
WHAT IS THE STUDY DESIGN?
              ↓
WHY WAS THE ORIGINAL SAMPLE SIZE CHOSEN?
              ↓
WHAT WAS THE PILOT/INTERIM REVIEW INTENDED TO DO?
              ↓
WHAT DO THE PRELIMINARY DATA SAY ABOUT
VARIABILITY / EVENT RATE / ATTRITION / FEASIBILITY?
              ↓
ARE THE ORIGINAL POWER ASSUMPTIONS STILL REASONABLE?
              ↓
IS SAMPLE-SIZE RE-ESTIMATION APPROPRIATE?
              ↓
WHAT STATISTICAL MODEL MATCHES THE
PRIMARY QUESTION AND DATA STRUCTURE?
              ↓
PRESPECIFY / DOCUMENT THE FINAL ANALYSIS
              ↓
COMPLETE THE STUDY
              ↓
FINAL ANALYSIS
```

The key question is not simply:

> **“What happened in the data collected so far?”**

It is:

> **“What was the study designed to detect, what assumptions produced the original sample size, are those assumptions still reasonable, and what analysis best addresses the primary research question?”**

That distinction provides the foundation for sensible use of pilot and interim data in power, sample-size and final-analysis planning.
