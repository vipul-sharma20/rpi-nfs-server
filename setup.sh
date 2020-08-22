apt install -y nfs-kernel-server rpcbind nfs-common

# Get available mounts
sdas=$(fdisk -l | grep "/dev/sda[0-9]")

readarray -t sda_list <<<"$sdas"

echo -e "\nWhich mount do you want to use as NFS? "

# List down available mounts
count=1
for sda in "${sda_list[@]}"
do
    echo "$count) $sda";
    ((++count))
done

# Get user choice
length=${#sda_list[@]}
while true; do
    echo -e "\nEnter the id from above available choices"
    read next
    if [[ $next -gt 0 && $next -le $length ]]; then
        break
    else
next=0
        echo 'Please enter a valid id'
    fi
done
sda=$sda_list[$(( next-1 ))] | cut -d' ' -f1

# Get mount's uuid
sda_uuid=$(blkid $sda | cut -d' ' -f3 | cut -d'=' -f2)

sudo mkdir -p /srv/nfs

echo 'UUID=$sda_uuid    /srv/nfs    auto    nosuid,nodev,nofail,noatime 0 0' >> /etc/fstab

systemctl enable rpcbind.service
systemctl enable nfs-server.service
systemctl start rpcbind.service
systemctl start nfs-server.service

echo -e "\nDone!"
