# Google Cloud Skills Boost Automation

This repository contains automation scripts for Google Cloud Skills Boost labs.

## Networking 101 Lab

This script automates:

- Custom VPC creation
- Subnet creation
- Firewall rule creation

## Usage

Open Cloud Shell and run:

## Step 1 — Download Script

```bash
curl -LO https://raw.githubusercontent.com/Semi-Coder-09/GoogleCloudSkillsboost/refs/heads/main/Networking/Networking101.sh
```

## Step 2 — Make Script Executable

```bash
sed -i 's/\r$//' Networking101.sh
```

```bash
chmod +x Networking101.sh
```

## Step 3 — Run Script

```bash
./Networking101.sh
```

---

# Example Input { According to your question asks in your Labs question }

```text
Enter REGION_1: us-central1
Enter REGION_2: europe-west1
Enter REGION_3: asia-east1
```

# Error came up then solutions { Subnet errors }

{ Creates a new subnet }
```text
gcloud compute networks subnets create subnet-us-east4 \
    --network=taw-custom-network \
    --region=us-east4 \
    --range=10.3.0.0/16
```

{ Delete the error existing subnet }
```text
gcloud compute networks subnets delete subnet-asia --region=europe-west1
```

---

# Resources Created

## VPC Network
- taw-custom-network

## Subnets
- subnet-us-central
- subnet-europe-west
- subnet-asia

## Firewall Rules
- nw101-allow-http
- nw101-allow-icmp
- nw101-allow-internal
- nw101-allow-ssh
- nw101-allow-rdp

---

# Notes

- Designed for Google Cloud Skills Boost labs
- Uses dynamic region input
- Do not use personal billing accounts
- Use temporary lab credentials only
- Google Skill up Summer
- Created by Bhabani
