# Rook-Ceph on Minikube

## Prerequisites

Because the M1 Mac is ARM-based, it is not possible to attach /dev/sd* devices or /dev/vd* devices. In this situation, we would normally default to the use of /dev/loop devices, but Ceph does not permit the use of /dev/loop devices. Instead, we will use the network block device /dev/nbd0.

### Starting Minikube

```bash
minikube start --memory 8192 --cpus no-limit --nodes 3 --disk-size=20g
```

### NBD Device Setup

```bash
minikube ssh
sudo mkdir /mnt/disks

# Create an empty file of size 10GB to mount disk as ceph osd

sudo dd if=/dev/zero of=/mnt/disks/mydisk.img bs=1M count=10240
sudo apt update
sudo apt upgrade
sudo apt-get install qemu-utils

# List the nbd devices

lsblk | grep nbd

# If you are unable to see the nbd device, load the NBD (Network Block Device)
kernel module.

sudo modprobe nbd max_part=8

# To bind nbd device to the file
# Note: Please check there is no necessary data in /dev/nbdx, otherwise back up that data.

sudo qemu-nbd --format raw -c /dev/nbd0 /mnt/disks/mydisk.img

# Verify the size of the nbd device by using lsblk
lsblk | grep nbd0
```

## Install Rook-Ceph

```bash
ansible-playbook mini.install.yaml -v --tags rook-ceph
```
