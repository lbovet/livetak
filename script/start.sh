#!/bin/bash

# Prepares the system to run audio smoothly, change the window manager
# and starts the studio

# Mostly taken from http://le-guitariste-libre.blogspot.ch/2012/05/diminuer-voir-eliminer-les-xruns-de.html

sudo modprobe -r ppdev # Pas de ports parallèles sur ma machine
sudo modprobe -r lp # Pas besoin d'imprimantes pour faire de la musique
sudo modprobe -r uvcvideo # Pas besoin de webcam non plus
sudo modprobe -r videodev # idem pour V4L2 (Vidéo for linux 2)
sudo modprobe -r wl # Wireless driver (son nom peut varier selon le chipset)
sudo modprobe -r btusb # Pas besoin de Bluetooth USB non plus (décommentez si nécessaire) 
sudo modprobe -r ath9k

sudo service bluetooth stop # Stoppe Bluetooth process
sudo service cups stop # Stoppe cups qui gére l'imprimante 
sudo service network-manager stop # Stoppe le réseau
sudo /etc/init.d/ondemand stop # Prevent this script from running so my CPU won't use the ondemand governor
sudo service hddtemp stop # Pas besoin de la température du CPU (Décommentez si nécessaire)
sudo killall /sbin/wpa_supplicant # Stoppe le service WPA pour le réseau wifi

sudo modprobe snd-hrtimer # Charge le module de haute résolution du temps

sudo sh -c 'echo -n performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor' # Set the CPU scaling governor to performance

sudo /etc/init.d/rtirq start

# Some useless things using CPU and screen real-estate
killall conky 
killall avant-window-navigator 

# Inhibit screen blank
xset -dpms
xset s noblank
xset s off

# A lighter window manager (will eventually be awesome-wm)
xfwm4 --replace &

# Loads and starts the studio
ladish_control sload live sstart
gladish &
