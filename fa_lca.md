# Factor Analysis vs Latent Class Analysis

| Feature               | Factor Analysis                   | Latent Class Analysis                      |
| --------------------- | --------------------------------- | ------------------------------------------ |
| What is being grouped | Variables/items                   | People/respondents                         |
| Latent variable       | Continuous factor/trait           | Categorical class/type                     |
| Output                | Factor scores for each person     | Class membership for each person           |
| Use case              | Reduce items, identify dimensions | Identify subtypes/groups in the population |

- Factor Analysis (FA) can be used to identify underlying continuous dimensions in questionnaire items. For example, FA can show whether the items can be clustered into meaningful factors such as “restrictive eating,” “binge behavior,” or “food-related anxiety.” This helps reduce the number of items, ensure the questionnaire measures distinct constructs, and generate factor scores that can be used as **predictors** in the logistic regression.
Essentially, FA helps answer: *“How much does each person exhibit each latent trait?”*

- Latent Class Analysis (LCA) can be used to identify distinct subgroups of respondents who share similar response patterns across the questionnaire. For example, LCA might reveal classes such as “restrictive/anxious type” or “binge-purge type.” These classes can be used as **categorical predictors** in logistic regression if the theoretical model suggests different autism risk profiles across types. 
LCA helps answer: *“What type of respondent is this person?”*
