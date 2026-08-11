# linux-idevice

You can use my precompiled bins, but you need make your image via pmbootstrap \
https://wiki.postmarketos.org/wiki/Pmbootstrap/Installation

## To make your image
1. pmbootstrap init 
2. pmbootstrap export
3. Copy image to netboot path

## To boot
1. Put idevice to DFU mode
2. Run exploit and boot to PongoOS \
sudo /home/hodak/.local/bin/palera1n -p
3. Run pongoterm to send blob \
sudo ./pongoterm
4. To pongoOS shell \
/send m1n1-linux.bin \
bootm
5. Wait some time, when "ip a" will show usb0
6. Turn on and set ip \
sudo ip link set usb0 up \
sudo ip addr add 172.16.42.2/24 dev usb0
7. Start netboot server \
pmbootstrap netboot serve

## SSH
Your name and password can be different \
ssh user@172.16.42.1

## Debug shell
Show usb ttys \
ls /dev/ttyACM* /dev/ttyUSB* 2>/dev/null \
Connect to tty \
sudo screen /dev/ttyACM0 115200

## Share internet, PC/idevice
On PC \
ip route show default \
sudo sysctl -w net.ipv4.ip_forward=1 \
sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE \
sudo iptables -A FORWARD -i usb0 -o wlan0 -j ACCEPT \
sudo iptables -A FORWARD -i wlan0 -o usb0 -m state --state RELATED,ESTABLISHED -j ACCEPT \

On idevice \
sudo ip route add default via 172.16.42.2 \
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf \
ping -c 3 google.com

## VNC
On idevice \
x11vnc -display :0 -forever -shared -rfbport 5900 -nopw \

On PC \
vncviewer 127.0.0.1:5900

## Rotate screen
DISPLAY=:0 xrandr -o left

## Install packages
sudo apk add <package> \
sudo apk install chromium

## Build your linux kernel
https://github.com/HoolockLinux/docs/blob/master/tutorials/SETUP.md#building-linux

## DTBs
https://github.com/HoolockLinux/linux/tree/hoolock/arch/arm64/boot/dts/apple \
Choose correct model: Global/GSM 

## Credits
https://palera.in/ \
https://github.com/HoolockLinux \
https://github.com/checkra1n/PongoOS/blob/master/scripts/pongoterm.c \
https://github.com/AsahiLinux/m1n1 \
https://wiki.postmarketos.org/wiki/Main_Page
