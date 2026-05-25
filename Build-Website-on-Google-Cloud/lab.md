# Build Website on Google Cloud Challenge Lab

This lab demonstrates how to:

- Build containers using Cloud Build
- Push images to Artifact Registry
- Create a GKE cluster
- Deploy monolith application
- Break monolith into microservices
- Deploy Orders, Products, and Frontend services

---

# Files

| File | Purpose |
|---|---|
| `Build-Website-on-Google-Cloud.sh` | Automates the entire challenge lab |
| `lab.md` | Complete usage instructions |

---

# Usage

## Step 1 — Clone Repository

```bash
git clone https://github.com/Semi-Coder-09/GoogleCloudSkillsboost.git
```

---

## Step 2 — Navigate To Folder

```bash
cd "GoogleCloudSkillsboost/Build-Website-on-Google-Cloud"
```

---

## Step 3 — Make Script Executable

```bash
chmod +x Build-Website-on-Google-Cloud.sh
```

---

## Step 4 — Run Script

```bash
./Build-Website-on-Google-Cloud.sh
```

---

# Required Inputs

The script will ask:

```text
Enter your Zone :
Enter Monolith Identifier :
Enter Cluster name :
Enter Orders Service Identifier :
Enter Products Service Identifier :
Enter Frontend identifier :
```

---

# Example Inputs

```text
Enter your Zone : us-central1-a

Enter Monolith Identifier : monolith

Enter Cluster name : fancy-cluster

Enter Orders Service Identifier : orders

Enter Products Service Identifier : products

Enter Frontend identifier : frontend
```

---

# What The Script Does

The script automatically:

- Clones monolith repository
- Runs setup.sh
- Installs latest NodeJS LTS
- Enables required Google APIs
- Builds Monolith container
- Creates GKE cluster
- Deploys Monolith application
- Builds Orders microservice
- Builds Products microservice
- Deploys Orders service
- Deploys Products service
- Configures Frontend environment
- Builds Frontend container
- Deploys Frontend service
- Prints frontend URL and APIs

---

# Services & Ports

| Service | Internal Port | External Port |
|---|---|---|
| Monolith | 8080 | 80 |
| Orders | 8081 | 80 |
| Products | 8082 | 80 |
| Frontend | 8080 | 80 |

---

# Verify Deployments

## Orders Service

```text
http://ORDERS_EXTERNAL_IP/api/orders
```

Should return JSON response.

---

## Products Service

```text
http://PRODUCTS_EXTERNAL_IP/api/products
```

Should return JSON response.

---

## Frontend Service

Open frontend external IP in browser.

You should see:

```text
Fancy Store Homepage
```

---

# Common Errors

## Cluster Already Exists

If you see:

```text
Already exists
```

Delete cluster manually:

```bash
gcloud container clusters delete CLUSTER_NAME --zone=ZONE
```

---

## Docker Build Failed

Retry manually:

```bash
gcloud builds submit --tag IMAGE_NAME
```

---

## External IP Pending

Wait few minutes:

```bash
kubectl get svc
```

until external IP appears.

---

## NodeJS Not Found

Run:

```bash
nvm install --lts
```

again.

---

# Notes

- Cloud Shell is pre-authenticated
- Uses e2-medium machine type
- Uses 3-node GKE cluster
- Uses Google Cloud Build
- Uses Kubernetes LoadBalancer services

---

# Final Step

Click:

```text
Check My Progress
```

All tasks should pass successfully.