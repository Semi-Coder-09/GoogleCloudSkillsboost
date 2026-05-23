# Test Network Latency Between VMs

This lab creates VM instances across multiple regions to test:

- Network connectivity
- Latency
- Traceroute
- Network throughput using iperf

---

# What This Lab Teaches

- VM instance creation
- Cross-region networking
- Internal DNS
- Ping and ICMP
- Traceroute
- Network throughput testing

---

# Files

| File | Purpose |
|---|---|
| TestNetworkLatencyVMs.sh | Automates VM creation |

---

# Usage

## Step 1 — Clone Repository

```bash
git clone https://github.com/Semi-Coder-09/GoogleCloudSkillsboost.git
```

---

## Step 2 — Navigate to Folder

```bash
cd "GoogleCloudSkillsboost/Test-Network-Latency-Between-VMs"
```

---

## Step 3 — Make Script Executable

```bash
chmod +x TestNetworkLatencyVMs.sh
```

---

## Step 4 — Run Script

```bash
./TestNetworkLatencyVMs.sh
```

---

# Example Input

```text
Enter REGION_1: us-central1
Enter REGION_2: europe-west1
Enter REGION_3: asia-east1

Enter ZONE_1: us-central1-a
Enter ZONE_2: europe-west1-b
Enter ZONE_3: asia-east1-a
```

---

# Resources Created

## VM Instances

| VM | Purpose |
|---|---|
| us-test-01 | Testing VM |
| us-test-02 | Testing VM |
| us-test-03 | Testing VM |
| us-test-04 | Performance Testing VM |

---

# Manual Testing Commands

## Ping Test

SSH into us-test-01:

```bash
ping -c 3 EXTERNAL_IP
```

Example:

```bash
ping -c 3 34.120.10.20
```

---

# Install Tools

Run on VMs:

```bash
sudo apt-get update

sudo apt-get -y install traceroute mtr tcpdump iperf whois host dnsutils siege
```

---

# Traceroute

```bash
traceroute www.icann.org
```

---

# Internal VM Ping

```bash
ping -c 3 us-test-02.ZONE
```

Example:

```bash
ping -c 3 us-test-02.europe-west1-b
```

---

# iperf Server

Run on us-test-01:

```bash
iperf -s
```

---

# iperf Client

Run on us-test-02:

```bash
iperf -c us-test-01.ZONE
```

Example:

```bash
iperf -c us-test-01.us-central1-a
```

---

# Parallel iperf Streams

```bash
iperf -c us-test-01.ZONE -P 20
```

---

# UDP Bandwidth Test

Server:

```bash
iperf -s -u
```

Client:

```bash
iperf -c us-test-01.ZONE -u -b 2G
```

---

# Internal DNS Example

```text
hostName.[ZONE].c.[PROJECT_ID].internal
```

Example:

```text
us-test-02.us-central1-a.c.my-project.internal
```

---

# Notes

- Use only temporary Skills Boost credentials
- Cloud Shell is already authenticated
- Firewall rules must already exist
- VPC network must already exist before running this lab
- Latency depends on geographical distance between regions
- Internal DNS is automatically configured by Compute Engine

---

# Expected Outcome

After completing the lab, you should be able to:

- Verify VM connectivity
- Measure latency using ping
- Trace routes using traceroute
- Test bandwidth using iperf
- Understand Google Cloud internal networking
