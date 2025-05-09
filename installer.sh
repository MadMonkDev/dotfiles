#!/bin/bash

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

clear
echo -e "${CYAN}${BOLD}Welcome to MadMonk's Dotfiles Setup!${RESET}"
echo

# ASCII Art
echo -e "${BLUE}"
cat <<'EOF'
██████╗░░█████╗░████████╗  ███╗░░░███╗░█████╗░███╗░░██╗
██╔══██╗██╔══██╗╚══██╔══╝  ████╗░████║██╔══██╗████╗░██║
██║░░██║██║░░██║░░░██║░░░  ██╔████╔██║███████║██╔██╗██║
██║░░██║██║░░██║░░░██║░░░  ██║╚██╔╝██║██╔══██║██║╚████║
██████╔╝╚█████╔╝░░░██║░░░  ██║░╚═╝░██║██║░░██║██║░╚███║
╚═════╝░░╚════╝░░░░╚═╝░░░  ╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░╚══╝   

EOF
echo -e "${RESET}"

# Countdown
for i in 3 2 1; do
    echo -e "${YELLOW}Starting in $i...${RESET}"
    sleep 1
done

# Supported packages
supported_packages=("nvim" "zsh" "tmux" "ghostty" "kitty" "hyprland" "waybar" "swww")

# Ask what to do
echo -e "${CYAN}Choose an option:${RESET}"
echo -e "  ${GREEN}1)${RESET} Install packages only"
echo -e "  ${GREEN}2)${RESET} Link dotfiles only"
echo -e "  ${GREEN}3)${RESET} Do both"
read -p "Enter your choice (1-3): " choice

# Detect distro and package manager
detect_package_manager() {
    if [ -f /etc/arch-release ]; then
        echo "sudo pacman -S --needed"
    elif [ -f /etc/debian_version ]; then
        echo "sudo apt install"
    elif [ -f /etc/fedora-release ]; then
        echo "sudo dnf install"
    else
        echo ""
    fi
}

# Ensure Stow is installed
ensure_stow_installed() {
    if ! command -v stow &>/dev/null; then
        echo -e "${YELLOW}GNU Stow not found. Installing it...${RESET}"
        pkg_mgr=$(detect_package_manager)
        if [ -z "$pkg_mgr" ]; then
            echo -e "${RED}Unsupported distro. Please install 'stow' manually.${RESET}"
            exit 1
        fi
        $pkg_mgr stow
    fi
}

# Install selected packages
install_packages() {
    pkg_mgr=$(detect_package_manager)
    if [ -z "$pkg_mgr" ]; then
        echo -e "${RED}Unsupported distro. Exiting.${RESET}"
        exit 1
    fi

    echo
    echo -e "${CYAN}Supported packages:${RESET}"
    for i in "${!supported_packages[@]}"; do
        printf "  ${GREEN}%2d)${RESET} %s\n" $((i+1)) "${supported_packages[i]}"
    done

    echo
    read -p "Enter package numbers to install (e.g. 1 3 5): " selected

    to_install=()
    for i in $selected; do
        index=$((i-1))
        if [[ "$index" -ge 0 && "$index" -lt "${#supported_packages[@]}" ]]; then
            to_install+=("${supported_packages[$index]}")
        fi
    done

    for pkg in "${to_install[@]}"; do
        echo -e "${BLUE}Installing: ${BOLD}$pkg${RESET}"
        $pkg_mgr $pkg
    done
}

# Link dotfiles using stow
link_dotfiles() {
    ensure_stow_installed

    echo
    echo -e "${CYAN}Available dotfile configs:${RESET}"
    for i in "${!supported_packages[@]}"; do
        printf "  ${GREEN}%2d)${RESET} %s\n" $((i+1)) "${supported_packages[i]}"
    done

    echo
    read -p "Enter numbers to link (e.g. 2 4 7): " selected

    for i in $selected; do
        index=$((i-1))
        if [[ "$index" -ge 0 && "$index" -lt "${#supported_packages[@]}" ]]; then
            pkg="${supported_packages[$index]}"
            echo -e "${BLUE}Linking dotfiles for '${BOLD}$pkg${RESET}${BLUE}'...${RESET}"
            stow "$pkg"
        fi
    done
}

# Execute based on choice
case "$choice" in
    1) install_packages ;;
    2) link_dotfiles ;;
    3)
        install_packages
        link_dotfiles
        ;;
    *)
        echo -e "${RED}Invalid choice. Exiting.${RESET}"
        exit 1
        ;;
esac

echo
echo -e "${GREEN}${BOLD}All done! Enjoy your setup.${RESET}"
