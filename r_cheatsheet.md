# R Cheatsheet

A holistic, organized reference of essential R functions across all major categories. Compiled by @erikaris. 

---

## **1. Data Exploration & Inspection**

Basic functions to understand your data structure and contents.

| Function | Purpose |
|----------|---------|
| `head()` / `tail()` | View first/last 6 rows |
| `str()` | Display structure of object (types, dimensions) |
| `summary()` | Statistical overview (mean, median, quartiles) |
| `glimpse()` | (dplyr) Cleaner, transposed version of `str()` |
| `dim()` | Returns rows and columns count |
| `nrow()` / `ncol()` | Number of rows or columns |
| `names()` / `colnames()` | Get/set column names |
| `rownames()` | Get/set row names |
| `class()` | Object class |
| `typeof()` | Data type |
| `unique()` | Unique values |
| `table()` | Frequency table |
| `View()` | Interactive data viewer (RStudio) |

**Example:**
```r
str(df)
summary(df)
table(df$category)
glimpse(df)
```

---

## **2. Type Conversion & Type Checking**

Convert between data types and check object types.

### Conversion Functions
| Function | Purpose |
|----------|---------|
| `as.numeric()` | Convert to numeric |
| `as.character()` | Convert to character/string |
| `as.integer()` | Convert to integer |
| `as.logical()` | Convert to logical (TRUE/FALSE) |
| `as.factor()` | Convert to factor |
| `as.data.frame()` | Convert to data frame |
| `as.matrix()` | Convert to matrix |
| `as.list()` | Convert to list |
| `as.Date()` | Convert to date |

### Type Checking Functions
| Function | Purpose |
|----------|---------|
| `is.numeric()` | Check if numeric |
| `is.character()` | Check if character |
| `is.integer()` | Check if integer |
| `is.logical()` | Check if logical |
| `is.factor()` | Check if factor |
| `is.na()` | Check for missing values |
| `is.null()` | Check if NULL |
| `is.data.frame()` | Check if data frame |
| `is.list()` | Check if list |
| `is.matrix()` | Check if matrix |

**Example:**
```r
as.numeric("123")
is.na(df$column)
as.factor(df$category)
```

---

## **3. Data Manipulation (Base R)**

Core functions for filtering, transforming, and reshaping data.

| Function | Purpose |
|----------|---------|
| `subset()` | Filter rows based on conditions |
| `merge()` | Join datasets by common columns |
| `rbind()` | Bind rows together |
| `cbind()` | Bind columns together |
| `order()` | Sort rows (returns indices) |
| `rank()` | Rank values |
| `transform()` | Add or modify columns |
| `within()` | Modify multiple columns |
| `aggregate()` | Group and summarize data |
| `reshape()` | Reshape data (wide/long) |
| `stack()` | Stack columns into rows |
| `unstack()` | Unstack rows into columns |
| `by()` | Apply function by groups |
| `with()` | Evaluate expression in data frame context |
| `[`, `[[`, `$` | Subsetting and indexing operators |

**Example:**
```r
subset(df, age > 30)
df[order(df$income), ]
aggregate(sales ~ region, data = df, mean)
transform(df, new_col = age * 2)
```

---

## **4. Data Manipulation (dplyr/tidyverse)**

Modern, intuitive functions for data wrangling.

| Function | Purpose |
|----------|---------|
| `filter()` | Pick rows based on conditions |
| `select()` | Choose specific columns |
| `mutate()` | Create/transform columns |
| `arrange()` | Sort rows (ascending/descending) |
| `group_by()` | Group data for split-apply-combine |
| `summarize()` / `summarise()` | Calculate summary stats by groups |
| `pivot_longer()` | Reshape data (wide to long) |
| `pivot_wider()` | Reshape data (long to wide) |
| `distinct()` | Remove duplicate rows |
| `slice()` | Select rows by position |
| `pull()` | Extract column as vector |
| `rename()` | Rename columns |

**Example:**
```r
df %>%
  filter(age > 30) %>%
  mutate(age_group = cut(age, breaks = c(0, 30, 60, 100))) %>%
  group_by(region) %>%
  summarize(avg_sales = mean(sales))
```

---

## **5. Apply Family (Loop Alternatives)**

Functions to apply operations across data structures without explicit loops.

| Function | Purpose |
|----------|---------|
| `apply()` | Apply function across rows/columns of matrix |
| `lapply()` | Apply to list, return list |
| `sapply()` | Apply to list, return simplified vector |
| `tapply()` | Apply function by groups (factor) |
| `mapply()` | Multivariate apply (multiple arguments) |
| `Reduce()` | Accumulate/reduce a function over vector |
| `Filter()` | Filter elements matching a condition |
| `Map()` | Apply function to corresponding elements |

**Example:**
```r
apply(mat, 2, mean)           # Mean of each column
lapply(df, class)             # Class of each column
sapply(df, mean, na.rm=TRUE)  # Mean of each numeric column
tapply(df$sales, df$region, mean)  # Mean by region
```

---

## **6. Vector & Logical Operations**

Fundamental operations on vectors and logical conditions.

| Function | Purpose |
|----------|---------|
| `which()` | Indices where condition is TRUE |
| `which.min()` / `which.max()` | Index of min/max value |
| `ifelse()` | Vectorized conditional (if-else) |
| `any()` / `all()` | Test if any/all conditions are TRUE |
| `cut()` | Bin continuous variables into factors |
| `seq()` | Generate sequences |
| `seq_along()` | Safe sequence from 1 to length |
| `seq_len()` | Safe sequence from 1 to n |
| `rep()` | Repeat elements |
| `length()` | Vector length |
| `sort()` | Sort values |
| `rev()` | Reverse order |
| `append()` | Add elements to vectors |
| `match()` | Find positions of matches |
| `duplicated()` | Identify duplicate values |
| `range()` | Min and max of vector |
| `diff()` | Differences between consecutive elements |
| `cumsum()` | Cumulative sum |
| `cumprod()` | Cumulative product |

**Example:**
```r
which(df$age > 40)
df$category <- ifelse(df$sales > 1000, "High", "Low")
cut(df$age, breaks = c(0, 18, 65, 100), labels = c("Child", "Adult", "Senior"))
seq(0, 100, by = 5)
rep(c(1, 2, 3), times = 3)
```

---

## **7. List & Data Frame Operations**

Functions for creating and manipulating lists and data frames.

| Function | Purpose |
|----------|---------|
| `list()` | Create a list |
| `data.frame()` | Create a data frame |
| `as.list()` | Convert to list |
| `unlist()` | Flatten list to vector |
| `expand.grid()` | Create all combinations of vectors |
| `names()` | Get/set element names |
| `length()` | Number of elements |
| `str()` | Structure of list/data frame |
| `$` | Extract element by name |
| `[[` | Extract single element |
| `[` | Extract subset |

**Example:**
```r
my_list <- list(a = 1:3, b = c("x", "y"), c = TRUE)
df <- data.frame(id = 1:3, name = c("A", "B", "C"), value = c(10, 20, 30))
unlist(my_list)
expand.grid(x = 1:3, y = c("a", "b"))
```

---

## **8. Factor Operations**

Functions for working with categorical data (factors).

| Function | Purpose |
|----------|---------|
| `factor()` | Create factor from vector |
| `as.factor()` | Convert to factor |
| `levels()` | Get/set factor levels |
| `nlevels()` | Number of levels |
| `ordered()` | Create ordered factor |
| `droplevels()` | Remove unused levels |
| `relevel()` | Reorder factor levels |

**Example:**
```r
df$category <- factor(df$category, levels = c("Low", "Medium", "High"))
levels(df$category)
df$category <- relevel(df$category, ref = "Low")
```

---

## **9. Matrix Operations**

Functions for matrix creation and manipulation.

| Function | Purpose |
|----------|---------|
| `matrix()` | Create matrix |
| `t()` | Transpose matrix |
| `dim()` | Dimensions (rows, columns) |
| `nrow()` / `ncol()` | Number of rows/columns |
| `colSums()` / `rowSums()` | Sum columns/rows |
| `colMeans()` / `rowMeans()` | Mean of columns/rows |
| `diag()` | Diagonal matrix or extract diagonal |
| `%*%` | Matrix multiplication |
| `solve()` | Matrix inverse |
| `det()` | Matrix determinant |
| `eigen()` | Eigenvalues and eigenvectors |

**Example:**
```r
mat <- matrix(1:12, nrow = 3, ncol = 4)
t(mat)                    # Transpose
colSums(mat)              # Sum of each column
mat1 %*% mat2             # Matrix multiplication
diag(mat)                 # Diagonal elements
```

---

## **10. Missing Data Handling**

Functions for detecting and handling missing values.

| Function | Purpose |
|----------|---------|
| `is.na()` | Detect missing values |
| `na.omit()` | Remove rows with any NA |
| `complete.cases()` | Identify rows without NA |
| `na.rm = TRUE` | Ignore NA in calculations |
| `na.approx()` | Interpolate missing values |
| `fill = TRUE` | Fill missing values in dplyr |

**Example:**
```r
sum(is.na(df))
df <- df[complete.cases(df), ]
mean(df$value, na.rm = TRUE)
df <- na.omit(df)
```

---

## **11. String Manipulation**

Functions for working with text and character strings.

| Function | Purpose |
|----------|---------|
| `paste()` | Concatenate strings (with separator) |
| `paste0()` | Concatenate strings (no separator) |
| `sprintf()` | Formatted string |
| `nchar()` | String length |
| `substr()` | Extract substring |
| `substring()` | Extract substring (vectorized) |
| `tolower()` | Convert to lowercase |
| `toupper()` | Convert to UPPERCASE |
| `chartr()` | Character translation |
| `grep()` | Find pattern positions |
| `grepl()` | Logical pattern matching |
| `regexpr()` | Find first pattern occurrence |
| `gregexpr()` | Find all pattern occurrences |
| `gsub()` | Replace all occurrences |
| `sub()` | Replace first occurrence |
| `strsplit()` | Split string by separator |
| `trimws()` | Remove leading/trailing whitespace |
| `startsWith()` / `endsWith()` | Check string prefix/suffix |

**Example:**
```r
paste0("ID_", df$id)
grep("food", df$caption)
gsub("#", "", hashtag)
tolower(df$name)
strsplit("a-b-c", "-")
nchar("hello")
sprintf("Value: %.2f", 3.14159)
```

---

## **12. Statistical Functions**

Functions for statistical analysis and hypothesis testing.

### Descriptive Statistics
| Function | Purpose |
|----------|---------|
| `mean()` | Mean/average |
| `median()` | Median |
| `sd()` | Standard deviation |
| `var()` | Variance |
| `mad()` | Median absolute deviation |
| `quantile()` | Percentiles/quantiles |
| `IQR()` | Interquartile range |
| `min()` / `max()` | Minimum/maximum |
| `sum()` | Sum |
| `prod()` | Product |
| `cumsum()` | Cumulative sum |

### Correlation & Regression
| Function | Purpose |
|----------|---------|
| `cor()` | Correlation matrix |
| `cov()` | Covariance matrix |
| `lm()` | Fit linear model |
| `glm()` | Generalized linear model |
| `predict()` | Predictions from model |
| `residuals()` | Extract residuals |
| `fitted()` | Fitted values |
| `coef()` / `coefficients()` | Extract coefficients |
| `confint()` | Confidence intervals |
| `summary()` | Model summary |

### Hypothesis Tests
| Function | Purpose |
|----------|---------|
| `t.test()` | T-test |
| `wilcox.test()` | Wilcoxon test (non-parametric) |
| `chisq.test()` | Chi-square test |
| `fisher.test()` | Fisher's exact test |
| `anova()` | ANOVA |
| `kruskal.test()` | Kruskal-Wallis test |
| `cor.test()` | Correlation test |

**Example:**
```r
mean(df$salary)
median(df$age)
cor(df$x, df$y)
model <- lm(salary ~ age + experience, data = df)
summary(model)
predict(model, newdata = new_df)
t.test(group1, group2)
```

---

## **13. Probability Distributions**

Functions for working with probability distributions (Normal, Binomial, Poisson, Uniform, etc.).

For each distribution, there are typically 4 functions with prefixes: `d` (density), `p` (cumulative probability), `q` (quantile), `r` (random).

| Prefix | Purpose |
|--------|---------|
| `d*()` | Density/probability function |
| `p*()` | Cumulative distribution function (CDF) |
| `q*()` | Quantile function (inverse CDF) |
| `r*()` | Generate random samples |

### Common Distributions
| Distribution | Functions |
|--------------|-----------|
| Normal | `dnorm()`, `pnorm()`, `qnorm()`, `rnorm()` |
| Binomial | `dbinom()`, `pbinom()`, `qbinom()`, `rbinom()` |
| Poisson | `dpois()`, `ppois()`, `qpois()`, `rpois()` |
| Uniform | `dunif()`, `punif()`, `qunif()`, `runif()` |
| T-distribution | `dt()`, `pt()`, `qt()`, `rt()` |
| Chi-square | `dchisq()`, `pchisq()`, `qchisq()`, `rchisq()` |
| Exponential | `dexp()`, `pexp()`, `qexp()`, `rexp()` |
| Gamma | `dgamma()`, `pgamma()`, `qgamma()`, `rgamma()` |

**Example:**
```r
rnorm(100, mean = 0, sd = 1)      # 100 random normal values
pnorm(1.96)                        # P(X ≤ 1.96) in N(0,1)
qnorm(0.975)                       # 97.5th percentile
dnorm(0)                           # Density at 0
rbinom(50, size = 10, prob = 0.5)  # 50 random binomial values
```

---

## **14. Mathematical Functions**

Basic mathematical operations.

| Function | Purpose |
|----------|---------|
| `abs()` | Absolute value |
| `sqrt()` | Square root |
| `log()` | Natural logarithm |
| `log10()` | Base-10 logarithm |
| `log2()` | Base-2 logarithm |
| `exp()` | Exponential (e^x) |
| `sin()`, `cos()`, `tan()` | Trigonometric functions |
| `asin()`, `acos()`, `atan()` | Inverse trigonometric |
| `sinh()`, `cosh()`, `tanh()` | Hyperbolic functions |
| `round()` | Round to nearest integer |
| `ceiling()` / `ceil()` | Round up |
| `floor()` | Round down |
| `trunc()` | Truncate decimal |
| `sign()` | Sign of number (-1, 0, 1) |
| `max()` / `min()` | Maximum/minimum |
| `sum()` | Sum of elements |
| `prod()` | Product of elements |
| `scale()` | Standardize (center and scale) |

**Example:**
```r
sqrt(16)
log(100)
round(3.7)
abs(-5)
scale(df$column)
```

---

## **15. Date & Time**

Functions for working with dates and times.

| Function | Purpose |
|----------|---------|
| `Sys.Date()` | Current date |
| `Sys.time()` | Current date and time |
| `as.Date()` | Convert to date |
| `as.POSIXct()` / `as.POSIXlt()` | Convert to datetime |
| `format()` | Format date/time |
| `strptime()` | Parse date string |
| `difftime()` | Difference between dates |
| `seq.Date()` | Sequence of dates |
| `lubridate::ymd()` | Parse year-month-day format |
| `lubridate::dmy()` | Parse day-month-year format |
| `date()` | Current system date as text |

**Example:**
```r
as.Date("2026-03-09")
format(Sys.Date(), "%Y-%m-%d")
difftime(date2, date1, units = "days")
seq(as.Date("2026-01-01"), as.Date("2026-12-31"), by = "month")
```

---

## **16. Data Import & Export**

Functions for reading and writing data files.

| Function | Purpose |
|----------|---------|
| `read.csv()` | Read CSV file |
| `write.csv()` | Write CSV file |
| `read.table()` | Read delimited text file |
| `write.table()` | Write delimited text file |
| `read.delim()` | Read tab-delimited file |
| `read.fwf()` | Read fixed-width file |
| `readLines()` | Read text file as lines |
| `writeLines()` | Write lines to file |
| `readRDS()` | Load R object |
| `saveRDS()` | Save R object |
| `load()` | Load R workspace |
| `save()` | Save R objects |
| `readxl::read_excel()` | Read Excel file |
| `openxlsx::write.xlsx()` | Write Excel file |
| `jsonlite::read_json()` | Read JSON |
| `jsonlite::write_json()` | Write JSON |
| `haven::read_sav()` | Read SPSS file |
| `foreign::read.spss()` | Read SPSS (alternative) |

**Example:**
```r
df <- read.csv("data.csv")
write.csv(df, "output.csv", row.names = FALSE)
saveRDS(df, "data.rds")
df <- readRDS("data.rds")
df <- readxl::read_excel("data.xlsx", sheet = 1)
```

---

## **17. Visualization (Base R)**

Functions for creating plots with base R graphics.

| Function | Purpose |
|----------|---------|
| `plot()` | Basic scatter/line plot |
| `hist()` | Histogram |
| `boxplot()` | Box plot |
| `barplot()` | Bar chart |
| `density()` | Kernel density estimate |
| `pairs()` | Scatter plot matrix |
| `pie()` | Pie chart |
| `curve()` | Plot mathematical curve |
| `lines()` | Add lines to plot |
| `points()` | Add points to plot |
| `abline()` | Add line (a + bx) |
| `legend()` | Add legend |
| `title()` | Add title |
| `axis()` | Customize axes |
| `grid()` | Add grid lines |
| `par()` | Set graphics parameters |
| `layout()` | Custom multi-panel layout |
| `mfrow` | Multi-panel plots (rows, columns) |

**Example:**
```r
plot(x, y)
hist(df$income, breaks = 30)
boxplot(salary ~ department, data = df)
barplot(table(df$category))
legend("topleft", legend = c("A", "B"), col = c(1, 2), lty = 1)
par(mfrow = c(2, 2))  # 2x2 plot layout
```

---

## **18. Visualization (ggplot2)**

Modern grammar of graphics for professional visualizations.

| Function | Purpose |
|----------|---------|
| `ggplot()` | Initialize plot and map aesthetics |
| `aes()` | Define aesthetic mappings |
| `geom_point()` | Scatter plot |
| `geom_line()` | Line graph |
| `geom_smooth()` | Add smoothing curve |
| `geom_histogram()` | Histogram |
| `geom_boxplot()` | Box plot |
| `geom_bar()` | Bar chart |
| `geom_density()` | Density plot |
| `geom_violin()` | Violin plot |
| `geom_jitter()` | Scatter with jitter |
| `facet_wrap()` | Multiple plots by variable |
| `facet_grid()` | Grid of plots |
| `labs()` | Add labels and titles |
| `theme()` | Customize appearance |
| `scale_*()` | Customize scales |
| `coord_*()` | Customize coordinates |
| `ggsave()` | Save plot to file |

**Example:**
```r
ggplot(df, aes(x = age, y = salary, color = department)) +
  geom_point() +
  geom_smooth(method = "lm") +
  facet_wrap(~ gender) +
  labs(title = "Salary by Age", x = "Age", y = "Salary") +
  theme_minimal()

ggsave("plot.png", width = 10, height = 6)
```

---

## **19. Control Flow**

Functions for controlling execution flow.

| Function | Purpose |
|----------|---------|
| `if()` | Conditional execution |
| `else` | Else clause |
| `ifelse()` | Vectorized conditional (returns vector) |
| `for()` | For loop |
| `while()` | While loop |
| `repeat` | Repeat loop (infinite) |
| `break` | Exit loop |
| `next` | Skip iteration |
| `switch()` | Multi-way branching |
| `try()` | Try-catch error handling |
| `tryCatch()` | Catch specific errors |
| `warning()` | Issue warning message |
| `stop()` | Stop with error message |

**Example:**
```r
if (x > 10) {
  print("Greater than 10")
} else {
  print("Less than or equal to 10")
}

for (i in 1:10) {
  if (i == 5) break
  print(i)
}

switch(choice,
  "a" = print("Choice A"),
  "b" = print("Choice B"),
  print("Invalid choice"))
```

---

## **20. Function Definition & Environment**

Functions for defining and managing functions.

| Function | Purpose |
|----------|---------|
| `function()` | Define function |
| `return()` | Return value from function |
| `environment()` | Get/set environment |
| `args()` | Function arguments |
| `formals()` | Get formal parameters |
| `body()` | Get function body |
| `do.call()` | Call function with list of arguments |
| `match.call()` | Match function call |
| `eval()` | Evaluate expression |
| `parse()` | Parse text as expression |
| `substitute()` | Substitute values in expression |
| `quote()` | Quote expression |
| `deparse()` | Convert expression to string |

**Example:**
```r
my_function <- function(x, y = 10) {
  result <- x + y
  return(result)
}

my_function(5)        # Uses default y = 10
my_function(5, 20)    # Uses y = 20

args(mean)
do.call(paste, list("a", "b", "c"))
```

---

## **21. File & Directory Operations**

Functions for working with files and directories.

| Function | Purpose |
|----------|---------|
| `getwd()` | Get working directory |
| `setwd()` | Set working directory |
| `dir()` / `list.files()` | List files in directory |
| `file.exists()` | Check if file exists |
| `file.create()` | Create empty file |
| `file.remove()` | Delete file |
| `file.rename()` | Rename file |
| `file.copy()` | Copy file |
| `file.path()` | Construct file path |
| `basename()` | Get filename from path |
| `dirname()` | Get directory from path |
| `dir.create()` | Create directory |
| `list.dirs()` | List directories |
| `file.info()` | Get file information |

**Example:**
```r
getwd()
setwd("~/my_project")
dir()
file.exists("data.csv")
list.files(pattern = "\\.csv$")
```

---

## **22. Environment & Workspace Management**

Functions for managing R environment and workspace.

| Function | Purpose |
|----------|---------|
| `ls()` | List objects in workspace |
| `ls.str()` | List objects with structure |
| `rm()` | Remove objects |
| `remove()` | Remove objects (same as rm) |
| `exists()` | Check if object exists |
| `get()` | Get object by name |
| `assign()` | Assign value to object by name |
| `objects()` | List objects (same as ls) |
| `search()` | Search path for packages |
| `searchpaths()` | Package search paths |
| `library()` | Load package |
| `require()` | Load package (returns logical) |
| `attach()` | Attach data frame/list |
| `detach()` | Detach data frame/list |
| `data()` | Load built-in datasets |

**Example:**
```r
ls()
rm(x, y, z)
exists("df")
get("df")
library(dplyr)
data(iris)
```

---

## **23. Sorting & Ordering**

Functions for arranging data.

| Function | Purpose |
|----------|---------|
| `sort()` | Sort vector values |
| `order()` | Get sorting indices |
| `rank()` | Rank values |
| `rev()` | Reverse order |
| `arrange()` | (dplyr) Sort data frame |
| `sort.list()` | Sort indices |

**Example:**
```r
sort(c(3, 1, 4, 1, 5, 9))
order(df$age)                      # Get indices sorted by age
df[order(df$age), ]                # Sort data frame by age
rank(c(10, 20, 15, 25))            # Ranks: 1, 3, 2, 4
rev(c(1, 2, 3, 4, 5))              # 5, 4, 3, 2, 1
```

---

## **24. Utility & Miscellaneous Functions**

Useful functions that don't fit other categories.

| Function | Purpose |
|----------|---------|
| `print()` | Print object |
| `cat()` | Concatenate and print |
| `message()` | Print message |
| `sprintf()` | Formatted string printing |
| `head()` / `tail()` | View first/last elements |
| `help()` / `?` | Get help documentation |
| `example()` | Run function examples |
| `demo()` | Run demonstrations |
| `set.seed()` | Set random seed for reproducibility |
| `sample()` | Random sample |
| `split()` | Split data by factor |
| `Reduce()` | Accumulate/fold function |
| `Filter()` | Filter elements |
| `Map()` | Apply to multiple arguments |
| `Vectorize()` | Vectorize non-vectorized function |
| `source()` | Run R script |
| `system()` | Execute system command |
| `Sys.time()` / `Sys.Date()` | Current time/date |
| `proc.time()` | CPU time used |
| `memory.limit()` | Memory limit |

**Example:**
```r
set.seed(123)
sample(1:100, 10)                  # Random sample without replacement
sample(1:100, 10, replace = TRUE)  # With replacement

print(df)
cat("Value:", 42, "\n")
help(lm)
?lm
example(plot)

Reduce("+", 1:10)                  # Sum 1:10 using Reduce
Filter(function(x) x > 5, 1:10)    # Elements > 5
```

---

## **Quick Reference by Task**

### **Want to filter rows?**
- Base R: `subset()`, `which()`, `[`
- dplyr: `filter()`

### **Want to select columns?**
- Base R: `select()`, `[`, `$`, `[[`
- dplyr: `select()`

### **Want to add/modify columns?**
- Base R: `transform()`, `within()`, `$`
- dplyr: `mutate()`

### **Want to group and summarize?**
- Base R: `aggregate()`, `tapply()`, `by()`
- dplyr: `group_by() %>% summarize()`

### **Want to reshape data?**
- Base R: `reshape()`, `stack()`, `unstack()`
- dplyr: `pivot_longer()`, `pivot_wider()`

### **Want to apply function to multiple elements?**
- `apply()`, `lapply()`, `sapply()`, `mapply()`, `tapply()`

### **Want to create a plot?**
- Base R: `plot()`, `hist()`, `boxplot()`, `barplot()`
- ggplot2: `ggplot()` + `geom_*()`

### **Want to read/write data?**
- CSV: `read.csv()`, `write.csv()`
- Excel: `readxl::read_excel()`, `openxlsx::write.xlsx()`
- R objects: `saveRDS()`, `readRDS()`

### **Want to test statistical significance?**
- `t.test()`, `anova()`, `chisq.test()`, `cor.test()`

### **Want to fit a regression model?**
- `lm()` (linear), `glm()` (generalized linear), `predict()` (predictions)

---

## **Cheat Sheet Summary**

| Category | Key Functions |
|----------|---------------|
| **Exploration** | `head()`, `str()`, `summary()`, `glimpse()` |
| **Type Conversion** | `as.numeric()`, `as.character()`, `as.factor()` |
| **Filtering** | `subset()`, `filter()`, `which()` |
| **Selecting** | `select()`, `[`, `$` |
| **Transforming** | `mutate()`, `transform()`, `$` |
| **Grouping** | `group_by()`, `aggregate()`, `tapply()` |
| **Summarizing** | `summarize()`, `aggregate()`, `summary()` |
| **Reshaping** | `pivot_longer()`, `pivot_wider()`, `reshape()` |
| **Looping** | `apply()`, `lapply()`, `sapply()`, `for()` |
| **Strings** | `paste()`, `gsub()`, `grep()`, `nchar()` |
| **Math** | `mean()`, `sum()`, `sqrt()`, `abs()` |
| **Stats** | `lm()`, `t.test()`, `cor()`, `anova()` |
| **Dates** | `as.Date()`, `format()`, `difftime()` |
| **Files** | `read.csv()`, `write.csv()`, `readRDS()` |
| **Plotting** | `plot()`, `ggplot()`, `hist()`, `boxplot()` |

---

**Last Updated:** March 2026
**Total Functions Covered:** 200+
