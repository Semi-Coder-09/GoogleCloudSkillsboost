# Cloud Scheduler Qwik Start

This lab demonstrates how to:

- Enable the Cloud Scheduler API
- Create a Pub/Sub topic
- Create a Pub/Sub subscription
- Create a Cloud Scheduler job
- Trigger scheduled Pub/Sub messages
- Verify scheduler execution

---

# What This Lab Teaches

- Cloud Scheduler basics
- Pub/Sub integration
- Cron scheduling
- Automated task execution
- Message verification using Pub/Sub

---

# Files

| File | Purpose |
|---|---|
| CloudScheduler.sh | Automates Cloud Scheduler lab setup |

---

# Usage

## Step 1 — Clone Repository

```bash
git clone https://github.com/Semi-Coder-09/GoogleCloudSkillsboost.git
```

---

## Step 2 — Navigate to Folder

```bash
cd "GoogleCloudSkillsboost/Cloud-Scheduler-Qwik-Start"
```

---

## Step 3 — Make Script Executable

```bash
chmod +x CloudScheduler.sh
```

---

## Step 4 — Run Script

```bash
./CloudScheduler.sh
```

---

# Required Inputs

```text
ENTER REGION:
ENTER TOPIC_NAME:
ENTER SUBSCRIPTION_NAME:
ENTER JOB_NAME:
ENTER TIMEZONE:
```

---

# Example Input

```text
ENTER REGION: us-central1

ENTER TOPIC_NAME: cron-topic

ENTER SUBSCRIPTION_NAME: cron-sub

ENTER JOB_NAME: cron-job

ENTER TIMEZONE: Asia/Kolkata
```

---

# What The Script Does

The script automatically:

- Sets compute region
- Enables Cloud Scheduler API
- Creates Pub/Sub topic
- Creates Pub/Sub subscription
- Creates Cloud Scheduler job
- Waits for execution
- Pulls messages from Pub/Sub

---

# Cloud Scheduler Configuration

| Setting | Value |
|---|---|
| Schedule | `* * * * *` |
| Frequency | Every Minute |
| Message Body | `hello cron!` |

---

# Verify Scheduler Messages

The script automatically runs:

```bash
gcloud pubsub subscriptions pull SUBSCRIPTION_NAME \
--limit=5 \
--auto-ack
```

---

# Expected Output

You should see messages similar to:

```text
DATA: hello cron!
```

---

# Cloud Scheduler Cron Format

```text
* * * * *
```

Meaning:

```text
Every minute
```

---

# Question Answer

## Statement

```text
You can trigger an App Engine app, send a message via Cloud Pub/Sub,
or hit an arbitrary HTTP endpoint running on Compute Engine,
Google Kubernetes Engine, or on-premises with your Cloud Scheduler job.
```

## Correct Answer

```text
TRUE
```

---

# Notes

- Use temporary Skills Boost credentials only
- Cloud Shell is pre-authenticated
- Scheduler jobs may take 1–2 minutes to trigger
- Pub/Sub messages are automatically acknowledged

---

# Expected Outcome

After completing this lab, you should be able to:

- Enable Cloud Scheduler
- Create Pub/Sub topics
- Configure subscriptions
- Create scheduled jobs
- Verify automated execution
- Understand cron scheduling basics