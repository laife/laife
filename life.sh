#!/bin/bash

###########################################################################
# Nome: life.sh ###########################################################
###########################################################################
# Criador: welinton da silva (welitonsant1@gmail.com)######################
###########################################################################
# Data: 15/06/2019 ########################################################
###########################################################################
# Descrição: Esse script vai fazer backup dos arquivos e criar um novo ####
###########################################################################
# Versão: 1.0 #############################################################
###########################################################################
# Uso: ./life.sh ou sh life.sh ############################################
########################################################################### 

# Cores

vermelhoClaro="\033[1;31m"
verdeClaro="\033[1;32m"
amarelo="\033[1;33m"
azulClaro="\033[1;34m"
purpleClaro="\033[1;35m"
cyanClaro="\033[1;36m"
branco="\033[1;37m"

# Menu
echo "${verdeClaro}
					 ############
					 ### MENU ###
					 ############ 
"
echo "${amarelo}
(1) Configuração Interface
(2) Configuração Dhcp
(3) Configuração Samba"
echo "${vermelhoClaro}(4) Sair"
read -p "=>>" numero
echo "{$branco}"

if [ "$numero" = "1" ]; then
	clear
	sleep 0.7

	echo "${verdeClaro}
			##################################
			### CONFIGURAÇÃO DO INTERFACES ### 
			##################################
" 
echo "${amarelo}
(1) Configuração interface"
echo "${vermelhoClaro}(2)Voltar"
read -p "=>>" a
echo "{$amarelo}"
fi

if [ "$numero" = "2" ]; then
	clear
	sleep 0.7

	 echo "${verdeClaro}
			############################
			### CONFIGURAÇÃO DO DHCP ###
			############################
" 
echo "${amarelo}
(1) Pacote Isc-Dhcp-Server
(2) Configuração Dhcp"
echo "${vermelhoClaro}(3) Voltar"
read -p "=>>" b
echo "${amarelo}"
fi

if [ "$numero" = "3" ]; then
	clear
	sleep 0.4

echo "${verdeClaro}
			#############################
			### CONFIGURAÇÃO DO SAMBA ###
			#############################
			"
			echo "{$amarelo}
(1) Criação de Usuários
(2) Criação de Grupos e adicionando os Usuários a ele
(3) Criação de Diretorios
(4) Instalação do Samba e Cria senha para os usuarios de Samba
(5) Configuração do Samba (smb.conf)"
echo "${vermelhoClaro}(6) Voltar"
read -p "=>>" c
echo "{$amarelo}"
fi

if [ "$numero" = "4" ]; then
	sleep 0.2
	exit
fi

if [ "$a" = "1" ]; then
	clear 
echo "${cyanClaro}configurando o interfaces..."
sleep 0.6
	cd /etc/network/
mv interfaces interfaces.original
touch interfaces

echo "source /etc/network/interfaces.d/*
auto lo
iface lo inet loopback" >> interfaces

echo >> interfaces

echo "allow-hotplug enp0s3
auto enp0s3
iface enp0s3 inet dhcp" >> interfaces

echo >> interfaces
echo "allow-hotplug enp0s8
auto enp0s8
iface enp0s8 inet static" >> interfaces

echo >> interfaces

echo "address 192.168.0.1
netmask 255.255.255.0
network 192.168.0.0
broadcast 192.168.0.255" >> interfaces
echo "${azulClaro}Concluido.."
sleep 0.3
cd /home/welinton/life2 && sh life.sh
echo "${branco}"
fi

if [ "$a" = "2" ]; then
	echo "${purpleClaro}Voltando....."
	sleep 0.4
cd /home/welinton/life2 && sh life.sh
echo "${branco}"
fi

if [ "$b" = "1" ]; then
	echo "${cyanClaro}Instalando o pacote isc-dhcp-server"
sleep 0.3
apt-get install isc-dhcp-server -y &&
cd /etc/default/
mv isc-dhcp-server isc-dhcp-server.original
touch isc-dhcp-server
echo 'INTERFACESv4="enp0s8"' >> isc-dhcp-server
echo 'INTERFACESv6=""' >> isc-dhcp-server
echo "${azulClaro}Instalado com sucesso..."
sleep 0.4
cd /home/welinton/life2 && sh life.sh
echo "${branco}"
fi

if [ "$b" = "2" ]; then
	echo "${cyanClaro}Configuração do Dhcp"
	sleep 0.5
	cd /etc/dhcp/
mv dhcpd.conf dhcpd.conf.original
touch dhcpd.conf

echo "ddns-update-style none;
option domain-name-servers 192.168.0.1;
default-lease-time 600;
max-lease-time 7200;
authoritative;
log-facility local7;
subnet 192.168.0.0 netmask 255.255.255.0{
        range 192.168.0.50 192.168.0.100;
        option routers 192.168.0.1;
}" >> dhcpd.conf

apt-get install apache2 -y
apt-get install ssh -y
echo "${azulClaro} Configurado com sucesso..."
sleep 0.5
cd /home/welinton/life2 && sh life.sh
echo "${branco}"
fi

if [ "$b" = "3" ]; then
	echo "${cyanClaro}Voltando"
	sleep 0.4
	cd /home/welinton/life2 && sh life.sh
	echo "${branco}"
fi

if [ "$c" = "1" ]; then
	clear
	echo "${azulClaro} Criação de Usuários"
	echo "${branco}"
	sleep 0.5
	apt-get update -y
	sleep 0.5
	echo "${vermelhoClaro} Usuários joao"
	adduser --disabled-login --no-create-home joao
	echo "${branco}"
	sleep 0.5
	echo "${vermelhoClaro} Usuários maria"
	adduser --disabled-login --no-create-home maria
	echo "${branco}"
	sleep 0.5
	echo "${vermelhoClaro} Usuários pedro"
	adduser --disabled-login --no-create-home pedro
	echo "${branco}"
	sleep 0.5
	echo "${vermelhoClaro} Usuários tiago"
	adduser --disabled-login --no-create-home tiago
	echo "${branco}"
	cd /home/welinton/life2 && sh life.sh
fi

if [ "$c" = "2" ]; then
clear 
	echo "${azulClaro} Criação dos Grupos"
	echo "${branco}"
	sleep 0.4
	echo "${vermelhoClaro}Criando Grupo Administrativo"
	sleep 0.6
	echo "${branco}"
	groupadd administrativo
	echo "${vermelhoClaro}Criando Grupo Financeiro"
	sleep 0.6
	echo "${branco}"
	groupadd financeiro

	echo "${azulClaro} adicionando Usuários ao Grupo"
	sleep 9
	echo "${vermelhoClaro} Os Usuários Que Vão Ser Adicionandos ao Grupo Administrativo serão Joao e Maria"
	sleep 10
	adduser joao administrativo
	adduser maria administrativo
	echo "${cyanClaro} Usuários adicionandos ao grupo administrativo com sucesso..."

	echo "${purpleClaro} Os Usuários Que Vão Ser Adicionandos ao Grupo Financeiro serão pedro e tiago "
	sleep 10
	adduser pedro financeiro
	adduser tiago financeiro
	echo "${amarelo} Usuários adicionandos ao grupo Financeiro com sucesso..."
	echo "${branco}"
	cd /home/welinton/life2 && sh life.sh
fi

if [ "$c" = "3" ]; then
	cd /home/
	mkdir DADOS
	mkdir lixeira
	cd DADOS/
	mkdir Administrativo
	mkdir Financeiro
	cd ..
	chmod 775 DADOS/ # permissão total para o usuario no grupo e apesnas leitura para os usuarios
	cd DADOS/ 
	chgrp administrativo Administrativo/
	chgrp financeiro Financeiro/
	chmod 770 Administrativo/
	chmod 770 Financeiro/
	chmod 777 lixeira/
	cd /home/welinton/life2 && sh life.sh
fi

if [ "$c" = "4" ]; then 
clear
echo "${purpleClaro} Instalando o Samba"
sleep 0.5
apt-get install samba -y
echo "${cyanClaro} Adicionando os usuarios ao samba"
sleep 0.4
echo "${vermelhoClaro} Crie uma senha para o usuarios joao"
smbpasswd -a joao
echo "${verdeClaro} OK"
clear
echo "${vermelhoClaro} Crie uma senha para o usuario maria"
smbpasswd -a maria
echo "${verdeClaro} OK"
clear
echo "${vermelhoClaro} Crie uma senha para o usuario pedro"
smbpasswd -a pedro
echo "${verdeClaro} OK"
clear
echo "${vermelhoClaro} Crie uma senha para o usuario tiago"
smbpasswd -a tiago
echo "${verdeClaro} OK"
clear
cd /home/welinton/life2/ && sh life.sh
fi

if [ "$c" = "5" ]; then
	sleep 0.4
	cd /etc/samba/
	mv smb.conf smb.conf.original
	touch smb.conf

	echo "
[global]
		netbios name = Servidor
		workgroup = piribinha
		server string = Servidor de Arquivos da Piribinha
		security = user
		encrypt passwords = yes
		invalid users = root


[arquivos]
		path = /home/DADOS
		writeable = yes
		available = yes
		valid users = @adminstrativo @financeiro
		comment = Servidor de Arquivos da Empresa X
		vfs object = recycle
		recycle:repository = /home/lixeira
		recycle:keeptree = yes
		recycle:exclud = *.tmp
		recycle:exclud_dir = tmp, cache
		" >> smb.conf
		/etc/init.d/samba restart
		cd /home/welinton/life2/ && sh life.sh
	fi

	if [ "$c" = "6" ]; then
		sleep 0.4
		exit
	fi
