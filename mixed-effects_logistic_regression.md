# Tutoring session prep: reviewing a revised data analysis section (mixed-effects logistic regression)

General version for any student who brings a revised analysis section, based on a glmer model, for checking before resubmission to a journal.

---

## 1. Snapshot of the typical request

What the request usually looks like
- A student, often not a statistics specialist, has revised a data analysis section after supervisor or reviewer comments.
- The audience is peer reviewers, not only a supervisor, so the standard is journal-level.
- A common trigger is a comment about whether an interaction term belongs in a glmer model. The guidance to give is: include only terms with a plausible reason to predict the outcome, interaction terms included. Useful reading: https://strengejacke.github.io/ggeffects/articles/practical_logisticmixedmodel.html

What to confirm first
- The revised text and R script. The examples below assume a mixed-effects logistic model (lme4 in R) with a binary outcome such as correct/incorrect. If the outcome is a count or a proportion, the structure of the review stays the same but the family and the interpretation change.

What the student is asking, in plain words
"I changed my analysis after the comments. Before I send the paper back, is what I wrote correct, justified, and safe from reviewer criticism?"

So the task is a review, not teaching from scratch. The most useful stance is to read the revised text with the student and check four things: model choice, interaction justification, reporting, and wording.

---

## 2. Suggested running order for the session

1. Ask the student to share the revised section and the R script (2 min).
2. Confirm outcome type, design, and the model formula used (2 min).
3. Check the interaction term logic (Approach A).
4. Check random effects and convergence (Approach B).
5. Check that the results are reported in an interpretable way (Approach C).
6. Check assumptions and diagnostics (Approach D).
7. Run through the wording checklist (Approach E).
8. Agree two or three concrete edits before the student leaves.

Questions to ask first
- What is the outcome variable, and is it binary, count, or proportion?
- What are the units that are measured repeatedly (participants, items, texts, classrooms)?
- Which predictors are in the model, and why each one?
- What exactly did the supervisor or reviewer object to?
- Did the model produce any warning (singular fit, failure to converge)?

---

## 3. Dummy dataset used in all examples

Scenario: 40 participants (20 native speakers, 20 learners) each answer 20 items. Items are either easy or hard. The outcome is whether the answer was correct (1) or not (0). This is a typical design with repeated measures, so subjects and items are both random effects.

```r
# Load the package that fits generalised linear mixed models
library(lme4)

# Make the simulated data reproducible: the same random numbers each run
set.seed(123)

# Number of participants
n_subj <- 40

# Number of items each participant sees
n_item <- 20

# Build every combination of subject and item (40 x 20 = 800 rows)
d <- expand.grid(subject = factor(1:n_subj), item = factor(1:n_item))

# Participants 1 to 20 are native speakers, 21 to 40 are learners
d$group <- factor(ifelse(as.integer(d$subject) <= 20, "native", "learner"),
                  levels = c("learner", "native"))   # learner is the reference level

# Even-numbered items are easy, odd-numbered items are hard
d$condition <- factor(ifelse(as.integer(d$item) %% 2 == 0, "easy", "hard"),
                      levels = c("hard", "easy"))    # hard is the reference level

# Draw one random intercept per participant (some people are just better overall)
subj_eff <- rnorm(n_subj, mean = 0, sd = 0.8)

# Draw one random intercept per item (some items are just easier overall)
item_eff <- rnorm(n_item, mean = 0, sd = 0.5)

# Build the true log-odds of a correct answer for every row
# Intercept -0.35, easy items +0.90, native +0.75, extra native-by-easy boost +0.55
lp <- -0.35 +
  0.90 * (d$condition == "easy") +
  0.75 * (d$group == "native") +
  0.55 * (d$condition == "easy") * (d$group == "native") +
  subj_eff[as.integer(d$subject)] +              # add each participant's own shift
  item_eff[as.integer(d$item)]                   # add each item's own shift

# Convert log-odds to probability and draw a 0/1 answer from it
d$correct <- rbinom(nrow(d), size = 1, prob = plogis(lp))

# Quick look at the first rows
head(d)
```

Dummy output (illustrative; values will differ slightly when you run it)
```
  subject item   group condition correct
1       1    1  native      hard       1
2       2    1  native      hard       0
3       3    1  native      hard       1
4       4    1  native      hard       1
5       5    1  native      hard       0
6       6    1  native      hard       1
```

---

## 4. Approach A: Decide whether the interaction term belongs, then test it

Why this matters
Supervisor and reviewer comments often point here. An interaction asks: does the effect of one predictor depend on the level of another? Adding interactions "just in case" inflates the number of tests, makes the model harder to read, and invites reviewer questions.

Two-part justification that a reviewer will accept
1. Theory: a reason, stated in the paper, why the effect of condition should differ by group (for example, learners may benefit less from easy items because of a ceiling in their knowledge).
2. Evidence: a likelihood ratio test (LRT) comparing the model with and without the interaction.

Case example: the same data, two models.

```r
# Model without the interaction: condition and group act independently
m_main <- glmer(correct ~ condition + group +          # two fixed effects, no interaction
                  (1 | subject) + (1 | item),          # random intercepts for people and items
                data = d,                              # the dataset
                family = binomial)                     # binary outcome, logit link

# Model with the interaction: the condition effect may differ by group
m_int <- glmer(correct ~ condition * group +           # '*' expands to both main effects plus the interaction
                 (1 | subject) + (1 | item),           # same random effects so the comparison is fair
               data = d,                               # same data
               family = binomial)                      # same family

# Likelihood ratio test: does adding the interaction improve fit more than chance?
anova(m_main, m_int)                                   # compares the two nested models

# Show the full interaction model results
summary(m_int)                                         # fixed effects, random effects, fit statistics
```

Dummy output: model comparison
```
Data: d
Models:
m_main: correct ~ condition + group + (1 | subject) + (1 | item)
m_int:  correct ~ condition * group + (1 | subject) + (1 | item)
       npar    AIC    BIC  logLik deviance  Chisq Df Pr(>Chisq)
m_main    5 2415.2 2438.6 -1202.6   2405.2
m_int     6 2409.8 2437.9 -1198.9   2397.8 7.4012  1   0.006516 **
```

Dummy output: summary of the interaction model
```
Generalized linear mixed model fit by maximum likelihood (Laplace Approximation) ['glmerMod']
 Family: binomial  ( logit )
Formula: correct ~ condition * group + (1 | subject) + (1 | item)

     AIC      BIC   logLik deviance df.resid
  2409.8   2437.9  -1198.9   2397.8      794

Random effects:
 Groups  Name        Variance Std.Dev.
 subject (Intercept) 0.6180   0.7861
 item    (Intercept) 0.3110   0.5577
Number of obs: 800, groups:  subject, 40; item, 20

Fixed effects:
                         Estimate Std. Error z value Pr(>|z|)
(Intercept)               -0.3500     0.2310  -1.515  0.12980
conditioneasy              0.9000     0.2100   4.286  1.82e-05 ***
groupnative                0.7500     0.3050   2.459  0.01393 *
conditioneasy:groupnative  0.5500     0.2900   1.897  0.05780 .
```

How to interpret, step by step
1. Intercept (-0.35): log-odds of a correct answer for the reference cell, learners on hard items. As a probability, plogis(-0.35) is about 0.41, so 41 percent.
2. conditioneasy (0.90): for learners, easy items raise the log-odds by 0.90. Odds ratio exp(0.90) = 2.46, so the odds of a correct answer are about 2.5 times higher on easy items.
3. groupnative (0.75): on hard items, native speakers have log-odds 0.75 higher. Odds ratio exp(0.75) = 2.12.
4. Interaction (0.55): the easy-item benefit is larger for native speakers. Their condition effect is 0.90 + 0.55 = 1.45, odds ratio exp(1.45) = 4.26, compared with 2.46 for learners.
5. Important trap: with treatment (default) coding, "conditioneasy" is not an average effect. It is the effect for the reference group only. Many authors misreport this. A reviewer will notice.
6. The LRT (chi-square 7.40, df 1, p = 0.0065) says the interaction improves fit. The Wald p-value in the table (0.058) is borderline. The two can disagree. The LRT is the preferred test for a single term, so report the LRT and say which test you used.
7. AIC is lower for the interaction model (2409.8 versus 2415.2), which agrees with the LRT.

What to say to the student
- Keep the interaction only if there is a stated theoretical reason and the test supports it. If both are weak, remove it and say in the text that it was tested and not retained.
- If the interaction is kept, never interpret the main effects alone. Report the simple effects for each group.

Getting the simple effects and odds ratios

```r
# Load the package that computes estimated marginal means and contrasts
library(emmeans)

# Estimated effect of condition separately within each group, on the odds-ratio scale
emmeans(m_int,                       # the fitted interaction model
        pairwise ~ condition | group, # compare easy vs hard within each group
        type = "response")           # back-transform from log-odds to probabilities and odds ratios
```

Dummy output
```
$emmeans
group = learner:
 condition  prob     SE  df asymp.LCL asymp.UCL
 hard      0.413 0.0560 Inf     0.308     0.526
 easy      0.634 0.0580 Inf     0.516     0.737
group = native:
 condition  prob     SE  df asymp.LCL asymp.UCL
 hard      0.599 0.0590 Inf     0.480     0.708
 easy      0.870 0.0330 Inf     0.793     0.921

$contrasts
group = learner:
 contrast    odds.ratio    SE  df null z.ratio p.value
 hard / easy      0.407 0.0855 Inf    1  -4.286  <.0001
group = native:
 contrast    odds.ratio    SE  df null z.ratio p.value
 hard / easy      0.235 0.0680 Inf    1  -5.000  <.0001
```

Interpretation: in both groups easy items are answered correctly more often. The gap is wider for native speakers (hard/easy odds ratio 0.235, which is the same as easy being 4.3 times more likely) than for learners (0.407, which is 2.5 times). Report probabilities alongside odds ratios, because probabilities are easier for readers from non-statistical fields.

---

## 5. Approach B: Check the random effects structure and convergence

Why this matters
Reviewers in linguistics and psychology often ask whether random slopes were considered. A singular fit or convergence warning that is not mentioned is a common reason for a request for revision.

Case example

```r
# Check whether the fitted model is singular (a random effect estimated at zero or perfect correlation)
isSingular(m_int)                                     # TRUE means the structure is too complex for the data

# Fit a richer model: the condition effect may vary between participants
m_slope <- glmer(correct ~ condition * group +        # same fixed effects
                   (1 + condition | subject) +        # random intercept and random slope of condition by participant
                   (1 | item),                        # random intercept for items (group varies between people, not items)
                 data = d,                            # the data
                 family = binomial,                   # binary outcome
                 control = glmerControl(optimizer = "bobyqa"))  # a robust optimiser that often fixes convergence

# Compare the simpler and richer random structures
anova(m_int, m_slope)                                 # LRT on the random slope

# If a warning appears, try all optimisers and see whether they agree
allFit(m_slope)                                       # refits with several optimisers and reports estimates
```

Dummy output
```
> isSingular(m_int)
[1] FALSE

Models:
m_int:   correct ~ condition * group + (1 | subject) + (1 | item)
m_slope: correct ~ condition * group + (1 + condition | subject) + (1 | item)
        npar    AIC    BIC  logLik deviance  Chisq Df Pr(>Chisq)
m_int      6 2409.8 2437.9 -1198.9   2397.8
m_slope    8 2411.5 2449.0 -1197.8   2395.5  2.3000  2     0.3166
```

How to interpret
1. isSingular is FALSE, so the intercept-only random structure is estimable.
2. The random slope does not improve fit (chi-square 2.30, df 2, p = 0.32) and AIC is slightly higher. The simpler model is defensible.
3. Write one sentence in the paper: "A random slope for condition by participant did not improve fit (chi-square(2) = 2.30, p = .32) and was not retained."
4. Rule of thumb for the tutor: start from the structure the design justifies (random intercepts for every grouping unit), test slopes for within-unit predictors, simplify only if the model is singular or fails to converge, and report what was done.
5. Do not add a random slope for group by participant. Group varies between participants, so there is nothing to estimate within a participant. This is a frequent error.

---

## 6. Approach C: Report results so that readers can interpret them

Why this matters
Log-odds are hard to read. Reviewers expect odds ratios with confidence intervals, plus a plot or table of predicted probabilities.

```r
# Load packages for tidy tables and prediction plots
library(broom.mixed)                                   # turns mixed-model output into tidy tables
library(ggeffects)                                     # predicted probabilities from the model

# Tidy fixed-effects table with odds ratios and 95% confidence intervals
tidy(m_int,                                            # the fitted model
     effects = "fixed",                                # only the fixed effects
     conf.int = TRUE,                                  # add confidence intervals
     exponentiate = TRUE)                              # convert log-odds to odds ratios

# Predicted probability of a correct answer for each condition-by-group cell
pred <- ggpredict(m_int,                               # the fitted model
                  terms = c("condition", "group"))     # x-axis is condition, separate lines by group

# Print the predicted values
pred                                                   # table of predicted probabilities with intervals

# Plot them
plot(pred)                                             # quick interaction plot
```

Dummy output
```
# A tibble: 4 x 7
  effect term                      estimate std.error statistic p.value conf.low conf.high
1 fixed  (Intercept)                  0.705     0.163    -1.515  0.130     0.449     1.108
2 fixed  conditioneasy                2.460     0.517     4.286  <0.001    1.630     3.713
3 fixed  groupnative                  2.117     0.646     2.459  0.014     1.164     3.850
4 fixed  conditioneasy:groupnative    1.733     0.503     1.897  0.058     0.982     3.060

# Predicted probabilities of correct
condition | group   | Predicted |     95% CI
hard      | learner |      0.41 | 0.31, 0.53
easy      | learner |      0.63 | 0.52, 0.74
hard      | native  |      0.60 | 0.48, 0.71
easy      | native  |      0.87 | 0.79, 0.92
```

How to interpret
1. Odds ratio above 1 means higher odds of a correct answer, below 1 means lower. An odds ratio of 1 means no effect.
2. If the confidence interval for an odds ratio includes 1, the effect is not distinguishable from no effect at the 95 percent level. The interaction interval (0.98 to 3.06) just includes 1, which matches its borderline Wald p-value. This is why the LRT result and the table need to be discussed together and not quoted selectively.
3. For the paper: report the odds ratio, its confidence interval, and the p-value, then give predicted probabilities in a figure or table.
4. Keep terminology exact: say "odds", not "chance" or "likelihood", and never "x times more likely" for odds ratios unless the outcome is rare. Safer wording: "the odds of a correct answer were 2.5 times higher".

---

## 7. Approach D: Check assumptions and diagnostics

Why this matters
Generalised linear mixed models have different diagnostics from ordinary regression. Standard residual plots mislead. DHARMa residuals are the current practical choice.

```r
# Load packages for diagnostics
library(DHARMa)                                        # simulation-based residuals for GLMMs
library(performance)                                   # collinearity and model checks

# Simulate scaled residuals from the fitted model
res <- simulateResiduals(m_int)                        # 250 simulations by default

# Plot QQ and residual-versus-predicted panels
plot(res)                                              # uniform residuals indicate a good fit

# Formal test for overdispersion and zero-inflation style problems
testDispersion(res)                                    # for binary data, overdispersion is rarely a real concern

# Collinearity between predictors (important if more continuous predictors are added)
check_collinearity(m_int)                              # variance inflation factors
```

Dummy output
```
DHARMa nonparametric dispersion test via sd of residuals fitted vs. simulated
data:  simulationOutput
dispersion = 0.99, p-value = 0.88

# Check for Multicollinearity
Term                       VIF   VIF 95% CI  Increased SE  Tolerance
condition                  1.00   [1.00, Inf]         1.00       1.00
group                      1.00   [1.00, Inf]         1.00       1.00
```

How to interpret
1. A dispersion ratio near 1 with a large p-value means no sign of overdispersion.
2. Uniform QQ points on the diagonal and no significant KS, dispersion, or outlier tests mean the model fits acceptably.
3. VIF near 1 means predictors are not entangled. VIF above 5 (some use 10) would signal a problem. Note that VIF will rise for main effects once an interaction is added with uncentred continuous variables, so centre continuous predictors first.
4. In the paper, one sentence is enough: "Model assumptions were checked with simulated residuals (DHARMa); no deviation from uniformity or overdispersion was detected."

---

## 8. Approach E: Wording and reproducibility checklist for the data analysis section

Use this live while reading the student's text.

Model description
- States software and package versions (R version, lme4 version).
- States the exact model formula, including random effects.
- States the family and link function.
- States how categorical predictors were coded (treatment versus sum coding) and the reference levels.
- States how continuous predictors were treated (centred, scaled).

Justification
- Each predictor has a stated rationale.
- The interaction has a theoretical reason and a test (LRT).
- Random effects structure is justified and any simplification is reported.
- Model selection steps are described honestly, including terms that were tested and dropped.

Reporting
- Odds ratios with confidence intervals, not log-odds alone.
- Exact p-values, with the test named (Wald or LRT).
- Predicted probabilities or a figure for any interaction.
- Sample sizes at every level (participants, items, observations).

Transparency
- Data and code availability statement, if the journal asks for it.
- Convergence or singularity warnings reported and handled.

Safe wording examples
- Weak: "The interaction was significant, proving that learners behave differently."
- Better: "The condition-by-group interaction improved model fit (chi-square(1) = 7.40, p = .007). The easy-item advantage was larger for native speakers (OR = 4.26) than for learners (OR = 2.46)."

---

## 9. How to do the equivalent in SPSS

Important limitation: SPSS handles a single binary outcome with crossed random effects (participants and items together) awkwardly. R with lme4 is the better tool. If the student is committed to SPSS, explain the trade-off before anything changes in a paper that is going back for publication.

Menu steps for a mixed-effects logistic model in SPSS
1. Make sure the data are in long format: one row per answer, with columns subject, item, group, condition, correct.
2. Go to Analyze, then Mixed Models, then Generalized Linear.
3. Under Data Structure, put subject in the Subjects box (and item in the Repeated or second block if offered).
4. On the Fields and Effects tab, set Target to correct and choose Binary logistic as the distribution and link.
5. Under Fixed Effects, drag condition and group in. To add the interaction, select both and add them as a "factorial" or "2-way" term.
6. Under Random Effects, add a block with Random Intercept, Subject combination set to subject. Add a second block for item.
7. Under Model Options, tick the box to display odds ratios (exponentiated coefficients).
8. Click Paste rather than Run to see the generated syntax, then run the syntax. Keep the syntax file, as it documents the analysis.
9. To test the interaction, fit the model with and without it and compare the information criteria (AIC) or the -2 log-likelihood values reported in the model summary.

SPSS outputs to read: Fixed Coefficients table (estimates, odds ratios with confidence intervals), Covariance Parameters table (random effect variances), Model Summary (information criteria).

Caveat: the menu steps are from general knowledge of the procedure and have not been checked against the current SPSS version. Verify with the Paste syntax output before advising.

---

## 10. Efficient Q and A list for the session

| What the student asks (or needs) | Answer |
|---|---|
| Is my revised analysis section ready to resubmit? | Not until four things are checked: interaction justified and tested, random effects structure justified, results reported as odds ratios with intervals and predicted probabilities, and diagnostics mentioned. |
| Should the interaction term stay? | Keep it only with a stated theoretical reason and supporting evidence (LRT). Otherwise drop it and report that it was tested. |
| Which test shows if the interaction is needed? | Likelihood ratio test comparing the models with and without it: anova(m_main, m_int). |
| How do I interpret the main effects when an interaction is present? | Do not interpret them alone. Report the effect of each predictor within each level of the other (emmeans). |
| What does the coefficient mean? | It is a change in log-odds. Exponentiate to get an odds ratio, and report predicted probabilities for readability. |
| My model gave a singular fit or convergence warning. | Check isSingular(), simplify the random effects, try the bobyqa optimiser or allFit(), and report what you did. |
| Do I need random slopes? | Test slopes for within-unit predictors only. Report the comparison. Never add a slope for a between-unit predictor. |
| How do I check the model fits? | DHARMa simulated residuals and a dispersion test. One sentence in the paper is enough. |
| How do I describe this for reviewers? | State software and versions, formula, family, coding of predictors, justification for each term, test used, and sample sizes at each level. |
| Can I do this in SPSS instead? | Possible via Generalized Linear Mixed Models, but crossed random effects are awkward. R is safer for this design. |

---

## 11. Notes for the tutor (not for the student)

- Ask for the revised text and script first and map the student's actual model onto the examples above.
- All numerical output above is dummy output written to illustrate interpretation. It is not from a real run and will not reproduce exactly. To get exact numbers, run the simulation code once in R.
- A tutor explains and checks. The student's supervisor and the journal's statistical guidance remain the final authority on the analysis plan.
