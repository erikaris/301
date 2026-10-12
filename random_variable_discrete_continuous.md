# COM226 Week 2 — Worked Solutions: Tutorial and Home Exercises

**Topic:** Random variables and discrete distributions  
**Scope:** Tutorial Exercises 1–11 and Home Exercises 1–14  
**Format:** GitHub Flavoured Markdown with GitHub-supported LaTeX maths (`$...$` and `$$...$$`)

> **About this resource.** These are independently prepared worked solutions based on the supplied COM226 Week 2 tutorial and home exercise sheets, not an official module answer key. The explanations emphasise *why* each probability formula applies, as well as how to calculate the answer. Questions are paraphrased; refer to the original sheets for the full wording.
>
> **Notation:** $P(A)$ is the probability of event $A$; $A^c$ is its complement; $A\cap B$ means both events occur; $A\cup B$ means at least one occurs; $P(A\mid B)$ means the probability of $A$ given $B$.

## Contents

- [Core probability ideas](#core-probability-ideas)
- [Part A — Tutorial exercises](#part-a--tutorial-exercises)
- [Part B — Home exercises](#part-b--home-exercises)
- [Quick answer key](#quick-answer-key)
- [R verification examples](#r-verification-examples)

---

## Core probability ideas

### 1. Why do we add probabilities?

If $A$ and $B$ cannot occur together, they are *mutually exclusive*:

$$
P(A\cup B)=P(A)+P(B).
$$

If they **can** overlap, simply adding counts the intersection twice:

$$
P(A\cup B)=P(A)+P(B)-P(A\cap B).
$$

### 2. Why do we multiply probabilities?

Conditional probability is defined by

$$
P(A\mid B)=\frac{P(A\cap B)}{P(B)},\qquad P(B)>0.
$$

Rearranging gives the **multiplication rule**:

$$
P(A\cap B)=P(A\mid B)P(B).
$$

If $A$ and $B$ are independent, $P(A\mid B)=P(A)$, so

$$
P(A\cap B)=P(A)P(B).
$$

**Important:** Multiplying $P(A)P(B)$ without checking independence is generally incorrect.

### 3. Why does the law of total probability work?

Suppose $S_1,\ldots,S_n$ are mutually exclusive and collectively exhaustive: exactly one must occur. Every occurrence of $D$ then belongs to exactly one of $D\cap S_1,\ldots,D\cap S_n$. Thus,

$$
P(D)=\sum_{i=1}^{n}P(D\cap S_i)
    =\sum_{i=1}^{n}P(D\mid S_i)P(S_i).
$$

The first equality **adds non-overlapping cases**. The second uses the **multiplication rule** to calculate each case. No independence assumption is needed.

### 4. Where does Bayes' theorem come from?

Write the same intersection in two ways:

$$
P(A\cap B)=P(A\mid B)P(B)=P(B\mid A)P(A).
$$

Divide by $P(B)>0$:

$$
\boxed{P(A\mid B)=\frac{P(B\mid A)P(A)}{P(B)}}.
$$

Bayes' theorem reverses the direction of a conditional probability: from the likelihood of evidence **given a cause** to the probability of the cause **given the evidence**.

### 5. Why must a discrete PMF sum to one?

For a discrete random variable $X$, the probability mass function (PMF) is $f(x)=P(X=x)$. Its possible values are mutually exclusive and collectively exhaustive, so

$$
f(x)\ge 0,\qquad \sum_{x\in\operatorname{Im}X}f(x)=1.
$$

A formula such as $f(x)=c(5-x)$ often contains an unknown *normalising constant* $c$ that ensures the probabilities add to one.

### 6. Why use a complement?

An event and its complement cover all possibilities without overlap:

$$
P(A)+P(A^c)=1.
$$

For example, “at least one machine fails” is the complement of “no machine fails”:

$$
P(\text{at least one})=1-P(\text{none}).
$$

---

# Part A — Tutorial exercises

## Tutorial 1 — Defective components from three suppliers

**Given:** Suppliers A, B and C provide proportions $0.40$, $0.35$ and $0.25$; their conditional defect rates are $0.02$, $0.03$ and $0.05$.

**Find:** $P(D)$, the probability that a randomly selected component is defective.

**Why this formula?** A defective component must come from **exactly one** supplier. We add the probabilities of the three disjoint cases; for each case, multiply the supplier proportion by the defect rate *conditional on that supplier*:

$$
\begin{aligned}
P(D)
&=P(D\cap A)+P(D\cap B)+P(D\cap C)\\
&=P(D\mid A)P(A)+P(D\mid B)P(B)+P(D\mid C)P(C)\\
&=(0.02)(0.40)+(0.03)(0.35)+(0.05)(0.25)\\
&=0.008+0.0105+0.0125\\
&=\boxed{0.031}.
\end{aligned}
$$

**Interpretation:** About **3.1%** of all components are defective. For intuition, in 10,000 components the three suppliers would contribute approximately 80, 105 and 125 defective components, respectively: $310/10000=0.031$.

## Tutorial 2 — Risk categories after a missed payment

**Given:** Low-, medium- and high-risk customer proportions $0.40$, $0.35$, $0.25$, with missed-payment probabilities $0.02$, $0.03$, $0.05$. A missed payment $M$ is observed.

**Find:** $P(\text{medium or high}\mid M)$.

**Why this formula?** The question asks us to **reverse** the conditioning: we know how likely a missed payment is within each risk group, but want the risk group *given* a missed payment. Use Bayes' theorem, grouping medium and high as one event $H$.

First calculate the probability of a missed payment across all groups:

$$
P(M)=(0.40)(0.02)+(0.35)(0.03)+(0.25)(0.05)=0.031.
$$

The probability of both medium/high risk and a missed payment is

$$
P(H\cap M)=(0.35)(0.03)+(0.25)(0.05)=0.023.
$$

Therefore,

$$
P(H\mid M)=\frac{P(H\cap M)}{P(M)}
=\frac{0.023}{0.031}
=\boxed{\frac{23}{31}\approx0.7419}.
$$

**Interpretation:** Among customers who missed a payment, approximately **74.19%** are medium or high risk. This is different from the proportion of medium/high-risk customers in the whole population ($60\%$).

## Tutorial 3 — Correct method versus a correct answer

**Given:** The student uses the correct method with probability $p$ and then certainly obtains the correct answer. Otherwise the student makes a mistake and chooses uniformly among $k$ possible answers.

Let $C$ be “used the correct method” and $R$ be “reported the correct answer”.

**Why Bayes?** We observe the answer $R$, but want to infer the unobserved method $C$.

$$
P(C)=p,\quad P(R\mid C)=1,\quad P(R\mid C^c)=\frac1k.
$$

By total probability,

$$
P(R)=p+\frac{1-p}{k}.
$$

Hence

$$
\begin{aligned}
P(C\mid R)
&=\frac{P(R\mid C)P(C)}{P(R)}\\
&=\frac{p}{p+(1-p)/k}\\
&=\boxed{\frac{kp}{kp+1-p}}.
\end{aligned}
$$

**Interpretation:** A correct answer is evidence of a correct method, but it does not prove the method was correct: guessing may also produce the right answer.

## Tutorial 4 — Independent events and complements

**Given:** Independent events $A$ and $B$ with $P(A)=0.5$ and $P(B)=0.2$.

Independence implies

$$
P(A\cap B)=P(A)P(B)=(0.5)(0.2)=0.1.
$$

**(a) Find $P(A\cup B)$.** Adding $P(A)$ and $P(B)$ double-counts their overlap, so subtract it:

$$
P(A\cup B)=0.5+0.2-0.1=\boxed{0.6}.
$$

**(b) Find $P(A^c\cap B^c)$.** Neither event occurring is the complement of at least one occurring (De Morgan's law):

$$
P(A^c\cap B^c)=1-P(A\cup B)=\boxed{0.4}.
$$

**(c) Find $P(A^c\cup B^c)$.** At least one event not occurring is the complement of *both* occurring:

$$
P(A^c\cup B^c)=1-P(A\cap B)=\boxed{0.9}.
$$

## Tutorial 5 — Mutual independence of Bernoulli trials

**Given:** $\Omega=\{0,1\}^n$. For $\omega=(x_1,\ldots,x_n)$, let $h(\omega)=\sum_i x_i$ and

$$
P(\{\omega\})=p^{h(\omega)}(1-p)^{n-h(\omega)}.
$$

Let $A_k$ mean “the $k$-th trial succeeds”.

**Formal definition:**

$$
A_k=\{(x_1,\ldots,x_n)\in\{0,1\}^n:x_k=1\}.
$$

**Why is $P(A_k)=p$?** Fix $x_k=1$ and sum over all possible results of the other trials. Each other coordinate contributes a total probability $p+(1-p)=1$:

$$
P(A_k)=p\prod_{j\ne k}[p+(1-p)]=\boxed{p}.
$$

**Why are the events mutually independent?** Choose *any* set of $m$ distinct trial indices $i_1,\ldots,i_m$. The intersection means all those trials succeed. The remaining $n-m$ outcomes can be anything:

$$
P(A_{i_1}\cap\cdots\cap A_{i_m})
=p^m[p+(1-p)]^{n-m}
=p^m.
$$

But

$$
\prod_{j=1}^mP(A_{i_j})=p^m.
$$

The equality holds for **every subset** of indices, which is the definition of mutual independence.

$$
\boxed{A_1,\ldots,A_n\text{ are mutually independent and }P(A_k)=p.}
$$

## Tutorial 6 — Indicator random-variable identities

For an event $A$, its indicator is

$$
\mathbf1_A(\omega)=
\begin{cases}
1,&\omega\in A,\\
0,&\omega\notin A.
\end{cases}
$$

**Why do these formulas work?** Indicators take only the values 0 and 1. Compare what each expression produces for the four possibilities: neither event, only $A$, only $B$, or both.

| $A$ occurs? | $B$ occurs? | $\mathbf1_A$ | $\mathbf1_B$ | Product | Maximum | Minimum |
|---|---|---:|---:|---:|---:|---:|
| No | No | 0 | 0 | 0 | 0 | 0 |
| Yes | No | 1 | 0 | 0 | 1 | 0 |
| No | Yes | 0 | 1 | 0 | 1 | 0 |
| Yes | Yes | 1 | 1 | 1 | 1 | 1 |

**(a) Both events:**

$$
\boxed{\mathbf1_{A\cap B}=\mathbf1_A\mathbf1_B}.
$$

**(b) At least one event:**

$$
\boxed{\mathbf1_{A\cup B}=\max\{\mathbf1_A,\mathbf1_B\}}.
$$

**(c) $A$ but not $B$:**

$$
\boxed{\mathbf1_{A\setminus B}=\mathbf1_A\mathbf1_{B^c}}.
$$

**Final question:** The minimum equals 1 only when both events occur:

$$
\boxed{\min\{\mathbf1_A,\mathbf1_B\}=\mathbf1_{A\cap B}}.
$$

## Tutorial 7 — Normalising a discrete PMF

**Why normalise?** The possible values of a discrete random variable are disjoint outcomes covering all possibilities, so their PMF probabilities must sum to 1.

### (a) $f(x)=c/(x+1)$ for $x=0,1,2,3$

Set the sum to 1:

$$
\begin{aligned}
1
&=\sum_{x=0}^3\frac{c}{x+1}\\
&=c\left(1+\frac12+\frac13+\frac14\right)\\
&=c\frac{25}{12}.
\end{aligned}
$$

Therefore,

$$
\boxed{c=\frac{12}{25}=0.48}.
$$

The event $\xi\ge2$ contains only the values 2 and 3, so add their probabilities:

$$
\begin{aligned}
P(\xi\ge2)
&=f(2)+f(3)\\
&=\frac{12}{25}\left(\frac13+\frac14\right)\\
&=\boxed{\frac7{25}=0.28}.
\end{aligned}
$$

### (b) $f(x)=c3^{-x}$ for $x=0,1,2,\ldots$

There are infinitely many possible values, so use the geometric-series identity

$$
\sum_{x=0}^{\infty}r^x=\frac1{1-r},\qquad |r|<1.
$$

With $r=1/3$:

$$
1=c\sum_{x=0}^{\infty}\left(\frac13\right)^x
=c\frac1{1-1/3}
=\frac{3c}{2}.
$$

Thus,

$$
\boxed{c=\frac23}.
$$

**Why use a complement for $P(\xi\ge2)$?** The complementary event contains only $\xi=0$ and $\xi=1$, avoiding an infinite sum:

$$
\begin{aligned}
P(\xi\ge2)
&=1-P(\xi=0)-P(\xi=1)\\
&=1-\frac23-\frac29\\
&=\boxed{\frac19\approx0.1111}.
\end{aligned}
$$

## Tutorial 8 — Recovering a PMF from cumulative probabilities

**Given:** $\operatorname{Im}\xi=\{-1,2,5,7.5\}$ and

$$
P(\xi\le1)=0.2,\quad
P(\xi\le2)=0.6,\quad
P(\xi\le7)=0.85.
$$

**Why subtract?** A cumulative probability $P(\xi\le t)$ includes *all* probability mass at or below $t$. Subtracting consecutive cumulative totals isolates the mass at the newly included value.

| Value $x$ | Derivation | $f(x)$ |
|---|---|---:|
| $-1$ | $P(\xi\le1)$ | $0.20$ |
| $2$ | $P(\xi\le2)-P(\xi\le1)$ | $0.40$ |
| $5$ | $P(\xi\le7)-P(\xi\le2)$ | $0.25$ |
| $7.5$ | $1-P(\xi\le7)$ | $0.15$ |

Check: $0.20+0.40+0.25+0.15=1$.

**Find $P(\xi>2\mid\xi<7)$.** The condition $\xi<7$ restricts the possibilities to $-1,2,5$, with total probability $0.85$. Within this restricted set, $\xi>2$ holds only for $\xi=5$, with probability $0.25$.

$$
\begin{aligned}
P(\xi>2\mid\xi<7)
&=\frac{P(2<\xi<7)}{P(\xi<7)}\\
&=\frac{0.25}{0.85}\\
&=\boxed{\frac5{17}\approx0.2941}.
\end{aligned}
$$

## Tutorial 9 — Complements preserve mutual independence

**Given:** $A_1,\ldots,A_k,B_1,\ldots,B_n$ are mutually independent. Prove that $A_1,\ldots,A_k,B_1^c,\ldots,B_n^c$ are mutually independent.

**Why isn't pairwise independence enough?** Mutual independence requires the product rule for **every finite subset**, not only pairs.

Take any subset of the $A$-events and any subset of the complemented $B$-events. Let $E$ be the intersection of the selected $A$-events, and let the selected complemented events be $B_{j_1}^c,\ldots,B_{j_m}^c$.

For a single complemented event, disjointness gives

$$
P(E\cap B_{j_1}^c)=P(E)-P(E\cap B_{j_1}).
$$

Mutual independence of the original events implies

$$
P(E\cap B_{j_1})=P(E)P(B_{j_1}),
$$

so

$$
P(E\cap B_{j_1}^c)=P(E)[1-P(B_{j_1})]=P(E)P(B_{j_1}^c).
$$

To complement multiple events, repeat this subtraction (equivalently, use inclusion–exclusion). The result is

$$
P\left(E\cap\bigcap_{\ell=1}^mB_{j_\ell}^c\right)
=P(E)\prod_{\ell=1}^m[1-P(B_{j_\ell})].
$$

Since the original $A$-events are mutually independent, $P(E)$ is the product of their individual probabilities. Therefore, the probability of **any** intersection of the new events equals the product of the individual probabilities.

$$
\boxed{\text{The new family is mutually independent.}}
$$

## Tutorial 10 — Source and operating condition given a failure

**Given:** $P(A)=0.6$, $P(B)=0.4$, $P(S\mid A)=0.2$, $P(S\mid B)=0.5$. Failure rates:

| Source | Normal $N$ | Stressed $S$ |
|---|---:|---:|
| $A$ | $0.02$ | $0.15$ |
| $B$ | $0.05$ | $0.25$ |

**Find:** $P(A\mid F)$, where $F$ means failed inspection.

**Why two applications of probability rules?** Failure depends on both source and condition. First **average the condition-specific failure rates within each source** using total probability. Then **reverse the conditioning** using Bayes.

For source A:

$$
P(F\mid A)=(0.8)(0.02)+(0.2)(0.15)=0.046.
$$

For source B:

$$
P(F\mid B)=(0.5)(0.05)+(0.5)(0.25)=0.15.
$$

Across both sources:

$$
P(F)=(0.6)(0.046)+(0.4)(0.15)=0.0876.
$$

Apply Bayes:

$$
\begin{aligned}
P(A\mid F)
&=\frac{P(F\mid A)P(A)}{P(F)}\\
&=\frac{(0.046)(0.6)}{0.0876}\\
&=\boxed{\frac{23}{73}\approx0.3151}.
\end{aligned}
$$

**Interpretation:** About **31.51%** of failed items came from source A.

## Tutorial 11 — Functions of random variables

A real-valued random variable $X$ is measurable: for every real $t$, the set $\{X\le t\}$ is an event.

### (a) Show that $\max\{\xi,\eta\}$ is a random variable

**Why use the event definition?** The maximum is at most $t$ exactly when **both** inputs are at most $t$:

$$
\{\max(\xi,\eta)\le t\}
=\{\xi\le t\}\cap\{\eta\le t\}.
$$

Each set on the right is an event because $\xi$ and $\eta$ are random variables. Intersections of events are events. Thus the left-hand set is measurable for every $t$, proving

$$
\boxed{\max\{\xi,\eta\}\text{ is a random variable}.}
$$

### (b) Show that $\mathbf1_{\{\xi+\eta\le1\}}$ is a random variable

The sum $\xi+\eta$ is a random variable, so $E=\{\xi+\eta\le1\}$ is an event. Its indicator takes only the values 0 and 1:

$$
\mathbf1_E(\omega)=
\begin{cases}
1,&\xi(\omega)+\eta(\omega)\le1,\\
0,&\text{otherwise}.
\end{cases}
$$

**Why is the indicator measurable?** For any real $t$, the set $\{\mathbf1_E\le t\}$ is either $\varnothing$, $E^c$, or the whole sample space, depending on $t$. All are events. Hence

$$
\boxed{\mathbf1_{\{\xi+\eta\le1\}}\text{ is a random variable}.}
$$

---

# Part B — Home exercises

## Home 1 — Train lateness and weather

**Given:** $P(R)=0.3$ for rain; $P(L\mid R)=0.25$ and $P(L\mid R^c)=0.08$.

**Why total probability?** The day must be either rainy or dry, and these cases do not overlap. Calculate lateness through each case and add:

$$
\begin{aligned}
P(L)
&=P(L\mid R)P(R)+P(L\mid R^c)P(R^c)\\
&=(0.25)(0.3)+(0.08)(0.7)\\
&=\boxed{0.131}.
\end{aligned}
$$

**Answer:** **13.1%**.

## Home 2 — Red ball from one of three boxes

**Given:** Each box is chosen with probability $1/3$. Red-ball probabilities are $4/10$, $7/10$, and $2/10$.

**Why total probability?** The selected ball must come from exactly one box. Condition on the box:

$$
\begin{aligned}
P(R)
&=\sum_{i=1}^3P(R\mid B_i)P(B_i)\\
&=\frac13\left(\frac4{10}+\frac7{10}+\frac2{10}\right)\\
&=\boxed{\frac{13}{30}\approx0.4333}.
\end{aligned}
$$

**Answer:** Approximately **43.33%**.

## Home 3 — Which coin was selected after observing heads?

**Given:** Three equally likely coins: fair $F$ with $P(H\mid F)=1/2$; double-headed $D$ with $P(H\mid D)=1$; biased $B$ with $P(H\mid B)=3/4$.

**Why Bayes?** The observed result is heads, and we want to infer which coin caused it.

First calculate the probability of heads:

$$
P(H)=\frac13\left(\frac12+1+\frac34\right)=\frac34.
$$

For each coin $C$, use $P(C\mid H)=P(H\mid C)P(C)/P(H)$:

**(a) Fair coin**

$$
P(F\mid H)=\frac{(1/2)(1/3)}{3/4}
=\boxed{\frac29}.
$$

**(b) Double-headed coin**

$$
P(D\mid H)=\frac{(1)(1/3)}{3/4}
=\boxed{\frac49}.
$$

**(c) Biased coin**

$$
P(B\mid H)=\frac{(3/4)(1/3)}{3/4}
=\boxed{\frac13}.
$$

**Check:** $2/9+4/9+1/3=1$. The double-headed coin is most likely after observing heads.

## Home 4 — Was the original ball blue?

**Given:** Originally one blue ball with probability $1-p$, or one red ball with probability $p$. A blue ball is added; one of the two balls is drawn and is blue.

Let $O$ mean “the original ball was blue” and $S$ mean “the selected ball is blue”.

**Why Bayes?** We know the selected colour and want to infer the earlier, hidden original colour.

If the original was blue, the box contains two blue balls, so $P(S\mid O)=1$. If the original was red, only one of the two balls is blue, so $P(S\mid O^c)=1/2$.

$$
\begin{aligned}
P(O\mid S)
&=\frac{P(S\mid O)P(O)}
{P(S\mid O)P(O)+P(S\mid O^c)P(O^c)}\\
&=\frac{1(1-p)}{1(1-p)+(1/2)p}\\
&=\boxed{\frac{2(1-p)}{2-p}}.
\end{aligned}
$$

## Home 5 — Pairwise but not mutually independent dice events

**Given:** Two fair dice $(\xi_1,\xi_2)$ and

$$
A=\{\xi_2=1\},\quad
B=\{\xi_1+\xi_2=7\},\quad
C=\{\xi_1=6\}.
$$

There are 36 equally likely ordered outcomes. Each event has 6 outcomes:

$$
P(A)=P(B)=P(C)=\frac16.
$$

**Why check intersections?** Pairwise independence requires the product rule for each of the three pairs.

Each pair occurs at the single outcome $(6,1)$:

$$
P(A\cap B)=P(A\cap C)=P(B\cap C)=\frac1{36}
=\frac16\cdot\frac16.
$$

So the events are **pairwise independent**.

**Why isn't that enough for mutual independence?** Mutual independence additionally requires the product rule for the triple intersection:

$$
P(A\cap B\cap C)=\frac1{36},
$$

but

$$
P(A)P(B)P(C)=\left(\frac16\right)^3=\frac1{216}.
$$

Since these differ,

$$
\boxed{\text{Pairwise independent, but not mutually independent.}}
$$

## Home 6 — Three independent machines with common failure probability

**Given:** Three independent machines, each failing with probability $p$. Let $X$ count failures.

**Why the binomial formula?** Every machine has two outcomes (fail/not fail), all trials are independent, and the failure probability is the same. Thus $X\sim\operatorname{Binomial}(3,p)$:

$$
P(X=k)=\binom3k p^k(1-p)^{3-k}.
$$

The factor $p^k(1-p)^{3-k}$ is the probability of **one specific pattern** of $k$ failures and $3-k$ successes. The coefficient $\binom3k$ counts the number of such patterns.

**(a) No failures**

$$
P(X=0)=\binom30p^0(1-p)^3=\boxed{(1-p)^3}.
$$

**(b) Exactly one failure**

There are three choices for which machine fails:

$$
P(X=1)=\binom31p(1-p)^2=\boxed{3p(1-p)^2}.
$$

**(c) At least one failure**

The complement of “at least one” is “none”:

$$
P(X\ge1)=1-P(X=0)=\boxed{1-(1-p)^3}.
$$

## Home 7 — Three independent machines with different failure probabilities

**Given:** Failure probabilities $p_1=0.05$, $p_2=0.08$, $p_3=0.10$.

**Why not use the ordinary binomial formula?** The trials are independent but their failure probabilities are *different*. Instead, enumerate disjoint patterns or use complements.

**(a) None fails:**

$$
P(X=0)=(0.95)(0.92)(0.90)=\boxed{0.7866}.
$$

**(b) Exactly one fails:** There are three mutually exclusive possibilities—only machine 1, only machine 2, or only machine 3:

$$
\begin{aligned}
P(X=1)
&=(0.05)(0.92)(0.90)\\
&\quad +(0.95)(0.08)(0.90)\\
&\quad +(0.95)(0.92)(0.10)\\
&=0.0414+0.0684+0.0874\\
&=\boxed{0.1972}.
\end{aligned}
$$

**(c) At least one fails:**

$$
P(X\ge1)=1-0.7866=\boxed{0.2134}.
$$

## Home 8 — Constructing a PMF from probability constraints

**Given:** $\operatorname{Im}\xi=\{-1,-0.1,0,1.1\}$ and

$$
\begin{aligned}
P(-0.5\le\xi\le0.5)&=0.4,\\
P(\xi\le0.5)&=0.8,\\
P(\xi\ge0)&=0.5.
\end{aligned}
$$

Let

$$
a=P(\xi=-1),\quad b=P(\xi=-0.1),\quad
c=P(\xi=0),\quad d=P(\xi=1.1).
$$

**Why translate the constraints into sums?** Each inequality selects particular possible values. Because distinct values of a discrete random variable cannot occur simultaneously, add their individual probabilities:

$$
b+c=0.4,\quad a+b+c=0.8,\quad c+d=0.5,\quad a+b+c+d=1.
$$

Subtract the first equation from the second: $a=0.4$.

Subtract the second from the total: $d=0.2$.

Then $c=0.5-d=0.3$, and $b=0.4-c=0.1$.

| $x$ | $-1$ | $-0.1$ | $0$ | $1.1$ |
|---|---:|---:|---:|---:|
| $P(\xi=x)$ | $0.4$ | $0.1$ | $0.3$ | $0.2$ |

**Find $P(\xi\ge-0.1\mid\xi\le0.1)$.**

**Why divide?** Conditioning on $\xi\le0.1$ restricts the sample space to $-1,-0.1,0$, with total probability $0.8$. Within that space, the requested event includes only $-0.1$ and $0$:

$$
\begin{aligned}
P(\xi\ge-0.1\mid\xi\le0.1)
&=\frac{P(-0.1\le\xi\le0.1)}{P(\xi\le0.1)}\\
&=\frac{0.1+0.3}{0.4+0.1+0.3}\\
&=\boxed{0.5}.
\end{aligned}
$$

## Home 9 — Normalising $f(x)=c(5-x)$

**Given:** $X\in\{0,1,2,3,4\}$ with PMF $f(x)=c(5-x)$.

**Why set the sum to 1?** $X$ must equal one of these five values, so the probabilities must sum to 1:

$$
1=\sum_{x=0}^4c(5-x)=c(5+4+3+2+1)=15c.
$$

Thus,

$$
\boxed{c=\frac1{15}}.
$$

**Find $P(X\ge2)$.** The values satisfying $X\ge2$ are 2, 3 and 4, so add their PMF values:

$$
P(X\ge2)=\frac3{15}+\frac2{15}+\frac1{15}
=\boxed{\frac6{15}=0.4}.
$$

**Find $P(1<X\le4)$.** Since $X$ is integer-valued on this support, the condition again selects exactly 2, 3 and 4:

$$
\boxed{P(1<X\le4)=0.4}.
$$

## Home 10 — PMF of a function of two dice

**Given:** Independent fair dice $\xi_1,\xi_2\in\{1,\ldots,6\}$, and

$$
\eta=\min\{\xi_1+\xi_2,\xi_1\xi_2\}.
$$

**Why enumerate the outcomes?** The new random variable $\eta$ is a *function* of the dice. Different ordered pairs can produce the same $\eta$. To obtain $P(\eta=y)$, add the probabilities of **all** pairs $(i,j)$ for which $\min(i+j,ij)=y$:

$$
P(\eta=y)=
\sum_{\substack{1\le i,j\le6\\\min(i+j,ij)=y}}
P(\xi_1=i,\xi_2=j).
$$

Each ordered pair has probability $1/36$ because the dice are independent and fair. Thus the PMF equals the **number of matching pairs divided by 36**.

### All 36 values of $\eta$

| $\xi_1\backslash\xi_2$ | 1 | 2 | 3 | 4 | 5 | 6 |
|---|---:|---:|---:|---:|---:|---:|
| **1** | 1 | 2 | 3 | 4 | 5 | 6 |
| **2** | 2 | 4 | 5 | 6 | 7 | 8 |
| **3** | 3 | 5 | 6 | 7 | 8 | 9 |
| **4** | 4 | 6 | 7 | 8 | 9 | 10 |
| **5** | 5 | 7 | 8 | 9 | 10 | 11 |
| **6** | 6 | 8 | 9 | 10 | 11 | 12 |

For example, for $(\xi_1,\xi_2)=(2,3)$, the sum is 5 and the product is 6, so $\eta=\min(5,6)=5$.

### PMF

| $\eta$ | Count | $P(\eta=y)$ |
|---|---:|---:|
| 1 | 1 | $1/36$ |
| 2 | 2 | $2/36$ |
| 3 | 2 | $2/36$ |
| 4 | 3 | $3/36$ |
| 5 | 4 | $4/36$ |
| 6 | 5 | $5/36$ |
| 7 | 4 | $4/36$ |
| 8 | 5 | $5/36$ |
| 9 | 4 | $4/36$ |
| 10 | 3 | $3/36$ |
| 11 | 2 | $2/36$ |
| 12 | 1 | $1/36$ |
| **Total** | **36** | **1** |

**Interpretation:** The most likely values are 6 and 8, each occurring in 5 of the 36 equally likely dice outcomes.

## Home 11 — Product of positive random variables

**Given:** Positive-valued random variables $\xi$ and $\eta$. Prove that $\xi\eta$ is a random variable.

**Why use logarithms?** Logarithms convert multiplication into addition, and sums of random variables are random variables. Since $\xi,\eta>0$, their logarithms are defined:

$$
Z=\log\xi+\log\eta.
$$

The logarithm is continuous on $(0,\infty)$, so $\log\xi$ and $\log\eta$ are random variables. Their sum $Z$ is therefore a random variable.

The exponential function is continuous, so $e^Z$ is also a random variable. But

$$
e^Z=e^{\log\xi+\log\eta}=\xi\eta.
$$

Therefore,

$$
\boxed{\xi\eta\text{ is a random variable}.}
$$

**Extension:** Positivity makes this proof convenient, but the product of any two real-valued random variables is measurable; for example, use $\xi\eta=\bigl[(\xi+\eta)^2-(\xi-\eta)^2\bigr]/4$.

## Home 12 — Particle reaching a target

**Given:** From the start, the particle goes left to $C$ with probability $0.4$, or right with probability $0.6$; after going right, it reaches $A$ or $B$ with probability $0.5$ each. Target-reaching probabilities from $C,A,B$ are $0.3,0.8,0.2$.

**Why total probability?** The particle must pass through exactly one of $C$, $A$ or $B$. Multiply probabilities along each path, then add the disjoint path probabilities.

$$
P(C)=0.4,\qquad P(A)=(0.6)(0.5)=0.3,\qquad P(B)=(0.6)(0.5)=0.3.
$$

Thus,

$$
\begin{aligned}
P(T)
&=P(T\mid C)P(C)+P(T\mid A)P(A)+P(T\mid B)P(B)\\
&=(0.3)(0.4)+(0.8)(0.3)+(0.2)(0.3)\\
&=0.12+0.24+0.06\\
&=\boxed{0.42}.
\end{aligned}
$$

**Answer:** **42%**.

## Home 13 — Restaurant choices over two days

**Given:** Alice chooses steakhouse, Chinese or Italian with probabilities $p=(0.1,0.4,0.5)$. Bob joins with conditional probabilities $q=(0.9,0.6,0.8)$. Choices across days and conditional joining decisions are independent.

Let $J_1,J_2$ mean Bob joins on the two days; let $S$ mean Alice chooses the same restaurant on both days.

**Why square probabilities?** The two days are independent. For example, the probability of steakhouse **and** Bob joining on *both* days is $[(0.1)(0.9)]^2$. Add over the three mutually exclusive restaurant choices.

First compute Bob's one-day joining probability:

$$
P(J)=\sum_{i=1}^3p_iq_i=(0.1)(0.9)+(0.4)(0.6)+(0.5)(0.8)=0.73.
$$

The joint probability of choosing the same restaurant and Bob joining on both days is

$$
\begin{aligned}
P(S\cap J_1\cap J_2)
&=\sum_{i=1}^3(p_iq_i)^2\\
&=(0.09)^2+(0.24)^2+(0.40)^2\\
&=0.2257.
\end{aligned}
$$

### (a) Same restaurant given Bob joined both days

**Why this denominator?** We are restricting attention to days on which Bob joined **both times**, so divide by $P(J_1\cap J_2)=P(J)^2$:

$$
\begin{aligned}
P(S\mid J_1\cap J_2)
&=\frac{P(S\cap J_1\cap J_2)}{P(J_1\cap J_2)}\\
&=\frac{0.2257}{0.73^2}\\
&=\boxed{\frac{0.2257}{0.5329}\approx0.4235}.
\end{aligned}
$$

### (b) Bob joined both days given the same restaurant

**Why is this different?** Now the *condition* is that Alice chose the same restaurant twice, so the denominator is $P(S)$:

$$
P(S)=0.1^2+0.4^2+0.5^2=0.42.
$$

Thus,

$$
\begin{aligned}
P(J_1\cap J_2\mid S)
&=\frac{P(S\cap J_1\cap J_2)}{P(S)}\\
&=\frac{0.2257}{0.42}\\
&=\boxed{\approx0.5374}.
\end{aligned}
$$

**Key distinction:** $P(S\mid J_1\cap J_2)$ and $P(J_1\cap J_2\mid S)$ are different conditional probabilities.

## Home 14 — Two unknown parameters in a PMF

**Given:** $X\in\{0,1,2,3,4,5\}$ with $f(k)=c(a+k)$, where $a,c>0$. Also,

$$
P(X\le1)=P(X\ge5).
$$

**Find:** $a$, $c$, and $P(X\text{ is even}\mid X\ne0)$.

### Step 1 — Use the probability equality to find $a$

**Why add the PMF terms?** The event $X\le1$ contains $X=0$ or $X=1$, while $X\ge5$ contains only $X=5$:

$$
f(0)+f(1)=f(5).
$$

Substitute $f(k)=c(a+k)$:

$$
ca+c(a+1)=c(a+5).
$$

Since $c>0$, divide by $c$:

$$
2a+1=a+5
\quad\Longrightarrow\quad
\boxed{a=4}.
$$

### Step 2 — Normalise to find $c$

**Why normalise?** All six possible values must have total probability 1:

$$
1=\sum_{k=0}^{5}c(4+k)
=c(4+5+6+7+8+9)=39c.
$$

Thus,

$$
\boxed{c=\frac1{39}}.
$$

The PMF is therefore

| $k$ | 0 | 1 | 2 | 3 | 4 | 5 |
|---|---:|---:|---:|---:|---:|---:|
| $f(k)$ | $4/39$ | $5/39$ | $6/39$ | $7/39$ | $8/39$ | $9/39$ |

### Step 3 — Calculate the conditional probability

**Why exclude zero from the numerator?** The condition $X\ne0$ restricts the possible outcomes to 1, 2, 3, 4 and 5. Among those, the even values are only 2 and 4:

$$
\begin{aligned}
P(X\text{ even}\mid X\ne0)
&=\frac{P(X\in\{2,4\})}{P(X\ne0)}\\
&=\frac{6/39+8/39}{1-4/39}\\
&=\frac{14/39}{35/39}\\
&=\boxed{\frac25=0.4}.
\end{aligned}
$$

---

# Quick answer key

## Tutorial exercises

| No. | Answer |
|---|---|
| 1 | $0.031$ |
| 2 | $23/31\approx0.7419$ |
| 3 | $kp/(kp+1-p)$ |
| 4 | (a) $0.6$; (b) $0.4$; (c) $0.9$ |
| 5 | $P(A_k)=p$; events mutually independent |
| 6 | (a) $\mathbf1_{A\cap B}=\mathbf1_A\mathbf1_B$; (b) $\mathbf1_{A\cup B}=\max(\mathbf1_A,\mathbf1_B)$; (c) $\mathbf1_{A\setminus B}=\mathbf1_A\mathbf1_{B^c}$; minimum $=\mathbf1_{A\cap B}$ |
| 7 | (a) $c=12/25$, $P(\xi\ge2)=7/25$; (b) $c=2/3$, $P(\xi\ge2)=1/9$ |
| 8 | PMF $(0.2,0.4,0.25,0.15)$; conditional probability $5/17$ |
| 9 | Complemented family remains mutually independent |
| 10 | $23/73\approx0.3151$ |
| 11 | Both expressions are random variables |

## Home exercises

| No. | Answer |
|---|---|
| 1 | $0.131$ |
| 2 | $13/30$ |
| 3 | (a) $2/9$; (b) $4/9$; (c) $1/3$ |
| 4 | $2(1-p)/(2-p)$ |
| 5 | Pairwise independent; not mutually independent |
| 6 | (a) $(1-p)^3$; (b) $3p(1-p)^2$; (c) $1-(1-p)^3$ |
| 7 | (a) $0.7866$; (b) $0.1972$; (c) $0.2134$ |
| 8 | PMF $(0.4,0.1,0.3,0.2)$; conditional probability $0.5$ |
| 9 | $c=1/15$; both requested probabilities $0.4$ |
| 10 | PMF in the 12-row table above |
| 11 | Product is a random variable |
| 12 | $0.42$ |
| 13 | (a) $\approx0.4235$; (b) $\approx0.5374$ |
| 14 | $a=4$, $c=1/39$, conditional probability $0.4$ |

---

# R verification examples

The mathematical reasoning above is the primary solution. R is useful for checking arithmetic and enumerating discrete outcomes.

## Verify Tutorial 7 and Home 9

```r
# Tutorial 7(a): determine the normalising constant
x <- 0:3
c_a <- 1 / sum(1 / (x + 1))

# Construct the PMF
pmf_a <- c_a / (x + 1)

# Check that the probabilities sum to 1
sum(pmf_a)

# Calculate P(X >= 2)
sum(pmf_a[x >= 2])

# Tutorial 7(b): infinite geometric series, c = 2/3
c_b <- 2 / 3

# Calculate P(X >= 2) by complement
1 - c_b * 3^0 - c_b * 3^(-1)

# Home 9: determine c for f(x) = c(5 - x)
x <- 0:4
c_home9 <- 1 / sum(5 - x)

# Construct the PMF
pmf_home9 <- c_home9 * (5 - x)

# Check total probability
sum(pmf_home9)

# P(X >= 2)
sum(pmf_home9[x >= 2])
```

## Verify Home 7 (different machine failure probabilities)

```r
# Independent failure probabilities
p <- c(0.05, 0.08, 0.10)

# Probability that none fails
p_none <- prod(1 - p)

# Exactly one failure: enumerate the three possible machines
p_one <- sum(vapply(seq_along(p), function(i) {
  # Start with probabilities of no failure for all machines
  factors <- 1 - p

  # Replace the i-th factor by its failure probability
  factors[i] <- p[i]

  # Multiply independent probabilities for this pattern
  prod(factors)
}, numeric(1)))

# At least one failure is the complement of none
p_at_least_one <- 1 - p_none

# Print results
c(none = p_none, exactly_one = p_one,
  at_least_one = p_at_least_one)
```

Expected result:

```text
        none  exactly_one at_least_one
      0.7866       0.1972       0.2134
```

## Verify Home 10 (transformed dice PMF)

```r
# Enumerate all 36 equally likely ordered dice outcomes
dice <- expand.grid(die1 = 1:6, die2 = 1:6)

# Compute eta = min(sum of dice, product of dice)
dice$eta <- pmin(dice$die1 + dice$die2,
                 dice$die1 * dice$die2)

# Count how many outcomes produce each value of eta
counts <- table(dice$eta)

# Each ordered outcome has probability 1/36
pmf_eta <- counts / nrow(dice)

# Display the resulting PMF
print(pmf_eta)

# Check that all probabilities add to 1
sum(pmf_eta)
```

Expected counts for $\eta=1,\ldots,12$:

```text
1  2  3  4  5  6  7  8  9 10 11 12
1  2  2  3  4  5  4  5  4  3  2  1
```

## Verify Home 13 (two-day conditional probabilities)

```r
# Restaurant selection probabilities
p <- c(0.1, 0.4, 0.5)

# Bob's conditional joining probabilities
q <- c(0.9, 0.6, 0.8)

# Probability Bob joins on a single day
p_join <- sum(p * q)

# Probability of same restaurant and Bob joining on both days
p_same_and_both_join <- sum((p * q)^2)

# Part (a): same restaurant given Bob joined on both days
answer_a <- p_same_and_both_join / p_join^2

# Probability of the same restaurant on both days
p_same <- sum(p^2)

# Part (b): Bob joins on both days given same restaurant
answer_b <- p_same_and_both_join / p_same

# Display answers
c(part_a = answer_a, part_b = answer_b)
```

Expected result (rounded):

```text
   part_a    part_b
0.4235316 0.5373810
```

---

## Suggested study order

For a student concentrating specifically on **random variables and discrete distributions**, work through **Home 9 → Tutorial 7 → Tutorial 8 → Home 8 → Home 10 → Home 14**. These build from normalising a PMF, through cumulative and conditional probabilities, to distributions of transformed random variables.

The remaining exercises develop supporting probability foundations: total probability, Bayes' theorem, independence, Bernoulli trials and measurability.

## GitHub rendering notes

This file uses GitHub's native mathematical notation:

- Inline maths: `$P(X=x)$`
- Display maths: `$$` on separate lines
- Standard LaTeX commands such as `\frac`, `\sum`, `\cap`, `\mid`, `\boxed`, `\mathbf`, `\begin{aligned}` and `\end{aligned}`

To publish, upload this `.md` file to a GitHub repository. GitHub renders the Markdown tables and mathematical expressions directly in its file preview. A GitHub Pages site using a different Markdown renderer may require MathJax or KaTeX configuration.

**Source material:** COM226 Week 2 *Tutorial exercises* and *Home exercises* supplied for this resource.
