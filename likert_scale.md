# Analysing Likert Scale

## Typical Workflow:

1. Descriptive statistics
   * mean
   * frequency
2. Reliability check (sometimes **Cronbach’s alpha**)
3. Main analysis:
   * **t-test / ANOVA** (group comparison)
   * **correlation / regression** (relationships)

---

## Case Example for Likert Scale

**Research question:**

> What factors influence students’ satisfaction with university digital library services?

---

### 1. Data collection (Likert survey)

Students answer several statements using a **1–5 Likert scale**
(1 = strongly disagree, 5 = strongly agree).

Example items measuring **digital library usability**:

| Item | Statement                               |
| ---- | --------------------------------------- |
| U1   | The library website is easy to navigate |
| U2   | It is easy to find the resources I need |
| U3   | The search system works efficiently     |
| U4   | Accessing databases is straightforward  |

Example items measuring **satisfaction**:

| Item | Statement                                        |
| ---- | ------------------------------------------------ |
| S1   | I am satisfied with the digital library services |
| S2   | The digital resources meet my academic needs     |
| S3   | I would recommend these services to others       |

Other variables collected:

* **Gender**
* **Level of study** (UG / PG)
* **Frequency of library use**

---

### 2. Descriptive statistics

First step: describe the data.

Example outputs:

| Variable           | Mean | SD   |
| ------------------ | ---- | ---- |
| Usability score    | 3.9  | 0.72 |
| Satisfaction score | 4.1  | 0.68 |

Also frequencies:

| Gender | Frequency |
| ------ | --------- |
| Female | 120       |
| Male   | 80        |

Purpose:

* understand the dataset
* summarise responses

---

### 3. Reliability analysis

Because **usability** is measured with multiple items (U1–U4), we check internal consistency using **Cronbach's alpha**.

Example result:

> Cronbach’s α = 0.87

Interpretation:

> The usability scale showed good internal reliability.

Then the researcher **creates a scale score**:

```
Usability score = mean(U1, U2, U3, U4)
```

#### 3a. about cronbach's alpha:
**Cronbach's alpha** measures **internal consistency**, which means:

> **How well several survey questions measure the same underlying concept.**

Simple example:

You want to measure **library satisfaction**, so you ask:

* “I am satisfied with the library services.”
* “The library meets my academic needs.”
* “I would recommend the library to others.”

If people who agree with one statement **also tend to agree with the others**, the items are consistent.

Cronbach’s alpha checks **how strongly these items move together**.

**Interpretation (rough guide):**

| Alpha   | Meaning          |
| ------- | ---------------- |
| < 0.6   | poor consistency |
| 0.7–0.8 | acceptable       |
| 0.8–0.9 | good             |

---

## 4. Main analysis examples

### A. Group comparison → t-test

Research question:

> Do postgraduate students report higher satisfaction than undergraduate students?

Variables:

* IV: Level of study (UG vs PG)
* DV: Satisfaction score

Method:

* **Independent samples t-test**

Example result:

> Postgraduate students reported significantly higher satisfaction than undergraduate students (t(198)=2.45, p=0.015).

---

## B. Multiple groups → ANOVA

Research question:

> Does satisfaction differ depending on frequency of library use?

Variable:

* Rarely
* Monthly
* Weekly
* Daily

Method:

* **ANOVA**

Interpretation:

> Satisfaction differed significantly across usage frequency groups.

---

## C. Relationship → correlation

Research question:

> Is perceived usability related to satisfaction?

Variables:

* usability score
* satisfaction score

Method:

* **Spearman's rank correlation coefficient** (often used for Likert-scale data)

Example result:

> There was a strong positive correlation between usability and satisfaction (ρ = .62, p < .001).

Interpretation:

> Higher perceived usability is associated with higher satisfaction.

---

## D. Prediction → regression

Research question:

> Which factors predict satisfaction with digital library services?

Predictors:

* usability
* frequency of use
* training attendance

Method:

* **Multiple regression**

Example result:

> Usability was the strongest predictor of satisfaction (β = .54, p < .001).

---

# 5. Typical dissertation structure

Students often follow this order:

1. **Descriptive statistics**
2. **Reliability test**
3. **Create scale variables**
4. **Run main statistical tests**

Example final model:

```
Usability → Satisfaction
Frequency of use → Satisfaction
Training attendance → Satisfaction
```

---
