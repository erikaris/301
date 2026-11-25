# Introduction to R and RStudio for Absolute Beginners

*A practical, step-by-step tutorial for students from any discipline*

## Who is this tutorial for?

This tutorial is for anyone who is new to R, including people who have never written code before. You do not need prior programming or statistics knowledge. The examples use simple numbers and a fictional dataset, so you can work through them regardless of your subject area.

**By the end, you should be able to:**

1. Recognise the main parts of RStudio.
2. Run simple commands and read their output.
3. Create objects, vectors, and data frames.
4. Calculate basic descriptive statistics.
5. Make and label a simple graph.
6. Read a CSV file and save your script.
7. Understand and troubleshoot common beginner errors.

**How to use this tutorial:** Work through the sections in order. Type the code yourself when possible, run one line or short block at a time, and check your results against the examples. All sample data are fictional.

---

## 1. What are R and RStudio?

**R** is a programming language for working with data. You can use it to perform calculations, organise datasets, compute statistics, and make visualisations.

**RStudio** is an application that makes it easier to write and run R code. R is the language; RStudio is an environment for using it. Think of R as the engine and RStudio as the dashboard.

To follow this tutorial on your own computer, install **R** from [CRAN](https://cran.r-project.org/) and then **RStudio Desktop** from [Posit](https://posit.co/download/rstudio-desktop/). If your university or workplace already provides them, you may not need to install anything.

### The main areas of RStudio

Depending on your screen layout, RStudio usually has four main panes:

| Area | What it is for | Beginner-friendly analogy |
|---|---|---|
| Source (script editor) | Write, edit, and save commands | A notebook of instructions |
| Console | Run commands and view results | A calculator that understands R |
| Environment | See the objects you have created | A list of labelled storage boxes |
| Files, Plots, Packages, Help | Browse files, inspect graphs, and look up help | Your toolbox |

You can type a command directly into the **Console** and press **Enter**. To keep your work, it is usually better to type commands in an **R script**.

### Create and run your first script

1. In RStudio, select **File → New File → R Script**.
2. Type `2 + 3` on the first line.
3. Put your cursor on that line.
4. Press **Ctrl + Enter** (Windows/Linux) or **Cmd + Enter** (Mac), or use the **Run** button.
5. Find the result in the **Console**.
6. Save your script using **File → Save As**, for example `my_first_r_script.R`.

**Important:** A script is a file containing commands. The Console shows commands that have run and their output. Saving a script does not automatically save everything displayed in the Console.

---

## 2. R as a calculator

Start with commands you already understand: arithmetic.

```r
# Add two numbers
2 + 3

# Subtract
10 - 4

# Multiply (use *, not x)
5 * 2

# Divide
20 / 4

# Raise 2 to the power of 3
2^3
```

**Expected results:**

```text
> 2 + 3
[1] 5
> 10 - 4
[1] 6
> 5 * 2
[1] 10
> 20 / 4
[1] 5
> 2^3
[1] 8
```

### How to read the Console

- `>` is the prompt: R is ready for a command.
- `[1]` tells you that the first displayed element starts at position 1. It is **not** part of the numerical answer.
- The number after `[1]` is the result of the calculation.

### Comments: what does `#` mean?

Everything after `#` on a line is treated as a **comment** and is not executed as code. Comments help you understand your work later.

```r
# This line is just a note
2 + 3  # R calculates this expression; the rest is a comment
```

**Try it:** Predict the answer to `8 + 7`, then run it yourself.

---

## 3. Objects: how R remembers information

An **object** is information stored under a name. You create or update an object with the assignment operator `<-`.

```r
# Store a number in an object named score
score <- 72

# Display the stored number
score

# Use the stored number in a calculation
score + 5
```

**Expected Console output:**

```text
> score <- 72
> score
[1] 72
> score + 5
[1] 77
```

Think of `score` as a labelled box containing `72`.

**Notice:** The assignment `score <- 72` does not normally print a result. You can see `score` in the Environment pane or type its name to display it.

### Calculating is not the same as updating

```r
# This calculates 77 but leaves score unchanged
score + 5

# Check: score is still 72
score

# This changes the value stored in score
score <- score + 5

# Check: score is now 77
score
```

Object names are **case-sensitive**: `score`, `Score`, and `SCORE` are different names. Choose clear names without spaces, such as `test_score` or `daily_steps`.

**Try it:** Create an object called `age` with any fictional number, then calculate `age + 1`. Check whether the stored value changed.

---

## 4. Vectors: storing several values

A **vector** stores multiple values together. The function `c()` means *combine*.

Imagine five fictional students received these marks: 68, 72, 75, 70, and 65.

```r
# Combine five marks into one numeric vector
marks <- c(68, 72, 75, 70, 65)

# Display the values
marks

# Count how many values are stored
length(marks)
```

**Expected output:**

```text
> marks
[1] 68 72 75 70 65
> length(marks)
[1] 5
```

Each element of a vector has a position. R starts counting positions at **1**, not 0.

```r
# Display the first value (68)
marks[1]

# Display the third value (75)
marks[3]
```

### Working with text

Text values need quotation marks:

```r
# Create a character vector of names
names <- c("Alex", "Sam", "Taylor", "Jordan", "Casey")

# Display the second name
names[2]
```

**Expected output:**

```text
[1] "Sam"
```

**Try it:** Create a vector of four numbers of your choosing. Use `length()` to count them and `[2]` to display the second value.

---

## 5. Functions and descriptive statistics

A **function** is a ready-made instruction that performs a task. For example, `mean()` calculates an arithmetic average.

Using our five fictional marks:

```r
# Store the data (run this first if you have started a new session)
marks <- c(68, 72, 75, 70, 65)

# Calculate the arithmetic mean
mean(marks)

# Find the smallest value
min(marks)

# Find the largest value
max(marks)

# Find the median (middle value when sorted)
median(marks)

# Calculate the sample standard deviation
sd(marks)

# Display several descriptive statistics at once
summary(marks)
```

**Expected results:**

```text
> mean(marks)
[1] 70
> min(marks)
[1] 65
> max(marks)
[1] 75
> median(marks)
[1] 70
> sd(marks)
[1] 3.807887
> summary(marks)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
   65.0    68.0    70.0    70.0    72.0    75.0
```

### What do these results mean?

| Statistic | Result | Interpretation |
|---|---:|---|
| Number of observations | 5 | There are five marks. |
| Mean | 70 | Their arithmetic average is 70. |
| Median | 70 | The middle mark after sorting is 70. |
| Minimum | 65 | The lowest mark is 65. |
| Maximum | 75 | The highest mark is 75. |
| Sample standard deviation | About 3.81 | The marks vary around their mean; larger SD generally indicates more spread. |

These statistics **describe the five values**. They do not, by themselves, tell us anything about the wider student population.

### Missing values (`NA`)

Real datasets sometimes have missing observations, represented by `NA` in R.

```r
# One mark is missing
marks_with_missing <- c(68, 72, NA, 70, 65)

# By default, the mean cannot be calculated with NA present
mean(marks_with_missing)

# Calculate a mean using only the available values
mean(marks_with_missing, na.rm = TRUE)
```

**Expected output:**

```text
> mean(marks_with_missing)
[1] NA
> mean(marks_with_missing, na.rm = TRUE)
[1] 68.75
```

`na.rm = TRUE` tells R to remove missing values **for this calculation**. It does not delete them from the original vector. In a real analysis, consider why data are missing before deciding how to handle them.

**Try it:** Find the mean of `c(10, 12, 14, 16)` without using a calculator, then check it with R.

---

## 6. Data frames: working with tables

A **data frame** is a table with rows and columns, similar to a spreadsheet. Rows often represent observations (for example, people, experiments, or days), while columns represent variables.

Create a small, fictional dataset:

```r
# Create a column of participant IDs (text)
participant <- c("P01", "P02", "P03", "P04", "P05")

# Create a column of test marks (numbers)
mark <- c(68, 72, 75, 70, 65)

# Create a column of study hours (numbers)
study_hours <- c(4, 5, 7, 6, 3)

# Combine the three columns into one data frame
students <- data.frame(participant, mark, study_hours)

# Print the entire table
students

# Show the first few rows
head(students)

# Inspect the data types and structure
str(students)

# Open the table in RStudio's data viewer
View(students)
```

**Expected printed table:**

```text
  participant mark study_hours
1         P01   68           4
2         P02   72           5
3         P03   75           7
4         P04   70           6
5         P05   65           3
```

### What does `$` mean?

Use `$` to select a named column from a data frame.

```r
# Display the mark column
students$mark

# Calculate the average mark
mean(students$mark)

# Calculate the average study time
mean(students$study_hours)
```

**Expected output:**

```text
> students$mark
[1] 68 72 75 70 65
> mean(students$mark)
[1] 70
> mean(students$study_hours)
[1] 5
```

Read `students$mark` as: *the `mark` column in the `students` table*.

**Try it:** Add a new variable, `attendance <- c(90, 95, 100, 85, 80)`, then create a data frame that includes it.

---

## 7. Making your first graphs

Graphs help you understand and communicate patterns. Base R can make many graphs without installing additional packages.

### A histogram: distribution of one numeric variable

A histogram groups numeric observations into intervals (bins) and shows how many fall into each interval.

```r
# Create a histogram of the fictional marks
hist(students$mark,
     main = "Distribution of marks",    # Graph title
     xlab = "Mark",                     # Horizontal-axis label
     ylab = "Frequency",                # Vertical-axis label
     col = "lightblue")                 # Bar colour
```

The graph should appear in RStudio's **Plots** pane. Its exact bin boundaries depend on R's default binning. With only five observations, this is mainly a demonstration of how plotting works.

### A scatter plot: relationship between two numeric variables

```r
# Plot study hours on the horizontal axis and marks on the vertical axis
plot(students$study_hours, students$mark,
     main = "Study hours and marks",   # Graph title
     xlab = "Study hours",             # Horizontal-axis label
     ylab = "Mark",                    # Vertical-axis label
     pch = 19,                         # Solid circular points
     col = "darkblue")                 # Point colour
```

Each point represents one fictional student. A pattern in these five points is **not enough to establish causation** or generalise to other students.

**Try it:** Change the histogram's `col` to `"pink"`, run the code again, and see what changes.

---

## 8. Files, working directories, and CSV data

### What is a working directory?

The **working directory** is the default folder R uses to find and save files when you provide a relative file path.

```r
# Show the current working directory
getwd()

# List files inside that directory
list.files()
```

You can also use **Session → Set Working Directory → Choose Directory** in RStudio (menu wording may vary by version). Alternatively, `setwd()` can change the directory, but the example folder must actually exist:

```r
# EXAMPLE ONLY: replace with a real folder path on your computer
# setwd("C:/Users/Student/Documents/R_Practice")
```

The example is commented out so it will not cause an error if you run the tutorial as written.

### Import a CSV file

A CSV (comma-separated values) file stores data in a text-based table format. Suppose a file named `students.csv` is in your working directory and contains the following:

```csv
participant,mark,study_hours
P01,68,4
P02,72,5
P03,75,7
P04,70,6
P05,65,3
```

To load it:

```r
# Read the CSV file into a data frame
students_from_file <- read.csv("students.csv")

# Check that the file loaded correctly
head(students_from_file)

# Inspect column names and data types
str(students_from_file)

# Calculate the average mark
mean(students_from_file$mark)
```

**Expected average:** `70`.

If R says the file cannot be opened, first check the **file name**, **file location**, and **working directory**. The code above requires an actual file called `students.csv` to exist in that folder.

### Export a CSV file

You can save the data frame created earlier in the tutorial:

```r
# Save a data frame to a CSV file in the working directory
write.csv(students, "students_output.csv", row.names = FALSE)

# Check whether the output file is now present
list.files()
```

`row.names = FALSE` avoids writing an extra column of row numbers.

### Saving and reusing your code

Save scripts with the `.R` extension, such as `intro_to_r.R`. A script saves **the commands**, not necessarily the objects currently stored in the Environment. If you close R and reopen it, you can usually recreate your results by rerunning the saved script from the beginning, as long as required input files are available.

---

## 9. Common R errors and how to fix them

Getting errors is a normal part of using R. The goal is not to avoid every mistake; it is to learn how to read messages and investigate them.

| What happened | Example | What to check |
|---|---|---|
| Object not found | `mean(markss)` | Was the object created? Is its name spelled correctly? |
| Function name not found | `Mean(marks)` | R is case-sensitive. Use `mean()` instead. |
| Missing closing bracket | `mean(marks` | Finish the command with `)`. |
| Missing quotation mark | `"Hello` | Add a closing quotation mark. |
| Missing comma | `c(4 5 6)` | Separate values with commas: `c(4, 5, 6)`. |
| Unexpected missing result | `mean(c(3, NA, 5))` | Do the data contain `NA`? |
| File cannot be opened | `read.csv("unknown.csv")` | Is the file in the right folder? Is the name correct? |
| Command depends on missing object | `mean(students$mark)` before creating `students` | Run the code that creates the object first. |

### Example: object not found

```r
# Mistyped object name (this produces an error)
mean(markss)
```

**Typical error:**

```text
Error: object 'markss' not found
```

Correct it by using the name that actually exists:

```r
# Correct object name
mean(marks)
```

**Expected result:**

```text
[1] 70
```

### What does the `+` prompt mean?

If you type an incomplete expression such as:

```r
mean(marks
```

R may show `+` instead of `>`. The `+` prompt means R is **waiting for you to finish the command**. Type `)` and press Enter, or press **Esc** to cancel the unfinished expression.

### A simple troubleshooting checklist

1. Read the error message rather than deleting everything.
2. Check spelling, capitalisation, commas, brackets, and quotation marks.
3. Check that the necessary objects have been created.
4. Check any file names and paths.
5. Run the smallest piece of code that might reveal the problem.
6. If necessary, search the exact error message or use R's help system, for example `?mean`.

---

## 10. A complete practice script

This self-contained script does not require additional packages or external files. Paste it into a new R script and run it **from top to bottom**.

```r
# ========================================================
# INTRODUCTION TO R: COMPLETE BEGINNER PRACTICE
# All data are fictional.
# ========================================================

# 1. Basic arithmetic
2 + 3                        # Add two numbers
4 * 5                        # Multiply two numbers
20 / 2                       # Divide two numbers

# 2. Create and use an object
score <- 72                  # Store a value
score                        # Display the stored value
score + 5                    # Calculate a result without changing score
score <- score + 5           # Update score
score                        # Display the updated score: 77

# 3. Create a numeric vector
marks <- c(68, 72, 75, 70, 65)  # Combine five values
marks                           # Print the vector
length(marks)                   # Count observations: 5
mean(marks)                     # Mean: 70
median(marks)                   # Median: 70
min(marks)                      # Minimum: 65
max(marks)                      # Maximum: 75
sd(marks)                       # Sample SD: about 3.81
summary(marks)                  # Summary statistics

# 4. Create a data frame
participant <- c("P01", "P02", "P03", "P04", "P05") # IDs
study_hours <- c(4, 5, 7, 6, 3)                    # Hours
students <- data.frame(participant, mark = marks, study_hours)
students                                            # Display data
mean(students$study_hours)                          # Mean hours: 5

# 5. Make a histogram
hist(students$mark,                  # Variable to plot
     main = "Distribution of marks", # Graph title
     xlab = "Mark",                  # X-axis label
     ylab = "Frequency",             # Y-axis label
     col = "lightblue")              # Bar colour

# 6. Make a scatter plot
plot(students$study_hours, students$mark,  # X and Y variables
     main = "Study hours and marks",       # Graph title
     xlab = "Study hours",                 # X-axis label
     ylab = "Mark",                        # Y-axis label
     pch = 19)                             # Solid circular points

# 7. Export the data
write.csv(students, "students_output.csv", row.names = FALSE)

# 8. Confirm that the output file exists
file.exists("students_output.csv")   # TRUE if successfully saved
```

---

## 11. Practice exercises

Try these yourself before looking at the suggested answers.

**Exercise 1: Calculator**  
Use R to calculate `12 + 8`, `9 * 4`, and `100 / 5`.

**Exercise 2: Objects**  
Create an object called `price` and store `15` in it. Calculate `price * 2`. Does the stored `price` change?

**Exercise 3: Vectors**  
Create a vector called `values` containing `10, 15, 20, 25, 30`. Display the third value and count the observations.

**Exercise 4: Descriptive statistics**  
Calculate the mean, median, minimum, maximum, and sample standard deviation of `values`.

**Exercise 5: Data frames**  
Create a table with five fictional participant names and the five values from Exercise 3. Call it `results`. Calculate the average of the numeric column.

**Exercise 6: Plotting**  
Create a histogram of the numeric column in `results`, give it a title, and change its colour.

**Exercise 7: Troubleshooting**  
Why does `Mean(values)` fail when `mean(values)` works?

### Suggested answers

```r
# Exercise 1
12 + 8                      # 20
9 * 4                       # 36
100 / 5                     # 20

# Exercise 2
price <- 15                 # Store 15
price * 2                   # 30; price itself remains 15
price                       # 15

# Exercise 3
values <- c(10, 15, 20, 25, 30)  # Create the vector
values[3]                   # 20
length(values)              # 5

# Exercise 4
mean(values)                # 20
median(values)              # 20
min(values)                 # 10
max(values)                 # 30
sd(values)                  # Approximately 7.905694

# Exercise 5
participant <- c("A", "B", "C", "D", "E")
results <- data.frame(participant, value = values)
results                     # Show the table
mean(results$value)         # 20

# Exercise 6
hist(results$value,
     main = "Distribution of values",
     xlab = "Value",
     ylab = "Frequency",
     col = "pink")

# Exercise 7
# R is case-sensitive: Mean and mean are different names.
# The built-in function is mean().
```

---

## 12. Quick reference: the most useful commands

| Command | Purpose | Example |
|---|---|---|
| `#` | Add a comment | `# My analysis` |
| `<-` | Assign a value | `x <- 10` |
| `c()` | Combine values | `c(2, 4, 6)` |
| `length()` | Count elements | `length(c(2, 4, 6))` |
| `mean()` | Arithmetic mean | `mean(c(2, 4, 6))` |
| `median()` | Median | `median(c(2, 4, 6))` |
| `min()` / `max()` | Minimum / maximum | `max(c(2, 4, 6))` |
| `sd()` | Sample standard deviation | `sd(c(2, 4, 6))` |
| `summary()` | Summary statistics | `summary(c(2, 4, 6))` |
| `data.frame()` | Create a table | `data.frame(id = 1:3, value = c(2, 4, 6))` |
| `$` | Select a column | `students$mark` |
| `head()` | Preview first rows | `head(students)` |
| `str()` | Inspect data structure | `str(students)` |
| `hist()` | Create a histogram | `hist(marks)` |
| `plot()` | Make a basic plot | `plot(1:5, 6:10)` |
| `getwd()` | Show working directory | `getwd()` |
| `list.files()` | List files | `list.files()` |
| `read.csv()` | Import a CSV file | `read.csv("students.csv")` |
| `write.csv()` | Export a CSV file | `write.csv(students, "out.csv", row.names = FALSE)` |
| `?` | Open help for a function | `?mean` |

---

## 13. Where to go next

Once you feel comfortable with the ideas in this tutorial, useful next topics include:

- Choosing appropriate graphs for different types of data.
- Cleaning data and dealing with missing values.
- Using the `dplyr` package to filter and summarise tables.
- Using the `ggplot2` package to create custom visualisations.
- Understanding sampling, uncertainty, and basic statistical tests.
- Keeping projects reproducible with RStudio Projects.

You do **not** need to memorise every function. Save useful examples, revisit your scripts, and focus on understanding what each line does. A little regular practice is more valuable than trying to learn everything at once.

### Helpful resources

- [R Project](https://www.r-project.org/) — information about R.
- [CRAN](https://cran.r-project.org/) — R downloads, packages, and documentation.
- [Posit RStudio](https://posit.co/products/open-source/rstudio/) — RStudio information and learning materials.
- [R for Data Science (2e)](https://r4ds.hadley.nz/) — free online book for working with data in R.

---

*End of tutorial.*
