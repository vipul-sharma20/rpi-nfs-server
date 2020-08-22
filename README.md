# rpi-nfs-server

Shell script to setup NFS server on raspberry pi with a USB Hard Disk.

## Usage

### Setting up the NFS server on a Raspberry Pi (Raspbian only)

Run the `setup.sh` script as below:

```bash
sudo bash setup.sh
```

The script will guide you through the steps.

### To mount the NFS in the client use the commands below:

Create a directory to mount an nfs share:

```bash
sudo mkdir /private/nfs
```

Mount an NFS file system

```bash
sudo mount -o rw -t nfs -o resvport,rw <rpi-ip-on-lan-here>:/srv/nfs/ /private/nfs
```

## License

MIT
