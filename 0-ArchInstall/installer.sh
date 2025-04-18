#!/bin/bash

arch_chroot() {
    arch-chroot /mnt /bin/bash -c "$1"
}

echo "Welcome to my ArchInstaller, might not be the best but is good enough"

# Partitions

echo "Enter the root partition (/dev/sda, for example): "
read root
echo "Enter the root's filesystem (ext4, btrfs, zfs, xfs): "
read root_fs

echo "Enter the boot partition (/dev/sda, for example): "
read boot

echo "Will you use other swap partition? [N/y] "
read maybeSwap

if [[ $maybeSwap == "Y" || $maybeSwap == "y" ]]; then
    echo "Enter the swap partition (/dev/sda, for example): "
    read swap
    echo "Formating swap partition"
    mkswap $swap
    swapon $swap
fi

# TODO: Make it work with creating other partitions

# Formating partitions

echo "Formating root partition"
mkfs.$root_fs $root

echo "Formating boot partition"
mkfs.fat -F 32 $boot

echo "Mounting the partitions"
mount $root /mnt
mount --mkdir $boot /mnt/boot

# Generating mirrorlists

echo "Generating the mirrorlist for Brazil (aí sim)"
cat <<EOF > /etc/pacman.d/mirrorlist
Server = https://geo.mirror.pkgbuild.com/\$repo/os/\$arch
Server = https://ftpmirror.infania.net/mirror/archlinux/\$repo/os/\$arch
Server = https://mirror.rackspace.com/archlinux/\$repo/os/\$arch
Server = https://archlinux.c3sl.ufpr.br/\$repo/os/\$arch
Server = https://www.caco.ic.unicamp.br/archlinux/\$repo/os/\$arch
Server = https://br.mirrors.cicku.me/archlinux/\$repo/os/\$arch
Server = https://mirror.ufscar.br/archlinux/\$repo/os/\$arch
Server = https://mirrors.ic.unicamp.br/archlinux/\$repo/os/\$arch
Server = https://geo.mirror.pkgbuild.com/\$repo/os/\$arch
Server = https://ftpmirror.infania.net/mirror/archlinux/\$repo/os/\$arch
Server = http://mirror.rackspace.com/archlinux/\$repo/os/\$arch
Server = https://mirror.rackspace.com/archlinux/\$repo/os/\$arch
EOF

pacman -Syyu

# TODO: chose which kernel to install

echo "Installing essencial packages"
pacstrap -K /mnt base linux-zen linux-firmware sof-firmware networkmanager vim base-devel grub efibootmgr pulseaudio

# System configs
echo "Generating fstab"
genfstab -U /mnt >> /mnt/etc/fstab

echo "Setting the time for Fortaleza-CE (o pai é do nordeste :D)"
arch_chroot ln -sf /usr/share/zoneinfo/America/Fortaleza /etc/localtime
arch_chroot hwclock --systohc

arch_chroot echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
arch_chroot echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen
arch_chroot locale-gen
arch_chroot echo "LANG=en_US.UTF-8" > /etc/locale.conf
arch_chroot echo "KEYMAP=br-abnt2" > /etc/vconsole.conf

echo "Define a root's password"
arch_chroot passwd

echo "Define the computer's name: "
read hostname
arch_chroot echo $hostname > /etc/hostname

echo "Grub config"
arch_chroot grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
arch_chroot grub-mkconfig -o /boot/grub/grub.cfg

umount -R /mnt

echo "Instalation (almost) complete. Now you can reboot the system :3"
