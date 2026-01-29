#!/bin/bash

install_list=(
    #############
    #    Core   #
    #############
    base-devel # Tools needed for building (compiling and linking)
    wget # Download from the web
    xclip # Clipboard manager, terminal emulator(using for nvim yank) yank support
    networkmanager # Manage wires
    i3 # Window manager
	autotiling # Autotiles for i3 and sway
    rofi # A window switcher, Application launcher and dmenu replacement
    polybar # Status bar
    ly # TUI Login screen
    xsecurelock # Lock screen
    man # Manual pages
    pipewire # Audio manager
    pavucontrol # PulseAudio Volume Control
    alsa-utils # Sound utilities like amixer, change volume with keybinds, etc 
    gvfs # Provides file system mounting and trash functionality
    playerctl # Mpris media player controller and lib
    tumbler # Image previewer
    ffmpegthumbnailer # Enable video thumbnailing
    thunar # File browser
    thunar-volman # Automatic management of removable devices in Thunar.
    thunar-archive-plugin # Manage archives directly in Thunar.
    file-roller # Create and modify archives | Used for the thunar-archive-plugin
    xbindkeys # is a program that allows to bind commands to certain keys or key combinations on the keyboard. Xbindkeys works with multimedia keys and is independent of the window manager and desktop environment.
    lxappearance # Be able to modify appearance, GTK+ theme switcher
    poppler-qt5 # Add support for opening PDF files in Krita (Poppler is a PDF rendering library)
    dunst # A highly configurable and lightweight notification daemon.
	ueberzugpp # Image support in terminal (using for Alacritty)

	#############
	# GTK Theme	#
	#############
	gruvbox-material-gtk-theme-git
	gruvbox-material-icon-theme-git

    #########
    # Fonts #
    #########
    otf-firamono-nerd 
    noto-fonts # An expansive font package
    noto-fonts-emoji # Emojis 
    noto-fonts-cjk # Font support for Chinese, Japanese and Korean characters

    ##################
    # Useful Utility #
    ##################
    unzip # Unzip files
    rofi-calc # Rofi as calculator
    ncdu # NCurses Disk Usage, disk utility
    bat # Improved cat command
    zellij # Terminal multiplexer
    fzf # Fuzzy finder
    fd # Faster find command
    npm # Sad language package installer
    stow # Symlink farm manager
    ripgrep # Line oriented search tool
    yt-dlp # Feature-rich command-line audio/video downloader
    xdotool # Simulate keyboard input and mouse activity
    tldr # Too long didn't read man pages
    mangohud # Game performance overlay
    gamemode # OS optimisation for games
	zoxide # Smarter cd command
	blesh # Bash Line Editor (ble.sh), improved shell interactions

    #########
    # Tools #
    #########   
    neovim # Based text editor
    # sc-im # A terminal excel like spreadsheet editor
    yazi # Cool kid's lf [file manager]
    mpv # Media Player
    alacritty # Terminal emulator
    arandr # Allows the user to customize monitor arrangements on X
    obsidian # Note taking app
    obs-studio # Stream and record videos
    krita # Drawing and image editing software
    blender # 3D (and much more) modelling software
    godot # 2D and 3D game engine
    hledger-bin # Manage your finance
    hledger-iadd-bin # Easily creates hledger entries
    htop-vim # Htop system resources + vim keybinds
    zathura # Document viewer
    zathura-pdf-mupdf # EPUB, PDF and XPS support based on MuPDF
	libreoffice-still # Libre office tools
    # brave-browser # A decent browser
    # firefox-developer-edition # The browser
	zen-browser-bin # Relaxed browser
    flameshot # Screenshot tool
    syncthing # A continuous file synchronization program
	qbittorrent # An advanced BitTorrent client
	laigter # Normal map creator from images
	kdenlive # Video editing software
	# musescore # Music notation app
	
	###########################
	# Japanese Language Input #
	##########################
	fcitx5-im # Input method framework
	fcitx5-mozc-ut # Japanese input method

    #######
    # Fun #
    #######
    ani-cli # Watch anime
    # lobster # Watch movies and tv shows    # Commenting out lobster, some issues when downloading package
    # mangal # Read and or download manga
    steam # The best game library
    discord # Message and voice chat with friends
)
