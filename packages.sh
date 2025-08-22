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
    arc-gtk-theme # Gtk Color theme
    poppler-qt5 # Add support for opening PDF files in Krita (Poppler is a PDF rendering library)
    dunst # A highly configurable and lightweight notification daemon.
	ueberzugpp # Image support in terminal (using for Alacritty)

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
    # gthumb # Image viewer and quick image edits
    obsidian # Note taking app
    obs-studio # Stream and record videos
    krita # Drawing and image editing software
    blender # 3D (and much more) modelling software
    godot # 2D and 3D game engine
    # hledger # Manage your finance
    # hledger-iadd # Easily creates hledger entries
    htop-vim # Htop system resources + vim keybinds
    zathura # Document viewer
    zathura-pdf-mupdf # EPUB, PDF and XPS support based on MuPDF
	libreoffice-still # Libre office tools
    # brave-browser # A decent browser
    # firefox-developer-edition # The browser
	zen-browser # Relaxed browser
    flameshot # Screenshot tool
    syncthing # A continuous file synchronization program
	qbittorrent # An advanced BitTorrent client
	# laigter # Normal map creator from images
	
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
