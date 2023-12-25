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


# Script starts
opts=("Install" "Update" "Exit")
singleselect result opts

if [ $result == 'Install' ]; then
	echo "Installation began"
elif [ $result == 'Update' ]; then
	echo "Updating with the latest config files"
else
	echo "See you next time"
fi
