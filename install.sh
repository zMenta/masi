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
#
# POSSIBLE TODO's
# - Create on the multiselect a description=("") parameter? -> on print_option $text $description
#

source menu.sh

function printWarning { printf "\n\e[38;5;178m-- $1 --\e[0m\n"; }
function printStatus { printf "\n\e[38;5;45m-- $1 --\e[0m\n"; }
function printSucess { printf "\e[38;5;46m-- $1 --\e[0m\n"; }
function printError { printf "\e[38;5;203m-- $1 --\e[0m\n"; }

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

echo
printWarning "Toggled selections are going to be installed. If in doubt, please check the packages in archlinux.org"

echo "-- Browsers --"
browser_options=("brave-bin" "firefox")
browser_defaults=("true" "false")
multiselect browser_result browser_options browser_defaults

echo "-- Misc --"
misc_options=( "alacritty" "fd" "ripgrep" "npm" "netcat" "texlive-most")
misc_default=( "true" "true" "true" "true" "netcat" "false")
multiselect misc_result misc_options misc_default

echo "-- Utility --"
utility_options=("flameshot" "htop" "zellij" "btop" "arandr")
utility_default=("true" "true" "true" "false" "false")
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

echo " - All the selected items are going to be installed, proceed with installation?"
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

echo " - Would you like to install Menta configuration files?"
echo " If in doubt, please consult https://github.com/zMenta/config-files"
singleselect yn_result yn_options
if [[ $yn_result == "yes" ]]; then
	echo " - Select the configurations you want to apply"
	config_options=("nvim" "zellij" "godot" "doom emacs" "bashrc" "endeavourOS i3wm")
	config_defaults=("true" "true" "true" "false" "true" "false")
	multiselect config_result config_options config_defaults

	printStatus "Clonning config files"
	git clone --depth 1 https://github.com/zMenta/config-files.git $PWD
	printSucess "done" 

	config_log=("")
    for ((i=0; i<${#config_options[@]}; i++)); do
		if [[ ${config_result[i]} == "false" ]]; then
			continue
		fi 

		case ${config_options[i]} in
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

			"doom emacs")
				printStatus "Installing Doom emacs"
				git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
				~/.emacs.d/bin/doom install -!
				config_log+=("Don't forget to run doom sync")

				printStatus "Applying doom emacs config"
				cp -rv $PWD/config-files/.doom.d ~/
				printSucess "done"
				;;

			bashrc)
				printStatus "Applying bashrc config"
				if [ -f "$HOME/.bashrc" ]; then
					echo ".bashrc found, procceding"
					bashrc_configs=(
					'export PATH="$HOME/godot:$PATH"'
					'export PATH="$HOME/.emacs.d/bin:$PATH"' 
					'alias emacs="emacsclient -c -a '"''"'"'
					'alias gvim="nvim --listen ./godothost ."'
					)
					
					for config in "${bashrc_configs[@]}"; do
						if grep -Fxq "$config" ~/.bashrc; then
							printWarning "$config not written. Line already exist in .bashrc"
						else
							sudo echo "$config" >> ~/.bashrc
							echo " -> Wrote $config in .bashrc" 
						fi
					done
					printSucess "done" 
				else
					printError ".bashrc NOT found, .bashrc not applied!."
				fi 
				;;

			"endeavourOS i3wm")
				printStatus "Applying endeavourOS i3wm config"
				cp -v $PWD/config-files/endeavourOS_i3wm/config ~/.config/i3/config
				cp -v $PWD/config-files/endeavourOS_i3wm/i3blocks.conf ~/.config/i3/i3blocks.conf
				printSucess "done" 
				;;

			zellij)
				printStatus "Applying zellij config"
				cp -rv $PWD/config-files/zellij ~/.config
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
