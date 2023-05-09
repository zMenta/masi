#!/bin/bash

# This is a simple script for installing the softwares I normally use. Using checkboxes for a bit of modularity. 
# Use it at own risk
#
# Requirements:
# - yay 
#
#
# ---------------------------------------------------------------------------------------------------------------------------
#
# Thanks for https://unix.stackexchange.com/questions/146570/arrow-key-enter-menu/673436#673436 making this project possible.
#
# ---------------------------------------------------------------------------------------------------------------------------

declare RED=1
declare GREEN=2
declare BLUE=4
declare WHITE=7

function printInstallStatus {
    local text=$1

    echo
    echo "$(tput setaf $BLUE)-- installing $text --$(tput setaf $WHITE)"
}

function printDone {
    echo "$(tput setaf $GREEN)-- done --$(tput setaf $WHITE)"
    echo
}

function installOptions {
    local -n options=$1
    local -n result=$2

    for ((i=0; i<${#options[@]}; i++)); do
        if [[ ${result[i]} == "true" ]]; then
            printInstallStatus ${options[i]}
            eval yay -S --noconfirm "${options[i]}"
            printDone
        fi
    done
}

# TODO
# 1 - Single selection menu
# 2 - Warns that yay is necessary and asks to install it. Check Chris Titus hyprland install
# 3 - Finish Install
# 4 - On final selection have the following message "The toggled options are going to be installed, proceed?"

source ./menu.sh

echo 
echo "k or up_arrow      => UP"
echo "j or down_arrow    => DOWN"
echo "Space              => toggle selection"
echo "Enter              => confirm selection"
echo 

echo "* The following script requires yay"
echo "Toggled selections are going to be installed. If in doubt, please check the packages in archlinux.org"

echo "-- Browsers --"
browser_options=("brave-bin" "firefox")
browser_defaults=("true" "false")
multiselect browser_result browser_options browser_defaults

echo "-- Misc --"
misc_options=( "fd" "ripgrep" "npm" "texlive-most")
misc_default=( "true" "true" "true" "false")
multiselect misc_result misc_options misc_default

echo "-- Utility --"
utility_options=("flameshot" "htop")
utility_default=("true" "true" )
multiselect utility_result utility_options utility_default

echo "-- Development --"
dev_options=("neovim" "vim" "emacs-nativecomp" "vscodium-bin" "godot" "rust")
dev_defaults=("true" "true" "false" "false" "true" "true")
multiselect dev_result dev_options dev_defaults


echo "--------------------------------------------------------------------------------------"
echo "   Installation Began, you might be asked for your sudo password to proceed."
echo "--------------------------------------------------------------------------------------"

echo
echo "$(tput setaf $BLUE)-- Updating the system --$(tput setaf $WHITE)"
yay -Syu --noconfirm
printDone

installOptions browser_options browser_result
installOptions misc_options misc_result
installOptions utility_options utility_result
installOptions dev_options dev_result

echo "-------------------------"
echo "  Installation Complete"
echo "-------------------------"
echo