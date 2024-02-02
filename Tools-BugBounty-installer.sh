#!/bin/bash
# Author: drak3hft7
# Tanggal: 08/09/2021

# Periksa apakah skrip dijalankan dengan hak akses root
if [ "${UID}" -eq 0 ]; then
    echo ""
    echo -e "\e[32m\e[1mOK. Skrip akan menginstal alat-alat.\e[0m\e[39m"
    echo ""
else
    echo ""
    echo -e "\e[91m\e[1mHak akses root diperlukan untuk menjalankan skrip ini.\e[0m\e[39m"
    echo ""
    exit 1
fi

#---------Update & upgrade penuh
echo -e "\e[93m\e[1m----> Memperbarui Semua Paket"
apt-get -y update && apt-get -y upgrade
echo -e "\e[32mSelesai!"
sleep 1.5
clear

#---------Install paket-paket esensial
echo -e "\e[93m\e[1m----> Menginstal paket dan alat esensial"
apt-get install -y git rename findutils terminator chromium-browser tmux
echo -e "\e[32mSelesai!"
sleep 1.5

#---------Sistem Operasi Umum
# Python, Ruby, dan beberapa paket
echo -e "\e[93m\e[1m----> Menginstal Python, Ruby, dan beberapa paket"
apt-get install -y python python-pip python3 python3-pip python-dnspython python-dev python-setuptools virtualenv unzip make gcc libpcap-dev curl build-essential libcurl4-openssl-dev libldns-dev libssl-dev libffi-dev libxml2 jq libxml2-dev libxslt1-dev build-essential ruby-dev ruby-full libgmp-dev zlib1g-dev
echo -e "\e[32mSelesai!"
sleep 1.5

#---------Install Golang
echo -e "\e[93m\e[1m----> Pemasangan lingkungan Golang sedang berlangsung ..."
cd /tmp && wget https://golang.org/dl/go1.17.1.linux-amd64.tar.gz > /dev/null 2>&1 && tar xvf go1.17.1.linux-amd64.tar.gz > /dev/null 2>&1
mv go /usr/local
export GOROOT=/usr/local/go && export GOPATH=$HOME/go && export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
echo 'export GOROOT=/usr/local/go' >> ~/.bashrc && echo 'export GOPATH=$HOME/go'	>> ~/.bashrc	&& echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
echo -e "\e[32mPemasangan lingkungan Golang selesai!"; echo ""
sleep 1.5

#---------Membuat folder Alat di Home ~/
echo -e "\e[93m\e[1m----> Membuat folder Alat"
mkdir -p ~/tools
cd ~/tools/
echo -e "\e[32mSelesai!"; echo ""
sleep 1.5

#---------Instalasi Pemindai Jaringan
# Nmap
echo -e "\e[93m\e[1m----> Menginstal nmap"
apt-get install -y nmap > /dev/null 2>&1
echo -e "\e[32mSelesai! Nmap diinstal."
sleep 1.5
# Masscan
echo -e "\e[93m\e[1m----> Menginstal Masscan"
git clone https://github.com/robertdavidgraham/masscan > /dev/null 2>&1 && cd masscan && make > /dev/null 2>&1 && make install > /dev/null 2>&1 && mv bin/masscan /usr/local/bin/
echo -e "\e[32mSelesai! Masscan diinstal."; echo ""
sleep 1.5
# Naabu
echo -e "\e[93m\e[1m----> Menginstal Naabu"
go get -v github.com/projectdiscovery/naabu/v2/cmd/naabu > /dev/null 2>&1 && ln -s ~/go/bin/naabu /usr/local/bin/
echo -e "\e[32mSelesai! Naabu diinstal."; echo ""
sleep 1.5

#---------Instalasi Pemindaian Subdomain dan Penyelesaian DNS
# dnsutils
apt-get install -y dnsutils > /dev/null 2>&1
sleep 1.5
# Massdns
echo -e "\e[93m\e[1m----> Menginstal massdns"
git clone https://github.com/blechschmidt/massdns.git > /dev/null 2>&1
cd ~/tools/massdns
make > /dev/null 2>&1
cd ~/tools/
echo -e "\e[32mSelesai! Massdns diinstal."; echo ""
sleep 1.5
# Subfinder
echo -e "\e[93m\e[1m----> Menginstal Subfinder"
go get -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder > /dev/null 2>&1 && ln -s ~/go/bin/subfinder /usr/local/bin/
echo -e "\e[32mSelesai! Subfinder diinstal."; echo ""
sleep 1.5
# Knock
echo -e "\e[93m\e[1m----> Menginstal Knock"
git clone https://github.com/guelfoweb/knock.git > /dev/null 2>&1
echo -e "\e[32mSelesai! Knock diinstal."; echo ""
sleep 1.5
# Lazyrecon
echo -e "\e[93m\e[1m----> Menginstal LazyRecon"
git clone https://github.com/nahamsec/lazyrecon.git > /dev/null 2>&1
echo -e "\e[32mSelesai! LazyRecon diinstal."; echo ""
sleep 1.5
# Github-subdomains
echo -e "\e[93m\e[1m----> Menginstal Github-subdomains"
go get -u github.com/gwen001/github-subdomains > /dev/null 2>&1 && ln -s ~/go/bin/github-subdomains /usr/local/bin/
echo -e "\e[32mSelesai! Github-subdomains diinstal."; echo ""
sleep 1.5
# Sublist3r
echo -e "\e[93m\e[1m----> Menginstal Sublist3r"
git clone https://github.com/aboul3la/Sublist3r.git > /dev/null 2>&1
cd Sublist3r
pip3 install -r requirements.txt > /dev/null 2>&1
cd ~/tools/
echo -e "\e[32mSelesai! Sublist3r diinstal."; echo ""
sleep 1.5

#---------Instalasi Alat untuk Analisis
# Amass
echo -e "\e[93m\e[1m----> Menginstal Amass"
go get -v github.com/OWASP/Amass/v3/... > /dev/null 2>&1 && ln -s ~/go/bin/amass /usr/local/bin/
echo -e "\e[32mSelesai! Amass diinstal."; echo ""
sleep 1.5
# Assetfinder
echo -e "\e[93m\e[1m----> Menginstal Assetfinder"
go get -u github.com/tomnomnom/assetfinder > /dev/null 2>&1 && ln -s ~/go/bin/assetfinder /usr/local/bin/
echo -e "\e[32mSelesai! Assetfinder diinstal."; echo ""
sleep 1.5
# Httprobe
echo -e "\e[93m\e[1m----> Menginstal Httprobe"
go get -u github.com/tomnomnom/httprobe > /dev/null 2>&1 && ln -s ~/go/bin/httprobe /usr/local/bin/
echo -e "\e[32mSelesai! Httprobe diinstal."; echo ""
sleep 1.5
# Subjack
echo -e "\e[93m\e[1m----> Menginstal Subjack"
go get -u github.com/haccer/subjack > /dev/null 2>&1 && ln -s ~/go/bin/subjack /usr/local/bin/
echo -e "\e[32mSelesai! Subjack diinstal."; echo ""
sleep 1.5
# Subover
echo -e "\e[93m\e[1m----> Menginstal SubOver"
git clone https://github.com/Ice3man543/SubOver.git > /dev/null 2>&1 && cd SubOver && python3 -m pip install -r requirements.txt > /dev/null 2>&1 && cd ~/tools/
echo -e "\e[32mSelesai! SubOver diinstal."; echo ""
sleep 1.5

#---------Instalasi Alat untuk Pemindaian Port dan Layanan
# NmapAutomator
echo -e "\e[93m\e[1m----> Menginstal NmapAutomator"
git clone https://github.com/21y4d/nmapAutomator.git > /dev/null 2>&1
echo -e "\e[32mSelesai! NmapAutomator diinstal."; echo ""
sleep 1.5

#---------Instalasi Alat untuk Pemindaian Web
# Nikto
echo -e "\e[93m\e[1m----> Menginstal Nikto"
apt-get install -y nikto > /dev/null 2>&1
echo -e "\e[32mSelesai! Nikto diinstal."; echo ""
sleep 1.5
# WFuzz
echo -e "\e[93m\e[1m----> Menginstal WFuzz"
apt-get install -y wfuzz > /dev/null 2>&1
echo -e "\e[32mSelesai! WFuzz diinstal."; echo ""
sleep 1.5

# Informasi Penginstalan
echo -e "\e[93m\e[1mPenginstalan selesai. Selamat menggunakan alat-alat Anda!"
echo -e "Pastikan untuk memeriksa README atau dokumentasi resmi alat untuk penggunaan yang benar."
echo -e "Terima kasih telah menggunakan skrip ini."
