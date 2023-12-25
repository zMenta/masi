#!/bin/bash

install_list=(
	#############
	#    Core   #
	#############
	base-devel 
	wget # Download from the web
	unzip # Unzip files
	xclip # Clipboard manager, nvim yank support
	networkmanager 
	i3 # Window manager
	rofi
	polybar 
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
	nvidia-inst # Nvidia driver installer
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
	xdg-mime default org.pwmt.zathura.desktop application/pdf # Make zathura the default pdf reader

	# Discord #
	# Enable client auto updates | Adds the skip_host_update: true line
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
}
