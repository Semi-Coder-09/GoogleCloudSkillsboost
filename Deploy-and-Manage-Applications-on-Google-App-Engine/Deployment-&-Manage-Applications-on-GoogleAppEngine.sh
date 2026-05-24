#!/bin/bash

# ============================================
# Google App Engine Deployment Lab
# ============================================

set -e

echo "======================================="
echo "Google App Engine Deployment"
echo "======================================="

# --------------------------------------------
# User Inputs
# --------------------------------------------

read -p "Enter App Engine Region (example: us-central): " REGION

read -p "Enter new application message: " NEW_MESSAGE

echo ""
echo "Region: $REGION"
echo "Message: $NEW_MESSAGE"
echo ""

# --------------------------------------------
# TASK 1: Enable API
# --------------------------------------------

echo "======================================="
echo "TASK 1: Enable App Engine Admin API"
echo "======================================="

gcloud services enable appengine.googleapis.com

# --------------------------------------------
# TASK 2: Download Repository
# --------------------------------------------

echo "======================================="
echo "TASK 2: Download Hello World App"
echo "======================================="

cd ~

# Delete old repo if already exists
if [ -d "python-docs-samples" ]; then
    echo "Old repository found. Removing..."
    rm -rf python-docs-samples
fi

echo "Cloning repository..."

git clone https://github.com/GoogleCloudPlatform/python-docs-samples.git

echo "Repository downloaded successfully."

# --------------------------------------------
# Navigate to App Engine Sample
# --------------------------------------------

cd ~/python-docs-samples/appengine/standard_python3/hello_world

echo "Current Directory:"
pwd

echo "Files:"
ls

# --------------------------------------------
# TASK 3: Create App Engine App
# --------------------------------------------

echo "======================================="
echo "TASK 3: Create App Engine Application"
echo "======================================="

gcloud app create --region=$REGION --quiet || true

# --------------------------------------------
# TASK 4: Deploy Application
# --------------------------------------------

echo "======================================="
echo "TASK 4: Deploy Application"
echo "======================================="

gcloud app deploy --quiet

# --------------------------------------------
# Open App
# --------------------------------------------

echo "======================================="
echo "Opening Application"
echo "======================================="

gcloud app browse

# --------------------------------------------
# TASK 5: Update Message
# --------------------------------------------

echo "======================================="
echo "TASK 5: Update Application"
echo "======================================="

sed -i "s/Hello World!/$NEW_MESSAGE/g" main.py

echo "Updated main.py successfully."

# --------------------------------------------
# Redeploy
# --------------------------------------------

echo "======================================="
echo "Redeploy Updated Application"
echo "======================================="

gcloud app deploy --quiet

# --------------------------------------------
# Open Updated App
# --------------------------------------------

echo "======================================="
echo "Opening Updated Application"
echo "======================================="

gcloud app browse

echo "======================================="
echo "Application Updated Successfully"
echo "======================================="