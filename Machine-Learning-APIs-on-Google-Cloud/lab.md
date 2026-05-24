````md
````
# Machine Learning APIs on Google Cloud

This lab demonstrates how to use:

- Cloud Vision API
- Cloud Translation API
- BigQuery
- Cloud Storage
- Service Accounts

to analyze image text and translate detected languages.

---

# Files

| File | Purpose |
|---|---|
| MachineLearningAPIs-on-Google-Cloud.sh | Automates initial setup |
| lab.md | Lab instructions |

---

# What This Lab Teaches

- Creating Service Accounts
- Assigning IAM Roles
- Using Cloud Vision API
- Using Translation API
- Writing results to BigQuery
- Working with Cloud Storage

---

# Usage

## Step 1 — Clone Repository

```bash
git clone https://github.com/Semi-Coder-09/GoogleCloudSkillsboost.git
````

---

## Step 2 — Navigate To Folder

```bash
cd "GoogleCloudSkillsboost/Machine-Learning-APIs-on-Google-Cloud"
```

---

## Step 3 — Make Script Executable

```bash
chmod +x MachineLearningAPIs-on-Google-Cloud.sh
```

---

## Step 4 — Run Script

```bash
./MachineLearningAPIs-on-Google-Cloud.sh
```

---

# Example Inputs

```text
ENTER LANGUAGE: en
ENTER LOCALE: en_US
ENTER BIGQUERY_ROLE: roles/bigquery.admin
ENTER CLOUD_STORAGE_ROLE: roles/storage.admin
```

---

# What The Script Does

* Enables APIs
* Creates service account
* Assigns IAM roles
* Creates credential JSON file
* Sets environment variable
* Copies Python script from Cloud Storage
* Installs required Python libraries

---

# Manual Tasks After Script

## Edit Python File

```bash
nano analyze-images-v2.py
```

Complete all `# TBD` sections.

---

## Run Python Script

```bash
python3 analyze-images-v2.py
```

---

## BigQuery Query

```sql
SELECT language, COUNT(*) as total
FROM ml_api_results.translated_text
GROUP BY language
ORDER BY total DESC;
```

---

# Notes

* Use temporary Qwiklabs credentials only
* Cloud Shell is pre-authenticated
* Vision API extracts text from images
* Translation API translates detected text
* BigQuery stores processed results

---

# Expected Outcome

* Text extracted from images
* Text translated into selected language
* Results saved to BigQuery
* Query reports most common language

---

# Exact Inputs You Should Give

For this lab use:

```text
ENTER LANGUAGE: en
ENTER LOCALE: en_US
ENTER BIGQUERY_ROLE: roles/bigquery.admin
ENTER CLOUD_STORAGE_ROLE: roles/storage.admin
```

---

# Exact Steps To Complete The Lab

## Step 1

Open Cloud Shell.

---

## Step 2

Navigate to the folder:

```bash
cd "GoogleCloudSkillsboost/Machine-Learning-APIs-on-Google-Cloud"
```

---

## Step 3

Run:

```bash
chmod +x MachineLearningAPIs-on-Google-Cloud.sh
```

---

## Step 4

Execute:

```bash
./MachineLearningAPIs-on-Google-Cloud.sh
```

---

# After Script Finishes

You must manually edit:

```bash
nano analyze-images-v2.py
```

because the lab specifically tests your API code modifications.

---

# Then Run

```bash
python3 analyze-images-v2.py
```

---

# Finally Run BigQuery Query

```bash
bq query --use_legacy_sql=false \
'SELECT language, COUNT(*) as total
FROM ml_api_results.translated_text
GROUP BY language
ORDER BY total DESC'
```

```
```
