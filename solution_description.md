# Data Take Home Task Solution
### Generate Compiled SQL Solution

```bash
dbt compile
```
_Result Location:_ `/target/compiled/data_takehome/analysis/`

### Generate Documentation
```bash
dbt docs generate
```

### Host & Browse Documentation
```bash
dbt docs serve --port 5001
```
Access from the browser, navigating to [Documentation Link](http://localhost:5001)

# Questions & Solutions
## Unfortunately the raw data has poor data quality. How can we handle data quality and integrity? How can we handle data quality and integrity?
### Data Quality Issues
Some of the quality issues found in the raw data are:
- Invalid practice with future established date.
- Unrealistic age in patients data like `150`, `-5`, etc.
- Inconsistent patient phone number format and usage of `null` and `-` to denote data unavailability.
- Invalid `practice_id` (e.g. `invalid`) in patients data.
- Duplicate patient and activity data.
- Patient records without practice reference.
- Activity records without patient reference.


### Handling Data Quality & Integrity
#### Data Validation
Running through the list of rules (constraints like unique, not_null, accepted_values, etc.) to prevent poor quality data from entering the system.

e.g. [Quality Check Example](/models/marts/schema.yml)

#### Data Enrichment
When there are known issues, data can be corrected applying the appropriate solutions. 
e.g. Assuming the negative `duration_minutes` in `activities` are due to a known issue and resolution is as simple as converting into positive.

[Solution](/models/staging/stg_activities.sql)

#### Cleansing
On some occasions, duplicate data exist and specifc measure can be applied to remove duplicates.
e.g. 
- duplicate activities can be handled by selecting the most recent activity. [Staging Activities](/models/staging/stg_activities.sql)
- duplicate patients can be handled by selecting the record with the oldest registered date. [Staging Patients](/models/staging/stg_patients.sql)

Removal of orphan data e.g. activity records without patient ID.

## How many patients belong to each PCN?
### Result
| pcn_name                           | total_patients |
| :--------------------------------- | :------------- |
| visualize virtual niches PCN       | 97             |
| streamline proactive mindshare PCN | 87             |

### Solution Scripts
- [Patient per PCN](/analysis/patient_per_pcn.sql)
- [Compiled](/target/compiled/data_takehome/analysis/patient_per_pcn.sql)

## What's the average patient age per practice?
### Result
| practice_name                     | average_patient_age |
| :-------------------------------- | :------------------ |
| Dominguez Ltd Clinic              | 49                  |
| Hayes, Walker and Williams Clinic | 59                  |
| Foster, West and Miller Clinic    | 57                  |
| Meza-Smith Clinic                 | 56                  |

### Solution Script
- [Average Patient Age per Practice](/analysis/average_patient_age_per_practice.sql)
- [Compiled](/target/compiled/data_takehome/analysis/)

## Categorize patients into age groups (0-18, 19-35, 36-50, 51+) and show the count per group per PCN.
### Result
| pcn_name                           | age_group | total_patients |
| :--------------------------------- | :-------- | :------------- |
| streamline proactive mindshare PCN | 0-18      | 6              |
| streamline proactive mindshare PCN | 19-35     | 19             |
| streamline proactive mindshare PCN | 36-50     | 9              |
| streamline proactive mindshare PCN | 51+       | 49             |
| visualize virtual niches PCN       | 0-18      | 16             |
| visualize virtual niches PCN       | 19-35     | 16             |
| visualize virtual niches PCN       | 36-50     | 19             |
| visualize virtual niches PCN       | 51+       | 40             |

### Solution Script 
- [Patient per Age Group per PCN](/analysis/patient_age_group_per_pcn.sql)
- [Compiled](/target/compiled/data_takehome/analysis/patient_age_group_per_pcn.sql)

## What percentage of patients have Hypertension at each practice?
### Result
| practice_name                     | hypertension_percentage |
| :-------------------------------- | :---------------------- |
| Dominguez Ltd Clinic              | 40.74                   |
| Foster, West and Miller Clinic    | 38.10                   |
| Hayes, Walker and Williams Clinic | 26.67                   |
| Meza-Smith Clinic                 | 37.21                   |

### Solution Scripts 
- [Patient with Hypertension per Practice](/analysis/patient_with_hypertension_per_practice.sql)
- [Compiled](/target/compiled/data_takehome/analysis/patient_with_hypertension_per_practice.sql)

## For each patient, show their most recent activity date.
### Result
[File Location](/results/patient_most_recent_activity_date.md)

### Solution Scripts 
- [Patient Most Recent Activity](/analysis/patient_most_recent_activity_date.sql)
- [Compiled](/target/compiled/data_takehome/analysis/patient_most_recent_activity_date.sql)

## Find Patients who had no activity for 3 months after their first activity.
### Result
| patient_id | first_activity_date |
| :--------- | :------------------ |
| 1001       | 2023-12-31 14:30:00 |
| 1045       | 2024-05-10 16:30:00 |
| 1088       | 2024-05-20 16:30:00 |
| 1105       | 2024-07-17 10:30:00 |
| 1139       | 2024-05-02 09:30:00 |
| 1140       | 2024-04-28 10:00:00 |
| 1193       | 2024-06-06 12:30:00 |
| 1201       | 2024-06-24 12:00:00 |
| 1239       | 2024-05-02 11:00:00 |
| 1100003    | 2024-02-20 14:30:00 |

### Solution Scripts 
- [Patient Inactive 3 Months after First Activity](/analysis/patient_inactive_3months_after_first_activity.sql)
- [Compiled](/target/compiled/data_takehome/analysis/patient_inactive_3months_after_first_activity.sql)


# Additional Remarks
For the provided dataset, Kimball Dimensional Modelling (Star schema with fact & dimensions tables) is not compulsory. However, as the questions of this take home task are analytical reporting, this approach optimises the queries. 

Additionally, `staging` layer holds the intermediate data, making it easier to debug & trace back. If staging models were used to obtain the result directly, the data cleansing, deduplication, formatting, etc., would clutter the script, decreasing readability, ultimately increasing the development time and the delivery.  
