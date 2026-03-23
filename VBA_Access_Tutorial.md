# VBA for Microsoft Access - Complete Tutorial

## 1. Introduction

VBA (Visual Basic for Applications) is a programming language built into Microsoft Office that allows you to automate tasks and add intelligence to your databases. In Microsoft Access, VBA enables you to:

- Automate repetitive data entry tasks
- Validate data before it enters the database
- Perform calculations and transformations
- Create custom user interfaces for data input
- Trigger actions based on user events (button clicks, field changes, etc.)

---

## 2. VBA Fundamentals

### 2.1 Where Does VBA Code Live?

In Microsoft Access, VBA code is stored in **Form Modules**. Every form has an associated VBA editor where you can write code.

To access it:
1. Open your form in Design View
2. Right-click the form and select **View Code**
3. The VBA Editor window opens

### 2.2 Events - The Heart of Form Automation

Events are actions that happen when users interact with your form. VBA responds to these events with code. Here are the most important ones:

| Event | When It Fires |
|-------|---------------|
| `Form_Load` | When the form first opens (good for setting defaults) |
| `FieldName_AfterUpdate` | When user types into a field and leaves it (good for validation) |
| `FieldName_BeforeUpdate` | Right before user's entry is saved (last chance to reject bad data) |
| `ButtonName_Click` | When user clicks a button |
| `CheckboxName_Click` | When user checks or unchecks a checkbox |

### 2.3 Basic Syntax

**Variables (storing data):**
```vba
Dim variableName As DataType
```

**Reading a value from a field:**
```vba
Dim age As Integer
age = Me.AgeField.Value
```

**Setting a field's value:**
```vba
Me.PatientName.Value = "John Smith"
```

**If statement (making decisions):**
```vba
If Me.Age.Value < 18 Then
    MsgBox "Age must be 18 or older"
End If
```

---

## 3. Case Study 1: Patient Registration Form

A medical researcher needs a form to register new patients. The form should validate data entry and calculate BMI automatically. This case study shows you the complete process from database design to VBA code.

### Step 1: Create a New Database

1. Open Microsoft Access
2. Click **"Blank Database"**
3. Name it **"PatientRegistration.accdb"**
4. Click **"Create"**

### Step 2: Create the Patients Table

You need a table to store patient data. Here's what to do:

1. In the Access interface, click the **"Create"** tab
2. Click **"Table Design"**
3. You'll see a blank table. Add these fields by typing in the first column:

| Field Name | Data Type |
|------------|-----------|
| PatientID | Text |
| PatientName | Text |
| Age | Number |
| Height | Number (in cm) |
| Weight | Number (in kg) |
| BMI | Number (calculated) |
| BMICategory | Text |

After entering all fields:

1. Right-click the **"PatientID"** row and select **"Primary Key"**
2. Press **Ctrl+S** and name it **"Patients"**
3. Close the table

### Step 3: Create a Form for Data Entry

Now create a user-friendly form:

1. Click the **"Create"** tab
2. Click **"Form Design"**
3. A blank form appears with a design grid

Now set up the form data source:

1. Right-click on the gray form background
2. Click **"Form Properties"**
3. Find **"Record Source"** and set it to **"Patients"**
4. Close the properties panel

### Step 4: Add Form Controls (Labels and Text Boxes)

You'll add labels and text boxes. Here's how for the first field:

**Adding a Label:**
1. On the **"Design"** tab, look for **"Label"**
2. Click it, then drag on the form to create a label
3. Type **"Patient ID:"**

**Adding a Text Box:**
1. Click **"Text Box"** on the Design tab
2. Drag to create a text box next to the label
3. Right-click the text box and select **"Properties"**
4. Change the **"Name"** from "Text1" to **"PatientID"**
5. In the "Data" tab, set **"Control Source"** to **"PatientID"**

**Repeat this process for all fields:**

| Label Text | Text Box Name | Control Source |
|------------|---------------|-----------------|
| Patient ID: | PatientID | PatientID |
| Name: | PatientName | PatientName |
| Age: | Age | Age |
| Height (cm): | Height | Height |
| Weight (kg): | Weight | Weight |
| BMI: | BMI | BMI |
| BMI Category: | BMICategory | BMICategory |

Finally, add buttons for saving:

1. Click **"Button"** and drag to create a button
2. Right-click and select **"Properties"**
3. Name it **"SaveButton"**
4. Set **"Caption"** to **"Save"**

### Step 5: Add VBA Code

Now the form is ready. It's time to add the VBA code that will validate data and calculate BMI.

Right-click anywhere on the form and select **"View Code"**. The VBA editor opens.

#### 5.1 Validate Patient ID

In the VBA editor, on the left side, find the dropdown that says **"(General)"**. Click it and select **"PatientID"**. Another dropdown appears on the right showing **"AfterUpdate"**. Click it. VBA creates the event handler automatically.

Now paste this code:

```vba
Private Sub PatientID_AfterUpdate()
    ' This runs after user enters a Patient ID and leaves the field
    
    ' Check if length is exactly 8 characters
    If Len(Me.PatientID.Value) <> 8 Then
        MsgBox "Patient ID must be exactly 8 characters", vbExclamation
        Me.PatientID.Value = ""  ' Clear the field
        Me.PatientID.SetFocus     ' Move cursor back to this field
    End If
End Sub
```

#### 5.2 Validate Age

Select **"Age"** from the left dropdown, and **"AfterUpdate"** from the right dropdown. Paste this code:

```vba
Private Sub Age_AfterUpdate()
    ' This runs when user enters age and moves to next field
    
    If IsNull(Me.Age.Value) Then
        Exit Sub  ' Allow blank (not required)
    End If
    
    If Me.Age.Value < 18 Or Me.Age.Value > 100 Then
        MsgBox "Age must be between 18 and 100", vbExclamation
        Me.Age.Value = ""
        Me.Age.SetFocus
    End If
End Sub
```

#### 5.3 Calculate BMI Automatically

Select **"Weight"** from the left dropdown, and **"AfterUpdate"** from the right. Paste this code:

```vba
Private Sub Weight_AfterUpdate()
    ' Calculate BMI: (weight in kg) / (height in m)^2
    
    ' Only calculate if both height and weight exist
    If Not IsNull(Me.Height.Value) And Not IsNull(Me.Weight.Value) Then
        Dim heightInMeters As Double
        Dim weight As Double
        Dim bmi As Double
        
        heightInMeters = Me.Height.Value / 100  ' Convert cm to meters
        weight = Me.Weight.Value
        
        bmi = weight / (heightInMeters ^ 2)
        
        ' Round to 1 decimal place and display
        Me.BMI.Value = Round(bmi, 1)
        
        ' Optional: Show category
        If bmi < 18.5 Then
            Me.BMICategory.Value = "Underweight"
        ElseIf bmi < 25 Then
            Me.BMICategory.Value = "Normal weight"
        ElseIf bmi < 30 Then
            Me.BMICategory.Value = "Overweight"
        Else
            Me.BMICategory.Value = "Obese"
        End If
    End If
End Sub
```

#### 5.4 Submit Button with Confirmation

Select **"SaveButton"** from the left dropdown and **"Click"** from the right. Paste this code:

```vba
Private Sub SaveButton_Click()
    ' This runs when the Save button is clicked
    
    ' First, check all required fields are filled
    If IsNull(Me.PatientID.Value) Then
        MsgBox "Patient ID is required", vbExclamation
        Me.PatientID.SetFocus
        Exit Sub
    End If
    
    If IsNull(Me.PatientName.Value) Then
        MsgBox "Patient Name is required", vbExclamation
        Me.PatientName.SetFocus
        Exit Sub
    End If
    
    If IsNull(Me.Age.Value) Then
        MsgBox "Age is required", vbExclamation
        Me.Age.SetFocus
        Exit Sub
    End If
    
    ' All checks passed - ask for confirmation
    Dim result As Integer
    result = MsgBox("Save this patient record? " & vbNewLine & _
                   "ID: " & Me.PatientID.Value & vbNewLine & _
                   "Name: " & Me.PatientName.Value, _
                   vbYesNo + vbQuestion)
    
    If result = vbYes Then
        ' Save the form (Access handles database saving automatically)
        DoCmd.RunCommand acCmdSaveRecord
        MsgBox "Patient record saved successfully", vbInformation
        DoCmd.GoToRecord , , acNewRec  ' Move to new blank record
    End If
End Sub
```

### Step 6: Test the Form

Now test everything:

1. Close the VBA editor (press **Alt+F4** or click the X)
2. Click **"Form View"** to switch from Design View
3. Try entering invalid data:
   - Enter a 5-character Patient ID (should show error)
   - Enter age 15 (should show error)
   - Enter height and weight (BMI should calculate)
4. Click Save (should ask for confirmation)

---

## 4. Case Study 2: Clinical Assessment Form

A clinical team needs a form where doctors can fill out patient assessment scores. This form demonstrates more advanced techniques with conditional visibility and status indicators.

### Step 1: Create a New Table

Create a table called **"Assessments"** with these fields:

| Field Name | Data Type |
|------------|-----------|
| AssessmentID | Number (Auto-increment) |
| PatientID | Text |
| AssessmentScore | Number (0-10) |
| PatientNotes | Memo (long text) |
| IsComplexCase | Yes/No |
| AdvancedDiagnosis | Text |
| Contraindications | Memo |
| IsSubmitted | Yes/No |

### Step 2: Create the Form

Create a new form in Design View and set its Record Source to **"Assessments"**

Add these controls:
- Label "Assessment Score:" with TextBox "AssessmentScore"
- Label "Patient Notes:" with TextBox "PatientNotes"
- Checkbox "ComplexCase" (label: "This is a complex case")
- Label "Advanced Diagnosis:" with TextBox "AdvancedDiagnosis" (initially hidden)
- Label "Contraindications:" with TextBox "Contraindications" (initially hidden)
- Button "SubmitButton" with caption "Submit Assessment"

### Step 3: Add VBA Code

#### 3.1 Validate Assessment Score

Select **"AssessmentScore"** from the left dropdown and **"AfterUpdate"** from the right:

```vba
Private Sub AssessmentScore_AfterUpdate()
    ' Ensure score is between 0 and 10
    
    Dim score As Integer
    score = Me.AssessmentScore.Value
    
    If score < 0 Or score > 10 Then
        MsgBox "Assessment score must be between 0 and 10", vbExclamation
        Me.AssessmentScore.Value = ""
        Me.AssessmentScore.SetFocus
    Else
        ' Update status label based on score
        ' You would add a label control to show this
        If score <= 3 Then
            ' Mild
        ElseIf score <= 6 Then
            ' Moderate
        Else
            ' Severe
        End If
    End If
End Sub
```

#### 3.2 Show/Hide Advanced Options

Select **"ComplexCaseCheckbox"** from the left dropdown and **"Click"** from the right:

```vba
Private Sub ComplexCaseCheckbox_Click()
    ' Show or hide advanced options based on checkbox
    
    If Me.ComplexCaseCheckbox.Value = True Then
        ' Checkbox is checked - show advanced fields
        Me.AdvancedDiagnosisLabel.Visible = True
        Me.AdvancedDiagnosis.Visible = True
        Me.ContraindicationsLabel.Visible = True
        Me.Contraindications.Visible = True
        
        MsgBox "Advanced options are now visible", vbInformation
    Else
        ' Checkbox is unchecked - hide advanced fields
        Me.AdvancedDiagnosisLabel.Visible = False
        Me.AdvancedDiagnosis.Visible = False
        Me.ContraindicationsLabel.Visible = False
        Me.Contraindications.Visible = False
    End If
End Sub
```

#### 3.3 Submit and Lock Form

Select **"SubmitButton"** from the left dropdown and **"Click"** from the right:

```vba
Private Sub SubmitButton_Click()
    ' When form is submitted, lock it from further editing
    
    Dim result As Integer
    result = MsgBox("Submit this assessment? This action cannot be undone.", _
                   vbYesNo + vbQuestion)
    
    If result = vbYes Then
        ' Save the record
        DoCmd.RunCommand acCmdSaveRecord
        
        ' Set a flag that form is submitted
        Me.IsSubmitted.Value = True
        
        ' Disable all editing fields
        Me.AssessmentScore.Enabled = False
        Me.PatientNotes.Enabled = False
        Me.ComplexCaseCheckbox.Enabled = False
        Me.AdvancedDiagnosis.Enabled = False
        Me.Contraindications.Enabled = False
        
        ' Disable submit button
        Me.SubmitButton.Enabled = False
        
        ' Show confirmation
        MsgBox "Assessment submitted and locked.", vbInformation
    End If
End Sub
```

---

## 5. Common VBA Patterns & Tricks

### 5.1 Checking if a Field is Empty

Three ways to check if a field is empty:

```vba
' Method 1: IsNull (most common)
If IsNull(Me.FieldName.Value) Then
    MsgBox "Field is empty"
End If

' Method 2: Check for empty string
If Me.FieldName.Value = "" Then
    MsgBox "Field is empty"
End If

' Method 3: Check length (for text fields)
If Len(Me.FieldName.Value) = 0 Then
    MsgBox "Field is empty"
End If
```

### 5.2 Message Box Types

You can customize how message boxes look:

```vba
' Simple message (no icon)
MsgBox "This is a simple message"

' Information icon (blue circle with 'i')
MsgBox "This is information", vbInformation

' Warning icon (yellow triangle with '!')
MsgBox "Be careful!", vbExclamation

' Question icon (with Yes/No buttons)
Dim response As Integer
response = MsgBox("Do you want to continue?", vbYesNo + vbQuestion)
If response = vbYes Then
    ' User clicked Yes
End If

' Error icon (red circle with 'X')
MsgBox "Something went wrong!", vbCritical
```

### 5.3 Working with Dates

```vba
' Get today's date
Dim today As Date
today = Date()

' Calculate days until appointment
Dim appointmentDate As Date
appointmentDate = Me.AppointmentDate.Value
Dim daysUntil As Integer
daysUntil = DateDiff("d", today, appointmentDate)

' Show warning if appointment is soon
If daysUntil < 7 Then
    MsgBox "Appointment is in " & daysUntil & " days"
End If

' Format date for display
Dim formattedDate As String
formattedDate = Format(appointmentDate, "dd/mm/yyyy")
MsgBox formattedDate
```

### 5.4 String Operations

```vba
' Convert to uppercase
Dim name As String
name = "John Smith"
name = UCase(name)  ' Result: "JOHN SMITH"

' Convert to lowercase
name = LCase(name)  ' Result: "john smith"

' Get first name and last name from full name
Dim fullName As String
fullName = "John Smith"
Dim spacePosition As Integer
spacePosition = InStr(fullName, " ")  ' Find position of space
Dim firstName As String
Dim lastName As String
firstName = Left(fullName, spacePosition - 1)  ' "John"
lastName = Right(fullName, Len(fullName) - spacePosition)  ' "Smith"

' Combine strings
Dim message As String
message = "Hello " & firstName & ", your last name is " & lastName
```

---

## 6. Debugging VBA Code

When your code doesn't work, here are the most common issues:

| Problem | Cause | Solution |
|---------|-------|----------|
| Code doesn't run at all | Event name spelled wrong; field name doesn't match | Check spelling of event and field names against form design |
| Error: "Object not found" | Field name in code doesn't exist on the form | Double-check the field name in form design |
| Error: "Syntax Error" | Missing quotes, parentheses, or keywords like End If | Check the red squiggly line; look for missing quotes, End If, etc. |
| Field value is always "Null" even after typing | Code is checking it in the wrong event (before it's saved) | Use AfterUpdate, not BeforeUpdate |

### 6.1 Using Debug.Print to Find Problems

Add Debug.Print statements to see what's happening:

```vba
Private Sub SaveButton_Click()
    Debug.Print "SaveButton clicked"
    
    If IsNull(Me.PatientID.Value) Then
        Debug.Print "PatientID is null"
        MsgBox "Patient ID is required"
        Exit Sub
    End If
    
    Debug.Print "PatientID value: " & Me.PatientID.Value
    
    ' More code here...
End Sub
```

To see the debug output:
1. Press **Ctrl+G** in the VBA editor to open the Immediate Window
2. Look at the messages printed by Debug.Print

---

## 7. Best Practices for Medical Applications

### 7.1 Validation is Critical

In medical data entry, validation prevents errors that could affect patient care. Always validate:

- Required fields are not empty
- Numbers are in valid ranges
- Dates are reasonable
- Related fields are consistent

### 7.2 Provide Clear Feedback

Users entering medical data need to know immediately if something is wrong:

- Use clear error messages explaining what's wrong
- Show confirmation before irreversible actions
- Highlight changes with color or status labels
- Explain calculated values

### 7.3 Code Organization

Keep your code readable and maintainable:

- Add comments explaining what each section does
- Use meaningful field names
- Avoid very long functions (break them into smaller pieces)
- Test thoroughly before deploying

---

## 8. When to Use Access & When Not To

### Access is great for:

- Small to medium-sized projects (hundreds to thousands of records)
- Single-user or small team applications
- Quick prototypes and internal tools
- When users are in the same office

### Access is NOT suitable for:

- Large-scale applications (millions of records)
- Many simultaneous users
- Applications requiring high security
- Systems that need to run 24/7 reliably
- Web-based applications

---

## 9. Summary

VBA in Microsoft Access is a powerful tool for automating data entry and adding validation to medical databases. The key takeaways are:

1. **Start with database design** (create tables) before building forms
2. **Create forms in Design View** and add controls carefully
3. **Write VBA code in the form's module**, responding to events
4. **Always validate medical data** thoroughly
5. **Provide clear feedback** to users via message boxes and status indicators
6. **Test your code thoroughly** before deployment
7. **Be honest about Access's limitations** for large or complex projects

With these fundamentals and step-by-step case studies, you're ready to help students debug their VBA code, guide them through form design, and suggest improvements.

Good luck with your session Monday!
