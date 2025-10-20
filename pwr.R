library(pwr)
# Estimated d (no pilot data)
effect_size <- 0.5  # Medium effect, decided upfront
alpha <- 0.05       # Chosen upfront
power <- 0.8        # Chosen upfront
result <- pwr.t.test(d = effect_size, sig.level = alpha, power = power, type = "two.sample", alternative = "two.sided")
print(result)  # ~64 per group
