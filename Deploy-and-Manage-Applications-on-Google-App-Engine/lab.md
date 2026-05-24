# Deploy and Manage Applications on Google App Engine

This lab demonstrates how to:

- Enable App Engine Admin API
- Download a sample web application
- Deploy an application to App Engine
- Update application code
- Redeploy updated application

---

# Files

| File | Purpose |
|---|---|
| `Deployment-&-Manage-Applications-on-GoogleAppEngine.sh` | Automates App Engine setup and deployment |
| `lab.md` | Complete lab instructions |

---

# What This Lab Teaches

- Using Google App Engine
- Deploying applications
- Managing App Engine services
- Updating deployed applications
- Working with Python / PHP / Go applications

---

# Usage

## Step 1 — Clone Repository

```bash
git clone https://github.com/Semi-Coder-09/GoogleCloudSkillsboost.git
```

---

## Step 2 — Navigate To Folder

```bash
cd "GoogleCloudSkillsboost/Deploy-and-Manage-Applications-on-Google-App-Engine"
```

---

## Step 3 — Make Script Executable

```bash
chmod +x Deployment-\&-Manage-Applications-on-GoogleAppEngine.sh
```

---

## Step 4 — Run Script

```bash
./Deployment-\&-Manage-Applications-on-GoogleAppEngine.sh
```

---

# Example Inputs

For this specific Skills Boost lab use:

```text
ENTER LANGUAGE (python/php/go): python

ENTER REGION: us-west1

ENTER UPDATED_MESSAGE: Hello, Cruel World!
```

---

# What The Script Does

The script automatically:

- Enables App Engine Admin API
- Downloads sample repository
- Navigates to Hello World app
- Creates App Engine Application
- Deploys application
- Opens deployed application
- Updates Hello World message
- Redeploys updated application

---

# Supported Languages

| Language | Repository |
|---|---|
| Python | python-docs-samples |
| PHP | php-docs-samples |
| Go | golang-samples |

---

# Important Note

Run all commands inside **Cloud Shell**.

Do NOT run commands inside:

```text
lab-setup VM
```

If your terminal shows:

```text
@student-xx@lab-setup
```

Exit from VM:

```bash
exit
```

Correct Cloud Shell prompt looks like:

```text
student_xxx@cloudshell:~$
```

---

# Manual Verification

After deployment finishes:

Run:

```bash
gcloud app browse
```

You should see the deployed application in your browser.

---

# Verify Updated Message

After redeployment:

Refresh browser page.

You should now see:

```text
Hello, Cruel World!
```

or your custom updated message.

---

# Redeployment Guide

If deployment is already running or stuck:

Press:

```text
CTRL + C
```

to stop the current deployment process.

Then redeploy again:

```bash
gcloud app deploy
```

When prompted:

```text
Do you want to continue (Y/n)?
```

Type:

```text
Y
```

After deployment completes:

```bash
gcloud app browse
```

---

# Common Errors

## App Engine Already Exists

If you see:

```text
ERROR: App Engine application already exists
```

It is safe to continue.

---

## Permission Denied Error

If you see:

```text
PERMISSION_DENIED
```

You are probably inside the VM instance.

Exit VM:

```bash
exit
```

Then rerun commands in Cloud Shell.

---

## gcloud Failed To Load

If you see:

```text
DuplicateSectionError
```

Fix it using:

```bash
sudo mv /usr/lib/google-cloud-sdk/properties /usr/lib/google-cloud-sdk/properties.broken
```

Then create clean config:

```bash
sudo tee /usr/lib/google-cloud-sdk/properties > /dev/null <<EOF
[core]
disable_usage_reporting = true
EOF
```

Verify:

```bash
gcloud version
```

---

## Invalid Region

Use valid regions like:

```text
us-west1
us-central1
us-east1
europe-west1
asia-south1
```

For this lab use:

```text
us-west1
```

---

## Deployment Failed

Retry deployment manually:

```bash
gcloud app deploy
```

---

# Expected Outcome

After completing the lab:

- App Engine Admin API is enabled
- Hello World application is downloaded
- Application is deployed successfully
- Application message is updated
- Updated version is redeployed successfully

---

# Notes

- Cloud Shell is pre-authenticated
- App Engine Standard Environment is used
- Temporary Skills Boost credentials are recommended
- Internet access is required for downloading repositories

---

# Final Step

Click:

```text
Check My Progress
```

All tasks should now pass successfully.