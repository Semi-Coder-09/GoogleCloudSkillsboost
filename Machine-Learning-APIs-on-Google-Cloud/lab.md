# Machine Learning APIs on Google Cloud

This lab demonstrates how to use:

- Cloud Vision API
- Cloud Translation API
- BigQuery
- Cloud Storage
- Service Accounts

to analyze image text, detect languages, translate text, and upload results into BigQuery.

---

# Files

| File | Purpose |
|---|---|
| `MachineLearningAPIs-on-Google-Cloud.sh` | Automates lab setup |
| `lab.md` | Complete lab instructions |

---

# What This Lab Teaches

- Creating Service Accounts
- Assigning IAM Roles
- Using Cloud Vision API
- Using Cloud Translation API
- Using BigQuery
- Working with Cloud Storage
- Processing image datasets
- Uploading results to BigQuery

---

# Usage

## Step 1 — Clone Repository

```bash
git clone https://github.com/Semi-Coder-09/GoogleCloudSkillsboost.git
```

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

ENTER BIGQUERY_ROLE: roles/bigquery.dataEditor

ENTER CLOUD_STORAGE_ROLE: roles/storage.admin
```

---

# What The Script Does

The script automatically:

- Enables required APIs
- Creates Service Account
- Assigns IAM Roles
- Creates Service Account Key
- Exports GOOGLE_APPLICATION_CREDENTIALS
- Installs required Python libraries
- Downloads analyze-images-v2.py
- Prepares Cloud environment

---

# IMPORTANT — Manual Steps Required

After the shell script finishes, you MUST complete the following manual steps.

---

# Step 5 — Verify Service Account Key

Run:

```bash
ls
```

You must see:

```text
sample-sa-key.json
```

---

# Step 6 — Export Credentials Variable

Run:

```bash
export GOOGLE_APPLICATION_CREDENTIALS=$PWD/sample-sa-key.json
```

Verify:

```bash
echo $GOOGLE_APPLICATION_CREDENTIALS
```

Expected output:

```text
/home/USERNAME/GoogleCloudSkillsboost/Machine-Learning-APIs-on-Google-Cloud/sample-sa-key.json
```

---

# Step 7 — Find Correct Cloud Storage Bucket

Run:

```bash
gsutil ls
```

Example output:

```text
gs://qwiklabs-gcp-02-3546e52b5e7c/
```

Your bucket name is:

```text
qwiklabs-gcp-02-3546e52b5e7c
```

DO NOT include:

```text
gs://
```

---

# Step 8 — Open Python File

Run:

```bash
nano analyze-images-v2.py
```

---

# Step 9 — Replace ALL Python Code

Replace the entire file contents with the updated Vision API + Translation API + BigQuery code.

This step is REQUIRED because the original file contains incomplete `# TBD` sections.

---

# Step 10 — Save Nano File

Inside nano:

```text
CTRL + O
ENTER
CTRL + X
```

---

# Step 11 — Install Required Python Libraries

Run:

```bash
pip3 install google-cloud-storage google-cloud-bigquery google-cloud-vision google-cloud-translate
```

---

# Step 12 — Run Python Script

Run:

```bash
python3 analyze-images-v2.py $DEVSHELL_PROJECT_ID YOUR_BUCKET_NAME
```

Example:

```bash
python3 analyze-images-v2.py $DEVSHELL_PROJECT_ID qwiklabs-gcp-02-3546e52b5e7c
```

---

# Step 13 — Verify Text Files Were Created

Run:

```bash
gsutil ls gs://YOUR_BUCKET_NAME
```

You should now see `.txt` files generated from image text extraction.

Example:

```text
image1.txt
image2.txt
```

This confirms:

- Vision API extraction works
- Task 3 is completed

---

# Step 14 — Verify BigQuery Upload

Run:

```bash
bq query --use_legacy_sql=false \
'SELECT locale, COUNT(*) as total
FROM image_classification_dataset.image_text_detail
GROUP BY locale
ORDER BY total DESC'
```

You should now see language counts.

This confirms:

- Translation API works
- BigQuery upload works
- Task 4 and Task 5 are completed

---

# Common Mistakes

## Wrong Bucket Name

Wrong:

```bash
qwiklabs-gcp-02-xxxx-bucket
```

Correct:

```bash
qwiklabs-gcp-02-xxxx
```

Always verify using:

```bash
gsutil ls
```

---

## Credentials File Missing

If you see:

```text
The GOOGLE_APPLICATION_CREDENTIALS file does not exist
```

then verify:

```bash
ls
```

You must see:

```text
sample-sa-key.json
```

---

## Environment Variable Missing

Verify:

```bash
echo $GOOGLE_APPLICATION_CREDENTIALS
```

If empty, rerun:

```bash
export GOOGLE_APPLICATION_CREDENTIALS=$PWD/sample-sa-key.json
```

---

# BigQuery Query Used

```sql
SELECT locale, COUNT(*) as total
FROM image_classification_dataset.image_text_detail
GROUP BY locale
ORDER BY total DESC
```

---

# Expected Outcome

After completing all steps:

- Text is extracted from images
- Non-English text is translated into English
- `.txt` files are created in Cloud Storage
- Results are uploaded into BigQuery
- Language frequency query works successfully
- All lab tasks pass successfully

---

# Notes

- Use temporary Google Cloud Skills Boost credentials only
- Cloud Shell is already authenticated
- Vision API extracts text from images
- Translation API translates detected languages
- BigQuery stores processed dataset results
- Cloud Storage stores generated text files

---

# Final Step

Click:

```text
Check My Progress
```

All tasks should now complete successfully.