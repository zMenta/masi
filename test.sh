#!/bin/bash

#--------------------------------------#
# This is simple install script to     #
#  install my desktop enviroment,      #
#  tested with basic xorg arch install #
#--------------------------------------#

# Sourcing files
source menu.sh
source packages.sh

# Helper Functions
function printWarning { printf "\n\e[38;5;178m-- $1 --\e[0m\n"; }
function printStatus { printf "\n\e[38;5;45m-- $1 --\e[0m\n"; }
function printSucess { printf "\e[38;5;46m-- $1 --\e[0m\n"; }
function printError { 
    printf "\e[38;5;203m-- $1 --\e[0m\n";
    exit
}

# Helper Variables
yn_options=("yes" "no")

yayCheck() {
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
		fi
	fi
}

install() {
	echo "--------------------------------------------------------------------------------------"
	echo "   Installation Began, you might be asked for your sudo password to proceed."
	echo "--------------------------------------------------------------------------------------"

	for value in "${install_list[@]}"; do
		printStatus "Installing $value"
		eval yay -S "$value" --noconfirm
		printSucess "done"
	done

	printStatus "Additional setups"
	packageSetups
	backlightSetup
	printSucess "done"

    echo 
	echo "----------------------------"
	echo "  Installation complete "
	echo "----------------------------"
}

#################
# Script starts #
#################
clear
printStatus "Welcome to Masi"
echo

opts=("Install" "Update" "Exit")
singleselect result opts

if [ $result == 'Install' ]; then
	echo "Installation began"
	yayCheck
	printStatus "Updating the system"
	yay -Syu --noconfirm 
	printSucess "done"
	install
elif [ $result == 'Update' ]; then
	echo "Updating with the latest config files"
else
	echo "See you next time"
fi
