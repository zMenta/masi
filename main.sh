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
# ---

source ./menu.sh

# Usage Example
my_options=( "Option0" "Option2" "Option3")
selection=( "true" "false" "true")
selection1=()
selection2=("true" "true" "true" "true" "true" "true" "true")

echo "First options"
multiselect result my_options selection2
echo "Second Options"
multiselect result my_options selection2

idx=-1
for option in "${my_options[@]}"; do
    echo -e "$option\t=> ${result[idx]}"
    ((idx++))
done