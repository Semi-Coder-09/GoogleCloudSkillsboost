#!/bin/bash

echo "=================================================="
echo "Cloud Scheduler Qwik Start Lab"
echo "=================================================="

echo ""
echo "Enter Required Details"
echo ""

read -p "ENTER REGION: " REGION
read -p "ENTER TOPIC_NAME: " TOPIC_NAME
read -p "ENTER SUBSCRIPTION_NAME: " SUBSCRIPTION_NAME
read -p "ENTER JOB_NAME: " JOB_NAME
read -p "ENTER TIMEZONE: " TIMEZONE

echo ""
echo "=================================================="
echo "Configuration Summary"
echo "=================================================="

echo "REGION              : $REGION"
echo "TOPIC NAME          : $TOPIC_NAME"
echo "SUBSCRIPTION NAME   : $SUBSCRIPTION_NAME"
echo "JOB NAME            : $JOB_NAME"
echo "TIMEZONE            : $TIMEZONE"

echo ""
read -p "Proceed with setup? (y/n): " CONFIRM

if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
    echo ""
    echo "Setup Cancelled."
    exit 1
fi

echo ""
echo "=================================================="
echo "Setting Compute Region"
echo "=================================================="

gcloud config set compute/region $REGION

echo ""
echo "=================================================="
echo "Enabling Cloud Scheduler API"
echo "=================================================="

gcloud services enable cloudscheduler.googleapis.com

echo ""
echo "=================================================="
echo "Creating Pub/Sub Topic"
echo "=================================================="

gcloud pubsub topics create $TOPIC_NAME

echo ""
echo "=================================================="
echo "Creating Pub/Sub Subscription"
echo "=================================================="

gcloud pubsub subscriptions create $SUBSCRIPTION_NAME \
    --topic=$TOPIC_NAME

echo ""
echo "=================================================="
echo "Creating Cloud Scheduler Job"
echo "=================================================="

gcloud scheduler jobs create pubsub $JOB_NAME \
    --schedule="* * * * *" \
    --topic=$TOPIC_NAME \
    --message-body="hello cron!" \
    --time-zone=$TIMEZONE \
    --location=$REGION

echo ""
echo "=================================================="
echo "Waiting For Scheduler Execution"
echo "=================================================="

sleep 90

echo ""
echo "=================================================="
echo "Pulling Messages From Subscription"
echo "=================================================="

gcloud pubsub subscriptions pull $SUBSCRIPTION_NAME \
    --limit=5 \
    --auto-ack

echo ""
echo "=================================================="
echo "Lab Completed Successfully!"
echo "=================================================="

echo ""
echo "Question Answer:"
echo ""
echo "You can trigger an App Engine app, send a message"
echo "via Cloud Pub/Sub, or hit an arbitrary HTTP endpoint"
echo "with Cloud Scheduler."
echo ""
echo "Correct Answer: TRUE"

echo ""
echo "Now click: Check my progress"