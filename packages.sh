#!/bin/bash

install_list=(
	#############
	#    Base   #
	#############
	base-devel 
	wget # Download from the web
	unzip # Unzip files
	xclip # Clipboard manager, nvim yank support
	networkmanager 
	i3 # Window manager
	rofi  
	polybar
	ly # TUI Login screen
	xsecurelock # Lock screen
	man # Manual pages
	ufw # Uncomplicated Firewall
	fzf # Fuzzy finder
	fd # Faster find command
	pipewire # Audio manager
	pavucontrol # PulseAudio Volume Control
	mpv # Media Player
	otf-firamono-nerd # Font
	ttf-firacode-nerd # Font
	nvidia-inst # Nvidia driver installer
	file-roller # Create and modify archives
	gthumb # Image viewer and quick image edits
	gvfs # Provides filesystem mounting and trash functionality
	playerctl # Mpris media player controller and lib
	tumbler # Image previewer
	ffmpegthumbnailer # Enable video thumbnailing
	thunar # File browser
	thunar-volman # Automatic management of removeable devices in Thunar.
	thunar-archive-plugin # Manage archives directly in Thunar.
	xbindkeys # is a program that allows to bind commands to certain keys or key combinations on the keyboard. Xbindkeys works with multimedia keys and is independent of the window manager and desktop environment.
	lxappearance # Be able to modify appearance
	arc-gtk-theme # Gtk Color theme



	################
	# Useful tools #
	################
	rofi-calc # Rofi as calculator
	ncdu # NCurses Disk Usage), disk utility
	obsidian # Note taking app
	bat # Improved cat command
	ani-cli # Watch anime
	mangohud # Game performance overlay
	)

