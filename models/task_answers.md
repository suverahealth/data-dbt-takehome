1. Unfortunately the raw data has poor data quality. How can we handle data quality and integrity?
dbt tests are great tool for this. I have implemented some tests in the staging layer that would catch some of the data quality issues I have spotted while looking at the data. 

2. How many patients belong to each PCN?

3. What's the average patient age per practice?

4. Categorize patients into age groups (0-18, 19-35, 36-50, 51+) and show the count per group per PCN

5. What percentage of patients have Hypertension at each practice?

6. For each patient, show their most recent activity date

7. Find Patients who had no activity for 3 months after their first activity