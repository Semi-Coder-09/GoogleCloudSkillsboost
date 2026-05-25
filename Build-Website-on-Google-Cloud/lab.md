# Google Cloud Lab — Monolith to Microservices

## Task 1 — Download the monolith code and build your container

### 1. Open Cloud Shell

Open **Cloud Shell** in your Google Cloud lab.

### 2. Clone the repository

```bash
git clone https://github.com/googlecodelabs/monolith-to-microservices.git
```

### 3. Enter the project directory

```bash
cd monolith-to-microservices
```

### 4. Run setup script

```bash
./setup.sh
```

If permission is denied:

```bash
chmod +x setup.sh
./setup.sh
```

### 5. Update Node.js

```bash
nvm install --lts
```

### 6. Move to monolith folder

```bash
cd monolith
```

### 7. Build and push the monolith container

```bash
gcloud builds submit --tag gcr.io/$GOOGLE_CLOUD_PROJECT/fancy-monolith-159:1.0.0
```

Expected image:

* Repo: `gcr.io/$GOOGLE_CLOUD_PROJECT`
* Image: `fancy-monolith-159`
* Version: `1.0.0`

### 8. Verify image

```bash
gcloud container images list-tags gcr.io/$GOOGLE_CLOUD_PROJECT/fancy-monolith-159
```

You should see tag `1.0.0`.

---

# Task 2 — Create a Kubernetes cluster and deploy the application

## 1. Create GKE cluster

```bash
gcloud container clusters create fancy-production-458 \
    --zone=us-central1-a \
    --num-nodes=3
```

## 2. Get cluster credentials

```bash
gcloud container clusters get-credentials fancy-production-458 \
    --zone=us-central1-a
```

## 3. Deploy monolith container

```bash
kubectl create deployment fancy-monolith-159 \
    --image=gcr.io/$GOOGLE_CLOUD_PROJECT/fancy-monolith-159:1.0.0
```

## 4. Expose the deployment

```bash
kubectl expose deployment fancy-monolith-159 \
    --type=LoadBalancer \
    --port=80 \
    --target-port=8080
```

## 5. Check services

```bash
kubectl get services
```

Wait until `EXTERNAL-IP` appears.

## 6. Open app in browser

```text
http://EXTERNAL-IP
```

## 7. Verify deployment

```bash
kubectl get deployments
kubectl get pods
kubectl get services
```

---

# Task 3 — Create new microservices

## Orders Microservice

### Go to orders folder

```bash
cd ~/monolith-to-microservices/microservices/src/orders
```

### Build and push orders image

```bash
gcloud builds submit --tag gcr.io/$GOOGLE_CLOUD_PROJECT/fancy-orders-982:1.0.0
```

---

## Products Microservice

### Go to products folder

```bash
cd ~/monolith-to-microservices/microservices/src/products
```

### Build and push products image

```bash
gcloud builds submit --tag gcr.io/$GOOGLE_CLOUD_PROJECT/fancy-products-304:1.0.0
```

---

## Deploy Orders microservice

```bash
kubectl create deployment fancy-orders-982 \
    --image=gcr.io/$GOOGLE_CLOUD_PROJECT/fancy-orders-982:1.0.0
```

### Expose Orders service

```bash
kubectl expose deployment fancy-orders-982 \
    --type=LoadBalancer \
    --port=80 \
    --target-port=8081
```

---

## Deploy Products microservice

```bash
kubectl create deployment fancy-products-304 \
    --image=gcr.io/$GOOGLE_CLOUD_PROJECT/fancy-products-304:1.0.0
```

### Expose Products service

```bash
kubectl expose deployment fancy-products-304 \
    --type=LoadBalancer \
    --port=80 \
    --target-port=8082
```

---

## Verify deployments and services

```bash
kubectl get deployments
kubectl get services
```

---

# Task 4 — Deploy the new microservices

## Deploy Orders service

```bash
kubectl create deployment fancy-orders-982 \
  --image=gcr.io/$GOOGLE_CLOUD_PROJECT/fancy-orders-982:1.0.0
```

### Expose Orders service

```bash
kubectl expose deployment fancy-orders-982 \
  --type=LoadBalancer \
  --port=80 \
  --target-port=8081
```

---

## Deploy Products service

```bash
kubectl create deployment fancy-products-304 \
  --image=gcr.io/$GOOGLE_CLOUD_PROJECT/fancy-products-304:1.0.0
```

### Expose Products service

```bash
kubectl expose deployment fancy-products-304 \
  --type=LoadBalancer \
  --port=80 \
  --target-port=8082
```

---

## Get external IPs

```bash
kubectl get services
```

---

## Test services

### Orders

```text
http://ORDERS_EXTERNAL_IP/api/orders
```

### Products

```text
http://PRODUCTS_EXTERNAL_IP/api/products
```

---

## Final verification

```bash
kubectl get deployments
kubectl get services
```

---

# Task 5 — Configure and deploy the Frontend microservice

## Go to React app folder

```bash
cd ~/monolith-to-microservices/react-app
```

## Open .env file

```bash
nano .env
```

Replace content with:

```env
REACT_APP_ORDERS_URL=http://ORDERS_EXTERNAL_IP/api/orders
REACT_APP_PRODUCTS_URL=http://PRODUCTS_EXTERNAL_IP/api/products
```

Example:

```env
REACT_APP_ORDERS_URL=http://34.122.124.18/api/orders
REACT_APP_PRODUCTS_URL=http://136.116.182.129/api/products
```

Save:

* CTRL + O
* ENTER
* CTRL + X

---

## Rebuild frontend app

```bash
npm run build
```

---

# Task 6 — Create a containerized version of the Frontend microservice

## Go to frontend microservice folder

```bash
cd ~/monolith-to-microservices/microservices/src/frontend
```

## Build and push frontend image

```bash
gcloud builds submit --tag gcr.io/$GOOGLE_CLOUD_PROJECT/fancy-frontend-898:1.0.0
```

## Verify frontend image

```bash
gcloud container images list-tags gcr.io/$GOOGLE_CLOUD_PROJECT/fancy-frontend-898
```

---

# Task 7 — Deploy the Frontend microservice

## Deploy frontend

```bash
kubectl create deployment fancy-frontend-898 \
  --image=gcr.io/$GOOGLE_CLOUD_PROJECT/fancy-frontend-898:1.0.0
```

## Expose frontend service

```bash
kubectl expose deployment fancy-frontend-898 \
  --type=LoadBalancer \
  --port=80 \
  --target-port=8080
```

## Get frontend external IP

```bash
kubectl get services
```

Wait until `EXTERNAL-IP` appears.

## Open frontend in browser

```text
http://FRONTEND_EXTERNAL_IP
```

You should see:

* Fancy Store homepage
* Products page working
* Orders page working

## Final verification

```bash
kubectl get deployments
kubectl get services
```
