
```markdown
# Machine Learning APIs on Google Cloud

This lab demonstrates how to use:

- Cloud Vision API
- Cloud Translation API
- BigQuery
- Cloud Storage
- Service Accounts

to analyze image text and translate detected languages.

---

## Files

| File | Purpose |
|---|---|
| `MachineLearningAPIs-on-Google-Cloud.sh` | Automates lab setup |
| `lab.md` | Lab instructions |

---

## What This Lab Teaches

- Creating Service Accounts  
- Assigning IAM Roles  
- Using Vision API  
- Using Translation API  
- Writing data to BigQuery  
- Using Cloud Storage  

---

## Usage

### Step 1 — Clone Repository

```bash
git clone https://github.com/Semi-Coder-09/GoogleCloudSkillsboost.git
```

### Step 2 — Navigate To Folder

```bash
cd "GoogleCloudSkillsboost/Machine-Learning-APIs-on-Google-Cloud"
```

### Step 3 — Make Script Executable

```bash
chmod +x MachineLearningAPIs-on-Google-Cloud.sh
```

### Step 4 — Run Script

```bash
./MachineLearningAPIs-on-Google-Cloud.sh
```

---

## Example Inputs

```
ENTER LANGUAGE: en
ENTER LOCALE: en_US
ENTER BIGQUERY_ROLE: roles/bigquery.dataEditor
ENTER CLOUD_STORAGE_ROLE: roles/storage.admin
```

---

## What The Script Does

- Enables required APIs  
- Creates service account  
- Assigns IAM roles  
- Creates credential file  
- Exports credential environment variable  
- Detects Cloud Storage bucket  
- Downloads Python file  
- Configures Vision API code  
- Configures Translation API code  
- Enables BigQuery upload  
- Runs Python script  
- Runs BigQuery query  

---

## BigQuery Query Used

```sql
SELECT locale, COUNT(*) as total
FROM image_classification_dataset.image_text_detail
GROUP BY locale
ORDER BY total DESC
```

---

## Notes

- Use temporary Skills Boost credentials only  
- Cloud Shell is pre-authenticated  
- Vision API extracts text from images  
- Translation API translates text  
- BigQuery stores results  

---

## Expected Outcome

- Text extracted from images  
- Text translated successfully  
- Results uploaded to BigQuery  
- Query displays language counts  
```

---
