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

# Example Input

```text
ENTER VPC_NAME: taw-custom-network

ENTER SUBNET_A: subnet-a
ENTER SUBNET_B: subnet-b

ENTER FIREWALL_1: allow-ssh
ENTER FIREWALL_2: allow-rdp
ENTER FIREWALL_3: allow-icmp

ENTER ZONE_1: us-central1-a
ENTER ZONE_2: europe-west1-b
```

---

# What The Script Creates

## VPC Network

| Resource | Details |
|---|---|
| Routing Mode | Regional |
| Stack Type | IPv4 Only |

---

## Subnetworks

| Subnet | CIDR |
|---|---|
| SUBNET_A | 10.10.10.0/24 |
| SUBNET_B | 10.10.20.0/24 |

---

## Firewall Rules

| Firewall | Purpose |
|---|---|
| FIREWALL_1 | Allow SSH |
| FIREWALL_2 | Allow RDP |
| FIREWALL_3 | Allow ICMP |

---

## VM Instances

| VM | Purpose |
|---|---|
| us-test-01 | Connectivity Testing |
| us-test-02 | Connectivity Testing |

---

# Manual Testing Commands

## SSH into us-test-01

Use the Compute Engine SSH button.

---

# Ping Internal IP

```bash
ping -c 3 INTERNAL_IP
```

---

# Internal DNS Ping

```bash
ping -c 3 us-test-02.ZONE
```

Example:

```bash
ping -c 3 us-test-02.europe-west1-b
```

---

# Internal DNS Format

```text
hostName.[ZONE].c.[PROJECT_ID].internal
```

Example:

```text
us-test-02.europe-west1-b.c.my-project.internal
```

---

# Notes

- Use temporary Skills Boost credentials only
- Cloud Shell is pre-authenticated
- Firewall rules are required for connectivity
- Regional dynamic routing is enabled
- IPv4 only networking is used

---

# Expected Outcome

After completing the lab, you should be able to:

- Create a custom VPC
- Configure subnetworks
- Configure firewall rules
- Launch VM instances
- Test VM-to-VM communication
- Verify internal DNS connectivity