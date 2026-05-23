#!/bin/bash

echo "========================================="
echo "Google Cloud Networking Lab Automation"
echo "========================================="

# Ask user for regions
read -p "Enter REGION_1: " REGION_1
read -p "Enter REGION_2: " REGION_2
read -p "Enter REGION_3: " REGION_3

echo "Using regions:"
echo "$REGION_1"
echo "$REGION_2"
echo "$REGION_3"

# # Regions written as fixed variables
# export REGION_1=us-central1
# export REGION_2=europe-west1
# export REGION_3=asia-east1

# Show active project
PROJECT_ID=$(gcloud config get-value project)

echo "Using Project: $PROJECT_ID"

echo "Creating VPC Network..."

gcloud compute networks create taw-custom-network \
    --subnet-mode=custom

echo "Creating Subnets..."

# US Subnet
gcloud compute networks subnets create subnet-us-central \
    --network=taw-custom-network \
    --region=$REGION_1 \
    --range=10.0.0.0/16

# Europe Subnet
gcloud compute networks subnets create subnet-europe-west \
    --network=taw-custom-network \
    --region=$REGION_2 \
    --range=10.1.0.0/16

# Asia Subnet
gcloud compute networks subnets create subnet-asia \
    --network=taw-custom-network \
    --region=$REGION_3 \
    --range=10.2.0.0/16

echo "Creating Firewall Rules..."

# HTTP
gcloud compute firewall-rules create nw101-allow-http \
    --network=taw-custom-network \
    --allow tcp:80 \
    --target-tags=http \
    --source-ranges=0.0.0.0/0

# ICMP
gcloud compute firewall-rules create nw101-allow-icmp \
    --network=taw-custom-network \
    --allow icmp \
    --target-tags=rules \
    --source-ranges=0.0.0.0/0

# Internal Communication
gcloud compute firewall-rules create nw101-allow-internal \
    --network=taw-custom-network \
    --allow tcp:0-65535,udp:0-65535,icmp \
    --source-ranges=10.0.0.0/16,10.1.0.0/16,10.2.0.0/16

# SSH
gcloud compute firewall-rules create nw101-allow-ssh \
    --network=taw-custom-network \
    --allow tcp:22 \
    --target-tags=ssh \
    --source-ranges=0.0.0.0/0

# RDP
gcloud compute firewall-rules create nw101-allow-rdp \
    --network=taw-custom-network \
    --allow tcp:3389 \
    --source-ranges=0.0.0.0/0

echo "========================================="
echo "Lab Setup Complete!"
echo "========================================="
