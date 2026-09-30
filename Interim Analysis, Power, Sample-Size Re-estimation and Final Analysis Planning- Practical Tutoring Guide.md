# Interim Analysis, Power, Sample-Size Re-estimation and Final Analysis Planning

## Quick summary: what is the statistical problem?

A common situation in clinical research is:

- a study was designed with help from a statistician;
- a target sample size was established, for example **60 patients**;
- an interim review was planned after some patients had been recruited;
- data are now available for the first **30 of the planned 60 patients**;
- the researcher wants to know:
  1. whether the original sample size is still appropriate;
  2. whether the study is adequately powered;
  3. how the interim data should be used;
  4. what the final statistical analysis should be.

These are related questions, but they should be handled separately.

The overall process is:

```text
UNDERSTAND ORIGINAL STUDY
        ↓
Identify primary research question and outcome
        ↓
Reconstruct original sample-size calculation
        ↓
Understand purpose of planned interim analysis
        ↓
Examine the first 30 patients appropriately
        ↓
Assess assumptions behind original calculation
        ↓
Consider sample-size re-estimation if appropriate
        ↓
Confirm final statistical analysis plan
        ↓
Continue recruitment
        ↓
Perform final analysis when study is complete
```

---

# 1. How to start the tutoring session

Start with:

> “From your appointment notes, I think there are two main things we need to work out. First, how the data you already have can inform the power and required sample size for the completed study. Second, what the final statistical analysis should look like.”

Then immediately clarify:

> **“Are these 30 patients a separate pilot sample, or are they the first 30 patients of the planned total of 60?”**

This distinction is extremely important.

---

# 2. Two possible situations

## Situation A: The 30 patients are a separate pilot study

The pilot participants are separate from the eventual main study.

In this situation, the pilot can potentially provide estimates such as:

- standard deviation;
- event rate;
- within-person correlation;
- dropout;
- feasibility information.

These quantities can then help design and power the main study.

---

## Situation B: The 30 patients are the first 30 of the planned 60

This is probably better described as an **internal pilot/interim review**.

The first 30 patients will eventually form part of the final dataset.

This requires more care because the same data are being used during the study and will later contribute to the final analysis.

If this is the situation, ask:

> **“Was an interim analysis or sample-size reassessment after approximately 30 patients specified in the original protocol?”**

And:

> **“What exactly did the original statistician intend the interim analysis to assess?”**

---

# 3. What is an interim analysis?

An interim analysis is an examination of specified aspects of a study **before data collection is complete**.

For example:

```text
Planned N = 60

Recruit first 30
       ↓
Interim review
       ↓
Continue recruitment
       ↓
Final N
       ↓
Final analysis
```

However, “interim analysis” can mean different things.

It might mean:

### A. Reviewing study assumptions

For example:

- variability;
- event rate;
- dropout;
- missing data;
- recruitment;
- data quality.

### B. Sample-size re-estimation

For example:

> “We originally assumed SD = 6. Does the accumulating data suggest this assumption remains reasonable?”

### C. Formal interim hypothesis testing

For example:

> “Is Treatment A already significantly better than Treatment B after 30 patients?”

This is statistically different.

Formal interim hypothesis testing can affect Type I error because the primary hypothesis is being tested multiple times.

Therefore, always establish:

> **“What was the interim analysis originally intended to do?”**

---

# 4. The first thing to find: the original sample-size calculation

Before doing a new power calculation, ask:

> **“Can you show me the original protocol or sample-size calculation?”**

Possible sources include:

- study protocol;
- ethics application;
- statistical analysis plan;
- previous statistician's report;
- grant application;
- thesis protocol.

You are looking for something like:

> “A sample of 60 participants will provide 80% power to detect a clinically meaningful difference of 5 points, assuming an SD of 6, a two-sided significance level of 0.05, and allowing for attrition.”

Extract the assumptions.

For example:

| Parameter                        | Original assumption |
| -------------------------------- | ------------------: |
| Primary outcome                  |       Symptom score |
| Clinically meaningful difference |            5 points |
| SD                               |                   6 |
| Alpha                            |                0.05 |
| Desired power                    |                 80% |
| Required complete sample         | approximately 46–48 |
| Expected attrition               |   approximately 20% |
| Recruitment target               |                  60 |

The central question then becomes:

> **Are the assumptions that produced N = 60 still reasonable?**

---

# 5. Understanding power

Power is the probability that a statistical test will detect an effect of a specified size when that effect exists, under the assumptions of the calculation.

Conceptually:

[\
\boxed{\
Effect + Variability + Alpha + Sample\ Size\
\rightarrow Power\
}\
]

For study planning, we usually reverse this:

[\
\boxed{\
Effect + Variability + Alpha + Desired\ Power\
\rightarrow Required\ Sample\ Size\
}\
]

Therefore:

> **Knowing that there are currently 30 patients is not sufficient to determine whether the study is adequately powered.**

We need the other quantities.

---

# 6. “What is my power?” versus “How many patients do I need?”

These are two different questions.

## Question 1

> “If I eventually have 60 patients, what power will I have to detect a specified effect?”

Here:

- sample size is known;
- power is calculated.

## Question 2

> “How many patients do I need to achieve 80% power?”

Here:

- desired power is known;
- sample size is calculated.

This distinction is useful when working with power software.

---

# 7. Worked example

Consider a hypothetical clinical study.

## Research question

Does Treatment B reduce symptom severity compared with Treatment A?

## Design

- two independent groups;
- continuous primary outcome;
- baseline and follow-up measurements;
- planned N = 60;
- currently N = 30;
- 15 participants per group.

Suppose the original calculation assumed:

[\
\text{Clinically meaningful difference}=5\
]

[\
SD=6\
]

[\
\alpha=.05\
]

[\
Power=80%\
]

---

# 8. Reconstruct the original sample-size calculation

For two independent groups:

[\
d=\frac{\Delta}{SD}\
]

Therefore:

[\
d=\frac{5}{6}=0.83\
]

In R:

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
n ≈ 23 per group
```

Therefore:

[\
N\approx46\
]

complete participants.

If approximately 20% dropout is anticipated:

\frac{46}{1-.20}\
]

[\
\=57.5\
]

So recruiting approximately **58–60 patients** would make sense.

This explains where the original N=60 may have come from.

---

# 9. Now examine the first 30 patients

Do **not** immediately perform the final hypothesis test.

Start descriptively.

Check:

1. number recruited;
2. number with primary outcome available;
3. missing data;
4. dropout;
5. descriptive statistics;
6. variability or event rate;
7. distribution of the outcome;
8. data quality;
9. whether the actual data structure matches the planned analysis.

---

# 10. Example interim dataset

Suppose the data look like:

| ID  | Group     | Baseline | Follow-up |
| --- | --------- | -------: | --------: |
| 1   | Control   |       51 |        48 |
| 2   | Control   |       48 |        46 |
| 3   | Control   |       55 |        52 |
| ... | ...       |      ... |       ... |
| 16  | Treatment |       52 |        43 |
| 17  | Treatment |       49 |        42 |
| 18  | Treatment |       56 |        48 |
| ... | ...       |      ... |       ... |

There are 30 recruited patients.

But perhaps only 27 currently have follow-up data.

---

# 11. Check missingness carefully

Suppose:

```text
30 recruited

27 have follow-up data
2 have not reached the follow-up date
1 withdrew
```

Do **not** automatically say:

[\
3/30=10%\ dropout\
]

because two patients have not yet had the opportunity to complete follow-up.

Distinguish:

- genuine withdrawal;
- loss to follow-up;
- follow-up not yet due;
- measurement failure;
- data-entry error.

This distinction matters for estimating future attrition.

---

# 12. Check variability

Suppose the primary outcome is continuous.

The original calculation assumed:

[\
SD=6\
]

Now calculate descriptive statistics for the first 30 patients.

Hypothetical results:

| Group     |  N | Mean |  SD |
| --------- | -: | ---: | --: |
| Control   | 14 | 47.8 | 8.7 |
| Treatment | 13 | 43.6 | 9.2 |

The observed variability is approximately:

[\
SD\approx9\
]

rather than 6.

This is potentially important.

---

# 13. Why does the SD matter?

Originally:

[\
\Delta=5\
]

and:

[\
SD=6\
]

giving:

[\
d=\frac{5}{6}=0.83\
]

Suppose the accumulating data suggest:

[\
SD\approx9\
]

Then:

[\
d=\frac{5}{9}=0.56\
]

The clinically meaningful difference has **not changed**.

The amount of noise has increased.

Therefore, detecting the same 5-point difference becomes more difficult.

---

# 14. Sample-size re-estimation example

If the study design allows an appropriate sample-size reassessment, repeat the calculation using the updated estimate of variability while keeping the clinically meaningful difference unchanged.

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

[\
n\approx52\
]

per group.

Therefore:

[\
N\approx104\
]

complete participants.

Compare:

|                                  | Original | Interim-informed illustration |
| -------------------------------- | -------: | ----------------------------: |
| Clinically meaningful difference |        5 |                             5 |
| SD                               |        6 |                             9 |
| Alpha                            |      .05 |                           .05 |
| Desired power                    |      80% |                           80% |
| Approximate N per group          |       23 |                            52 |
| Approximate total complete N     |       46 |                           104 |

This illustrates why the interim information may matter.

---

# 15. Does this mean the target should automatically change from 60 to 104?

**No.**

This calculation demonstrates the implications of a different SD.

It does not automatically establish a new recruitment target.

Reasons include:

1. the SD estimated from only 30 participants is itself uncertain;
2. the appropriate re-estimation method depends on the study design;
3. sample-size re-estimation may have been prespecified in a particular way;
4. changes to a clinical study protocol may require discussion/documentation;
5. if treatment-group information has already been examined, additional statistical issues may arise.

For an ongoing clinical study, a substantial change to the primary sample size should be discussed with the supervisor/research team and, where appropriate, a medical statistician.

---

# 16. Could we instead ask what power N=60 provides?

Yes.

Suppose:

- final N = 60;
- 30 per group;
- clinically meaningful difference = 5;
- SD = 9;
- alpha = .05.

Run:

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

This asks:

> **“If I retain the planned sample size of 60, what power would I have to detect a five-point difference under these assumptions?”**

This is different from asking:

> **“How many participants do I need for 80% power?”**

---

# 17. Do NOT automatically use the observed interim treatment difference

Suppose the first 30 participants show:

[\
Mean\_{Control}=47.8\
]

[\
Mean\_{Treatment}=43.6\
]

Therefore:

[\
Observed\ difference=4.2\
]

It may be tempting to say:

> “Let's use 4.2 as the effect size for the new power calculation.”

Be cautious.

The treatment effect estimated from only 30 participants may be unstable.

With additional participants it could become:

[\
2.8,\quad3.9,\quad5.2,\quad6.1,\ldots\
]

The effect used for study planning should generally reflect the **clinically/scientifically meaningful difference**, supported where possible by previous evidence, rather than simply whatever difference happened to occur in the interim sample.

---

# 18. Do NOT use non-significance as evidence that more participants are required

Avoid:

```text
Interim p > .05
       ↓
Study is underpowered
       ↓
Need more participants
```

This reasoning is incorrect.

A non-significant result could arise because:

- the true effect is small;
- the true effect is zero;
- the data are highly variable;
- the sample is small;
- or some combination of these.

A non-significant p-value does not itself diagnose insufficient power.

---

# 19. Be cautious with observed/post-hoc power

Suppose the first 30 participants produce:

[\
p=.22\
]

Calculating observed power from the same observed effect generally adds little useful information.

Observed power is strongly related to the observed effect and p-value.

Instead, focus on:

- the effect the study was designed to detect;
- the observed effect estimate;
- confidence interval;
- assumptions behind the original sample-size calculation.

---

# 20. What if the primary outcome is binary?

Suppose the primary outcome is:

> postoperative complication: yes/no.

Then the relevant quantity may be an **event rate**, rather than SD.

Perhaps the original calculation assumed:

[\
P\_{Control}=0.40\
]

and:

[\
P\_{Treatment}=0.15\
]

or an overall event rate relevant to the calculation.

At interim, suppose:

```text
30 relevant patients
8 complications
22 no complications
```

Then:

[\
\hat p=\frac{8}{30}=26.7%\
]

This can be compared with the assumptions used in the original sample-size calculation.

Again, do not automatically replace the original assumption with 26.7%. The estimate from 30 patients is uncertain.

The appropriate power calculation must match the actual design.

---

# 21. What if there are repeated measurements?

Suppose each patient is measured at:

```text
Baseline
1 month
3 months
6 months
```

Then the observations within each patient are correlated.

The data might look like:

| Patient | Time     | Score |
| ------- | -------- | ----: |
| 1       | Baseline |    55 |
| 1       | 1 month  |    49 |
| 1       | 3 months |    43 |
| 1       | 6 months |    39 |
| 2       | Baseline |    48 |
| 2       | 1 month  |    46 |
| 2       | 3 months |    42 |
| 2       | 6 months |    40 |

A simple independent t-test across all measurements would not be appropriate.

The final analysis might require:

- repeated-measures methods;
- mixed-effects models;
- another longitudinal model.

The power calculation should ideally correspond to the planned primary analysis.

---

# 22. Part 2: determining the final analysis plan

Treat this separately from the power calculation.

The workflow is:

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
MISSING DATA?
          ↓
APPROPRIATE STATISTICAL MODEL
```

Do not choose the final statistical method based on which analysis produces the smallest p-value in the first 30 patients.

---

# 23. Identify the primary outcome

Ask:

> **“What is your primary outcome?”**

Examples:

### Continuous

- symptom score;
- blood pressure;
- biomarker concentration;
- quality-of-life score.

### Binary

- complication: yes/no;
- disease recurrence: yes/no;
- response: yes/no.

### Time-to-event

- time until death;
- time until recurrence;
- time until discharge.

### Repeated continuous outcome

- symptom score measured repeatedly over time.

The outcome type strongly determines the final analysis.

---

# 24. Identify the comparison

Ask:

> **“What exactly is your primary comparison or effect of interest?”**

For example:

```text
Treatment A vs Treatment B
```

or:

```text
Before vs after treatment
```

or:

```text
Difference in change over time between two groups
```

These are different statistical questions.

---

# 25. Simple final-analysis map

| Study/outcome                                  | Possible analysis                                     |
| ---------------------------------------------- | ----------------------------------------------------- |
| Continuous outcome, two independent groups     | t-test / linear regression                            |
| Continuous follow-up with baseline measurement | Linear regression / ANCOVA framework                  |
| Continuous paired before/after data            | Paired analysis                                       |
| Binary outcome                                 | Chi-square/Fisher's exact test or logistic regression |
| Binary outcome with covariates                 | Logistic regression                                   |
| Repeated measurements                          | Longitudinal/mixed-effects model                      |
| Time-to-event outcome                          | Kaplan-Meier/Cox regression                           |
| Continuous outcome with several predictors     | Multiple linear regression                            |

This is a guide rather than an automatic rule.

---

# 26. Example: continuous follow-up with baseline measurement

Suppose:

- treatment group is the exposure;
- symptom score at six months is the primary outcome;
- baseline symptom score is available.

A possible final model is:

\beta_0\
+\
\beta_1Treatment\
+\
\beta_2Y\_{baseline}\
+\
\epsilon\
]

In R:

```r
model <- lm(
    followup ~ treatment + baseline,
    data = final_data
)

summary(model)
```

The treatment coefficient estimates the group difference in follow-up outcome after accounting for baseline outcome, conditional on the model.

---

# 27. Why might this be preferable to simply comparing follow-up means?

Suppose baseline symptom severity varies considerably.

A simple analysis:

[\
Followup\sim Treatment\
]

ignores baseline outcome.

An adjusted model:

[\
Followup\sim Treatment+Baseline\
]

uses information about where each participant started.

Whether baseline adjustment should form the primary analysis should ideally be specified in advance rather than chosen because it produces a more favourable result.

---

# 28. Example: binary outcome

Suppose the outcome is:

```text
Complication:
0 = No
1 = Yes
```

A simple comparison might use:

- chi-square test;
- Fisher's exact test where appropriate.

If adjustment for prespecified covariates is needed:

```r
model <- glm(
    complication ~ treatment + age + baseline_severity,
    family = binomial,
    data = final_data
)

summary(model)
```

This is logistic regression.

---

# 29. Use the interim data to assess feasibility of the final model

Although the first 30 patients should not be used for significance hunting, they can reveal practical problems.

Check:

- are all required variables actually being collected?
- how much missing data is there?
- are some categories extremely rare?
- are there enough events?
- are there impossible or erroneous values?
- are outcomes extremely skewed?
- are there floor/ceiling effects?
- are repeated measurements structured as expected?

Example:

Suppose the intended final model is:

```text
Complication ~ Treatment + Age + Sex +
               BMI + Smoking + Disease Severity
```

But after 30 patients there are only:

```text
3 complications
```

This raises concerns about the feasibility of fitting a model containing many parameters.

That is useful information for planning.

---

# 30. SPSS: practical interim exploration

For a continuous primary outcome:

### Descriptive statistics

Go to:

**Analyze → Descriptive Statistics → Explore**

Put:

- primary outcome → **Dependent List**
- group → **Factor List**

Under **Plots**, request appropriate:

- histogram;
- boxplot;
- QQ plot.

Example output:

```text
Group          N      Mean      SD

Control       14      47.8      8.7
Treatment     13      43.6      9.2
```

Compare the observed variability with the assumptions from the original sample-size calculation.

---

# 31. SPSS: missing data

Start by checking:

**Analyze → Descriptive Statistics → Frequencies**

or appropriate descriptive procedures.

Determine:

- number of valid observations;
- number missing;
- which variables are missing;
- why the observations are missing where this information is available.

Do not treat participants whose follow-up date has not yet arrived as dropouts.

---

# 32. SPSS: final continuous two-group comparison

If a simple independent-group analysis is genuinely appropriate:

**Analyze → Compare Means → Independent-Samples T Test**

- Test Variable: primary continuous outcome
- Grouping Variable: treatment/group

But do not automatically perform this as a formal interim efficacy analysis unless that is appropriate under the study design.

---

# 33. SPSS: regression with baseline adjustment

Go to:

**Analyze → Regression → Linear**

Set:

- Dependent: follow-up outcome
- Independent: treatment/group and baseline outcome

Conceptually:

[\
Followup=\beta_0+\beta_1Treatment+\beta_2Baseline+\epsilon\
]

---

# 34. R: useful interim descriptive analysis

For sample size:

```r
table(data$group)
```

For missingness:

```r
colSums(is.na(data))
```

Percentage missing:

```r
colMeans(is.na(data)) * 100
```

For group descriptive statistics:

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

For visual inspection:

```r
hist(data$followup)

qqnorm(data$followup)
qqline(data$followup)

boxplot(followup ~ group, data = data)
```

---

# 35. Should normality be tested?

Do not mechanically use a normality test as:

```text
Shapiro-Wilk p > .05
→ data are normal

Shapiro-Wilk p < .05
→ data are not normal
```

With small samples, normality tests have limited ability to detect departures from normality.

Use:

- QQ plots;
- histograms;
- boxplots;
- knowledge of the measurement;
- model residual diagnostics where appropriate.

Also remember that assumptions generally concern the statistical model/errors rather than requiring the raw outcome in every group to be perfectly normally distributed.

---

# 36. What if formal interim hypothesis testing was planned?

This requires special care.

Suppose the plan is:

```text
N=30:
test Treatment A vs Treatment B

then

N=60:
test Treatment A vs Treatment B again
```

Testing the same primary hypothesis multiple times creates multiple opportunities to reject the null hypothesis.

This can inflate the overall Type I error if ordinary significance thresholds are repeatedly used.

Formal group-sequential designs may use methods such as:

- O'Brien-Fleming boundaries;
- Pocock boundaries;
- alpha-spending approaches.

If formal interim efficacy/futility testing was part of the protocol, follow that planned procedure.

If it is unclear, do not improvise a new sequential testing procedure during a tutoring appointment.

---

# 37. If the first 30 are part of the final 60, can they still be included in the final analysis?

Potentially, **yes**.

That is one feature of an appropriately designed internal pilot.

Conceptually:

```text
First 30 patients
       ↓
Internal pilot/interim review
       ↓
Assess prespecified assumptions
       ↓
Continue recruitment
       ↓
Additional patients
       ↓
Final dataset
       ↓
Original 30 + later participants
       ↓
Final analysis
```

The precise validity of this approach depends on how the internal pilot and any sample-size re-estimation were designed.

---

# 38. What should NOT be done?

## Do not do this:

```text
First 30 patients
       ↓
Treatment difference isn't significant
       ↓
Calculate observed power
       ↓
Power is low
       ↓
Keep adding participants until significant
```

This is not an appropriate sample-size strategy.

---

## Also avoid:

### Changing the primary outcome because another outcome looks significant

Do not:

```text
Primary outcome → p=.20

Secondary outcome → p=.03

Therefore make secondary outcome primary
```

---

### Choosing the final model based on significance

Do not:

```text
Model A → p=.08
Model B → p=.04

Therefore choose Model B
```

The model should be determined by the research question and design.

---

### Adding/removing covariates solely according to p-values

Do not simply say:

```text
Age significant → include
Sex not significant → remove
BMI significant → include
```

Covariate selection should primarily reflect the design, prespecified plan and scientific rationale.

---

# 39. The most useful table to create during the appointment

Fill this in together.

| Parameter                    | Original assumption |          Interim information | Action/question                                   |
| ---------------------------- | ------------------: | ---------------------------: | ------------------------------------------------- |
| Primary outcome              |                   ? |                            ? | Confirm                                           |
| Clinically meaningful effect |                   ? | Do not automatically replace | Is original effect still scientifically relevant? |
| SD/event rate                |                   ? |                            ? | Compare with original                             |
| Alpha                        |                   ? |            Usually unchanged | Confirm                                           |
| Desired power                |                   ? |            Usually unchanged | Confirm                                           |
| Expected dropout             |                   ? |                            ? | Compare                                           |
| Required complete N          |                   ? |                            ? | Re-estimate only if appropriate                   |
| Recruitment target           |                 60? |                            ? | Determine after review                            |
| Primary analysis             |                   ? |                            ? | Confirm based on design                           |

This table will keep the consultation focused.

---

# 40. Questions to ask in order

## First: study design

Ask:

> **“What is your primary research question?”**

Then:

> **“What is your primary outcome?”**

Then:

> **“Can you explain the study design and what is being compared?”**

Then:

> **“Are the 30 patients a separate pilot or the first 30 of the planned 60?”**

---

## Second: original power calculation

Ask:

> **“Can you show me the original sample-size calculation or protocol?”**

Then identify:

```text
Effect to detect = ?
SD / event rate = ?
Alpha = ?
Desired power = ?
Expected dropout = ?
Required complete N = ?
Why was N=60 chosen?
```

---

## Third: interim analysis

Ask:

> **“What did the previous statistician say the interim analysis at 30 patients was intended to assess?”**

Was it:

- variability?
- event rate?
- sample-size reassessment?
- recruitment/dropout?
- safety?
- efficacy?
- futility?
- something else?

---

## Fourth: current data

Check:

```text
How many recruited?
How many have completed follow-up?
How many have the primary outcome?
How much missing data?
How much genuine dropout?
What is the SD/event rate?
Any major data-quality problems?
```

---

## Fifth: power/sample size

Compare:

```text
ORIGINAL ASSUMPTIONS
        versus
INTERIM INFORMATION
```

Then determine whether an appropriate sample-size reassessment is warranted.

---

## Sixth: final analysis

Ask:

```text
What is the outcome type?
What is the primary comparison?
Independent or repeated observations?
Baseline measurement available?
Prespecified covariates?
Missing data?
```

Then determine the statistical model.

---

# 41. Straightforward answers to the main questions

## “I have 30 of my planned 60 patients. Am I adequately powered?”

**Answer:**

> “We can't determine that from 30/60 alone. First we need to reconstruct the original power calculation and identify the effect the study was designed to detect, the assumed variability or event rate, alpha and desired power. We can then consider whether the accumulating data suggest that the assumptions behind the original calculation remain reasonable.”

---

## “Can I use my 30 patients to calculate the final sample size?”

**Answer:**

> “Potentially, particularly if an internal-pilot sample-size reassessment was planned. The accumulating data may help estimate quantities such as variability, event rate or dropout. We should be cautious about simply using the observed treatment difference from the first 30 patients as the new effect size.”

---

## “How do I know whether 60 is still enough?”

**Answer:**

> “First identify why 60 was originally chosen. Then compare the assumptions behind that calculation with the relevant information from the accumulating data. If an appropriate sample-size re-estimation shows that substantially more or fewer participants are required, that can then be discussed in the context of the study protocol.”

---

## “My first 30 patients don't show a significant result. Do I need more patients?”

**Answer:**

> “Not necessarily. A non-significant interim result does not by itself demonstrate inadequate power. We should return to the original study assumptions rather than increasing sample size simply because the interim p-value is above .05.”

---

## “Should I calculate observed/post-hoc power?”

**Answer:**

> “Usually this adds little useful information when it is based on the same observed treatment effect. The estimated effect and confidence interval, together with the original power assumptions, are generally more informative.”

---

## “Can I test the primary outcome now?”

**Answer:**

> “Descriptive analysis is useful. Formal interim hypothesis testing is different and should follow the planned study design because repeatedly testing the primary hypothesis can affect the overall Type I error.”

---

## “How do I decide my final analysis?”

**Answer:**

> “Start with the primary research question, primary outcome and study design. Then determine whether observations are independent or repeated, whether baseline adjustment is appropriate, what covariates were prespecified, and how missing data will be handled. The statistical model should follow from those features rather than from the interim p-values.”

---

# 42. If completely stuck during the appointment

Return to these five questions:

> **1. What is your primary outcome?**

> **2. Are these 30 patients part of the final study or a separate pilot?**

> **3. Can you show me how the original target of 60 was calculated?**

> **4. What exactly was the planned interim analysis supposed to assess?**

> **5. What is the primary comparison you ultimately want to make?**

The answers to these questions will usually determine the next statistical step.

---

# 43. One-minute conceptual explanation

A concise way to explain the whole situation is:

> **“There are really two separate questions here. The first is sample size: we need to understand why the study originally planned 60 patients and whether the assumptions behind that calculation, such as variability, event rate or dropout, remain reasonable based on the accumulating data. If sample-size re-estimation was planned and appropriate, we can then reassess the required sample size. The second question is the final analysis: that should be determined by the primary outcome, research question and study design, including whether measurements are independent or repeated, whether baseline adjustment is needed, and how missing data will be handled. We shouldn't choose either the sample size or final model simply according to whether the first 30 patients produce a significant result.”**

---

# 44. Bottom line

For an ongoing study with **30 of a planned 60 patients**, the process should generally be:

```text
1. FIND ORIGINAL PROTOCOL / POWER CALCULATION
                    ↓
2. UNDERSTAND WHY N=60 WAS CHOSEN
                    ↓
3. IDENTIFY WHAT THE INTERIM ANALYSIS WAS
   SUPPOSED TO ASSESS
                    ↓
4. REVIEW THE FIRST 30 PATIENTS
   - data quality
   - missingness
   - dropout
   - SD / event rate
   - data structure
                    ↓
5. COMPARE WITH ORIGINAL ASSUMPTIONS
                    ↓
6. IF APPROPRIATE, PERFORM A FORMAL
   SAMPLE-SIZE REASSESSMENT
                    ↓
7. CONFIRM THE FINAL ANALYSIS FROM
   THE RESEARCH QUESTION + STUDY DESIGN
                    ↓
8. DOCUMENT THE PLAN BEFORE THE
   FINAL DATA ARE ANALYSED
                    ↓
9. COMPLETE RECRUITMENT
                    ↓
10. PERFORM FINAL ANALYSIS
```

The key principle is:

> **Do not ask only, “What happened in the first 30 patients?” Ask, “What was the study designed to detect, what assumptions produced the original sample size, and are those assumptions still reasonable?”**

That provides the bridge from the interim data to both the **power/sample-size decision** and the **final statistical analysis plan**.
