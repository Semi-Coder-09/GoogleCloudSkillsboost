# Set Up a Google Cloud Network - Challenge Lab

This challenge lab creates:

- A custom VPC network
- Two subnetworks
- Three firewall rules
- Two VM instances
- Connectivity testing between VMs

---

# What This Lab Teaches

- Creating custom VPC networks
- Creating subnetworks
- Configuring firewall rules
- Launching VM instances
- Testing VM connectivity
- Internal DNS resolution

---

# Files

| File | Purpose |
|---|---|
| GoogleCloudNetwork-ChallengeLab.sh | Automates VPC, subnet, firewall, and VM creation |

---

# Usage

## Step 1 — Clone Repository

```bash
git clone https://github.com/Semi-Coder-09/GoogleCloudSkillsboost.git
```

---

## Step 2 — Navigate to Folder

```bash
cd "GoogleCloudSkillsboost/Set-Up-a-Google-Cloud-Network-Challenge-Lab"
```

---

## Step 3 — Make Script Executable

```bash
chmod +x GoogleCloudNetwork-ChallengeLab.sh
```

---

## Step 4 — Run Script

```bash
./GoogleCloudNetwork-ChallengeLab.sh
```

---

# Required Inputs

```text
ENTER VPC_NAME:
ENTER SUBNET_A:
ENTER SUBNET_B:
ENTER FIREWALL_1:
ENTER FIREWALL_2:
ENTER FIREWALL_3:
ENTER ZONE_1:
ENTER ZONE_2:
```

---

# Exact Input For This Lab

```text
ENTER VPC_NAME: vpc-network-22zs

ENTER SUBNET_A: subnet-a-6wks
ENTER SUBNET_B: subnet-b-hzgn

ENTER FIREWALL_1: gars-firewall-ssh
ENTER FIREWALL_2: pilm-firewall-rdp
ENTER FIREWALL_3: necx-firewall-icmp

ENTER ZONE_1: us-east4-b
ENTER ZONE_2: europe-west4-a
```

---

# What The Script Creates

## VPC Network

| Resource | Details |
|---|---|
| VPC Name | vpc-network-22zs |
| Routing Mode | Regional |
| Stack Type | IPv4 Only |

---

## Subnetworks

| Subnet | Region | CIDR |
|---|---|---|
| subnet-a-6wks | us-east4 | 10.10.10.0/24 |
| subnet-b-hzgn | europe-west4 | 10.10.20.0/24 |

---

## Firewall Rules

| Firewall Rule | Purpose |
|---|---|
| gars-firewall-ssh | Allow SSH |
| pilm-firewall-rdp | Allow RDP |
| necx-firewall-icmp | Allow ICMP |

---

## VM Instances

| VM | Zone | Machine Type |
|---|---|---|
| us-test-01 | us-east4-b | e2-standard-2 |
| us-test-02 | europe-west4-a | e2-standard-2 |

---

# After Script Completes

The script automatically creates:

- VPC network
- Subnetworks
- Firewall rules
- VM instances

---

# Manual Testing Steps

## Open SSH

Go to:

```text
Compute Engine → VM Instances
```

Click:

```text
SSH
```

for:

```text
us-test-01
```

---

# Test 1 — Ping Internal IP

Inside `us-test-01` SSH terminal:

```bash
ping -c 3 INTERNAL_IP
```

Example:

```bash
ping -c 3 10.10.20.2
```

---

# How to Find Internal IP

Go to:

```text
Compute Engine → VM Instances
```

Copy the:

```text
Internal IP
```

of:

```text
us-test-02
```

---

# Test 2 — Internal DNS Ping

Inside `us-test-01` SSH terminal:

```bash
ping -c 3 us-test-02.europe-west4-a
```

---

# Expected Output

```text
64 bytes from 10.10.20.x: icmp_seq=1 ttl=64 time=xxx ms
```

---

# Internal DNS Format

```text
hostName.[ZONE].c.[PROJECT_ID].internal
```

Example:

```text
us-test-02.europe-west4-a.c.my-project.internal
```

---

# Final Verification

After successful ping tests:

```text
Click "Check my progress"
```

---

# Notes

- Use temporary Skills Boost credentials only
- Cloud Shell is pre-authenticated
- IPv4 single-stack networking is used
- Regional dynamic routing is enabled
- Firewall rules are required for VM communication

---

# Expected Outcome

After completing this challenge lab, you should be able to:

- Create a custom VPC
- Configure subnetworks
- Configure firewall rules
- Launch VM instances
- Verify internal VM connectivity
- Test internal DNS resolution