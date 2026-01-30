#!/bin/bash

packageSetups() {
    # Zathura #
    echo "-> Zathura"
    xdg-mime default org.pwmt.zathura.desktop application/pdf # Make zathura the default pdf reader

    # Discord #
    # Enable client auto updates | Adds the skip_host_update: true line
    echo "-> Discord"
    echo '{
          "IS_MAXIMIZED": true,
          "IS_MINIMIZED": false,
          "SKIP_HOST_UPDATE": true
        }' > ~/.config/discord/settings.json

    # NetworkManager #
    echo "-> NetworkManager"
    sudo systemctl start NetworkManager
    sudo systemctl enable NetworkManager

    echo " -> ly Login Manager"
	sudo systemctl enable ly@tty2.service

	# User scripts #
    echo " -> User services"
	# Checks if the system has the BAT0 battery, if yes, enable the batteryNotification user service
	[ -e /sys/class/power_supply/BAT0 ] && systemctl --user start batteryNotification.timer && systemctl --user enable batteryNotification.timer

	# Treesitter-cli #
	cargo install --locked tree-sitter-cli
}

backlightSetup() {
    # Adding the user to video group and adding a backlight rule, so polybar can change the backlight levels.
    # check https://wiki.archlinux.org/title/Backlight#ACPI for more info.
    rule='ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp video $sys$devpath/brightness", RUN+="/bin/chmod g+w $sys$devpath/brightness"'
    rule_path="/etc/udev/rules.d/backlight.rules"
    echo " -> Adding user $USER to video group"
    sudo usermod -aG video "$USER"
    echo " -> Adding backlight rule to $rule_path"
    if [[ ! -f "$rule_path" ]]; then
        touch rule_path
        echo " -> Rule file created"
    fi

    if ! grep -Fxq "$rule" "$rule_path"; then
        echo "$rule" | sudo tee -a "$rule_path"
        echo " -> Rule written"
    else
        echo " -> [W] Backlight rule already exist in $rule_path"
    fi
}
