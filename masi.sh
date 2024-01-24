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
function sendError { 
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
			sendError "yay is required for this script, exiting"
		fi
	fi
}

install() {
	echo "--------------------------------------------------------------------------------------"
	echo "   Installation Began, you might be asked for your sudo password to proceed."
	echo "--------------------------------------------------------------------------------------"
    
	yayCheck

	printStatus "Updating the system"
	yay -Syu --noconfirm || sendError "Error on system update, exiting"
	printSucess "done"

	for value in "${install_list[@]}"; do
		printStatus "Installing $value"
		eval yay -S "$value" --noconfirm || sendError "Error on package install, exiting"
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

update() {
	echo "--------------------------------------------"
	echo "   Updating with the latest config files"
	echo "--------------------------------------------"


    if [ -d $PWD/config-files ]; then
        printWarning "Config files directory exists"
        printStatus "Cleaning up..."
        rm -rdf $PWD/config-files || sendError "Error on removing directory $PWD/config-files, exiting"
        printSucess "done"
    fi

    printStatus "cloning https://github.com/zMenta/config-files.git"
	git clone --quiet --depth 1 https://github.com/zMenta/config-files.git $PWD/config-files || sendError "Git clone error, exiting"
    printSucess "done"

    printStatus "Copying config files to ~/.config"
    for dir in $PWD/config-files/dotfiles/*; do
        cp -r $dir ~/.config || sendError "Error on copying $dir config to ~/.config, exiting"
    done
    printSucess "done"
    
    printStatus "Copying .bashrc file"
    cp $PWD/config-files/bashrc/.bashrc ~/ || sendError "Error on copying .bashrc file to home directory, exiting"
    printSucess "done"

    printStatus "Copying script files to ~/.scripts"
    if [ ! -d ~/.scripts ]; then
        mkdir ~/.scripts
    fi
    cp -r $PWD/config-files/scripts ~/.scripts || sendError "Error on copying $dir config to ~/.scripts, exiting"
    printSucess "done"

    echo
    echo "Would you like to delete temporary config files?"
    echo " -> masi/config-files"
    singleselect clean_after yn_options

    if [ $clean_after == "yes" ]; then
        printStatus "Cleaning up..."
        rm -rdf $PWD/config-files || sendError "Error on removing directory $PWD/config-files, exiting"
        printSucess "done"
    fi

    echo
	echo "---------------------"
	echo "   Update complete   "
	echo "---------------------"
    echo
}

################
# Script start #
################
clear
printStatus "Welcome to Masi"
echo

opts=("Full-Setup" "Install" "Update" "Exit")
singleselect result opts

if [ $result == 'Full-Setup' ]; then
    install
    update
elif [ $result == 'Install' ]; then
	install
elif [ $result == 'Update' ]; then
    update
else
	echo "- See you next time -"
fi
