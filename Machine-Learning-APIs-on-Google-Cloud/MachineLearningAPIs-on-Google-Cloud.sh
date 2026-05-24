#!/bin/bash

echo "=================================================="
echo "Machine Learning APIs on Google Cloud Lab"
echo "=================================================="

echo ""
echo "Enter Required Details"
echo ""

read -p "ENTER LANGUAGE (e.g., en, fr, es): " LANGUAGE
read -p "ENTER LOCALE (e.g., en_US, fr_FR): " LOCALE
read -p "ENTER BIGQUERY_ROLE (e.g., roles/bigquery.admin): " BIGQUERY_ROLE
read -p "ENTER CLOUD_STORAGE_ROLE (e.g., roles/storage.admin): " CLOUD_STORAGE_ROLE

PROJECT_ID=$(gcloud config get-value project)
SERVICE_ACCOUNT_NAME="ml-api-service-account"
SERVICE_ACCOUNT_EMAIL="${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com"

echo ""
echo "=================================================="
echo "Configuration Summary"
echo "=================================================="
echo "PROJECT ID           : $PROJECT_ID"
echo "LANGUAGE             : $LANGUAGE"
echo "LOCALE               : $LOCALE"
echo "BIGQUERY ROLE        : $BIGQUERY_ROLE"
echo "CLOUD STORAGE ROLE   : $CLOUD_STORAGE_ROLE"
echo "SERVICE ACCOUNT      : $SERVICE_ACCOUNT_EMAIL"

echo ""
read -p "Proceed with setup? (y/n): " CONFIRM

if [[ $CONFIRM != "y" ]]; then
    echo "Setup cancelled."
    exit 1
fi

echo ""
echo "=================================================="
echo "Enabling Required APIs"
echo "=================================================="

gcloud services enable vision.googleapis.com
gcloud services enable translate.googleapis.com
gcloud services enable bigquery.googleapis.com
gcloud services enable storage.googleapis.com

echo ""
echo "=================================================="
echo "Creating Service Account"
echo "=================================================="

gcloud iam service-accounts create $SERVICE_ACCOUNT_NAME \
    --display-name="ML API Service Account"

echo ""
echo "=================================================="
echo "Assigning IAM Roles"
echo "=================================================="

gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$SERVICE_ACCOUNT_EMAIL" \
    --role="$BIGQUERY_ROLE"

gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member="serviceAccount:$SERVICE_ACCOUNT_EMAIL" \
    --role="$CLOUD_STORAGE_ROLE"

echo ""
echo "=================================================="
echo "Creating Credential File"
echo "=================================================="

gcloud iam service-accounts keys create key.json \
    --iam-account=$SERVICE_ACCOUNT_EMAIL

export GOOGLE_APPLICATION_CREDENTIALS="$(pwd)/key.json"

echo ""
echo "Credential File Created:"
echo "$(pwd)/key.json"

echo ""
echo "=================================================="
echo "Copying Python Script From Bucket"
echo "=================================================="

gsutil ls

echo ""
echo "Locate the bucket containing analyze-images-v2.py"
echo ""

read -p "ENTER BUCKET NAME: " BUCKET_NAME

gsutil cp gs://$BUCKET_NAME/analyze-images-v2.py .

echo ""
echo "=================================================="
echo "Installing Python Packages"
echo "=================================================="

pip install --upgrade google-cloud-vision
pip install --upgrade google-cloud-translate
pip install --upgrade google-cloud-bigquery

echo ""
echo "=================================================="
echo "Next Manual Steps"
echo "=================================================="

echo ""
echo "1. Open analyze-images-v2.py"
echo ""
echo "nano analyze-images-v2.py"

echo ""
echo "2. Replace all # TBD sections using Vision API and Translation API"

echo ""
echo "3. Run the script"
echo ""
echo "python3 analyze-images-v2.py"

echo ""
echo "4. Uncomment the BigQuery upload line at the end"

echo ""
echo "5. Run BigQuery query:"
echo ""
echo "SELECT language, COUNT(*) as total"
echo "FROM ml_api_results.translated_text"
echo "GROUP BY language"
echo "ORDER BY total DESC;"

echo ""
echo "=================================================="
echo "Lab Setup Completed!"
echo "=================================================="
