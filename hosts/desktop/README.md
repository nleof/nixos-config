## Desktop

Personal desktop

``` shell
lsblk

parted /dev/nvme0n1 -- mklabel gpt
parted /dev/nvme0n1 -- mkpart ESP fat32 1MiB 512MiB
parted /dev/nvme0n1 -- set 1 boot on

parted /dev/nvme0n1 -- mkpart primary 512MiB 100%
cryptsetup luksFormat /dev/nvme0n1p2
cryptsetup luksOpen /dev/nvme0n1p2 crypted

pvcreate /dev/mapper/crypted
vgcreate vg /dev/mapper/crypted
lvcreate -L 8G -n swap vg
lvcreate -l '100%FREE' -n nixos vg

mkfs.fat -F 32 -n boot /dev/nvme0n1p1
mkfs.ext4 -L nixos /dev/vg/nixos
mkswap -L swap /dev/vg/swap

mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
swapon /dev/vg/swap

nixos-rebuild switch --flake .#desktop
```
