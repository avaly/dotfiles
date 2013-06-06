#!/bin/bash

#
# Helper Functions
#

add_key() {
    wget -qO - "$1" | sudo apt-key add - > /dev/null
}

add_ppa() {
    sudo add-apt-repository -y ppa:"$1" > /dev/null
}

add_source_list() {
    sudo sh -c "printf 'deb $1' >> '/etc/apt/sources.list.d/$2'"
}

cmd_exists() {
    [ -x "$(command -v "$1")" ] \
        && printf 1 \
        || printf 0
}

execute_str() {
    sudo sh -c "$1" > /dev/null
    print_result $? "$2"
}

execute() {
    $1 > /dev/null
    print_result $? "$2"
}

install_pkg() {
    local q="${2:-$1}"

    [ $(cmd_exists "$q") -eq 0 ] \
      && execute_str "sudo apt-get install --allow-unauthenticated -qy $1" "$1"
}

mkd() {
    if [ -n "$1" ]; then
        if [ -e "$1" ]; then
            if [ ! -d "$1" ]; then
                print_error "$1 [a file with the same name already exists]"
            fi
        else
            execute "mkdir -p $1" "$1"
        fi
    fi
}

print_error() {
    printf "\e[1;31m  ✖ $1 $2\e[0m\n"
}

print_info() {
    printf "\n\e[1;33m $1\e[0m\n\n"
}

print_result() {
    [ $1 -eq 0 ] \
        && print_success "$2" \
        || print_error "$2"
}

print_success() {
    printf "\e[1;32m  ✔ $1\e[0m\n"
}

remove_unneeded_pkgs() {
    execute_str "sudo apt-get autoremove -qy" "autoremove"
}

update_and_upgrade() {
    sudo apt-get update -qy
    sudo apt-get upgrade -qy
}

install_dotfiles() {
    git clone git://github.com/avaly/dotfiles.git ~/.dotfiles
    ~/.dotfiles/install.sh
}


#
# Install Software
#
init_software() {

    # Ensure the OS is Ubuntu
    if [ "$(uname -s)" != "Linux" ] || [ ! -e "/etc/lsb-release" ]; then
        print_error "Sorry, this script is for Ubuntu only!"
        exit
    fi

    # --------------------------------------------------------------------------
    # | Init                                                                   |
    # --------------------------------------------------------------------------

    declare i=""
    declare tmp=""

    # Ask for the administrator password upfront
    sudo -v

    # Update existing `sudo` time stamp until this script has finished
    # (https://gist.github.com/3118588)
    while true; do
        sudo -n true
        sleep 60
        kill -0 "$$" || exit
    done 2>/dev/null &

    # --------------------------------------------------------------------------
    # | Installation                                                           |
    # --------------------------------------------------------------------------

    print_info "Installation (this may take a while)"

    # Add software sources

    # Firefox Nightly
    [ $(cmd_exists "firefox-trunk") -eq 0 ] \
        && add_ppa "ubuntu-mozilla-daily/ppa"

    # Google Chrome
    [ $(cmd_exists "google-chrome") -eq 0 ] \
        && add_key "https://dl-ssl.google.com/linux/linux_signing_key.pub" \
        && add_source_list \
                "http://dl.google.com/linux/deb/ stable main" \
                "google-chrome.list"

    # NodeJS
    [ $(cmd_exists "node") -eq 0 ] \
        && add_ppa "chris-lea/node.js"

    # Opera & Opera Next
    [ $(cmd_exists "opera") -eq 0 ] \
        && add_key "http://deb.opera.com/archive.key" \
        && add_source_list \
                "http://deb.opera.com/opera/ stable non-free" \
                "opera.list"

    execute "update_and_upgrade" "update & upgrade"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Tools for compiling / building software from source
    install_pkg "build-essential"

    # GnuPG archive keys of the Debian archive
    install_pkg "debian-archive-keyring"

    # Software which is not included by default
    # in Ubuntu due to legal or copyright reasons
    #install_pkg "ubuntu-restricted-extras"

    install_pkg "git"

    execute "install_dotfiles" "avaly dotfiles"

    install_pkg "curl"
    install_pkg "vim"
    install_pkg "mc"

    install_pkg "nodejs" "node"
    install_pkg "npm"
    install_pkg "apache2"

    install_pkg "chromium-browser"
    install_pkg "firefox-trunk"
    install_pkg "google-chrome-unstable" "google-chrome"
    install_pkg "opera"
    # install_pkg "opera-next"

    install_pkg "virtualbox"
    install_pkg "filezilla"
    install_pkg "nautilus-dropbox" "dropbox"
    install_pkg "krusader"

    install_pkg "banshee"
    install_pkg "vlc"
    install_pkg "gimp"

    install_pkg "ccsm"

}

#
# UI Settings
#
init_ui() {

    print_info "UI Settings"

    # Get all settings: `gsettings list-recursively`

    # Hide the Battery icon from the menu bar when the battery is not in use
    gsettings set com.canonical.indicator.power icon-policy "charge"
    gsettings set com.canonical.indicator.power show-time false

    # Hide the Bluetooth icon from the menu bar
    gsettings set com.canonical.indicator.bluetooth visible false

    # Customize the Sound icon from the menu bar
    gsettings set com.canonical.indicator.sound visible true
    gsettings set com.canonical.indicator.sound interested-media-players "['banshee']"
    gsettings set com.canonical.indicator.sound preferred-media-players "['banshee']"

    # Set keyboard languages and show the Language icon in menu bar
    gsettings set org.gnome.libgnomekbd.keyboard layouts "['us','se','ro']"
    gsettings set org.gnome.libgnomekbd.keyboard options "['grp\tgrp:lalt_lshift_toggle']"

    # Use custom date format in the menu bar
    # (other date interpreted sequences: date --help)
    gsettings set com.canonical.indicator.datetime custom-time-format "%a %e %b %l:%M %p"
    gsettings set com.canonical.indicator.datetime time-format "custom"

    # Set Launcher favorites
    gsettings set com.canonical.Unity.Launcher favorites "[
        'application://nautilus.desktop',
        'application://gnome-terminal.desktop',
        'application://firefox.desktop',
        'application://google-chrome.desktop',
        'application://opera-browser.desktop',
        'application://thunderbird.desktop',
        'application://ubuntu-software-center.desktop',
        'application://gnome-control-center.desktop',
        'unity://running-apps',
        'application://sublime.desktop',
        'application://filezilla.desktop',
        'application://kde4-krusader.desktop',
        'application://banshee.desktop',
        'unity://expo-icon',
        'unity://devices'
    ]"

    # Reset all locale to en_US
    sudo cp locale /etc/default/locale

}

#
# Clean Up & Restart
#
init_cleanup() {

    print_info "Clean up"

    execute "update_and_upgrade" "update & upgrade"
    execute "remove_unneeded_pkgs" "autoremove"

    print_info "All done. Restarting ..."
    sleep 10
    sudo shutdown -r now
}


init_software
init_ui
init_cleanup
