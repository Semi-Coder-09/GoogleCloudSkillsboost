#!/bin/bash

echo "=================================================="
echo "Set Up a Google Cloud Network - Challenge Lab"
echo "=================================================="

echo ""
echo "Enter Required Details"
echo ""

read -p "ENTER VPC_NAME: " VPC_NAME
read -p "ENTER SUBNET_A: " SUBNET_A
read -p "ENTER SUBNET_B: " SUBNET_B

read -p "ENTER FIREWALL_1: " FIREWALL_1
read -p "ENTER FIREWALL_2: " FIREWALL_2
read -p "ENTER FIREWALL_3: " FIREWALL_3

read -p "ENTER ZONE_1: " ZONE_1
read -p "ENTER ZONE_2: " ZONE_2

# Extract regions from zones
REGION_1=$(echo $ZONE_1 | sed 's/-[a-z]$//')
REGION_2=$(echo $ZONE_2 | sed 's/-[a-z]$//')

echo ""
echo "=================================================="
echo "Configuration Summary"
echo "=================================================="

echo "VPC NAME      : $VPC_NAME"

echo ""
echo "SUBNET DETAILS"
echo "SUBNET A      : $SUBNET_A"
echo "REGION 1      : $REGION_1"
echo "CIDR          : 10.10.10.0/24"

echo ""
echo "SUBNET B      : $SUBNET_B"
echo "REGION 2      : $REGION_2"
echo "CIDR          : 10.10.20.0/24"

echo ""
echo "FIREWALL RULES"
echo "FIREWALL 1    : $FIREWALL_1 (SSH)"
echo "FIREWALL 2    : $FIREWALL_2 (RDP)"
echo "FIREWALL 3    : $FIREWALL_3 (ICMP)"

echo ""
echo "VM ZONES"
echo "ZONE 1        : $ZONE_1"
echo "ZONE 2        : $ZONE_2"

echo ""
read -p "Proceed with setup? (y/n): " CONFIRM

if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
    echo ""
    echo "Setup Cancelled."
    exit 1
fi

echo ""
echo "=================================================="
echo "Creating VPC Network"
echo "=================================================="

gcloud compute networks create $VPC_NAME \
    --subnet-mode=custom \
    --bgp-routing-mode=regional

echo ""
echo "Creating Subnet A..."

gcloud compute networks subnets create $SUBNET_A \
    --network=$VPC_NAME \
    --region=$REGION_1 \
    --range=10.10.10.0/24 \
    --stack-type=IPV4_ONLY

echo ""
echo "Creating Subnet B..."

gcloud compute networks subnets create $SUBNET_B \
    --network=$VPC_NAME \
    --region=$REGION_2 \
    --range=10.10.20.0/24 \
    --stack-type=IPV4_ONLY

echo ""
echo "=================================================="
echo "Creating Firewall Rules"
echo "=================================================="

# Firewall 1 - SSH
gcloud compute firewall-rules create $FIREWALL_1 \
    --network=$VPC_NAME \
    --priority=1000 \
    --direction=INGRESS \
    --action=ALLOW \
    --rules=tcp:22 \
    --source-ranges=0.0.0.0/0

# Firewall 2 - RDP
gcloud compute firewall-rules create $FIREWALL_2 \
    --network=$VPC_NAME \
    --priority=65535 \
    --direction=INGRESS \
    --action=ALLOW \
    --rules=tcp:3389 \
    --source-ranges=0.0.0.0/24

# Firewall 3 - ICMP
gcloud compute firewall-rules create $FIREWALL_3 \
    --network=$VPC_NAME \
    --priority=1000 \
    --direction=INGRESS \
    --action=ALLOW \
    --rules=icmp \
    --source-ranges=10.10.10.0/24,10.10.20.0/24

echo ""
echo "=================================================="
echo "Creating VM Instances"
echo "=================================================="

# VM 1
gcloud compute instances create us-test-01 \
    --zone=$ZONE_1 \
    --machine-type=e2-standard-2 \
    --subnet=$SUBNET_A

# VM 2
gcloud compute instances create us-test-02 \
    --zone=$ZONE_2 \
    --machine-type=e2-standard-2 \
    --subnet=$SUBNET_B

echo ""
echo "=================================================="
echo "VM Creation Complete"
echo "=================================================="

echo ""
echo "Listing VM Instances..."

gcloud compute instances list

echo ""
echo "=================================================="
echo "NEXT MANUAL STEPS"
echo "=================================================="

echo ""
echo "1. SSH into us-test-01"

echo ""
echo "2. Ping us-test-02 Internal IP"
echo "Example:"
echo "ping -c 3 INTERNAL_IP"

echo ""
echo "3. Test Internal DNS"
echo "Example:"
echo "ping -c 3 us-test-02.$ZONE_2"

echo ""
echo "=================================================="
echo "Challenge Lab Completed!"
echo "=================================================="