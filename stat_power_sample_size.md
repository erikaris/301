
# Power and Sample Size Tutorial (No Pilot Data)

This guide updates the previous tutorial for a scenario where the student has no pilot data but provides an estimated effect size (e.g., Cohen’s d = 0.5, medium effect) from literature or assumptions. We assume a two-sample t-test (e.g., comparing treatment vs. control means) with alpha = 0.05, power = 0.8, two-sided test.

## Option 1: Using R
### Step 1: Install and Load `pwr` Package
```R
install.packages("pwr")  # Run once
library(pwr)
```

### Step 2: Calculate Sample Size
For effect size = 0.5, power = 0.8, alpha = 0.05:
```R
effect_size <- 0.5
alpha <- 0.05
power <- 0.8

result <- pwr.t.test(d = effect_size, sig.level = alpha, power = power, type = "two.sample", alternative = "two.sided")
print(result)
```
**Output**: ~64 samples per group (total N ≈ 128).

### Step 3: Calculate Power for Fixed N
For N = 20 per group:
```R
effect_size <- 0.5
n_per_group <- 20
alpha <- 0.05

power_result <- pwr.t.test(d = effect_size, n = n_per_group, sig.level = alpha, type = "two.sample", alternative = "two.sided")
print(power_result)
```
**Output**: Power ≈ 0.48 (underpowered).

**Note**: Explain that N = 20 is too small for a medium effect. Suggest increasing N or checking if a larger effect is plausible.

## Option 2: Using SPSS
### Step 1: Open Power Analysis
- **Analyze** > **Power Analysis** > **Means** > **Independent Samples T-Test** (or use syntax if unavailable).

### Step 2: Calculate Sample Size
- Select **Sample Size**.
- Enter:
  - Effect size = 0.5.
  - Alpha = 0.05.
  - Power = 0.8.
  - Two-tailed.
  - Equal groups (1:1).
- **Output**: ~64 samples per group (total N ≈ 128).

### Step 3: Calculate Power
- Select **Power**.
- Enter:
  - Effect size = 0.5.
  - Sample size per group = 20.
  - Alpha = 0.05.
  - Two-tailed.
- **Output**: Power ≈ 0.48.

**Note**: If no Power Analysis module, use syntax:
```spss
POWER TTEST
  /MEANS DIFF=5 SD=10  /* Effect size = 5/10 = 0.5 */
  /TEST=INDEPENDENT
  /SIGLEVEL=0.05
  /POWER=0.8
  /TAIL=TWO.
```

## Option 3: Using G*Power
### Step 1: Set Up
- Open G*Power (download: http://www.gpower.hhu.de/).
- Select **t tests** > **Means: Difference between two independent means** > **A priori**.

### Step 2: Calculate Sample Size
- Enter:
  - Effect size d = 0.5.
  - Alpha = 0.05.
  - Power = 0.8.
  - Allocation ratio = 1.
  - Two-tailed.
- Click **Calculate**.
- **Output**: Total N ≈ 128 (64 per group).

### Step 3: Calculate Power
- Change to **Post hoc**.
- Enter:
  - Effect size d = 0.5.
  - Alpha = 0.05.
  - Sample size group 1 = 20, group 2 = 20.
  - Two-tailed.
- **Output**: Power ≈ 0.48.

**Note**: Use G*Power’s effect size calculator if she brings raw means/SDs (e.g., mean difference = 5, SD = 10 → d = 0.5).


