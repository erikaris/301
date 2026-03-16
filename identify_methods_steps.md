# Steps in Identifying which methods to use

## 1. Clarify the research
> “Once we identify your research question and the types of variables you have, it becomes much easier to choose the right statistical method.”

1. **What is your research question or hypothesis?**
2. **What data are you collecting?** (survey, interviews coded into numbers, usage data, etc.)
3. **What are your main variables?**
   * Outcome / dependent variable
   * Predictor / independent variables
4. **What type of data are they?**
   * categorical (e.g., gender, department)
   * ordinal (Likert scale)
   * continuous (scores, counts)
   * Is your outcome variable **numeric or categorical**?
6. Are you **comparing groups** or **looking for relationships**?
   * **How many groups or variables are being compared?**
7. How many **participants/samples** do you expect/have?
8. What software are you planning to use? (e.g., SPSS, R, Excel)

---

## 2. Quick method guide (what usually appears in dissertations)

Check this [decision tree](https://raw.githubusercontent.com/erikaris/301/96fc1bd6ef6dd9c62719688497119e8e06c2eb40/stats_key.svg). 

### A. Comparing groups

If they want to see **differences between groups** and your DV is **normally distributed**:

| Situation | Method     |
| --------- | ---------- |
| 2 groups  | **t-test** |
| 3+ groups | **ANOVA**  |

Example:
Library training **vs** no training → effect on digital literacy score.

---

### B. Relationship between variables

If they want to see **whether variables are related**:

| Situation                          | Method                             |
| ---------------------------------- | ---------------------------------- |
| two numeric variables              | **Correlation (Pearson/Spearman)** |
| predicting outcome from predictors | **Regression**                     |

Example:
Digital resource usage → research productivity.

---

### C. Association between categorical variables

If variables are **categories**:

| Situation                 | Method              |
| ------------------------- | ------------------- |
| two categorical variables | **Chi-square test** |

Example:
Department × Preferred information source.

---

## 3. Common dissertation workflow

The **typical analysis pipeline**:
> “Most dissertations start with descriptive statistics, then move to one main inferential test depending on the research question.”

1. **Descriptive statistics**
   * mean
   * frequency
   * standard deviation
2. **Check assumptions / data**
3. **Run main test**
   * t-test / ANOVA / correlation / regression
4. **Report results**

---

## 5. If still in doubt: 

Suggested actions:
* Bring **sample dataset or questionnaire** next time
* Check methods used in **similar dissertations**

---

# Some Examples:

---

## 1. Comparing two groups → **t-test**

**Example research question:**
“Does attending library information literacy training improve students’ confidence in using academic databases?”

**Variables**

* Independent variable: training attendance (attended / not attended)
* Dependent variable: confidence score (Likert scale or numeric score)

**Method**

* **Independent samples t-test**

You can say:

> “Since we’re comparing the mean score between two groups, a t-test could work.”

---

## 2. Comparing several groups → **ANOVA**

**Example research question:**
“Does digital resource usage differ across academic disciplines?”

**Variables**

* Independent variable: discipline (Arts / Science / Engineering / etc.)
* Dependent variable: number of digital resources used per week

**Method**

* **One-way ANOVA**

You can say:

> “Because there are more than two groups, ANOVA is often used to compare the averages.”

---

## 3. Relationship between two variables → **Correlation**

**Example research question:**
“Is there a relationship between frequency of library database use and research productivity?”

**Variables**

* Database usage frequency
* Number of publications / research output score

**Method**

* **Correlation**

  * Pearson (continuous variables)
  * Spearman (ordinal or non-normal data)

You can say:

> “If we’re interested in whether two variables move together rather than comparing groups, correlation might be appropriate.”

---

## 4. Predicting an outcome → **Regression**

**Example research question:**
“What factors predict postgraduate students’ satisfaction with digital library services?”

**Variables**

* Dependent variable: satisfaction score
* Predictors: usability, access speed, training, support quality

**Method**

* **Multiple linear regression**

You can explain:

> “Regression is useful when we want to see how several variables predict an outcome.”

---

## 5. Relationship between categorical variables → **Chi-square**

> The Chi-square test of independence tests whether **two categorical variables** are related.

**Example research question:**
“Is preferred information source associated with students’ level of study?”

**Variables**

* Level of study (undergraduate / postgraduate)
* Preferred source (books / databases / Google Scholar)

**Method**

* **Chi-square test of independence**

---

## 6. Likert-scale survey dissertations

Typical workflow:

1. Descriptive statistics
   * mean
   * frequency
2. Reliability check (sometimes **Cronbach’s alpha**)
3. Main analysis:
   * **t-test / ANOVA** (group comparison)
   * **correlation / regression** (relationships)

---





