# Custom Network and Apply Firewall Rules

This lab automates the creation of:

- Custom VPC Network
- Subnets
- Firewall Rules

---

# What This Lab Teaches

- Creating custom VPC networks
- Creating subnetworks
- Understanding regions and zones
- Creating firewall rules
- Applying network tags

---

# Files

| File | Purpose |
|---|---|
| CustomNetwork.sh | Automates the lab setup |

---

# Usage

## Step 1 — Clone Repository

```bash
git clone https://github.com/Semi-Coder-09/GoogleCloudSkillsboost.git
```

---

## Step 2 — Navigate to Folder

```bash
cd "GoogleCloudSkillsboost/Custom-Network-and-Apply-Firewall-Rules"
```

---

## Step 3 — Make Script Executable

```bash
chmod +x CustomNetwork.sh
```

---

## Step 4 — Run Script

```bash
./CustomNetwork.sh
```

---

# Example Input

```text
Enter REGION_1: us-central1
Enter REGION_2: europe-west1
Enter REGION_3: asia-east1
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

# Firewall Purpose

| Rule | Purpose |
|---|---|
| HTTP | Allow web traffic |
| ICMP | Allow ping |
| Internal | Allow internal VM communication |
| SSH | Allow Linux remote login |
| RDP | Allow Windows remote desktop |

---

# Notes

- Use only temporary Skills Boost credentials
- Cloud Shell is already authenticated
- Project ID is automatically detected
- Regions should match lab requirements
