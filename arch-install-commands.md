# check efivars

ls /sys/firmware/efi/efivars    


# connect to wifi / ethernet

nmcli dev wifi connect


# make disk partitions

fdisk -l

fdisk <disk-to-be-partitioned> 

	# create 3 new partitions 

	g # to create new GPT partition table

	n 
	1
	<press-any-key>
	+550M  # efi partition

	n
	2
	<press-any-key>
	+<value 1-8>G # swap partition, select custom value in GB

	n
	3
	<press-any-key>
	<press-any-key> # root partition 
	
	#will give the rest of the space of the disk to 
	the last partition, could select custom value if not

	# select partition types

	t
	1 # efi partition
	1 # EFI system type

	t 
	2 # swap partition
	19 # swap partition type

	w # to write changes


# Format partitions

mkfs.ext4 /dev/<root-partition>
	- if we are going to make an ecnrypted partition do this instead
	
	cryptsetup -y -v luksFormat /dev/<root-partition>

	cryptsetup open /dev/<root-partition> cryptroot 

	mkfs.ext4 /dev/mapper/cryptroot

mkfs.fat -F 32 /dev/<efi-partition>


# Swap partition

mkswap /dev/<swap-partition>

swapon /dev/<swap-partition>


# Mount the file system

mount /dev/<root-partition> /mnt

mkdir -p /mnt/boot/efi

mount /dev/<efi-partition> /mnt/boot


# Install linux kernel

pacstrap /mnt base linux linux-firmware


# Create fstab

genfstab -U /mnt >> /mnt/etc/fstab
	# check results in /mnt/etc/fstab and edit file in case of errors


# Continue configuration

arch-chroot /mnt

ln -sf /usr/share/zoneinfo/Region/City /etc/localtime

hwclock --systohc

pacman -S neovim

nvim /etc/locale.gen   #uncomment the locale you use, in my case en_US.UTF-8 UTF-8

locale-gen

nvim /etc/locale.conf
	# add this, with your exact locale, in my case "en_US.UTF-8"
	LANG=en_US.UTF-8 


# Network configuration

nvim /etc/hostname
	# just add a word to set the hostname

nvim /etc/hosts
	#add this

	127.0.0.1	localhost
	::1			localhost
	127.0.1.1	<hostname>.localhost	<hostname>


# Set up passwords and user

passwd   # password for root user

useradd -m <new-username>

passwd <username>

usermod -aG wheel,audio,video,optical,storage <username>


# Install and configure sudo permissions

pacman -S sudo

EDITOR=nvim visudo
	# uncomment this line: %wheel ALL=(ALL) ALL

loadkeys es # if you use spanish keyboard

nvim /etc/vconsole.conf
	#add
	KEYMAP=es  # just write your keyboard language


# Install and configure grub

pacman -S grub efibootmgr dosfstools os-prober mtools networkmanager wpa_supplicant base-devel

	- if we made encrypted root partition do this: 
		nvim /etc/mkinitcpio.conf (and edit that)
			HOOKS=(base udev autodetect keyboard keymap modconf block encrypt filesystems fsck)

		mkinitcpio -p linux

grub-install --target=x86_64-efi --efi-directory=<efi-directory-path> --bootloader-id=grub_uefi --recheck
	#in this case our --efi-directory=/boot/efi

	# if we are installing arch linux in a pendrive we add the --removable flag before recheck

grub-mkconfig -o /boot/grub/grub.cfg

	- if we made encrypted root partition do this:
	
	blkid or lsblk -f   (to view UUID of the partition)

	nvim /etc/default/grub (and edit that)
		GRUB_CMDLINE_LINUX="cryptdevice=UUID=<uuid>:cryptroot root=/dev/mapper/cryptroot"  (in that case cryptroot is the name that i put)

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable wpa_supplicant.service

timedatectl set-ntp true


# Finish installation

exit

umount -R /mnt // umount -l /mnt

shutdown now
