# 1. CORRELATION

## what it is

correlation measures the **strength and direction of a relationship** between two variables

it answers: 
> do these two variables move together

**examples of variables**
1. study hours and exam score
2. temperature and ice cream sales
3. machine speed and production output
4. advertising spend and sales revenue

---

## types of correlation by direction

1. positive → both increase together
example
study hours ↑ → exam score ↑

2. negative → one increases, the other decreases
example
speed ↑ → time ↓

3. zero → no relationship
example
shoe size and exam score

---

## types of correlation by method 

### pearson → for continuous, normally distributed data

$$r = \frac{\sum (x - \bar{x})(y - \bar{y})}{\sqrt{\sum (x - \bar{x})^2 \sum (y - \bar{y})^2}}$$

**intuition**
uses actual values and distances from mean

**example**
height and weight

---

### spearman → for ordinal or non-normal data

$$r_s = 1 - \frac{6 \sum d^2}{n(n^2 - 1)}$$

---

## spearman case example

| student | hours rank | score rank | d  | d² |
| ------- | ---------- | ---------- | -- | -- |
| A       | 1          | 2          | -1 | 1  |
| B       | 2          | 1          | 1  | 1  |
| C       | 3          | 3          | 0  | 0  |

$$Σd² = 2$$ → imperfect correlation

**teaching point**
bigger rank differences → weaker relationship

---

### kendall → for ordinal data, based on pairwise agreement

$$\tau = \frac{C - D}{\frac{1}{2}n(n-1)}$$

---

## kendall case examples

### example 1 (perfect positive)

| student | hours | score |
| ------- | ----- | ----- |
| A       | 5     | 80    |
| B       | 3     | 60    |
| C       | 4     | 70    |

all pairs agree
C = 3, D = 0 → τ = 1

---

### example 2 (perfect negative)

| student | hours | score |
| ------- | ----- | ----- |
| A       | 5     | 60    |
| B       | 3     | 80    |
| C       | 4     | 70    |

all pairs disagree
C = 0, D = 3 → τ = −1

---

### example 3 (mixed — THIS IS THE IMPORTANT ONE)

| student | hours | score |
| ------- | ----- | ----- |
| A       | 5     | 80    |
| B       | 3     | 70    |
| C       | 4     | 60    |

check pairs

A vs B → 5 > 3 and 80 > 70 → concordant
A vs C → 5 > 4 and 80 > 60 → concordant
B vs C → 3 < 4 and 70 > 60 → discordant

so
C = 2
D = 1

total pairs = 3

$$τ = (2 − 1) / 3 = 0.33$$

---

## interpretation of mixed case

some pairs agree, some don’t
→ moderate positive relationship

---

## similarity between spearman and kendall

both non-parametric
both use order
both for ordinal data

---

## key difference

spearman
→ uses rank differences

kendall
→ uses pairwise agreement

---

## why kendall is less common

harder to explain
similar results to spearman
less intuitive for beginners

---

## when to use correlation

two variables
interested in relationship, not causation

---

## how to do it

**in SPSS**
analyze → correlate → bivariate

**in R**

```r
cor.test(x, y, method = "pearson")
cor.test(x, y, method = "spearman")
cor.test(x, y, method = "kendall")
```

---

## how to interpret

direction
strength
significance

---

## key teaching point

correlation ≠ causation

---

# 2. REGRESSION

## what it is

models how one variable predicts another

---

## formula

$$genui{"math_block_widget_always_prefetch_v2":{"content":"y = a + bx"}}$$

---

## example

study hours vs exam score

y = 40 + 5x

---

## interpretation

each extra hour → +5 marks

---

## relationship with correlation

correlation → relationship
regression → prediction

---

# 3. HYPOTHESIS TESTING

## what it is

tests if results are statistically reliable

---

## correlation test

tests if r ≠ 0

---

## regression test

tests if slope ≠ 0

---

## example

r = 0.6, p = 0.2 → not significant

---

# 4. CRITICAL CONCEPT

strength vs significance

---

## example

r = 0.7, n = 5 → not significant
r = 0.3, n = 300 → significant

---

# 5. CORE INSIGHT

pearson → values
spearman → ranks
kendall → pairs

---

# 6. ONE-LINE SUMMARY

correlation measures relationships, regression predicts outcomes, and hypothesis testing tells you whether results are reliable

---

This version now gives you:

* **perfect positive**
* **perfect negative**
* **realistic mixed case**

which is exactly what students need to *actually understand Kendall*.

If you want next step, I can turn just the Kendall section into a **2-minute board walkthrough script** — very powerful in tutoring.
