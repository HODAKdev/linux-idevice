# linux-idevice

Why did I create this repository?
Because nobody provides proper documentation, and more importantly premade/precompiled files!

<img src="https://github.com/HODAKdev/linux-idevice/blob/main/images/fastfetch.jpeg" width="300" alt="fastfetch"/>

## Showcase
https://www.youtube.com/shorts/un0yvOCv--g?is=asPFtHepmnCoCIOV

<img src="https://github.com/HODAKdev/linux-idevice/blob/main/images/gta.jpeg" width="300" alt="gta"/>
<img src="https://github.com/HODAKdev/linux-idevice/blob/main/images/doom.jpeg" width="300" alt="doom"/>

## Info
The linux kernel should work for any idevice that requires a 16k page size. \
Just change .dtb file for you idevice when you use cat to make final m1n1-linux.bin \
Do not forget that .dtb file is device tree of your idevice. This is why you need correct file.

You can use my precompiled bins, but you need make your rootfs via pmbootstrap \
https://wiki.postmarketos.org/wiki/Pmbootstrap/Installation

## To make your image
```
1. pmbootstrap init 
2. pmbootstrap export
3. Copy image to netboot path
```

## To boot
1. Put idevice to DFU mode
2. Run exploit and boot to PongoOS
```
sudo /home/hodak/.local/bin/palera1n -p
```
4. Run pongoterm to send blob
```
chmod +x pongoterm
sudo ./pongoterm
```
6. In pongoOS shell
```
/send m1n1-linux.bin
bootm
```
8. Wait some time, when "ip a" will show usb0
9. Turn on and set ip
```
sudo ip link set usb0 up
sudo ip addr add 172.16.42.2/24 dev usb0
```
11. Start netboot server
```
pmbootstrap netboot serve
```

-> No further steps are necessary, they are for information purposes only.

## Make blob
(default m1n1-linux.bin is for iPhone 8 GSM model) \
for different idevice or global model just use correct idevice dtb \
m1n1 bootloader + .dtb + linux kernel + initramfs
```
cat m1n1.bin \
    <(echo 'chosen.bootargs=loglevel=7 pmos.nosplash') \
    arch/arm64/boot/dts/apple/t8015-d20.dtb \
    arch/arm64/boot/Image.gz \
    initramfs.gz \
    > m1n1-linux.bin
```

## SSH
Your name and password can be different
```
ssh user@172.16.42.1
```

## Debug shell
Show usb ttys
```
ls /dev/ttyACM* /dev/ttyUSB* 2>/dev/null
```
Connect to tty
```
sudo screen /dev/ttyACM0 115200
```

## Share internet, PC/idevice
On PC
```
ip route show default
sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
sudo iptables -A FORWARD -i usb0 -o wlan0 -j ACCEPT
sudo iptables -A FORWARD -i wlan0 -o usb0 -m state --state RELATED,ESTABLISHED -j ACCEPT
```

On idevice
```
sudo ip route add default via 172.16.42.2
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf
ping -c 3 google.com
```

## VNC
On idevice
```
x11vnc -display :0 -forever -shared -rfbport 5900 -nopw
```

On PC
```
vncviewer 127.0.0.1:5900
```

## Rotate screen
```
DISPLAY=:0 xrandr -o left
```

## Install packages
```
sudo apk add <package>
sudo apk install chromium
```

## Play DOOM
```
sudo apk add chocolate-doom freedoom
DISPLAY=:0 chocolate-doom -iwad /usr/share/games/doom/freedoom1.wad
```

## Install linux to disk with iOS, no netboot needed
This commands can destroy iOS, but you can restore via DFU \
This will create 12GB partition for linux, you can set different size
1. Jailbreak iOS
2. Use terminal app or ssh to terminal access
3. Download tools
```
https://nightly.link/hoolocklinux/docs/workflows/build/master/hoolock-support-iphoneos.zip
```
5. Unpack to var/jb
6. If you use ssh set auto lock to never
7. Better to run this command in screen or tmux, this will take some few minutes
8. In ssh go to var/jb
9. ./resize_apfs disk0s1 51999997952
10. ./gdisk -l /dev/disk0
11. ./gdisk /dev/disk0
12. Command: d, Partition number: 1
13. Command: n, Partition number: 1, First sector: 6, Last sector: 12695317, Hex code: AF0A
14. Command: n, Partition number: 2, First sector: 12695318, Last sector: 15624994, Hex code: 8300
15. Command: p (user verify)
16. Command: w (write)
17. Boot Linux on idevice
18. sudo mkfs.ext4 -L hoolocklinux /dev/nvme0n1p2
19. sudo mkdir -p /mnt/linux
20. (Use only if you need mount) sudo mount /dev/nvme0n1p2 /mnt/linux \
More info \
https://github.com/HoolockLinux/docs/blob/master/tools/README.md
https://github.com/HoolockLinux/docs/blob/master/tutorials/gdisk.md

## Build your linux kernel
https://github.com/HoolockLinux/docs/blob/master/tutorials/SETUP.md#building-linux

## DTBs
https://github.com/HoolockLinux/linux/tree/hoolock/arch/arm64/boot/dts/apple \
Choose correct dtb: idevice and Global/GSM model

## If you want android on idevice you can look
https://github.com/LineageOS/android_device_apple_snowcastle

## Credits
https://palera.in/ \
https://github.com/HoolockLinux \
https://github.com/checkra1n/PongoOS/blob/master/scripts/pongoterm.c \
https://github.com/AsahiLinux/m1n1 \
https://wiki.postmarketos.org/wiki/Main_Page
