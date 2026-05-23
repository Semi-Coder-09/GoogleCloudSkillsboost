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
Enter REGION_1: us-east1
Enter REGION_2: us-east4
Enter REGION_3: europe-west1

Enter ZONE_1: us-east1-c
Enter ZONE_2: us-east4-c
Enter ZONE_3: europe-west1-b
```

---

# Resources Created

## VM Instances

| VM | Purpose |
|---|---|
| us-test-01 | Main Testing VM |
| us-test-02 | Cross-Region Testing VM |
| us-test-03 | Europe Testing VM |
| us-test-04 | Same-Region Performance Testing VM |

---

# Manual Testing Commands

## Ping External IP

SSH into us-test-01:

```bash
ping -c 3 EXTERNAL_IP
```

---

# Install Networking Tools

Run on us-test-02 and us-test-04:

```bash
sudo apt-get update

sudo apt-get -y install traceroute mtr tcpdump iperf whois host dnsutils siege
```

---

# Traceroute Test

```bash
traceroute www.icann.org
```

---

# Internal VM Ping

```bash
ping -c 3 us-test-02.us-east4-c
```

---

# TCP iperf Test

## On us-test-01

```bash
iperf -s
```

## On us-test-02

```bash
iperf -c us-test-01.us-east1-c
```

---

# UDP iperf Test

## On us-test-02

```bash
iperf -s -u
```

## On us-test-01

```bash
iperf -c us-test-02.us-east4-c -u -b 2G
```

---

# Parallel TCP Streams Test

## On us-test-01

```bash
iperf -s
```

## On us-test-02

```bash
iperf -c us-test-01.us-east1-c -P 20
```

---

# Internal DNS Example

```text
hostName.[ZONE].c.[PROJECT_ID].internal
```

Example:

```text
us-test-02.us-east4-c.c.my-project.internal
```

---

# Notes

- Use only temporary Skills Boost credentials
- Cloud Shell is already authenticated
- Firewall rules must already exist
- VPC network must already exist before running this lab
- Latency depends on geographical distance between regions
- Internal DNS is automatically configured by Compute Engine
- UDP tests can consume significant bandwidth

---

# Expected Outcome

After completing the lab, you should be able to:

- Verify VM connectivity
- Measure latency using ping
- Trace routes using traceroute
- Test bandwidth using iperf
- Compare TCP vs UDP throughput
- Test parallel TCP streams
- Understand Google Cloud internal networking
