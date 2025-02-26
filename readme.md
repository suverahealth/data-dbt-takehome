
# Suvera Data Take-home 

Welcome to the take-home assessment for the Data team! This assessment is designed to evaluate your abilities working with data, SQL and DBT. We would expect this to take 1-2 hours to complete.

Please *duplicate* the repository and either send us a link to your repo or you can submit your work as zip email attachment.

We've configured this repo with DBT and DuckDB to help you get started; Feel free to set up DBT yourself and/or use a different database if preferred.

There's a directory called `seeds` with the synthetic data we'll be working with.

There are 4 files:
* raw_pcns.csv - Primary Care Networks: A group of primary care practices that serve a local community.
* raw_practices.csv - Primary care practices that patients belong to
* raw_patients.csv - Patients containing contact information and what conditions they currently have
* raw_activities.csv - activities the practice may have the patient

In this exercise we would like you answer some questions about the data, whilst showing us how you approach this kind of task using DBT.

Please provide a document with answers to the questions that we can discuss in the technical interview.

Questions / Tasks:
* Unfortunately the raw data has poor data quality. How can we handle data quality and integrity?
* How many patients belong to each PCN?
* What's the average patient age per practice?
* Categorize patients into age groups (0-18, 19-35, 36-50, 51+) and show the count per group per PCN
* What percentage of patients have Hypertension at each practice?
* For each patient, show their most recent activity date
* Find Patients who had no activity for 3 months after their first activity



### Installation Instructions

The instructions below will get you set up with DBT and DuckDB in a virtual environment.

`python3 -m venv venv`

`source venv/bin/activate`

```
python3 -m pip install --upgrade pip
python3 -m pip install -r requirements.txt
source venv/bin/activate
```