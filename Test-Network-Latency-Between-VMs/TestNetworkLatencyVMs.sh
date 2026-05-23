#!/bin/bash

echo "========================================="
echo "VM Network Latency and Performance Lab"
echo "========================================="

# Input regions
read -p "Enter REGION_1: " REGION_1
read -p "Enter REGION_2: " REGION_2
read -p "Enter REGION_3: " REGION_3

# Input zones
read -p "Enter ZONE_1: " ZONE_1
read -p "Enter ZONE_2: " ZONE_2
read -p "Enter ZONE_3: " ZONE_3

echo ""
echo "Using Regions:"
echo "$REGION_1"
echo "$REGION_2"
echo "$REGION_3"

echo ""
echo "Using Zones:"
echo "$ZONE_1"
echo "$ZONE_2"
echo "$ZONE_3"

# Project
PROJECT_ID=$(gcloud config get-value project)

echo ""
echo "Using Project: $PROJECT_ID"

echo ""
echo "Creating VM Instances..."

# VM 1
gcloud compute instances create us-test-01 \
    --subnet=subnet-$REGION_1 \
    --zone=$ZONE_1 \
    --machine-type=e2-standard-2 \
    --tags=ssh,http,rules

# VM 2
gcloud compute instances create us-test-02 \
    --subnet=subnet-$REGION_2 \
    --zone=$ZONE_2 \
    --machine-type=e2-standard-2 \
    --tags=ssh,http,rules

# VM 3
gcloud compute instances create us-test-03 \
    --subnet=subnet-$REGION_3 \
    --zone=$ZONE_3 \
    --machine-type=e2-standard-2 \
    --tags=ssh,http,rules

echo ""
echo "Creating Additional VM us-test-04..."

# VM 4
gcloud compute instances create us-test-04 \
    --subnet=subnet-$REGION_1 \
    --zone=$ZONE_1 \
    --machine-type=e2-standard-2 \
    --tags=ssh,http

echo ""
echo "========================================="
echo "VM Creation Complete!"
echo "========================================="

echo ""
echo "Listing VM Instances..."

gcloud compute instances list

echo ""
echo "========================================="
echo "NEXT MANUAL STEPS"
echo "========================================="

echo ""
echo "STEP 1 — SSH into:"
echo "1. us-test-01"
echo "2. us-test-02"
echo "3. us-test-04"

echo ""
echo "STEP 2 — Install Tools on us-test-02 and us-test-04"

echo ""
echo "Run:"
echo "sudo apt-get update"
echo "sudo apt-get -y install traceroute mtr tcpdump iperf whois host dnsutils siege"

echo ""
echo "STEP 3 — TCP iperf Test"

echo ""
echo "On us-test-01:"
echo "iperf -s"

echo ""
echo "On us-test-02:"
echo "iperf -c us-test-01.$ZONE_1"

echo ""
echo "STEP 4 — Stop server using CTRL+C"

echo ""
echo "STEP 5 — UDP Performance Test"

echo ""
echo "On us-test-02:"
echo "iperf -s -u"

echo ""
echo "On us-test-01:"
echo "iperf -c us-test-02.$ZONE_2 -u -b 2G"

echo ""
echo "STEP 6 — Stop UDP server using CTRL+C"

echo ""
echo "STEP 7 — Parallel TCP Streams Test"

echo ""
echo "On us-test-01:"
echo "iperf -s"

echo ""
echo "On us-test-02:"
echo "iperf -c us-test-01.$ZONE_1 -P 20"

echo ""
echo "========================================="
echo "Lab Setup Completed!"
echo "========================================="