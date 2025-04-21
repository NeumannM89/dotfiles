#!/bin/bash


#https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#option-7-install-script for ubuntu

# Packages to install
PACKAGES=("stow" "make" "gcc" "ripgrep" "unzip" "xclip" "git" "neovim" "curl" "tmux" "nodejsl" "npm" "fzf" "noto-fonts" "i3-wm" "i3lock" "polybar" "i3blocks" "dmenu")

# Function to install package
install_package() {
    if [ -x "$(command -v apt)" ]; then
	    if ! dpkg -s $1 &> /dev/null; then
		    sudo apt update -y && sudo apt install -y $1
	    fi
    elif [ -x "$(command -v pacman)" ]; then
	    if ! pacman -Q $1 &> /dev/null; then
		    sudo pacman -S --noconfirm --needed $1
	    fi
    else
		    echo "Package manager not supported."
		    exit 1
	    fi
}

# Installation function
install_packages() {
    for package in "${PACKAGES[@]}"; do
	echo "Installing $package..."
	install_package $package
    done
}

# Call the installation function
install_packages

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "alias n='nvim'" >> ~/.bashrc
