#!/bin/bash

# Make an XFS file system on each of the attached block devices and label them
mkfs.xfs -f /dev/sdb -L DISK1
mkfs.xfs -f /dev/sdc -L DISK2

# Create mount-points for the block devices
mkdir /mnt/disk1
mkdir /mnt/disk2

# Mount the block devices
mount /dev/sdb /mnt/disk1
mount /dev/sdc /mnt/disk2

# Edit the file system configuration so that the drives are mounted correctly upon VM restart
echo "LABEL=DISK1      /mnt/disk1     xfs     defaults,noatime  0       2" >> /etc/fstab
echo "LABEL=DISK2      /mnt/disk2     xfs     defaults,noatime  0       2" >> /etc/fstab

# Edit the domain name resolver to accommodate MinIO expansion notation
echo "external-ip-1 minio1" >> /etc/hosts
echo "external-ip-2 minio2" >> /etc/hosts

# Download and prepare MinIO binary
wget https://dl.min.io/server/minio/release/linux-amd64/archive/minio_20230707071357.0.0_amd64.deb -O minio.deb
sudo dpkg -i minio.deb

# Run MinIO
minio server --console-address ":9090" "http://minio{1...2}/mnt/disk{1...2}/minio"
