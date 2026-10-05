# Regression and the Pay-for-Hours Model: A Plain-English Guide

## Start here

This guide explains how to read a regression and the maths of a simple model of why pay does not rise in step with hours. No advanced maths is needed.

Each idea comes in two versions: a plain one, and one for a 15-year-old using weekend jobs and games.

Not sure where to start? Begin with the part that feels least familiar, then read on in order. Finish by explaining the pay rule back in your own words.

### The running story

Three friends started full-time together: Maya (lawyer), Dev (accountant) and Elena (pharmacist). These invented numbers are used throughout. Pay is in £ thousands a year.

| Job | Full-time pay (k) | Pay lost if hours are cut (δ) | Hours threshold (λ\*) |
| --- | --- | --- | --- |
| Lawyer | 100 | 50% | 0.9 |
| Accountant | 80 | 30% | 0.6 |
| Pharmacist | 60 | none | none |

The numbers are for teaching, not real estimates. The model simplifies an idea from Goldin (2014).

## Regression 1: the basics

A regression draws the straight line that best summarises how one number changes when another changes.

| Word | Meaning |
| --- | --- |
| Outcome (y) | What you want to explain, such as pay |
| Predictor (x) | What you use to explain it, such as years of experience |
| Residual | How far a data point sits from the line |

The line is:

$$\hat{y} = a + b\,x$$

- **a (intercept):** the predicted outcome when x = 0.
- **b (slope):** the change in the predicted outcome for one more unit of x.

The best line makes the squared residuals as small as possible. This is called ordinary least squares (OLS).

**Example.** If mark = 40 + 3 × revision hours, then 0 hours predicts 40 and 10 hours predicts 70. Each extra hour goes with 3 more marks on average.

Say "associated with", not "causes". A slope shows how two things move together, not that one causes the other.

## Regression 2: more than one variable

Regressions usually include several predictors. Each coefficient is read holding the others constant.

An invented hourly-pay example, with female coded 1 for women and 0 for men:

$$\widehat{\text{wage}} = 5 + 1.5\,\text{education} + 0.4\,\text{experience} - 2\,\text{female}$$

- **1.5:** one more year of education goes with £1.50 more an hour, for people with the same experience and sex.
- **0.4:** one more year of experience goes with £0.40 more an hour.
- **−2:** a woman earns £2 less an hour than a man with the same education and experience.

Check: at 16 years of education and 10 of experience, a man is predicted £33 an hour and a woman £31.

The coefficient on a yes/no ("dummy") variable is the average gap between the two groups, with the other variables held constant. The raw gap compares everyone. The adjusted gap compares people who look alike on the variables included. What remains may still reflect left-out factors, so call it an association.

## Regression 3: reading an output

The worked example is a regression reported in Goldin (2014). Each of 89 US occupations is one data point. The outcome is the adjusted gender pay gap among graduates. The predictor is a standardised job-demands score, so 0 is an average occupation.

| Piece | Value | Standard error | t-value |
| --- | --- | --- | --- |
| Intercept | −0.153 | 0.00851 | −18.0 |
| Slope | −0.0593 | 0.0122 | −4.9 |

The fit is R² = 0.214 with n = 89. The line is gap = −0.153 − 0.0593 × score. Negative means women are paid less.

1. **Intercept.** An average occupation has a gap of −0.153, which is about −14.2% (exp(−0.153) − 1).
2. **Slope.** One standard deviation higher on the score goes with a gap about 0.06 larger.
3. **Uncertainty.** t = −0.0593 ÷ 0.0122 = −4.9. Beyond ±2 is significant at 5%. The 95% interval is −0.084 to −0.035 and excludes zero.
4. **Fit.** R² = 0.214, so the score explains about 21% of the variation in gaps. The rest is unexplained.
5. **Caveat.** This is an association across occupations, not a cause, and not a statement about individuals.

One-sentence summary: "Across 89 occupations, a one standard deviation higher job-demands score goes with a pay gap about 6 log points larger, and the score explains about 21% of the variation."

## Regression 4: logs and interactions

**Pay in logs.** Pay gaps are about proportions, so researchers use the log of pay. A small coefficient is then close to a percentage: −0.10 means about 10% less. For bigger values, convert exactly with exp(b) − 1. For example, −0.153 gives −14.2%, not −15.3%. Do not confuse a percentage with a percentage point: from 10% to 16% is 6 points, or a 60% rise.

**Interactions.** An interaction lets the slope differ by group:

$$\ln(\text{earnings}) = a + b_1\,\text{female} + b_2\,\ln(\text{hours}) + b_3\,(\text{female} \times \ln(\text{hours}))$$

- **b₂:** the hours slope for men.
- **b₂ + b₃:** the hours slope for women.
- **b₃:** the difference between the two slopes. It is not "the gender effect".

**Elasticity.** With logs on both sides, the coefficient is the percentage change in pay for a 1% change in hours. Above 1, pay rises faster than hours. At 1.5, doubling hours multiplies pay by 2^1.5 ≈ 2.8. This is the regression version of the upward-bending pay curve below.

## Regression 5: traps and a routine

Common traps:

- Association is not cause.
- A result about occupations does not automatically hold for individuals.
- A few outliers can tilt the line. Re-run without them.
- A low R² is not useless. It only says other things matter too.
- Significant is not the same as important. Always say how big the effect is.

A routine for any output:

1. Name the unit and the outcome.
2. Check the units: logs, percentages, standardised scores.
3. Say the sign and size of the slope, and what is held constant.
4. Judge uncertainty with the standard error, t-value or interval.
5. Judge fit with R².
6. State one caveat.

## The model: a pay rule with a threshold

The model is an if/else rule written as maths. Work more than a job's threshold and you get the full rate. Work at or below it and part of your pay is lost.

| Symbol | Meaning | Story value |
| --- | --- | --- |
| Q | Total pay | £ thousand a year |
| λ | Share of full-time hours, up to 1 | 1 = full-time, 0.5 = half-time |
| k | Pay per unit of hours in a job | 100, 80, 60 |
| δ | Share of pay lost below the threshold | 50%, 30%, none |
| λ\* | The job's hours threshold | 0.9, 0.6 |

$$Q = \begin{cases} \lambda\,k_j & \text{if } \lambda > \lambda_j^{*} \\ \lambda\,k_j\,(1-\delta_j) & \text{if } \lambda \le \lambda_j^{*} \end{cases}$$

In words: above the threshold, Q = λ × k. At or below it, Q = λ × k × (1 − δ).

The model assumes three things. Job 1 has the biggest penalty, job 2 a medium one, and job r none, so its pay is a straight line.

1. k₁ > k₂ > kᵣ: pay per unit is highest in job 1 and lowest in job r.
2. δ₁ > δ₂: job 1 punishes cut hours the most.
3. After the penalty the order reverses: k₁(1 − δ₁) < k₂(1 − δ₂) < kᵣ. Check: 100 × 0.5 = 50, which is less than 80 × 0.7 = 56, which is less than 60.

**Why a penalty?** A lawyer on call for clients has no perfect substitute, so her availability is worth more. A pharmacist's work is standardised, so a colleague can cover.

**A model, not a regression.** The rule describes pay under assumptions. A regression estimates relationships from data. The model predicts a pattern and regressions check it.

**Output or pay?** Presentations call Q either output or pay. The arithmetic is the same. This guide calls it pay.

### One job first

Take k = 100, δ = 0.3 and λ\* = 0.8. At λ = 0.9, Q = 0.9 × 100 = 90. At λ = 0.7, Q = 0.7 × 100 × 0.7 = 49. Hours fall 22% but pay falls 46%. A straight line would give 70. That sudden jump is what "discontinuous" means.

### Three jobs

This table is used in every diagram below. Each cell is pay Q at that share of full-time hours.

| Hours share (λ) | Lawyer | Accountant | Pharmacist | Best available |
| --- | --- | --- | --- | --- |
| 1.0 | 100 | 80 | 60 | 100 (lawyer) |
| 0.9 | 45 | 72 | 54 | 72 (accountant) |
| 0.8 | 40 | 64 | 48 | 64 (accountant) |
| 0.7 | 35 | 56 | 42 | 56 (accountant) |
| 0.6 | 30 | 33.6 | 36 | 36 (pharmacist) |
| 0.5 | 25 | 28 | 30 | 30 (pharmacist) |

## Diagram 1: One job, two pay lines

The same job pays at one of two rates, depending on your hours. In the 15-year-old versions, the three jobs are weekend jobs paying £100, £80 and £60 a week: concert crew, café and supermarket.

**What you see.** Hours share λ runs across and pay Q runs up. A steep solid line (slope k₁) and a flatter dashed line (slope k₁(1 − δ₁)) leave the origin. A dotted vertical line marks the threshold λ₁\*.

**Plain version.** The steep line is the full rate, paid if you work enough hours. The flatter line is the reduced rate, paid if you do not. The gap between them is the penalty.

**15-year-old version.** The crew manager pays the full rate if you stay for the whole event and halves it if you leave early. Steep line: stayed. Flatter line: left early. Dotted line: what counts as "the whole event".

**The story.** At 0.9 of full-time hours, Maya's full rate gives 90 and her reduced rate gives 45.

## Diagram 2: Only the pay you actually get

Pay jumps at the threshold.

**What you see.** The dashed line runs up to λ₁\*, then jumps vertically onto the solid line, which carries on upward.

**Plain version.** Below the threshold you are on the flat line. At the threshold your pay jumps. Pay that rewards the last hours disproportionately is called convex.

**15-year-old version.** It is like a bonus level. Finish 89% of the raid and you get ordinary loot. Finish all of it and the double-loot chest opens.

**The story.** Maya earns 91 at 0.91 hours but only 45 at 0.9. One extra percentage point of hours doubles her pay. Real pay is less sharp, so read this as a very steep slope.

## Diagram 3: A second job with a smaller penalty

Which job pays more depends on your hours.

**What you see.** Blue lines are job 1 and red lines are job 2. The red solid line sits below the blue solid line, but the red dashed line sits above the blue dashed line. Job 2's threshold is further left.

**Plain version.** If you can meet job 1's demands, job 1 pays more. If you cannot, job 2 pays more, because its penalty is milder.

**15-year-old version.** The crew pays most per hour but docks half if you leave early. The café pays less but docks only 30%. If you can only work part of the day, the café wins.

**The story.** At 0.8 hours, Maya earns 0.8 × 100 × 0.5 = 40. Dev earns 0.8 × 80 = 64.

## Diagram 4: Two jobs make two steps

Best pay rises in two jumps as hours increase.

**What you see.** Each job has a dashed part left of its threshold and a solid part right of it. The best pay follows red between the two thresholds and blue after λ₁\*. There are two jumps.

**Plain version.** Read left to right. At low hours both jobs are penalised. At λ₂\* you step up to red's full rate. At λ₁\* you step up again to blue's. The steps get bigger towards the right.

**15-year-old version.** It is a staircase with two big steps. Put in enough hours and you step up to the café's rate. Stay for the whole event and you step up to the crew's.

**The story.** Take the better of the lawyer and accountant jobs. From 0.5 to 0.6 pay adds 5.6 (28 to 33.6). From 0.6 to 0.7 it adds 22.4 (to 56). From 0.9 to 1.0 it adds 28 (72 to 100). The same extra tenth of hours is worth more near full-time.

## Diagram 5: A third job with no penalty

The lowest-paying job is the best choice at low hours.

**What you see.** A green straight line with slope kᵣ leaves the origin. At low hours it sits above both dashed lines.

**Plain version.** The third job has the lowest headline rate but no penalty. Below λ₂\* every other job is penalised, so green wins at low hours, red in the middle and blue at high hours.

**15-year-old version.** Shelf-stacking pays least per hour, but nobody minds who covers which shift. For a couple of hours after school it is the best deal.

**The story.** At 0.5 hours the lawyer earns 25, the accountant 28 and the pharmacist 30. Elena has the lowest headline rate, yet at half-time she earns the most.

## Diagram 6: The best pay bends upward

Put the three jobs together and the best pay curves upward. This shape is called convex.

**What you see.** A black curve traces the best pay at each level of hours: green, then red, then blue. It is shallow on the left and steep on the right.

**Plain version.** The curve answers one question: for each level of hours, what is the best pay on offer? The first hours earn little extra and the last hours earn a lot. Goldin (2014) argues the gender pay gap would be smaller if firms did not reward long, particular hours so disproportionately. Costa Dias et al. (2020) find that the gap after a first child is largely driven by differences in full-time experience.

**15-year-old version.** It is like levelling up in a game where each level takes the same effort but pays a bigger prize. Stop halfway and you miss the big rewards.

**The story.** Best pay is 100 at full-time and 30 at half-time. Hours halve, but pay falls 70%.

## Diagram 7: Do real data show the pattern?

This is the scatter plot behind the regression in Regression 3.

**What you see.** Each dot is one occupation. The score runs across and the adjusted gender pay gap among graduates runs up. Zero means no gap and negative means women earn less. The dashed line is gap = −0.153 − 0.0593 × score, with R² = 0.214 and n = 89.

**Plain version.** The line slopes downward, so occupations with higher scores tend to have bigger gaps. The cloud is wide, so the score explains only about a fifth of the variation. The pattern fits the model but does not prove it.

**15-year-old version.** Each dot is a job. Further right means the job needs you available at set times and in touch with people. Lower down means a bigger pay difference after comparing like with like. It is a trend with plenty of exceptions, like gaming time and sleep.

**The story.** On the line, the predicted gap is about −9% at a score of −1, about −14% at 0 and about −19% at +1.

## Putting it together

- The model explains why pay can rise much faster than hours: a threshold, a penalty, and jobs that differ in how much they punish short or inflexible hours.
- Regression checks whether real data show the pattern. Across 89 occupations, higher job-demands scores go with larger pay gaps.
- The pattern fits the model but does not prove it, because the score explains only about 21% of the variation.

**The one-minute version.** Some jobs pay disproportionately for particular hours. Workers who cannot supply them lose a lot, so they move to jobs with a smaller penalty and a lower headline rate. A regression across occupations checks whether gaps are larger where the penalty is larger.

## Quick questions and answers

| Question | Short answer |
| --- | --- |
| What does a slope mean? | The expected change in the outcome for one more unit of the predictor, holding other variables constant. |
| What does p < 0.05 mean? | If the true slope were zero, a result this extreme would occur less than 5% of the time. It does not show the effect is large. |
| Does a significant slope show cause? | No. It shows an association. |
| Why use log pay? | Differences in logs are close to percentages. For larger gaps use exp(b) − 1. |
| What is an interaction? | A term that lets a slope differ by group. |
| Why is the pay rule discontinuous? | Crossing the threshold switches the penalty on or off, so pay jumps. |
| What is the economic point? | Some jobs reward long or inflexible hours disproportionately, so workers who need flexibility lose a lot and may move to jobs with a smaller penalty. |
| Is the pay rule a regression? | No. It is a theoretical model. A regression estimates relationships from data. |

## Practice questions

1. A line is wage = 5 + 1.5 × education + 0.4 × experience − 2 × female. What do a man and a woman with 16 years of education and 10 of experience earn?
2. A slope is −0.0593 with a standard error of 0.0122 and 87 degrees of freedom. What are the t-value and the 95% interval?
3. A coefficient on a log outcome is −0.153. What percentage gap is that?
4. A job has k = 100, δ = 0.3 and λ\* = 0.8. What is pay at λ = 0.9 and at λ = 0.7?
5. In the three-job table, who earns most at λ = 0.8, and why is it not the lawyer?

**Answers**

1. A man: 5 + 24 + 4 = 33. A woman: 33 − 2 = 31.
2. t = −0.0593 ÷ 0.0122 = −4.86. The interval is −0.0593 ± 1.99 × 0.0122, which is −0.084 to −0.035. It excludes zero.
3. exp(−0.153) − 1 = −0.142, about 14.2% lower.
4. At 0.9: 90. At 0.7: 0.7 × 100 × 0.7 = 49. Crossing the threshold switches on the 30% penalty.
5. The accountant earns 64, against the lawyer's 40 and the pharmacist's 48. The lawyer is below her threshold of 0.9 and loses 50%.

## Try it yourself: R and SPSS

The data are simulated to match the reported numbers, so your estimates will be close to but not exactly the published ones.

### R

```r
set.seed(2026); n <- 89
onet <- rnorm(n)
gap  <- -0.153 - 0.0593*onet + rnorm(n, sd = 0.114)
fit  <- lm(gap ~ onet)
summary(fit); confint(fit)
exp(coef(fit)[1]) - 1                  # log points to a percentage

# Interaction, with your own data: lm(log(earnings) ~ female * log(hours), data = df)

# The pay rule
k <- c(100, 80, 60); d <- c(0.5, 0.3, 0); star <- c(0.9, 0.6, 0)
pay <- function(l, k, d, s) ifelse(l > s, l*k, l*k*(1 - d))
l <- round(seq(0.05, 1, by = 0.05), 2)   # round avoids 0.9000000000000001
Q <- sapply(1:3, function(j) pay(l, k[j], d[j], star[j]))
matplot(l, cbind(Q, apply(Q, 1, max)), type = "l")
```

### SPSS

Use Analyze, then Regression, then Linear (gap as Dependent, onet as Independent). Or use syntax:

```
REGRESSION
  /STATISTICS COEFF OUTS CI(95) R ANOVA
  /DEPENDENT gap
  /METHOD=ENTER onet.
```

For the pay rule, put hours shares in a column named lambda in a new data window, then run:

```
COMPUTE Q1 = lambda * 100.
IF (lambda <= 0.9) Q1 = lambda * 100 * 0.5.
COMPUTE Q2 = lambda * 80.
IF (lambda <= 0.6) Q2 = lambda * 80 * 0.7.
COMPUTE Qr = lambda * 60.
COMPUTE Qbest = MAX(Q1, Q2, Qr).
EXECUTE.
```

## Glossary and sources

| Term | Meaning |
| --- | --- |
| Slope | Change in the outcome for a one-unit rise in a predictor |
| Standard error | How much a coefficient would vary from sample to sample |
| t-value | Coefficient divided by its standard error |
| 95% confidence interval | A range of plausible values for the true coefficient |
| R² | Share of the outcome's variation explained by the model |
| Dummy variable | A 0/1 variable for a group, such as female |
| Interaction | A term that lets one variable's slope differ by group |
| Log points | Differences in logs, close to percentages when small |
| Convex | Bending upward, so each extra unit earns more than the last |
| Discontinuous | Jumping suddenly instead of changing smoothly |

**Sources**

- Goldin, C. (2014). A grand gender convergence: its last chapter. *American Economic Review*, 104(4), 1091–1119.
- Costa Dias, M., Joyce, R. and Parodi, F. (2020). The gender pay gap in the UK: children and experience in work. *Oxford Review of Economic Policy*, 36(4), 855–881.

**A note on accuracy.** The regression figures are as reported in teaching materials based on Goldin (2014), and the code data are simulated. The pay-rule numbers are invented. Before relying on the exact definition of Q, check the model section of the paper.
