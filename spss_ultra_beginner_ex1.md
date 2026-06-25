Here is the step-by-step text you can copy or use to guide you through the exercise in SPSS:

### Step 1: Set Up Variables in "Variable View"

Click the **Variable View** tab at the bottom left and create your 5 variables line-by-line using these settings:

1. **Name:** `CafeName` | **Type:** String | **Label:** Name of cafe | **Measure:** Nominal
2. **Name:** `Hygiene` | **Type:** Numeric | **Label:** Hygiene rating (1-5) | **Measure:** Ordinal
* *(Note: Go to the **Values** column for Hygiene, click the three dots, and set up your labels: `1 = Poor`, up to `5 = Excellent` so it has numeric codes).*


3. **Name:** `Spent` | **Type:** Dollar (or Numeric) | **Label:** Amount of Money Spent | **Measure:** Scale
4. **Name:** `DrinkString` | **Type:** String | **Label:** Drink (Tea or coffee) | **Measure:** Nominal
5. **Name:** `TravelTime` | **Type:** Numeric | **Label:** Travel time in minutes | **Measure:** Scale

---

### Step 2: Enter the Data in "Data View"

Switch to the **Data View** tab at the bottom left. Type the information into the rows exactly like this:

| CafeName | Hygiene | Spent | DrinkString | TravelTime |
| --- | --- | --- | --- | --- |
| Tast-E-Bite | 3 | 12.50 | Tea | 5 |
| Rick’s Cafe | 5 | 16.00 | Coffee | 26 |
| Central Perk | 5 | 9.75 | Coffee | 18 |
| Mos Eisley Cantina | 4 | 21.45 | Tea | 12 |

---

### Step 3: Run "Automatic Recode" for the Drink Variable

To automatically turn the text ("Tea" and "Coffee") into clean numeric codes (`1` and `2`) without retyping them:

1. Go to the top menu and click **Transform > Automatic Recode...**
2. Select your string variable (**Drink (Tea or coffee) [DrinkString]**) from the left list and click the arrow button to move it into the *Variable -> New Name* box.
3. In the **New Name** text box on the right, type a new name for your coded variable (e.g., `Drink_Numeric`).
4. Click the **Add New Name** button.
5. Click **OK**.

SPSS will instantly create a brand new numeric column at the end of your dataset where **Coffee** and **Tea** are safely converted into numbers with their underlying value labels automatically assigned!
