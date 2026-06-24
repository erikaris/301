## =========================================================
## MASH tutoring prep — Eleanor (MBChB Y3)
## Dummy data mimicking Pima Diabetes dataset structure
## =========================================================

set.seed(42)
n <- 200
diabetes_data <- data.frame(
  Pregnancies   = rpois(n, 3),
  Glucose       = rnorm(n, 120, 30),
  BloodPressure = rnorm(n, 70, 12),
  SkinThickness = rnorm(n, 25, 10),
  Insulin       = rnorm(n, 80, 40),
  BMI           = rnorm(n, 32, 6),
  Age           = round(runif(n, 21, 65)),
  Outcome       = rbinom(n, 1, 0.35)   # 0 = no diabetes, 1 = diabetes
)
diabetes_data$BMI <- diabetes_data$BMI + 0.15*diabetes_data$SkinThickness +
  3*diabetes_data$Outcome + rnorm(n, 0, 3)  # build in a real relationship

## ---------------------------------------------------------
## Appt 1: import, dimensions, pairs() coloured by Outcome
## ---------------------------------------------------------
dim(diabetes_data)
pairs(diabetes_data[ , !(names(diabetes_data) %in% "Outcome")],
      col = ifelse(diabetes_data$Outcome == 1, "red", "blue"),
      main = "Pairwise scatterplots coloured by diabetes status")

## ---------------------------------------------------------
## Appt 3: simple linear model, BMI ~ SkinThickness
## ---------------------------------------------------------
model_simple <- lm(BMI ~ SkinThickness, data = diabetes_data)
summary(model_simple)

plot(diabetes_data$SkinThickness, diabetes_data$BMI,
     xlab = "Skin Thickness", ylab = "BMI",
     main = "BMI vs Skin Thickness")
abline(model_simple, col = "darkgreen", lwd = 2)

## ---------------------------------------------------------
## Appt 4: multiple linear regression, R^2 vs adj R^2,
##         factor / binary predictors
## ---------------------------------------------------------
diabetes_data$Outcome_factor <- factor(diabetes_data$Outcome,
                                        labels = c("No Diabetes", "Diabetes"))

model_multi <- lm(BMI ~ SkinThickness + Age + Outcome_factor,
                   data = diabetes_data)
summary(model_multi)   # compare Multiple R-squared vs Adjusted R-squared

## ---------------------------------------------------------
## Appt 5 / TODAY: subset by diabetes status, separate fits,
##         compare R^2, then add diabetes as a predictor
## ---------------------------------------------------------
no_diabetes  <- subset(diabetes_data, Outcome == 0)
yes_diabetes <- subset(diabetes_data, Outcome == 1)

fit_no  <- lm(BMI ~ SkinThickness, data = no_diabetes)
fit_yes <- lm(BMI ~ SkinThickness, data = yes_diabetes)

summary(fit_no)$r.squared
summary(fit_yes)$r.squared

plot(diabetes_data$SkinThickness, diabetes_data$BMI,
     col = ifelse(diabetes_data$Outcome == 1, "red", "blue"),
     xlab = "Skin Thickness", ylab = "BMI",
     main = "Separate regression lines by diabetes status")
abline(fit_no,  col = "blue", lwd = 2)
abline(fit_yes, col = "red",  lwd = 2)
legend("topleft", legend = c("No Diabetes", "Diabetes"),
       col = c("blue", "red"), lwd = 2)

## Diabetes status as an ADDITIVE predictor (same slope, different intercept)
model_additive <- lm(BMI ~ SkinThickness + Outcome_factor, data = diabetes_data)
summary(model_additive)

## ---------------------------------------------------------
## LIKELY NEXT QUESTION TODAY: do the slopes actually differ?
## -> Interaction term (different slope AND intercept per group)
## ---------------------------------------------------------
model_interaction <- lm(BMI ~ SkinThickness * Outcome_factor, data = diabetes_data)
summary(model_interaction)

## Formal test: does adding the interaction improve the model?
anova(model_additive, model_interaction)

## Visual: interaction model reproduces the two separate-fit lines
## (compare model_interaction coefficients to fit_no / fit_yes coefficients)

## ---------------------------------------------------------
## ALSO STILL OUTSTANDING (flagged after Appt 4): binary DV
## i.e. logistic regression, Outcome ~ predictors
## ---------------------------------------------------------
model_logistic <- glm(Outcome ~ BMI + Age + SkinThickness,
                       data = diabetes_data, family = binomial)
summary(model_logistic)
exp(coef(model_logistic))  # odds ratios, often the more intuitive interpretation for clinicians
