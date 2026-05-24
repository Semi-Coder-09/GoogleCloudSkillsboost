#!/bin/bash

# ==================================================
# Colors
# ==================================================

BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

BOLD='\033[1m'
RESET='\033[0m'

# ==================================================
# Header
# ==================================================

echo -e "${CYAN}${BOLD}"
echo "=================================================="
echo " Deploy & Manage Applications on Google App Engine"
echo "=================================================="
echo -e "${RESET}"

# ==================================================
# Inputs
# ==================================================

echo -e "${YELLOW}${BOLD}Enter Required Details${RESET}"
echo

read -p "ENTER REGION : " REGION
read -p "ENTER MESSAGE : " MESSAGE

echo
echo -e "${CYAN}${BOLD}==================================================${RESET}"
echo -e "${CYAN}${BOLD}Configuration Summary${RESET}"
echo -e "${CYAN}${BOLD}==================================================${RESET}"

echo -e "REGION        : ${GREEN}$REGION${RESET}"
echo -e "MESSAGE       : ${GREEN}$MESSAGE${RESET}"

echo
read -p "Proceed with setup? (y/n): " CONFIRM

if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
    echo
    echo -e "${RED}Operation Cancelled.${RESET}"
    exit 1
fi

# ==================================================
# Enable API
# ==================================================

echo
echo -e "${BLUE}${BOLD}==================================================${RESET}"
echo -e "${BLUE}${BOLD}Enabling App Engine Admin API${RESET}"
echo -e "${BLUE}${BOLD}==================================================${RESET}"

gcloud services enable appengine.googleapis.com

# ==================================================
# Clone Repository
# ==================================================

echo
echo -e "${BLUE}${BOLD}==================================================${RESET}"
echo -e "${BLUE}${BOLD}Downloading Hello World App${RESET}"
echo -e "${BLUE}${BOLD}==================================================${RESET}"

rm -rf python-docs-samples

git clone https://github.com/GoogleCloudPlatform/python-docs-samples.git

# ==================================================
# Navigate To App Directory
# ==================================================

cd python-docs-samples/appengine/standard_python3/hello_world || exit

# ==================================================
# Create App Engine App
# ==================================================

echo
echo -e "${BLUE}${BOLD}==================================================${RESET}"
echo -e "${BLUE}${BOLD}Creating App Engine Application${RESET}"
echo -e "${BLUE}${BOLD}==================================================${RESET}"

gcloud app create --region=$REGION --quiet

# ==================================================
# First Deployment
# ==================================================

echo
echo -e "${BLUE}${BOLD}==================================================${RESET}"
echo -e "${BLUE}${BOLD}Deploying Initial Application${RESET}"
echo -e "${BLUE}${BOLD}==================================================${RESET}"

gcloud app deploy --quiet

# ==================================================
# Update Message
# ==================================================

echo
echo -e "${BLUE}${BOLD}==================================================${RESET}"
echo -e "${BLUE}${BOLD}Updating Application Message${RESET}"
echo -e "${BLUE}${BOLD}==================================================${RESET}"

sed -i "s/Hello, World!/$MESSAGE/g" main.py

# ==================================================
# Redeploy Updated App
# ==================================================

echo
echo -e "${BLUE}${BOLD}==================================================${RESET}"
echo -e "${BLUE}${BOLD}Redeploying Updated Application${RESET}"
echo -e "${BLUE}${BOLD}==================================================${RESET}"

gcloud app deploy --quiet

# ==================================================
# Open App
# ==================================================

echo
echo -e "${BLUE}${BOLD}==================================================${RESET}"
echo -e "${BLUE}${BOLD}Opening Application${RESET}"
echo -e "${BLUE}${BOLD}==================================================${RESET}"

gcloud app browse

# ==================================================
# Complete
# ==================================================

echo
echo -e "${GREEN}${BOLD}==================================================${RESET}"
echo -e "${GREEN}${BOLD}Lab Completed Successfully!${RESET}"
echo -e "${GREEN}${BOLD}==================================================${RESET}"
echo