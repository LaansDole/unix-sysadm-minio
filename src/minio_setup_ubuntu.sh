#!/bin/bash

# Step 1: Elevate to Superuser (root) Mode and Navigate to Home Directory
sudo -s
cd ~

# Step 2: Download and Prepare MinIO Server Binary
wget https://dl.min.io/server/minio/release/linux-amd64/minio
chmod +x minio
./minio server /minio

# Step 3: Move MinIO Server Binary to System Bin Directory
mv minio /usr/local/bin

# Step 4: Create a Directory for MinIO Data and Start the Server
mkdir ~/minio
minio server ~/minio --console-address :9090

# Step 5: View the MinIO Storage Structure
tree -h ~/minio

# Step 6: Download and Prepare MinIO Client (`mc`) Binary
wget https://dl.min.io/client/mc/release/linux-amd64/mc
chmod +x mc
mv mc /usr/local/bin/mc

# Step 7: Configure MinIO Client (`mc`) Alias
# Replace the following placeholders with your MinIO server details: server address, access key, and secret key
mc alias set local http://10.0.2.15:9000 minioadmin minioadmin

# Step 8: Retrieve MinIO Server Information
mc admin info local

# Step 9: List Objects in MinIO Storage
mc ls -r local
