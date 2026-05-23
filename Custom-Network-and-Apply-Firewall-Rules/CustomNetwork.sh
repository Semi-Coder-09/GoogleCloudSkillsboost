#!/bin/bash

echo "========================================="
echo "Custom Network and Firewall Automation"
echo "========================================="

# Ask for regions
read -p "Enter REGION_1: " REGION_1
read -p "Enter REGION_2: " REGION_2
read -p "Enter REGION_3: " REGION_3

echo ""
echo "Using Regions:"
echo "REGION_1=$REGION_1"
echo "REGION_2=$REGION_2"
echo "REGION_3=$REGION_3"

# Show active project
PROJECT_ID=$(gcloud config get-value project)

echo ""
echo "Using Project: $PROJECT_ID"

echo ""
echo "Creating Custom VPC Network..."

# Create custom network
gcloud compute networks create taw-custom-network \
    --subnet-mode=custom

echo ""
echo "Creating Subnets..."

# Subnet 1
gcloud compute networks subnets create subnet-us-central \
    --network=taw-custom-network \
    --region=$REGION_1 \
    --range=10.0.0.0/16

# Subnet 2
gcloud compute networks subnets create subnet-europe-west \
    --network=taw-custom-network \
    --region=$REGION_2 \
    --range=10.1.0.0/16

# Subnet 3
gcloud compute networks subnets create subnet-asia \
    --network=taw-custom-network \
    --region=$REGION_3 \
    --range=10.2.0.0/16

echo ""
echo "Listing Subnets..."

gcloud compute networks subnets list \
    --network=taw-custom-network

echo ""
echo "Creating Firewall Rules..."

# HTTP
gcloud compute firewall-rules create nw101-allow-http \
    --allow tcp:80 \
    --network taw-custom-network \
    --source-ranges 0.0.0.0/0 \
    --target-tags http

# ICMP
gcloud compute firewall-rules create nw101-allow-icmp \
    --allow icmp \
    --network taw-custom-network \
    --target-tags rules

# Internal
gcloud compute firewall-rules create nw101-allow-internal \
    --allow tcp:0-65535,udp:0-65535,icmp \
    --network taw-custom-network \
    --source-ranges 10.0.0.0/16,10.1.0.0/16,10.2.0.0/16

# SSH
gcloud compute firewall-rules create nw101-allow-ssh \
    --allow tcp:22 \
    --network taw-custom-network \
    --target-tags ssh

# RDP
gcloud compute firewall-rules create nw101-allow-rdp \
    --allow tcp:3389 \
    --network taw-custom-network

echo ""
echo "========================================="
echo "Lab Setup Complete!"
echo "========================================="