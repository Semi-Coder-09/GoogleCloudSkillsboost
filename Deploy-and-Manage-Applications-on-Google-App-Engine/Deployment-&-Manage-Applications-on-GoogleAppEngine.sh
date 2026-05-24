#!/bin/bash

# ============================================
# Google App Engine Deployment Lab
# ============================================

# Exit immediately if a command fails
set -e

echo "======================================="
echo "Google App Engine Deployment"
echo "======================================="

# --------------------------------------------
# User Inputs
# --------------------------------------------

read -p "Enter App Engine Region (example: us-central, us-east1): " REGION

read -p "Enter new application message: " NEW_MESSAGE

echo ""
echo "Region Selected: $REGION"
echo "Updated Message: $NEW_MESSAGE"
echo ""

echo "======================================="
echo "TASK 1: Enable App Engine Admin API"
echo "======================================="

gcloud services enable appengine.googleapis.com

echo "======================================="
echo "TASK 2: Download Hello World App"
echo "======================================="

cd ~

# Remove old repository if it exists
rm -rf python-docs-samples

# Clone Python sample repository
git clone https://github.com/GoogleCloudPlatform/python-docs-samples.git

# Navigate to Hello World sample
cd python-docs-samples/appengine/standard_python3/hello_world

echo "======================================="
echo "TASK 3: Create App Engine Application"
echo "======================================="

gcloud app create --region=$REGION --quiet || true

echo "======================================="
echo "TASK 4: Deploy Application"
echo "======================================="

gcloud app deploy --quiet

echo "======================================="
echo "Opening Application"
echo "======================================="

gcloud app browse

echo "======================================="
echo "TASK 5: Update Application"
echo "======================================="

# Replace default message
sed -i "s/Hello World!/$NEW_MESSAGE/g" main.py

echo "======================================="
echo "Redeploy Updated Application"
echo "======================================="

gcloud app deploy --quiet

echo "======================================="
echo "Opening Updated Application"
echo "======================================="

gcloud app browse

echo "======================================="
echo "Application Updated Successfully"
echo "======================================="