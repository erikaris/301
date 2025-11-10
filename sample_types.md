# Summary of Sample Types

| **Sample Type**                           | **Key Idea**                                                          | **Independence?**      | **Typical Analyses**                                            | **Examples (4–5 from different fields)**                                                                                                                                                                                                                                                                                                                            |
| ----------------------------------------- | --------------------------------------------------------------------- | ---------------------- | --------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **1. Simple Random Sample**               | Each observation is independent and equally likely to be chosen       | ✅ Yes                  | t-test, ANOVA, regression, correlation                          | 🧬 Biosciences: Randomly select 30 plants and measure leaf area. <br> 🧫 Medicine: Randomly select 100 blood samples for cholesterol testing. <br> 🎓 Education: Randomly pick 50 students to assess math scores. <br> 🌍 Environmental science: Randomly sample 20 soil plots for pH. <br> 💼 Economics: Randomly survey 200 households on spending habits.        |
| **2. Paired / Matched Samples**           | Two linked observations per subject (before–after, matched pairs)     | ❌ No                   | Paired t-test, Wilcoxon signed-rank test                        | 🧬 Medicine: Blood pressure measured before and after drug. <br> 🧠 Psychology: Reaction time before vs after caffeine intake. <br> 🌿 Agriculture: Crop yield on two adjacent plots with fertilizers A and B. <br> 🎓 Education: Students’ test scores before and after tutoring program. <br> 🧍‍♂️ Human biology: Weight before and after exercise intervention. |
| **3. Repeated Measures Sample**           | Same unit measured ≥3 times (often over time or conditions)           | ❌ No                   | Repeated-measures ANOVA, linear mixed model                     | 🌿 Biosciences: Measure plant growth weekly for 8 weeks. <br> 🧠 Psychology: Measure stress under 4 task difficulties. <br> 🧫 Medicine: Monitor blood glucose at 5 time points post-meal. <br> 🌍 Ecology: Measure air quality daily at one location. <br> 🎓 Education: Record student performance at 3 term exams.                                               |
| **4. Clustered Sample**                   | Observations grouped by source (cluster); within-group correlation    | ❌ No                   | Mixed-effects models, cluster-robust SEs                        | 🌿 Biosciences: 5 leaves sampled from each of 10 plants. <br> 🧬 Medicine: Patients nested within hospitals. <br> 🎓 Education: Students nested within schools or classes. <br> 🌍 Environmental science: Multiple soil samples per site. <br> 💼 Business: Employees nested within companies.                                                                      |
| **5. Stratified Sample**                  | Population divided into strata (subgroups); sample drawn from each    | ✅ Within strata        | Weighted means, stratified estimation                           | 🧬 Public health: Sample by age group (18–30, 31–50, 51+). <br> 🌍 Ecology: Equal number of samples from forest, grassland, and desert. <br> 🎓 Education: Sample students by major or gender. <br> 💼 Market research: Customers sampled by region (North, South, East, West). <br> 🗳️ Politics: Voter survey stratified by political affiliation.                |
| **6. Multistage / Hierarchical Sample**   | Sampling occurs in multiple stages (e.g., region → site → individual) | ❌ No                   | Multilevel / hierarchical models, survey-weighted analysis      | 🎓 Education: Select schools → classes → students. <br> 🌍 Ecology: Select regions → sites → trees. <br> 🏥 Public health: Select hospitals → wards → patients. <br> 🏠 Demography: Select cities → neighborhoods → households. <br> 💼 Marketing: Select stores → product aisles → customer purchases.                                                             |
| **7. Systematic Sample**                  | Select every *kth* element from an ordered list or sequence           | ✅ (if no pattern bias) | Descriptive or inferential stats, control charting              | 🧬 Manufacturing: Test every 10th product off the assembly line. <br> 🌿 Ecology: Sample every 10 meters along a transect. <br> 🧠 Psychology: Choose every 5th volunteer entering the lab. <br> 💼 Business: Survey every 20th customer transaction. <br> 🏥 Medicine: Record every 3rd patient entering clinic.                                                   |
| **8. Convenience / Opportunistic Sample** | Samples chosen for accessibility or ease; not random                  | ⚠️ Often biased        | Descriptive, exploratory, pilot studies                         | 🧠 Psychology: University student volunteers in experiments. <br> 🌿 Ecology: Plants sampled near easily accessible paths. <br> 💼 Marketing: Online survey open to social media followers. <br> 🏥 Public health: Screening attendees at a free clinic. <br> 🎓 Education: Students from one class used as study sample.                                           |
| **9. Panel / Longitudinal Sample**        | Same units followed over multiple long-term periods                   | ❌ No                   | Longitudinal mixed models, time-series cross-sectional analysis | 💼 Economics: Firms tracked yearly for 10 years. <br> 🧬 Public health: Patients followed over 5 years for weight changes. <br> 🎓 Education: Same students followed from age 5 to 18. <br> 🌍 Ecology: Tagged birds monitored over migration seasons. <br> 🗳️ Sociology: Households surveyed annually in national panel.                                          |

---

# 🌸 Key Takeaways

| Concept                     | Meaning                                                                             |
| --------------------------- | ----------------------------------------------------------------------------------- |
| **Independent samples**     | Observations are unrelated (Simple random, Stratified, Systematic).                 |
| **Dependent samples**       | Observations share subjects or sources (Paired, Repeated, Clustered, Longitudinal). |
| **Hierarchical structures** | Data have multiple dependency levels (Multistage, Clustered, Repeated).             |
| **Non-probability samples** | Convenience samples, volunteer samples — easy but biased.                           |

---

## 🌺 Tutor Tip: How to teach this visually

You can sketch this hierarchy for students:

```
                 ┌──────────────────────┐
                 │     Samples          │
                 └──────────────────────┘
                           │
       ┌───────────────────┴────────────────────┐
       │                                        │
 Independent Samples                    Dependent Samples
(Simple, Stratified, Systematic)   (Paired, Repeated, Clustered, Longitudinal)
```

Then show how **Multistage** overlaps both (independent between stages, dependent within clusters).

---

Would you like me to make this table + diagram into a **visual PDF cheat sheet** (great for quick tutoring reference or student handouts)?
It would include icons, short definitions, and field-specific examples all in one page.
