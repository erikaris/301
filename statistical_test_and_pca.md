# Choosing the right statistical approach and PCA (Biodiversity case example)

## Your research, in two questions

1. Do background factors (age, gender, education, wellbeing) relate to how people respond to green space?
2. How important are visual/sound/smell traits in driving aesthetic and emotional responses?

---

## Question 1: from separate tests to one combined model

> Q1: 1) Is there a relationship between participants’ underlying socio-cultural factors and background mental wellbeing and aesthetic/affective responses in urban green spaces? 

### What you've done
Several separate tests: wellbeing vs gender, wellbeing vs age, wellbeing vs education.

### The issue
Each test only looks at two variables at a time. None of them show how the factors work *together*, and running lots of separate tests increases the risk of finding a "significant" result purely by chance.

**Analogy:** imagine trying to work out what determines a plant's height by testing sunlight alone, then water alone, then soil alone — three separate experiments. You'd miss the fact that sunlight only matters *if* there's enough water. A single experiment varying all three at once tells you much more.

### The fix: multiple regression

Instead of:
- wellbeing vs gender
- wellbeing vs age
- wellbeing vs education

Run one model:

> **Response to green space = age + gender + education + wellbeing**

This tells you, in one go:
- Which factors actually matter once you account for the others
- Whether any factors interact (e.g. maybe wellbeing only predicts response for younger participants)
- One clean, defensible model instead of several to explain

**Case example:** a study on park satisfaction might find that age alone looks significant in a simple test, but in a combined regression with income and education included, age stops mattering — it was really income doing the work, and age was just correlated with it. Separate tests would have missed this.

### Question to clarify with your supervisor/yourself
Is wellbeing the thing you're trying to explain (an outcome), or is it one of the explanatory factors (a predictor) for aesthetic/affective response? This changes how the model should be built.

---

## Question 2: from PCA alone to PCA + regression (or SEM)

> 2)  How important are visual biodiversity traits as a driver of aesthetic perception, preference and affective response? 

### What you've done
PCA on three variable sets: visual only; visual+sound+smell; visual+sound+smell+8 emotions.

### What PCA actually does
PCA groups correlated variables into a smaller number of "components" — it's a **simplifying** tool, not a **predicting** tool. It tells you "these five visual variables move together," but not "these visual variables cause a stronger emotional response."

**Analogy:** PCA is like sorting a messy toolbox into categories ("cutting tools," "fastening tools"). Useful for organising — but it doesn't tell you which category gets the job done fastest. For that, you need to actually test them.

### The fix: PCA first, then regression

1. Run PCA on the sensory variables only (visual, sound, smell) — this gives you simplified "trait scores" (e.g. one score for overall visual richness).
2. Use those scores as predictors in a regression against affective/aesthetic response.

> **Affective response = visual score + sound score + smell score**

Now the regression coefficients directly answer "how important is each trait" — which is what your research question actually asks.

### Why mixing emotions into the PCA is a problem
You included the 8 emotions *inside* the same PCA as the sensory variables. This blurs cause and effect — emotions are likely your **outcome**, not part of the same group as the **traits causing it**. Keep them separate: traits go into PCA, emotions go into the regression as the outcome.

### Optional next step: structural equation modelling (SEM)
If you want to model a chain — traits → perception → affective response → preference — SEM lets you test the whole pathway at once rather than two separate regressions. 

---

