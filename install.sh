#!/bin/bash

#--------------------------------------#
# This is simple install script to     #
#  install my desktop enviroment,      #
#  tested with basic xorg arch install #
#--------------------------------------#

# Create a file for installation (this one)
# Create a file for updating config files (need to create)
# Create a file for package names(need to create)

source menu.sh

function printWarning { printf "\n\e[38;5;178m-- $1 --\e[0m\n"; }
function printStatus { printf "\n\e[38;5;45m-- $1 --\e[0m\n"; }
function printSucess { printf "\e[38;5;46m-- $1 --\e[0m\n"; }
function printError { printf "\e[38;5;203m-- $1 --\e[0m\n"; }

function installOptions {
    local -n options=$1

    for ((i=0; i<${#options[@]}; i++)); do
		printStatus "installing ${options[i]}"
		eval yay -S --noconfirm "${options[i]}"
		printSucess "done"
    done
}

# Options for yes or no questions
yn_options=("yes" "no")

printStatus "Commands"
echo "k or up_arrow      => UP"
echo "j or down_arrow    => DOWN"
echo "Space              => toggle selection"
echo "Enter              => confirm selection"
echo 

printStatus "Checking for yay"
ISYAY=/sbin/yay
if [ -f "$ISYAY" ]; then 
	echo " -> yay was located, procceding"
else
	printWarning "yay was NOT located"
	echo " - Would you like to install yay?"

	singleselect yn_result yn_options
	if [[ $yn_result == "yes" ]]; then
		printStatus "installing yay"
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
        cd ..
		printSucess "done"
	else
		printError "yay is required for this script, exiting"
		exit
	fi
fi

# echo
# printWarning "Toggled selections are going to be installed. If in doubt, please check the packages in archlinux.org"
#
# echo "-- Browsers --"
# browser_options=("brave-bin" "firefox")
# browser_defaults=("true" "false")
# multiselect browser_result browser_options browser_defaults
#
# echo "-- Misc --"
# misc_options=( "alacritty" "fd" "fzf" "ripgrep" "npm" "netcat" "texlive-most")
# misc_default=( "true" "true" "true" "true" "netcat" "false")
# multiselect misc_result misc_options misc_default
#
# echo "-- Utility --"
# utility_options=("flameshot" "htop" "zellij" "btop" "arandr")
# utility_default=("true" "true" "true" "false" "false")
# multiselect utility_result utility_options utility_default
#
# echo "-- Development --"
# dev_options=("neovim" "vim" "emacs-nativecomp" "vscodium-bin" "godot" "rust")
# dev_defaults=("true" "true" "false" "false" "true" "false")
# multiselect dev_result dev_options dev_defaults
#
# echo "-- Games and Communication --"
# gc_options=("discord" "steam")
# gc_defaults=("true" "false")
# multiselect gc_result gc_options gc_defaults

# echo "-- Multimidia Tools --"
# tool_options=(
# 	"mpv"
#     "audacity" "lmms"
#     "obs-studio" "kdenlive"
#     "krita" "gimp" "aseprite" "pureref" 
#     "blender" "blockbench"
#     )

echo " - All the items in the packages.sh file are going to be installed, proceed with installation?"
singleselect yn_result yn_options
if [[ $yn_result == "no" ]]; then
	printError "Installation cancelled, exiting"
	exit
fi

echo "--------------------------------------------------------------------------------------"
echo "   Installation Began, you might be asked for your sudo password to proceed."
echo "--------------------------------------------------------------------------------------"

printStatus "Updating the system"
yay -Syu --noconfirm
printSucess "System updated"

installOptions browser_options

echo "-------------------------"
echo "  Installation Complete"
echo "-------------------------"
echo

echo " - Would you like to install Menta configuration files?"
echo " If in doubt, please consult https://github.com/zMenta/config-files"
singleselect yn_result yn_options
if [[ $yn_result == "" ]]; then
	printStatus "Clonning config files"
	git clone --depth 1 https://github.com/zMenta/config-files.git $PWD/config-files
	printSucess "done" 

	config_log=("")
    for ((i=0; i<${#config_options[@]}; i++)); do
		if [[ ${config_result[i]} == "false" ]]; then
			continue
		fi 

			nvim) 
				printStatus "Applying nvim config"
				cp -rv $PWD/config-files/nvim/ ~/.config 
				printSucess "done"
				;;

			godot) 
				printStatus "Applying godot config"
				mkdir -v ~/godot
				mkdir -v ~/godot/projects
				printSucess "done"
				;;
		esac
	done
	
fi

echo
echo "-------------------------"
echo "  Script Complete"
echo "-------------------------"
echo
