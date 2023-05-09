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

function installOptions {
    local -n options=$1
    local -n result=$2

    for ((i=0; i<${#options[@]}; i++)); do
        if [[ ${result[i]} == "true" ]]; then
            echo "Installing ${options[i]}"
            eval yay -S --noconfirm "${options[i]}"
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
echo "Toggled selections are going to be installed."
echo

echo "-- Misc --"
misc_options=( "fd" "ripgrep" "texlive-most")
misc_default=( "true" "true" "false")
multiselect misc_result misc_options misc_default

echo "-- Utility --"
utility_options=("flameshot" "htop")
utility_default=("true" "true" )
multiselect utility_result utility_options utility_default

echo "--------------------------------------------------------------------------------------"
echo "   Installation Began, you might be asked for your sudo password to proceed."
echo "--------------------------------------------------------------------------------------"
echo 

installOptions misc_options misc_result