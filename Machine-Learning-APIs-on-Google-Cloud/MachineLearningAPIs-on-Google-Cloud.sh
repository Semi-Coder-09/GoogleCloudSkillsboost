#!/bin/bash

# ==================================================
# Colors
# ==================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
RESET='\033[0m'

# ==================================================
# Header
# ==================================================

clear

echo -e "${CYAN}==================================================${RESET}"
echo -e "${WHITE}     Machine Learning APIs on Google Cloud${RESET}"
echo -e "${CYAN}==================================================${RESET}"
echo ""

# ==================================================
# User Inputs
# ==================================================

read -p "$(echo -e "${YELLOW}ENTER LANGUAGE (e.g., en, fr, es): ${RESET}")" LANGUAGE

read -p "$(echo -e "${YELLOW}ENTER LOCALE (e.g., en_US, fr_FR): ${RESET}")" LOCALE

read -p "$(echo -e "${YELLOW}ENTER BIGQUERY_ROLE (e.g., roles/bigquery.dataEditor): ${RESET}")" BIGQUERY_ROLE

read -p "$(echo -e "${YELLOW}ENTER CLOUD_STORAGE_ROLE (e.g., roles/storage.admin): ${RESET}")" CLOUD_STORAGE_ROLE

echo ""

# ==================================================
# Summary
# ==================================================

echo -e "${CYAN}==================================================${RESET}"
echo -e "${WHITE}Configuration Summary${RESET}"
echo -e "${CYAN}==================================================${RESET}"

echo -e "${GREEN}LANGUAGE             : ${WHITE}$LANGUAGE${RESET}"
echo -e "${GREEN}LOCALE               : ${WHITE}$LOCALE${RESET}"
echo -e "${GREEN}BIGQUERY ROLE        : ${WHITE}$BIGQUERY_ROLE${RESET}"
echo -e "${GREEN}CLOUD STORAGE ROLE   : ${WHITE}$CLOUD_STORAGE_ROLE${RESET}"

echo ""

read -p "Proceed with setup? (y/n): " CONFIRM

if [[ $CONFIRM != "y" ]]; then
    echo "Setup cancelled."
    exit 1
fi

# ==================================================
# Variables
# ==================================================

PROJECT_ID=$(gcloud config get-value project)

SERVICE_ACCOUNT="ml-api-sa"

SERVICE_ACCOUNT_EMAIL="$SERVICE_ACCOUNT@$PROJECT_ID.iam.gserviceaccount.com"

KEY_FILE="key.json"

echo ""

# ==================================================
# Enable APIs
# ==================================================

echo -e "${CYAN}==================================================${RESET}"
echo -e "${WHITE}Enabling APIs${RESET}"
echo -e "${CYAN}==================================================${RESET}"

gcloud services enable vision.googleapis.com
gcloud services enable translate.googleapis.com
gcloud services enable bigquery.googleapis.com
gcloud services enable storage.googleapis.com

echo ""

# ==================================================
# Create Service Account
# ==================================================

echo -e "${CYAN}==================================================${RESET}"
echo -e "${WHITE}Creating Service Account${RESET}"
echo -e "${CYAN}==================================================${RESET}"

gcloud iam service-accounts create $SERVICE_ACCOUNT \
    --display-name="Machine Learning API Service Account"

echo ""

# ==================================================
# Assign IAM Roles
# ==================================================

echo -e "${CYAN}==================================================${RESET}"
echo -e "${WHITE}Assigning IAM Roles${RESET}"
echo -e "${CYAN}==================================================${RESET}"

gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$SERVICE_ACCOUNT_EMAIL" \
    --role="$BIGQUERY_ROLE"

gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$SERVICE_ACCOUNT_EMAIL" \
    --role="$CLOUD_STORAGE_ROLE"

echo ""

# ==================================================
# Create Service Account Key
# ==================================================

echo -e "${CYAN}==================================================${RESET}"
echo -e "${WHITE}Creating Credential File${RESET}"
echo -e "${CYAN}==================================================${RESET}"

gcloud iam service-accounts keys create $KEY_FILE \
    --iam-account=$SERVICE_ACCOUNT_EMAIL

export GOOGLE_APPLICATION_CREDENTIALS=$PWD/$KEY_FILE

echo ""

echo -e "${GREEN}Credentials Exported:${RESET}"
echo "$GOOGLE_APPLICATION_CREDENTIALS"

echo ""

# ==================================================
# Find Bucket
# ==================================================

echo -e "${CYAN}==================================================${RESET}"
echo -e "${WHITE}Detecting Cloud Storage Bucket${RESET}"
echo -e "${CYAN}==================================================${RESET}"

BUCKET_NAME=$(gsutil ls | head -n 1 | sed 's/gs:\/\///' | sed 's/\///')

echo ""

echo -e "${GREEN}Detected Bucket:${RESET} $BUCKET_NAME"

echo ""

# ==================================================
# Download Python File
# ==================================================

echo -e "${CYAN}==================================================${RESET}"
echo -e "${WHITE}Downloading Python File${RESET}"
echo -e "${CYAN}==================================================${RESET}"

gsutil cp gs://$BUCKET_NAME/analyze-images-v2.py .

echo ""

# ==================================================
# Replace TBD Sections Automatically
# ==================================================

echo -e "${CYAN}==================================================${RESET}"
echo -e "${WHITE}Configuring Python Script${RESET}"
echo -e "${CYAN}==================================================${RESET}"

sed -i "/# TBD: Create a Vision API image object called image_object/a\\
        image_object = vision.Image(content=file_content)
" analyze-images-v2.py

sed -i "/# TBD: Detect text in the image and save the response data into an object called response/a\\
        response = vision_client.document_text_detection(image=image_object)
" analyze-images-v2.py

sed -i "/# TBD: According to the target language pass the description data to the translation API/a\\
            translation = translate_client.translate(desc, target_language='$LANGUAGE')
" analyze-images-v2.py

sed -i "s/# errors = bq_client.insert_rows(table, rows_for_bq)/errors = bq_client.insert_rows(table, rows_for_bq)/" analyze-images-v2.py

echo ""

# ==================================================
# Run Python Script
# ==================================================

echo -e "${CYAN}==================================================${RESET}"
echo -e "${WHITE}Running Python Script${RESET}"
echo -e "${CYAN}==================================================${RESET}"

python3 analyze-images-v2.py $PROJECT_ID $BUCKET_NAME

echo ""

# ==================================================
# Run BigQuery Query
# ==================================================

echo -e "${CYAN}==================================================${RESET}"
echo -e "${WHITE}BigQuery Results${RESET}"
echo -e "${CYAN}==================================================${RESET}"

bq query --use_legacy_sql=false \
'SELECT locale, COUNT(*) as total
FROM image_classification_dataset.image_text_detail
GROUP BY locale
ORDER BY total DESC'

echo ""

# ==================================================
# Completion
# ==================================================

echo -e "${GREEN}==================================================${RESET}"
echo -e "${WHITE}Lab Completed Successfully!${RESET}"
echo -e "${GREEN}==================================================${RESET}"