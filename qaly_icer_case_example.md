This is a real exam question. Let me work through it fully, step by step.

---

## Setting up the two arms

You are comparing **no vaccination** (comparator) versus **vaccination** (new intervention) across a population of **100 people** over **1 year (52 weeks)**.

---

## Arm 1: No Vaccination (100 people)

**5 out of 100 contract the virus.** Each spends 1 week in hospital and 4 weeks recovering.

**Costs:**

| Resource | Calculation | Cost |
|---|---|---|
| Hospital (5 people, 7 days each) | 5 × 7 × £550 | £19,250 |
| **Total** | | **£19,250** |

**QALYs** — the sick person's year looks like this:

| Period | Weeks | Utility | QALYs |
|---|---|---|---|
| Inpatient stay | 1 | 0.4 | 1/52 × 0.4 = 0.00769 |
| Recovery | 4 | 0.8 | 4/52 × 0.8 = 0.06154 |
| Full health | 47 | 1.0 | 47/52 × 1.0 = 0.90385 |
| **Total per sick person** | | | **0.97308** |

Total QALYs (no vaccination):
- 5 sick people: 5 × 0.97308 = **4.8654**
- 95 healthy people: 95 × 1.0 = **95.0**
- **Total = 99.8654 QALYs**

---

## Arm 2: Vaccination (100 people)

Vaccine is 100% effective → **zero people get the virus.**
0.5% experience a side effect → **0.5 people** get 1 extra GP visit, 1 week at utility 0.9.

**Costs:**

| Resource | Calculation | Cost |
|---|---|---|
| Vaccine (100 people) | 100 × £3 | £300 |
| Practice nurse (100 people) | 100 × £40 | £4,000 |
| GP visit for side effect (0.5 people) | 0.5 × £50 | £25 |
| **Total** | | **£4,325** |

**QALYs:**

| Period | Weeks | Utility | QALYs |
|---|---|---|---|
| Side effect week | 1 | 0.9 | 1/52 × 0.9 = 0.01731 |
| Rest of year | 51 | 1.0 | 51/52 × 1.0 = 0.98077 |
| **Total per affected person** | | | **0.99808** |

Total QALYs (vaccination):
- 0.5 people with side effect: 0.5 × 0.99808 = **0.49904**
- 99.5 unaffected: 99.5 × 1.0 = **99.5**
- **Total = 99.99904 QALYs**

---

## Part a: Calculate the ICER

| | No vaccination | Vaccination | Incremental |
|---|---|---|---|
| Total cost | £19,250 | £4,325 | **-£14,925** |
| Total QALYs | 99.8654 | 99.9990 | **+0.1337** |

$$\text{ICER} = \frac{\Delta\text{Cost}}{\Delta\text{Effect}} = \frac{-£14{,}925}{0.1337} = \mathbf{-£111{,}}633 \text{ per QALY}$$

**Interpretation:** The ICER is **negative** — vaccination sits in the **bottom-right (dominant) quadrant**. It is simultaneously cheaper (saves £14,925 per 100 people) and more effective (+0.1337 QALYs). The vaccination programme should be adopted without needing to compare to the NICE threshold. This is the best possible outcome in economic evaluation.

---

## Part b: At what vaccine price does the ICER exceed £35,000?

Let **P** = new vaccine price per person. Only the vaccine cost changes. Everything else stays the same.

New total vaccination cost = 100P + £4,000 + £25 = 100P + £4,025

New ΔCost = (100P + £4,025) − £19,250 = 100P − £15,225

Set ICER = £35,000 and solve:

$$\frac{100P - £15{,}225}{0.1337} = £35{,}000$$

$$100P - £15{,}225 = £35{,}000 \times 0.1337 = £4{,}678$$

$$100P = £15{,}225 + £4{,}678 = £19{,}903$$

$$\boxed{P = £199.03}$$

**Interpretation:** The vaccine price would need to rise from £3 all the way to **£199.03** before the programme stops being cost-effective at the £35,000 threshold. This confirms the vaccination is extremely robust — even at a price 66 times higher, it would still be at the threshold boundary.

---

Your student's handwritten note (P = 199.03) is exactly right.
