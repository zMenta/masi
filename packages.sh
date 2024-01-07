#!/bin/bash

install_list=(
	#############
	#    Core   #
	#############
	base-devel # Tools needed for building (compiling and linking)
	wget # Download from the web
	unzip # Unzip files
	xclip # Clipboard manager, nvim yank support
	networkmanager 
	i3 # Window manager
	rofi # A window switcher, Application launcher and dmenu replacement
	polybar # Status bar
	arandr # Allows the user to customize monitor arrangements.
	ly # TUI Login screen
	xsecurelock # Lock screen
	man # Manual pages
	fzf # Fuzzy finder
	fd # Faster find command
	pipewire # Audio manager
	pavucontrol # PulseAudio Volume Control
	alsa-utils # Sound utilities like amixer, change volume with keybinds, etc 
	mpv # Media Player
	gthumb # Image viewer and quick image edits
	gvfs # Provides filesystem mounting and trash functionality
	playerctl # Mpris media player controller and lib
	tumbler # Image previewer
	ffmpegthumbnailer # Enable video thumbnailing
	thunar # File browser
	thunar-volman # Automatic management of removeable devices in Thunar.
	thunar-archive-plugin # Manage archives directly in Thunar.
	file-roller # Create and modify archives | Used for the thunar-archive-plugin
	xbindkeys # is a program that allows to bind commands to certain keys or key combinations on the keyboard. Xbindkeys works with multimedia keys and is independent of the window manager and desktop environment.
	lxappearance # Be able to modify appearance
	arc-gtk-theme # Gtk Color theme
	zathura # Document viewer
	zathura-pdf-mupdf # EPUB, PDF and XPS support based on MuPDF
    alacritty # Terminal emulator

	#########
	# Fonts #
	#########
	otf-firamono-nerd 
	noto-fonts # An expansive font package
	noto-fonts-emoji # Emojis 
	noto-fonts-cjk # Font support for chinese, japanese and korean characters


	##########
	# Useful #
	##########
	rofi-calc # Rofi as calculator
	ncdu # NCurses Disk Usage, disk utility
	obsidian # Note taking app
	bat # Improved cat command
	mangohud # Game performance overlay
	sc-im # A terminal excel like spreadsheet editor
	lf # Terminal file manager
	hledger # Manage your financee
	hledger-iadd # Easily creates hledger entries
    zellij # Terminal multiplexer
    htop-vim # Htop system resources + vim keybinds
	

	#######
	# Fun #
	#######
	ani-cli # Watch anime
	lobster # Watch movies and tv shows
	mangal # Read and or download manga
	steam # The best game library
	discord # Message and voice chat with friends
)


packageSetups() {
	# Zathura #
	echo "-> Zathura"
	xdg-mime default org.pwmt.zathura.desktop application/pdf # Make zathura the default pdf reader

	# Discord #
	# Enable client auto updates | Adds the skip_host_update: true line
	echo "-> Discord"
	echo '{
		  "IS_MAXIMIZED": false,
		  "IS_MINIMIZED": false,
		  "WINDOW_BOUNDS": {
			"x": 1,
			"y": 27,
			"width": 1918,
			"height": 1052
		  },
		  "SKIP_HOST_UPDATE": true
		}' > ~/.config/discord/settings.json

	# NetworkManager #
	echo "-> NetworkManager"
	sudo systemctl start NetworkManager
	sudo systemctl enable NetworkManager

	echo " -> ly Login Manager"
	sudo systemctl enable ly.service
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
