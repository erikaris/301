# ============================================================
# Mediation Analysis Example: Stress → Sleep → Memory
# ============================================================
# This script demonstrates a simple mediation analysis in R.
# We simulate a psychology case study where:
# X = Stress level (independent variable)
# M = Sleep hours (mediator)
# Y = Memory score (dependent variable)
# The goal is to see if the effect of stress on memory is mediated by sleep.
# ============================================================

# ---------------------------
# Step 0: Install and load packages
# ---------------------------
# Uncomment the following line if 'mediation' package is not installed
# install.packages("mediation")
library(mediation)

# Optional: for visualization
# install.packages("ggplot2")
library(ggplot2)

# ---------------------------
# Step 1: Simulate data
# ---------------------------
set.seed(123) # for reproducibility
n <- 100      # sample size

# Independent variable: Stress
stress <- rnorm(n, mean = 5, sd = 2)

# Mediator: Sleep (hours), negatively affected by stress
sleep <- 8 - 0.5 * stress + rnorm(n, sd = 1)

# Dependent variable: Memory score, influenced by both stress and sleep
memory <- 50 + 2 * sleep - 1 * stress + rnorm(n, sd = 5)

# Combine into a data frame
data <- data.frame(stress, sleep, memory)

# Quick view of data
head(data)

# ---------------------------
# Step 2: Fit regression models
# ---------------------------

# 2a: Mediator model: M ~ X
# This estimates path 'a' (effect of stress on sleep)
med.fit <- lm(sleep ~ stress, data = data)
summary(med.fit)

# 2b: Outcome model: Y ~ X + M
# This estimates path 'b' (effect of sleep on memory controlling for stress)
# and path 'c prime' (direct effect of stress on memory controlling for sleep)
out.fit <- lm(memory ~ stress + sleep, data = data)
summary(out.fit)

# ---------------------------
# Step 3: Conduct mediation analysis
# ---------------------------
# Using the 'mediate' function to calculate:
# ACME = average causal mediation effect (indirect effect)
# ADE = average direct effect (direct effect)
# Total effect = ACME + ADE
# Bootstrapping used for significance testing
med.out <- mediate(
  model.m = med.fit, 
  model.y = out.fit, 
  treat = "stress", 
  mediator = "sleep", 
  boot = TRUE, 
  sims = 5000
)

# View results
summary(med.out)

# ---------------------------
# Step 4: Interpretation (as comments)
# ---------------------------
# ACME: effect of stress on memory through sleep (indirect effect)
# ADE: effect of stress on memory not through sleep (direct effect)
# Total effect: sum of indirect and direct effects
# Prop. mediated: proportion of total effect explained by the mediator

# ---------------------------
# Step 5: Optional Visualization
# ---------------------------
ggplot(data, aes(x = stress, y = memory)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  labs(
    title = "Scatterplot: Stress vs Memory",
    x = "Stress Level",
    y = "Memory Score"
  )
