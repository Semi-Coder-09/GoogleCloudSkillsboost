#!/bin/bash

# =========================================================
# Google App Engine Deployment Lab
# =========================================================

# -------------------------------
# Color Variables
# -------------------------------

PURPLE=$'\033[0;35m'
GOLD=$'\033[1;33m'
CYAN=$'\033[0;36m'
GREEN=$'\033[1;32m'
RED=$'\033[1;31m'
BLUE=$'\033[1;34m'
NC=$'\033[0m'

BOLD=$(tput bold)
RESET=$(tput sgr0)

# -------------------------------
# Banner
# -------------------------------

clear

echo "${PURPLE}${BOLD}====================================================${RESET}"
echo "${PURPLE}${BOLD}     Google App Engine Deployment Automation        ${RESET}"
echo "${PURPLE}${BOLD}====================================================${RESET}"
echo

# -------------------------------
# User Inputs
# -------------------------------

echo -e "${GOLD}${BOLD}Enter App Engine Region:${RESET} ${NC}"
read REGION

echo

echo -e "${GOLD}${BOLD}Enter Updated Application Message:${RESET} ${NC}"
read MESSAGE

echo
echo "${CYAN}${BOLD}Region Selected:${RESET} $REGION"
echo "${CYAN}${BOLD}Message Selected:${RESET} $MESSAGE"
echo

sleep 2

# -------------------------------
# Enable API
# -------------------------------

echo "${BLUE}${BOLD}========================================${RESET}"
echo "${BLUE}${BOLD}Enabling App Engine Admin API...${RESET}"
echo "${BLUE}${BOLD}========================================${RESET}"

gcloud services enable appengine.googleapis.com

echo
echo "${GREEN}${BOLD}API Enabled Successfully.${RESET}"
echo

sleep 3

# -------------------------------
# Remove Existing Repository
# -------------------------------

cd ~

if [ -d "python-docs-samples" ]; then
    echo "${RED}${BOLD}Existing Repository Found. Removing...${RESET}"
    rm -rf python-docs-samples
    echo "${GREEN}${BOLD}Old Repository Removed.${RESET}"
    echo
fi

sleep 2

# -------------------------------
# Clone Repository
# -------------------------------

echo "${BLUE}${BOLD}========================================${RESET}"
echo "${BLUE}${BOLD}Downloading Hello World Application...${RESET}"
echo "${BLUE}${BOLD}========================================${RESET}"
echo

git clone --progress https://github.com/GoogleCloudPlatform/python-docs-samples.git

echo
echo "${GREEN}${BOLD}Repository Downloaded Successfully.${RESET}"
echo

sleep 2

# -------------------------------
# Navigate to App Directory
# -------------------------------

cd ~/python-docs-samples/appengine/standard_python3/hello_world

echo "${CYAN}${BOLD}Current Directory:${RESET}"
pwd

echo
echo "${CYAN}${BOLD}Project Files:${RESET}"
ls

echo
sleep 2

# -------------------------------
# Create App Engine App
# -------------------------------

echo "${BLUE}${BOLD}========================================${RESET}"
echo "${BLUE}${BOLD}Creating App Engine Application...${RESET}"
echo "${BLUE}${BOLD}========================================${RESET}"

gcloud app create --region=$REGION --quiet || true

echo
echo "${GREEN}${BOLD}App Engine Application Ready.${RESET}"
echo

sleep 3

# -------------------------------
# First Deployment
# -------------------------------

echo "${BLUE}${BOLD}========================================${RESET}"
echo "${BLUE}${BOLD}Deploying Application...${RESET}"
echo "${BLUE}${BOLD}========================================${RESET}"

gcloud app deploy --quiet

echo
echo "${GREEN}${BOLD}Application Deployed Successfully.${RESET}"
echo

sleep 3

# -------------------------------
# Open Application
# -------------------------------

echo "${CYAN}${BOLD}Opening Application in Browser...${RESET}"
gcloud app browse

echo
sleep 3

# -------------------------------
# Update Application Message
# -------------------------------

echo "${BLUE}${BOLD}========================================${RESET}"
echo "${BLUE}${BOLD}Updating Application Message...${RESET}"
echo "${BLUE}${BOLD}========================================${RESET}"

sed -i "s/Hello World!/$MESSAGE/g" main.py

echo
echo "${GREEN}${BOLD}Message Updated Successfully.${RESET}"
echo

sleep 2

# -------------------------------
# Redeploy Updated App
# -------------------------------

echo "${BLUE}${BOLD}========================================${RESET}"
echo "${BLUE}${BOLD}Redeploying Updated Application...${RESET}"
echo "${BLUE}${BOLD}========================================${RESET}"

gcloud app deploy --quiet

echo
echo "${GREEN}${BOLD}Updated Application Deployed Successfully.${RESET}"
echo

sleep 3

# -------------------------------
# Open Updated App
# -------------------------------

echo "${CYAN}${BOLD}Opening Updated Application...${RESET}"

gcloud app browse

echo
echo "${PURPLE}${BOLD}====================================================${RESET}"
echo "${PURPLE}${BOLD}          LAB COMPLETED SUCCESSFULLY                ${RESET}"
echo "${PURPLE}${BOLD}====================================================${RESET}"
echo