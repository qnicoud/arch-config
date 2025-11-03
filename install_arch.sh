#!/bin/bash

echo "Installer yay"
sudo pacman -Sy vim neovim git firefox dolphin kitty polkit \
    usbutils pavucontrol pulseaudio nvidia nvidia-utils \
    nerd-fonts sww wofi mlocate loupe discord sddm rhythmbox \
    bluez bluez-utils gnome-bluetooth-3.0a ttf-font-awesome otf-font-awesome \
    unzip cuda blender gamemode btop wlr-randr rofi-wayland quemu-full libvirt  virt-manager \
    dnsmasq dmidecode dart-sass dart-sass gnome-themes-extra gtk-engine-murrine evtest kvantum kvantum-qt5 \
    perl-image-exiftool pdftk xdg-utils ripgrep fd emacs fastfetch 
echo "yay -S vim-plug proton-mail spotify-player-full virtio-win superfile" 

echo "Hyprland & related tools"
sudo pacman -Sy egl-wayland nwg-displays hypridle hyprcursor waybar hyprland
echo "yay -S nordzy-hyprecursors nordzy-cursors hyprshot wlogout" 

echo "Authent polkit related"
sudo pacman -Sy hyprpolkitagent 

echo "Dev related packages"
sudo pacman -Sy docker kubectl k9s bash-completion helm arduino-ide jq
echo "yay -Sy lazydocker rpi-imager thonny"
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && bash Miniconda3-latest-Linux-x86_64.sh 
echo "Après avoir installé conda : sudo ln -s /opt/miniconda3/etc/profile.d/conda.sh /etc/profile.d/conda.sh"

echo "Nvidia graphics card utilities"
sudp pacman -Sy nvidia nvidia-settings nvidia-utils lib32-nvidia-utils lib32-opencl-nvidia opencl-nvidia libvdpau libxnvctrl vulkan-icd-loader lib32-vulkan-icd-loader

echo "Lutris Gaming"
sudo pacman -Sy dotnet-runtime directx-headers lutris 
echo "yay -S wine-stable"

echo "Steam +  Gaming"
echo "Pour isntaller steam décomenter la section multilib du fichier /etc/pacman.conf puis : pacman -Syu ; pacman -S steam"
sudo pacman -Sy lib32-fontconfig
echo "yay -S minecraft-launcher gnome-keyring"

# Divers
sudo pacman -Sy openrgb-bin freecad
echo "yay -Sy cura-bin"
echo "pour configurer materia gtk transparent theme  : https://github.com/ckissane/materia-theme-transparent/blob/master/INSTALL.md"
echo "pour configurer SDDM, c'est ici https://framagit.org/MarianArlt/sddm-sugar-candy"
