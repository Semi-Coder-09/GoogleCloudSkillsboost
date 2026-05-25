#!/bin/bash

# =========================================================
# Build Website on Google Cloud - Challenge Lab
# =========================================================

set -e

# ---------------- COLORS ----------------

PURPLE=$'\033[0;35m'
CYAN=$'\033[0;36m'
GREEN=$'\033[1;32m'
RED=$'\033[1;31m'
YELLOW=$'\033[1;33m'
BLUE=$'\033[1;34m'
NC=$'\033[0m'

BOLD=$(tput bold)
RESET=$(tput sgr0)

clear

echo "${PURPLE}${BOLD}====================================================${RESET}"
echo "${PURPLE}${BOLD}      Build Website on Google Cloud Challenge       ${RESET}"
echo "${PURPLE}${BOLD}====================================================${RESET}"
echo

# ---------------- USER INPUTS ----------------

echo -ne "${YELLOW}${BOLD}Enter your Zone:${RESET} "
read ZONE

echo -ne "${YELLOW}${BOLD}Enter Monolith Identifier:${RESET} "
read MONOLITH

echo -ne "${YELLOW}${BOLD}Enter Cluster Name:${RESET} "
read CLUSTER

echo -ne "${YELLOW}${BOLD}Enter Orders Service Identifier:${RESET} "
read ORDERS

echo -ne "${YELLOW}${BOLD}Enter Products Service Identifier:${RESET} "
read PRODUCTS

echo -ne "${YELLOW}${BOLD}Enter Frontend Identifier:${RESET} "
read FRONTEND

echo
echo "${CYAN}${BOLD}Inputs Summary${RESET}"
echo "ZONE: $ZONE"
echo "MONOLITH: $MONOLITH"
echo "CLUSTER: $CLUSTER"
echo "ORDERS: $ORDERS"
echo "PRODUCTS: $PRODUCTS"
echo "FRONTEND: $FRONTEND"
echo

sleep 3

# ---------------- CLONE REPO ----------------

cd ~

if [ -d "monolith-to-microservices" ]; then
    rm -rf monolith-to-microservices
fi

echo "${BLUE}${BOLD}Cloning Repository...${RESET}"

git clone https://github.com/googlecodelabs/monolith-to-microservices.git

cd monolith-to-microservices

chmod +x setup.sh

./setup.sh

echo
echo "${GREEN}${BOLD}Repository Ready.${RESET}"
echo

# ---------------- NODE UPDATE ----------------

echo "${BLUE}${BOLD}Installing Latest NodeJS LTS...${RESET}"

nvm install --lts

# ---------------- ENABLE APIS ----------------

echo "${BLUE}${BOLD}Enabling Required APIs...${RESET}"

gcloud services enable \
container.googleapis.com \
cloudbuild.googleapis.com

# ---------------- BUILD MONOLITH ----------------

echo
echo "${BLUE}${BOLD}Building Monolith Container...${RESET}"

cd ~/monolith-to-microservices/monolith

gcloud builds submit --tag gcr.io/$GOOGLE_CLOUD_PROJECT/$MONOLITH:1.0.0

echo
echo "${GREEN}${BOLD}Monolith Image Built Successfully.${RESET}"

# ---------------- CREATE CLUSTER ----------------

echo
echo "${BLUE}${BOLD}Creating GKE Cluster...${RESET}"

gcloud container clusters create $CLUSTER \
--zone=$ZONE \
--machine-type=e2-medium \
--num-nodes=3

echo
echo "${GREEN}${BOLD}Cluster Created Successfully.${RESET}"

# ---------------- DEPLOY MONOLITH ----------------

echo
echo "${BLUE}${BOLD}Deploying Monolith...${RESET}"

kubectl create deployment $MONOLITH \
--image=gcr.io/$GOOGLE_CLOUD_PROJECT/$MONOLITH:1.0.0

kubectl expose deployment $MONOLITH \
--type=LoadBalancer \
--port=80 \
--target-port=8080

echo
echo "${GREEN}${BOLD}Monolith Deployment Completed.${RESET}"

sleep 20

# ---------------- BUILD ORDERS ----------------

echo
echo "${BLUE}${BOLD}Building Orders Microservice...${RESET}"

cd ~/monolith-to-microservices/microservices/src/orders

gcloud builds submit --tag gcr.io/$GOOGLE_CLOUD_PROJECT/$ORDERS:1.0.0

# ---------------- BUILD PRODUCTS ----------------

echo
echo "${BLUE}${BOLD}Building Products Microservice...${RESET}"

cd ~/monolith-to-microservices/microservices/src/products

gcloud builds submit --tag gcr.io/$GOOGLE_CLOUD_PROJECT/$PRODUCTS:1.0.0

# ---------------- DEPLOY ORDERS ----------------

echo
echo "${BLUE}${BOLD}Deploying Orders Service...${RESET}"

kubectl create deployment $ORDERS \
--image=gcr.io/$GOOGLE_CLOUD_PROJECT/$ORDERS:1.0.0

kubectl expose deployment $ORDERS \
--type=LoadBalancer \
--port=80 \
--target-port=8081

# ---------------- DEPLOY PRODUCTS ----------------

echo
echo "${BLUE}${BOLD}Deploying Products Service...${RESET}"

kubectl create deployment $PRODUCTS \
--image=gcr.io/$GOOGLE_CLOUD_PROJECT/$PRODUCTS:1.0.0

kubectl expose deployment $PRODUCTS \
--type=LoadBalancer \
--port=80 \
--target-port=8082

echo
echo "${GREEN}${BOLD}Waiting For External IPs...${RESET}"

sleep 40

# ---------------- GET IPS ----------------

ORDERS_IP=$(kubectl get svc $ORDERS \
--output=jsonpath='{.status.loadBalancer.ingress[0].ip}')

PRODUCTS_IP=$(kubectl get svc $PRODUCTS \
--output=jsonpath='{.status.loadBalancer.ingress[0].ip}')

echo
echo "${CYAN}${BOLD}Orders IP:${RESET} $ORDERS_IP"
echo "${CYAN}${BOLD}Products IP:${RESET} $PRODUCTS_IP"

# ---------------- CONFIGURE FRONTEND ----------------

echo
echo "${BLUE}${BOLD}Configuring Frontend...${RESET}"

cd ~/monolith-to-microservices/react-app

cat > .env <<EOF
REACT_APP_ORDERS_URL=http://$ORDERS_IP/api/orders
REACT_APP_PRODUCTS_URL=http://$PRODUCTS_IP/api/products
EOF

npm install

npm run build

# ---------------- BUILD FRONTEND ----------------

echo
echo "${BLUE}${BOLD}Building Frontend Container...${RESET}"

cd ~/monolith-to-microservices/microservices/src/frontend

gcloud builds submit --tag gcr.io/$GOOGLE_CLOUD_PROJECT/$FRONTEND:1.0.0

# ---------------- DEPLOY FRONTEND ----------------

echo
echo "${BLUE}${BOLD}Deploying Frontend Service...${RESET}"

kubectl create deployment $FRONTEND \
--image=gcr.io/$GOOGLE_CLOUD_PROJECT/$FRONTEND:1.0.0

kubectl expose deployment $FRONTEND \
--type=LoadBalancer \
--port=80 \
--target-port=8080

echo
echo "${GREEN}${BOLD}Frontend Deployment Completed.${RESET}"

sleep 40

FRONTEND_IP=$(kubectl get svc $FRONTEND \
--output=jsonpath='{.status.loadBalancer.ingress[0].ip}')

echo
echo "${PURPLE}${BOLD}====================================================${RESET}"
echo "${PURPLE}${BOLD}              LAB COMPLETED SUCCESSFULLY            ${RESET}"
echo "${PURPLE}${BOLD}====================================================${RESET}"
echo

echo "${GREEN}${BOLD}Frontend URL:${RESET}"
echo "http://$FRONTEND_IP"

echo
echo "${CYAN}${BOLD}Orders API:${RESET}"
echo "http://$ORDERS_IP/api/orders"

echo
echo "${CYAN}${BOLD}Products API:${RESET}"
echo "http://$PRODUCTS_IP/api/products"

echo
echo "${YELLOW}${BOLD}Now Click:${RESET} Check My Progress"