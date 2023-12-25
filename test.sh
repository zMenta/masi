#!/bin/bash

#--------------------------------------#
# This is simple install script to     #
#  install my desktop enviroment,      #
#  tested with basic xorg arch install #
#--------------------------------------#

# Sourcing files
source menu.sh

# Helper Functions
function printWarning { printf "\n\e[38;5;178m-- $1 --\e[0m\n"; }
function printStatus { printf "\n\e[38;5;45m-- $1 --\e[0m\n"; }
function printSucess { printf "\e[38;5;46m-- $1 --\e[0m\n"; }
function printError { printf "\e[38;5;203m-- $1 --\e[0m\n"; }

yayCheck() {
	printStatus "Checking for yay"
	ISYAY=/sbin/yay
	if [ -f "$ISYAY" ]; then 
		echo " -> yay was located, procceding"
	else
		printWarning "yay was NOT located"
		echo " - Would you like to install yay?"

		yn_options=("yes" "no")
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
}

# Script starts
clear
printStatus "Welcome to Masi"
echo

opts=("Install" "Update" "Exit")
singleselect result opts

if [ $result == 'Install' ]; then
	echo "Installation began"
	yayCheck
elif [ $result == 'Update' ]; then
	echo "Updating with the latest config files"
else
	echo "See you next time"
fi
