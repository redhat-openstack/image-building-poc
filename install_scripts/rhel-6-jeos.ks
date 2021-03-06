install
url --url=<replace with rhel6 install tree URL>
# Needed for cloud-init
repo --name="EPEL-6" --baseurl="http://mirrors.kernel.org/fedora-epel/6/x86_64/"
graphical
vnc --password=${adminpw}
key --skip
keyboard us
lang en_US.UTF-8
skipx
network --device eth0 --bootproto dhcp
rootpw ${adminpw}
firewall --disabled
authconfig --enableshadow --enablemd5
selinux --enforcing
timezone --utc America/New_York
bootloader --location=mbr --append="console=tty0 console=ttyS0,115200"
zerombr yes
clearpart --all

part /boot --fstype ext4 --size=200
part pv.2 --size=1 --grow
volgroup VolGroup00 --pesize=32768 pv.2
#logvol swap --fstype swap --name=LogVol01 --vgname=VolGroup00 --size=768 --grow --maxsize=1536
logvol / --fstype ext4 --name=LogVol00 --vgname=VolGroup00 --size=1024 --grow
poweroff

%packages
@base
cloud-init

%post
