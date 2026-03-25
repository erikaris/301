# Teaching Assistant Preparation Guide: Tableau V
## Understanding Public Datasets for Decision Making

---

## MATERIAL SUMMARY

### Session Overview
This is a practical, project-based lab session where students work in groups (2-4 people) to develop data visualization dashboards. The session spans approximately 105 minutes and follows a structured design workflow process.

### Learning Objectives
- Understand real-world datasets and their application to decision-making
- Develop problem-solving skills through data visualization
- Experience the complete workflow of a data visualization project
- Practice stakeholder communication and client feedback integration
- Learn to create dashboards that address specific business problems

### Key Concepts
**The Typical Data Visualisation Activity** (5 stages):
1. **A Problem** - Understanding the business challenge
2. **Study of the domain and users** - Researching context through document analysis, stakeholder mapping, and creating user profiles
3. **A potential Solution** - Creating prototypes, sketches, dashboards, and visualisations
4. **Evaluation of the solution** - Through user evaluations, heuristic reviews, and scenario-based testing
5. **Acceptance/Operationalisation** - Client feedback and workshops

### Session Structure
The session emphasizes collaborative team-based learning with client interaction, mirroring real-world professional practice.

---

## TASK BREAKDOWN & SOLUTIONS

### TASK 1: Team Setup (10 minutes)
**Objective:** Organize team roles and establish team identity

**Instructions:**
- Each group selects a Project Manager (PM)
- Team creates a team name
- PM writes their name and team name on a post-it note
- Post-it is displayed on the desk

**Solution Example:**
```
Post-it Template:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Project Manager: Sarah Johnson
  
  Team Name: Data Dashers
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**TA Tips:**
- Ensure every student has a role (at least 1 PM per group, others can specialize in data analysis, visualization design, or documentation)
- Encourage diverse team names (creative and professional)
- Make a note of all PMs for the consultation phase
- Check that no students are working alone - minimum groups of 2

**Checklist for TA:**
- ✓ All groups have selected a PM
- ✓ All groups have a visible team name post-it
- ✓ No students are isolated
- ✓ Teams are balanced in size (2-4 people)

---

### TASK 2: Client Consultation (5 minutes)
**Objective:** Brief the Project Manager on their specific case study and business scenario

**Instructions:**
- Project Managers approach the "client" (instructor/TA) one at a time
- Client provides the scenario and dataset details
- PM returns to team and explains the project

**Solution Example - Client Briefing Template:**

```
CLIENT BRIEFING SHEET
═══════════════════════════════════════════════════════════

CASE STUDY: Public Transportation Performance Analytics

CLIENT: City Transport Authority

BUSINESS PROBLEM:
The City Transport Authority is struggling to understand commuter 
flow patterns and identify service bottlenecks. They need to make 
data-driven decisions about resource allocation and service optimization.

KEY QUESTIONS TO ANSWER:
1. Which routes have the highest usage during peak hours?
2. What are the patterns of passenger delays?
3. Where should additional resources be allocated?
4. How do travel times vary by time of day and location?

TARGET USERS:
- Operations managers (daily decision-making)
- Senior management (strategic planning)
- Service planners (route optimization)

DELIVERABLE OPTIONS:
- Full Dashboard (£5,000 budget) - Interactive, fully functional
- Prototype (£1,000 budget) - Sketch/mockup with key visualizations

DATASET PROVIDED:
- File: public_transport_data.csv
- Records: 50,000+ journeys (Dec 2019)
- Fields: Route, Departure time, Arrival time, Delays, Passenger count
- Time period: December 2019 (full month)

CONSTRAINTS:
- Delivery: End of session
- Technology: Tableau, Excel, or prototyping tool of choice
- Format: Single-page dashboard or 2-3 slide presentation

KEY SUCCESS CRITERIA:
✓ Addresses at least 3 of the key questions
✓ Uses appropriate visualization types
✓ Includes filtering/interactivity (if dashboard)
✓ Clear labels and insights
✓ Professional presentation
```

**PM's Return Brief to Team (Example):**

"Okay team, here's what we're working on. The City Transport Authority needs to understand passenger flow and service delays. We have data from December 2019 with over 50,000 journey records. Our main questions are:
1. Peak usage by route
2. Delay patterns
3. Where to allocate resources
4. Travel time variations

We need to create either a full interactive dashboard (goes for £5,000) or a prototype/mockup (£1,000). Let's discuss which approach makes sense for us and how to divide the work."

**TA Tips:**
- Prepare 2-3 different case studies with varying complexity
- Make scenarios realistic but achievable within the timeframe
- Ensure datasets are pre-loaded and accessible
- Have a "client" (instructor or TA) available for the consultation
- Brief note what "questions" each PM should focus on
- Allocate specific meeting times to avoid chaos (e.g., PM 1 at 10:05, PM 2 at 10:08, etc.)

**Checklist for TA:**
- ✓ All PMs briefed on their scenario
- ✓ Datasets accessible to teams
- ✓ Clear deliverable options understood
- ✓ Timeline and success criteria communicated

---

### TASK 3: Solution Development (60 minutes)
**Objective:** Teams design and develop dashboards/prototypes to solve their client's problem

**Instructions:**
- Teams work together to analyze datasets
- Teams discuss visualization approaches
- PM may delegate specific tasks to team members
- Create dashboard, prototype, or visualization mockup

**Solution Example - Dashboard Layout for Public Transport Case Study:**

```
╔═══════════════════════════════════════════════════════════════╗
║         CITY TRANSPORT AUTHORITY - DECEMBER 2019              ║
║              Service Performance Dashboard                     ║
╠═══════════════════════════════════════════════════════════════╣
║                                                               ║
║  [FILTERS] Route: [ ] Time Period: [ ] Day Type: [ ]         ║
║                                                               ║
├───────────────────────────────┬───────────────────────────────┤
║                               │                               ║
║  KEY METRICS (TOP ROW)        │                               ║
║  ┌─────────────┬─────────────┐│                               ║
║  │ Total Trips │  Avg Delay  ││  Peak Usage by Route          ║
║  │  49,732     │   8.2 min   ││  ┌──────────────────┐         ║
║  └─────────────┴─────────────┘│  │ Route 1  ▓▓▓▓▓   │         ║
║                               │  │ Route 5  ▓▓▓▓    │         ║
│  Peak Hour: 8-9 AM            │  │ Route 12 ▓▓▓     │         ║
║                               │  │ Route 3  ▓▓▓     │         ║
║                               │  └──────────────────┘         ║
├───────────────────────────────┼───────────────────────────────┤
║                               │                               ║
║  Average Travel Time by Hour  │  Delay Distribution           ║
║  ┌─────────────────────────┐  │  ┌──────────────────┐         ║
║  │  ___                    │  │  │ ■ On Time        │         ║
║  │ /   \___               │  │  │ ■ 5-15 min delay │         ║
║  │        \___            │  │  │ ■ 15+ min delay  │         ║
║  │            \___        │  │  └──────────────────┘         ║
║  └─────────────────────────┘  │                               ║
║                               │                               ║
├───────────────────────────────┼───────────────────────────────┤
║                               │                               ║
║  Geographic Heatmap:          │  High-Priority Recommendations
║  Resource Allocation by Zone  │  • Increase capacity Route 1  ║
║  ┌─────────────────────────┐  │  • Investigate Route 12 delays║
║  │ ██ High Priority        │  │  • Staff peak hours (8-9 AM)  ║
║  │ ▒▒ Medium Priority      │  │  • Monitor morning commute    ║
║  │ ░░ Low Priority         │  │                               ║
║  └─────────────────────────┘  │                               ║
║                               │                               ║
╚═══════════════════════════════╩═══════════════════════════════╝
```

**Alternative Prototype Approach (Simpler/Faster):**

```
PROTOTYPE - Public Transport Analytics
═════════════════════════════════════════════════════════════

[3-Slide Presentation]

SLIDE 1: THE PROBLEM & KEY INSIGHTS
─────────────────────────────────────
Problem Statement:
"December 2019 saw significant service delays and uneven passenger 
distribution across routes, impacting commuter experience and 
operational efficiency."

Key Finding: Routes 1 and 5 carry 45% of all passengers during 
peak hours, creating bottlenecks and delays.

SLIDE 2: DATA VISUALIZATION
─────────────────────────────────────
[Visual 1]                  [Visual 2]
Peak Routes by             Delays by Time of Day
Passenger Volume           
Route 1: 12,480 trips  ▓▓▓▓▓▓  Morning (6-10AM):
Route 5: 10,320 trips  ▓▓▓▓▓      8,234 trips
Route 12: 7,840 trips  ▓▓▓▓       Average delay: 12 min
Route 3: 6,240 trips   ▓▓▓    
Route 8: 5,120 trips   ▓▓

SLIDE 3: RECOMMENDATIONS & NEXT STEPS
──────────────────────────────────────
Recommended Actions:
1. Deploy additional buses on Routes 1 & 5 during 8-10 AM
2. Implement real-time delay alerts to passengers
3. Stagger work start times to reduce peak congestion
4. Conduct detailed analysis of Route 12 delay causes

Expected Impact:
- 30% reduction in peak delays
- Improved passenger satisfaction
- Better resource utilization
```

**Sample Team Task Allocation:**

```
TEAM STRUCTURE - DATA DASHERS
═════════════════════════════════════════════════════════════

Project Manager: Sarah Johnson
─ Oversees timeline and deliverables
─ Communicates with client at midpoint consultation
─ Presents final solution

Data Analyst: Marcus Chen
─ Loads and explores dataset
─ Performs statistical analysis
─ Identifies key patterns and outliers
─ Task: Create summary statistics, identify top routes

Visualization Designer: Priya Patel
─ Designs visualization types
─ Creates dashboard layout mockups
─ Ensures visual clarity and aesthetics
─ Task: Design charts and determine color schemes

Documentation Lead: James O'Brien
─ Documents findings and insights
─ Writes explanatory text for dashboard
─ Prepares presentation notes
─ Task: Create narrative and recommendations
```

**Development Workflow Example:**

```
MINUTE 0-15: Data Exploration & Planning
- Load dataset into Tableau/Excel
- Understand variables and data quality
- Brainstorm 3-4 visualization types
- Sketch rough dashboard layout on paper
- Decide: Dashboard vs. Prototype?

MINUTE 15-45: Build Core Visualizations
- Create main charts (peak routes, time patterns, delays)
- Apply appropriate visualization types:
  * Bar chart: Route comparison
  * Line graph: Time-based patterns
  * Heat map: Geographic/time patterns
  * Pie/Donut: Distribution of delays

MINUTE 45-60: Polish & Refine
- Add titles, labels, legends
- Apply consistent color schemes
- Add filters/interactivity (if applicable)
- Verify accuracy of all numbers
- Create 2-3 key insight callouts
```

**TA Tips:**
- Circulate among groups to monitor progress
- Ask guiding questions: "What story does your data tell?" "Who needs this info and why?"
- Point teams toward relevant columns if they're stuck
- Remind teams of time at 30 min, 45 min, 60 min marks
- Be ready with suggestions for common issues:
  * "Your chart is too crowded - have you tried filtering?"
  * "What would a decision-maker do with this information?"
  * "Can you simplify this to 1-2 key messages?"

**Common Pitfalls to Address:**
- ✓ Too much information - encourage focusing on 3-5 key insights
- ✓ Poor color choices - suggest accessible color palettes
- ✓ Unclear labels - remind: every chart needs a title and axis labels
- ✓ Wrong chart type - help teams select appropriate visualizations
- ✓ Time management - keep them on track!

**Checklist for TA:**
- ✓ Teams have loaded data
- ✓ Teams have discussed approach
- ✓ Teams are creating visualizations
- ✓ Progress check at 30 min mark
- ✓ Teams understand deliverable requirements
- ✓ Dashboard/prototype is taking shape

---

### TASK 4: Solution Refinement (30 minutes)
**Objective:** Refine and finalize the solution, then submit

**Instructions:**
- Team refines their dashboard based on the client's original brief (from Task 2)
- Focus on addressing the client's original questions/requirements
- Finalize visualizations and add polish
- Submit final solutions to Padlet

**Note on Client Input:**
The material indicates that the **one client consultation opportunity occurs during Task 2** (when the PM receives the scenario brief). During Task 4, teams refine based on that original client brief and their own analysis - but there is no second formal client meeting described in the material. Teams should self-assess whether their solution addresses the original client questions.

**Self-Refinement Checklist (What Teams Should Ask):**

```
REFLECTION QUESTIONS FOR TEAMS:

1. Does our solution answer the client's original questions?
   ✓ Review Task 2 client brief
   ✓ Verify all key questions are addressed
   ✓ Confirm our visualizations support the brief

2. Is the visualization clear and professional?
   ✓ All charts have titles and labeled axes
   ✓ Legends are clear and complete
   ✓ Color schemes are consistent and accessible
   ✓ Text is readable and properly sized

3. Does the data support our conclusions?
   ✓ Numbers are accurate
   ✓ Charts correctly represent the data
   ✓ No misleading visualizations
   ✓ Assumptions are stated

4. Is the solution actionable for the client?
   ✓ Clear recommendations provided
   ✓ Decisions are supported by data
   ✓ Next steps are identified
   ✓ Insights are relevant to client's role

5. Is the presentation polished?
   ✓ Professional appearance
   ✓ Consistent formatting throughout
   ✓ Spelling and grammar correct
   ✓ Layout is organized and logical
```

**Refinement Checklist (Team Self-Assessment):**

```
BEFORE FINAL SUBMISSION, TEAMS SHOULD VERIFY:

□ Alignment with Client Brief
  ✓ Original client questions are answered
  ✓ Key requirements from Task 2 are addressed
  ✓ Deliverable type matches what was briefed (dashboard vs. prototype)

□ Visual Clarity
  ✓ All charts have clear titles
  ✓ Axes are labeled
  ✓ Legends are present and understandable
  ✓ Color choices are distinguishable (colorblind-friendly)
  ✓ Font sizes are readable

□ Data Accuracy
  ✓ Numbers are correct (spot-check against data)
  ✓ Totals add up
  ✓ Charts match the narrative/conclusions
  ✓ No data is misrepresented

□ Story & Insights
  ✓ Dashboard tells a clear story
  ✓ 3-5 key insights are highlighted
  ✓ Recommendations are actionable
  ✓ Client's original questions are answered

□ Professional Presentation
  ✓ Consistent formatting throughout
  ✓ No spelling/grammar errors
  ✓ Professional color scheme
  ✓ Aligned/organized layout

□ Interactivity (if Dashboard)
  ✓ Filters work correctly
  ✓ No broken links or missing elements
  ✓ Dashboard loads without errors

□ Documentation
  ✓ Assumptions are stated
  ✓ Data limitations are noted
  ✓ Brief explanation of methodology included
```

**Solution Submission Format:**

```
FINAL SUBMISSION - DATA DASHERS
═════════════════════════════════════════════════════════════

Title: City Transport Authority - Service Performance Dashboard
Team: Data Dashers
Project Manager: Sarah Johnson
Date: [Date]

DELIVERABLE TYPE: ☑ Full Dashboard  ☐ Prototype

FILES SUBMITTED:
1. Dashboard_DataDashers.twbx (Tableau file)
2. README.txt (assumptions, methodology, data sources)
3. Summary_Insights.pdf (1-page summary of key findings)

EXECUTIVE SUMMARY:
The analysis of December 2019 data reveals significant 
bottlenecks on Routes 1 and 5, which carry 45% of peak-hour 
traffic. Average delays during 8-10 AM exceed 12 minutes, 
impacting 8,234 daily commuters. This dashboard enables 
operations managers to identify resource gaps and optimize 
service scheduling. Priority recommendations include: 
(1) increase bus capacity on Routes 1 & 5; (2) implement 
staggered departure patterns; (3) deploy real-time alerts.

KEY METRICS:
- Total December Trips: 49,732
- Peak Usage Routes: Routes 1, 5, 12
- Average Delay: 8.2 minutes
- Peak Period: 8-10 AM
- High-Risk Period: Morning Commute

VISUALIZATIONS INCLUDED:
1. Peak Routes by Passenger Volume (Bar Chart)
2. Delay Distribution by Time of Day (Line Graph)
3. Geographic Resource Allocation Heatmap
4. Top 3 Recommendations with Rationale

CLIENT FEEDBACK INCORPORATED:
✓ Added time-of-day breakdown
✓ Highlighted top 3 priority routes
✓ Included geographic analysis
✓ Strengthened executive summary
```

**Padlet Submission Instructions:**

```
SUBMISSION LINK:
https://padlet.com/s_mazumdar/case-study-dashboards85uzpddv68xi8k12

HOW TO SUBMIT:
1. Click the link above
2. Click "+ Add a note"
3. Add your team information:
   - Team Name
   - Project Manager
   - Team Members
   - Case Study Name
4. Attach your final dashboard file or screenshots
5. Paste a 2-3 sentence description of your solution
6. Click "Post"

SUBMISSION DEADLINE: End of Task 4 (5 minutes before session ends)
```

**TA Tips for Refinement Phase:**
- Circulate among groups to monitor progress on final touches
- Ask guiding questions: "Does this answer the original client brief?" "Is this ready to submit?"
- Point teams toward areas that might need improvement
- Remind teams of time at 15 min and 5 min before deadline
- Be ready with suggestions for common finishing touches:
  * "Your chart needs a title"
  * "Add a brief explanation of what this shows"
  * "Is the color scheme professional?"
  * "Would the client understand this?"
- Help with technical issues (saving files, exporting, etc.)

**Handling Team Challenges During Refinement:**

| Challenge | TA Solution |
|-----------|------------|
| "We want to change our whole dashboard" | Redirect to focused improvements only (30 min is for polish) |
| "We realized our analysis is wrong" | If minor: quick fix. If major: note as limitation in submission |
| "Our dashboard is too messy" | Suggest focusing on 1-2 main visualizations instead of many |
| Team member wants to add lots of new charts | Remind: refinement phase, not development phase |
| Unsure if solution addresses client brief | Have them review Task 2 brief together, do self-assessment |

**Checklist for TA:**
- ✓ Client consultation meetings completed
- ✓ Teams understand feedback
- ✓ Teams making meaningful refinements
- ✓ Progress check at 15 min and 25 min marks
- ✓ Files being saved/exported correctly
- ✓ Teams aware of submission deadline
- ✓ All submissions posted to Padlet

---

## TEACHING ASSISTANT ROLE SUMMARY

### Before the Session
- [ ] Read through all materials and understand learning objectives
- [ ] Prepare 2-3 case studies with client briefing sheets
- [ ] Ensure datasets are accessible and tested
- [ ] Gather PM name tags/post-its for Task 1
- [ ] Set up Padlet link and test access
- [ ] Brief any co-instructors on case study details
- [ ] Have contingency plans for technical issues

### During the Session
- **Task 1 (10 min):** Observe team formation, ensure no one is alone, check post-its
- **Task 2 (5 min):** Conduct PM consultations with case brief, note key points
- **Task 3 (60 min):** Circulate, ask guiding questions, provide encouragement, monitor progress
- **Task 4 (30 min):** Conduct second consultations, help with refinements, support submissions

### Key TA Responsibilities
1. **Facilitator** - Keep session on track with time management
2. **Coach** - Ask questions that guide teams toward insights
3. **Problem-Solver** - Address technical and conceptual issues
4. **Cheerleader** - Motivate teams and celebrate progress
5. **Observer** - Monitor learning and identify struggling groups

### Helpful Questions to Ask During Development

**Problem Understanding:**
- "What is the client really trying to decide?"
- "Who will use this dashboard?"
- "What would make this information useful for them?"

**Data Analysis:**
- "What patterns do you see in the data?"
- "What surprises you?"
- "What's missing from your analysis?"

**Visualization Design:**
- "Is this the best way to show this data?"
- "Could a simpler chart work?"
- "What story does this visualization tell?"

**Solution Quality:**
- "Would a decision-maker understand this?"
- "Can you simplify this?"
- "What's the most important insight to highlight?"

### Common Issues & Solutions

| Issue | Solution |
|-------|----------|
| Team confused about task | Re-explain with an example, break into smaller steps |
| Technical problems with software | Have quick tutorials ready, offer alternatives (Excel, sketches) |
| Team member not contributing | Check in privately, assign specific task, encourage participation |
| Team working too slow | Suggest focusing on 2-3 key visualizations, reduce scope |
| Team working on wrong problem | Reference the PM's briefing notes, refocus on client questions |
| Disagreement within team | Facilitate discussion, suggest compromise, remind of time |

---

## ASSESSMENT & LEARNING OUTCOMES

### What to Look For (Quality Indicators)

**Excellent Solutions:**
- ✓ Addresses client's key questions clearly
- ✓ Appropriate visualization types selected
- ✓ Professional presentation with clear labels
- ✓ Actionable recommendations included
- ✓ Team collaborated effectively
- ✓ Incorporates client feedback

**Good Solutions:**
- ✓ Addresses 2-3 of client's questions
- ✓ Mostly appropriate visualizations
- ✓ Reasonably professional appearance
- ✓ Some recommendations provided
- ✓ Team worked together
- ✓ Some feedback incorporated

**Developing Solutions:**
- ✓ Addresses at least one client question
- ✓ Has basic visualizations
- ✓ Attempts professional formatting
- ✓ Some insights identified
- ✓ Limited team collaboration
- ✓ Minimal feedback integration

### Learning Outcomes to Assess
By the end of this session, students should be able to:
1. Analyze datasets to identify patterns relevant to decision-making
2. Select appropriate visualization types for different data
3. Design dashboards that address stakeholder needs
4. Communicate findings clearly to non-technical audiences
5. Incorporate feedback and iterate on solutions
6. Understand the real-world workflow of data visualization projects

---

## RESOURCES FOR TA

### Recommended Talking Points
- "Great visualization! How would a manager use this to make a decision?"
- "I notice you have 6 charts here. What are the 2-3 most important?"
- "What does this bar chart tell you that the numbers alone don't?"
- "Let's check if this conclusion is supported by your data."

### Time Management Reminders
- Use a visible timer or announce time checks
- "15 minutes left for development!"
- "You have 5 minutes to submit your final solution!"
- Help teams make quick decisions when time is running out

### Encouraging Teamwork Language
- "How can each of you contribute differently?"
- "What skill does each team member bring?"
- "This looks like great collaboration!"
- "I love how you're dividing the work!"

---

## FINAL TIPS FOR SUCCESS

### For the TA
1. **Stay Organized** - Keep track of PM names, case study assignments, contact info
2. **Be Visible** - Walk around the room; don't sit at a desk
3. **Be Patient** - This is a learning experience; progress over perfection
4. **Be Encouraging** - Celebrate effort and creativity
5. **Be Flexible** - Adapt guidance based on team needs
6. **Stay On Time** - Keep the session flowing smoothly

### For Students (Share with Class)
1. **Read the briefing carefully** - Understand what the client really needs
2. **Start with exploration** - Get to know your data before jumping to visualizations
3. **Think before you visualize** - Sketch ideas on paper first
4. **Get feedback early** - Use the client consultation to validate your direction
5. **Quality > Quantity** - 2-3 excellent visualizations beat 6 mediocre ones
6. **Tell a story** - Connect visualizations to actionable recommendations

---

## Session Overview Template for Reference

```
TABLEAU V: UNDERSTANDING PUBLIC DATASETS FOR DECISION MAKING
═══════════════════════════════════════════════════════════════

Duration: 105 minutes
Format: Team-based project work
Class Size: 20-30 students (5-8 teams of 3-4)

TIMELINE:
0-10 min: Task 1 (Team Setup) - Select PM, name, post-it
10-15 min: Task 2 (Client Consultation) - Brief all PMs
15-75 min: Task 3 (Development) - Build dashboards
75-105 min: Task 4 (Refinement) - Client feedback + final touches

ASSESSMENT:
- Team collaboration and communication
- Data interpretation and analysis
- Visualization design and clarity
- Problem-solving and decision support
- Incorporation of feedback

DELIVERABLES:
- Interactive dashboard OR prototype/mockup
- Submitted via Padlet by session end

SUCCESS CRITERIA:
✓ Addresses client's key questions
✓ Uses appropriate visualizations
✓ Professional presentation
✓ Actionable recommendations
✓ Incorporates client feedback
```

---

**Good luck with your teaching assistant role! Remember: your role is to guide, encourage, and help students learn through doing. Enjoy the session!**
