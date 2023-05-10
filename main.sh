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

function printWarning { printf "\n\e[38;5;178m-- $1 --\e[0m\n"; }
function printStatus { printf "\n\e[38;5;45m-- $1 --\e[0m\n"; }
function printSucess { printf "\e[38;5;46m-- $1 --\e[0m\n"; }
	

function installOptions {
    local -n options=$1
    local -n result=$2

    for ((i=0; i<${#options[@]}; i++)); do
        if [[ ${result[i]} == "true" ]]; then
            printStatus "installing ${options[i]}"
            eval yay -S --noconfirm "${options[i]}"
            printSucess "done"
        fi
    done
}

### TODO
# DONE 1 - Single selection menu
# 2 - Warns that yay is necessary and asks to install it. Check Chris Titus hyprland install
# DONE 3 - Finish Install
# 4 - On final selection have the following message "The toggled options are going to be installed, proceed?"
# 5 - Create on the multiselect a description=("") parameter? -> on print_option $text $description

source ./menu.sh

printStatus "Commands"
echo "k or up_arrow      => UP"
echo "j or down_arrow    => DOWN"
echo "Space              => toggle selection"
echo "Enter              => confirm selection"
echo 

# printStatus "Checking for yay"
# ISYAY=/sbin/yay
# if [ -f "$ISYAY" ]; then 
# 	printStatus "yay was located"
# fi
#
echo "Toggled selections are going to be installed. If in doubt, please check the packages in archlinux.org"
echo

echo "-- Browsers --"
browser_options=("brave-bin" "firefox")
browser_defaults=("true" "false")
multiselect browser_result browser_options browser_defaults

echo "-- Misc --"
misc_options=( "alacritty" "fd" "ripgrep" "npm" "texlive-most")
misc_default=( "true" "true" "true" "true" "false")
multiselect misc_result misc_options misc_default

echo "-- Utility --"
utility_options=("flameshot" "htop" "btop" "arandr")
utility_default=("true" "true" "false" "false")
multiselect utility_result utility_options utility_default

echo "-- Development --"
dev_options=("neovim" "vim" "emacs-nativecomp" "vscodium-bin" "godot" "rust")
dev_defaults=("true" "true" "false" "false" "true" "true")
multiselect dev_result dev_options dev_defaults

echo "-- Games and Communication --"
gc_options=("discord" "steam")
gc_defaults=("true" "false")
multiselect gc_result gc_options gc_defaults

echo "-- Multimidia Tools --"
tool_options=(
    "audacity" "lmms"
    "obs-studio" 
    "krita" "gimp" "aseprite" "pureref" 
    "blender" "blockbench"
    )
tool_defaults=(
    "false" "false"
    "true"
    "true" "false" "false" "false"
    "false" "false"
    )
multiselect tool_result tool_options tool_defaults

echo "--------------------------------------------------------------------------------------"
echo "   Installation Began, you might be asked for your sudo password to proceed."
echo "--------------------------------------------------------------------------------------"

printStatus "Updating the system"
yay -Syu --noconfirm
printSucess "System updated"

installOptions browser_options browser_result
installOptions misc_options misc_result
installOptions utility_options utility_result
installOptions dev_options dev_result
installOptions gc_options gc_result
installOptions tool_options tool_result

echo "-------------------------"
echo "  Installation Complete"
echo "-------------------------"
echo
