#!/bin/bash

##################################################################  
#                                                                #                                      
# Nome: lifearch.sh                                              #
#                                                                #
# Descrição: Este script vai fazer a instalação do sistema arch  #
#  			  linux e vai ter um menu para escolher o tipo da in-#
#             -terface grafica ao seu desejo.                    #
#                                                                #
# Criador: welinton da silva (welitonsant1@gmail.com)            #
#                                                                #                                                                 
# Data: DD/MM/AAAA                                               #
#                                                                #
# Uso: sh lifearch.sh                                            #
#                                                                #
##################################################################

# Cores

ver="\033[0;31m"
ve="\033[0;32m"
az="\033[0;34m"
cy="\033[0;36m"
am="\033[1;33m"
b="\033[1;37m"

echo "${cy}
	################
	##### MENU #####
	################
"
echo "${ve}
(1) - Instalação do Sistema Arch
(2) - Instalação da interface grafica"
echo "${ver}(3) - Sair"
read -p "=>" numero

if [ "$numero" = "1" ]; then
	clear
	sleep 3

	echo "${cy}
	##############################
	##### INSTALAÇÃO DO ARCH #####
	##############################
	"
	echo "${ve}
	(1) - Instalação Do Arch em modo hd"
	echo "${ver}(2) - Voltar"
	read -p "=>" a
fi

if [ "$numero" = "2" ]; then 
	clear
	sleep 3

echo "${az}
	###############################
	##### INTERFACES GRAFICAS #####
	###############################
	"
	echo "${ve}
	(1) - Gnome
	(2) - Kde
	(3) - Cinnamon
	(4) - Mate
	(5) - Xfce
	(6) - Pantheon
	(7) - Deepin"
	echo "${ver} Voltar"
	read -p "=>" b
fi

if [ "$numero" = "3" ]; then
	sleep 2
	exit
fi


if [ "$a" = "1" ]; then 
	clear 
	sleep 3
# configura o teclado
loadkeys br-abnt2
	# habilitar o dhcpd
	systemctl start dhcpcd
	# Diretorio das liguas do arch
	cd /etc/
	echo "pt_BR.UTF-8 UTF-8" >> locale.gen
	locale-gen && export LANG=pt_BR.UTF-8
	cd ..
	cfdisk /dev/sda

	# formata as particoes
	mkfs.ext4 /dev/sda1
	mkswap /dev/sda2
	swapon /dev/sda2
	mkfs.ext4 /dev/sda3

	# monta as particoes
	mount /dev/sda1 /mnt
	mkdir /mnt/home
	mount /dev/sda3 /mnt/home

	# ferramentas basicas de instalaçao 
	pacstrap -i /mnt base base-devel
	# sstab e para manter as configuracoes das particoes
	genfstab -U -p /mnt >> /mnt/etc/fstab
	# monta o sistema
	arch-chroot /mnt /bin/bash
	cd /etc
	echo "pt_BR.UTF-8 UTF-8" >> locale.gen
	cd ..
	locale-gen
	echo LANG=pt_BR.UTF-8 > /etc/locale
	echo LANG=pt_BR.UTF-8 > /etc/locale.conf
	export LANG=pt_BR.UTF-8
	rm /etc/localtime
	ln -s /usr/share/zoneinfo/America/Maceio /etc/localtime
	hwclock --systohc --utc
	echo life > /etc/hostname
	pacman -S wireless_tools wpa_supplicant wpa_actiond dialog
	mkinitcpio -p linux
	passwd
	# atualizar o sistema
	pacman -Syu
	# instalar o Grub
	pacman -S grub
	grub-install /dev/sda
	grub-mkconfig -o /boot/grub/grub.cfg
	pacman -S os-prober
	echo "o  usuario criado e joao"
	sleep 4
	useradd -m -g users -s /bin/bash joao
	echo "cria uma senha para joao"
	passwd joao

	#grupos
	gpasswd -a joao audio
	gpasswd -a joao users
	gpasswd -a joao video
	gpasswd -a joao deame
	gpasswd -a joao dbus
	gpasswd -a joao disk
	gpasswd -a joao games
	gpasswd -a joao lp
	gpasswd -a joao network 
	gpasswd -a joao rfkill 
	gpasswd -a joao optical
	gpasswd -a joao power
	gpasswd -a joao scanner
	gpasswd -a joao storage
pacman -Sy yaourt
umount -R /mnt && reboot
fi
