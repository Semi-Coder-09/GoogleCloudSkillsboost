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

```text
ENTER LANGUAGE (python/php/go): python

ENTER REGION: us-central

ENTER UPDATED_MESSAGE: Welcome To App Engine
```

---

# What The Script Does

The script automatically:

- Enables App Engine Admin API
- Creates App Engine Application
- Downloads sample repository
- Navigates to Hello World app
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

Refresh the browser page.

You should now see:

```text
Welcome To App Engine
```

or your custom updated message.

---

# Common Errors

## App Engine Already Exists

If you see:

```text
ERROR: App Engine application already exists
```

It is safe to continue.

---

## Invalid Region

Use valid regions like:

```text
us-central
us-east1
europe-west
asia-south1
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

---

# Final Step

Click:

```text
Check My Progress
```

All tasks should now pass successfully.