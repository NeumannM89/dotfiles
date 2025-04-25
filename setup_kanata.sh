#!/bin/bash

mkdir $HOME/aur-packages/
git clone https://aur.archlinux.org/kanata.git $HOME/aur-packages/
cd $HOME/aur-packages/kanata/
makepkg --install

sudo groupadd uinput
sudo usermod -aG input $USER
sudo usermod -aG uinput $USER
sudo touch /etc/udev/rules.d/99-input.rules
echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' | sudo tee -a /etc/udev/rules.d/99-input.rules
# echo "run sudo pacman -U 'name of kanata version'"
sudo udevadm control --reload && udevadm trigger --verbose --sysname-match=uniput
sudo modprobe uinput
systemctl --user start kanata.service
systemctl --user enable kanata.service
