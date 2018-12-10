{ config, pkgs, lib, ... }:

let
stable = pkgs;

base = (with stable; [
    atool
    bc
    binutils
    curl
    dhcpcd
    file
    htop
    imagemagick
    libnotify
    lm_sensors
    lxappearance
    neofetch
    networkmanager
    openssl
    parallel
    parted
    patchelf
    pass
    pavucontrol
    psmisc
    stow
    tree
    usbutils
    unrar
    unzip
    neovim
    vim
    wget
    wmname
    xorg.xbacklight
    xorg.xev
    xorg.xmodmap
    xorg.xprop
    xorg.xwininfo
    zathura
    zsh
    wget
    ]);

extra = (with stable; [
    # browsers
    firefox
    qutebrowser

    # documents
    texlive.combined.scheme-full
    pdftk

    # music
    mpc_cli
    mpd
    mpd_clientlib # necessary for polybar support
    mpv
    audacity

    # arts
    gimp
    inkscape
    maim

    # fancy stuff
    compton
    neofetch
    i3-gaps
    jsoncpp
    polybar
    rofi
    feh
    ranger
    termite
    redshift
    unclutter-xfixes
    taskwarrior

    # communication
    tdesktop
    irssi

    # x11-stuff
    acpi
    hibernate
    xclip
    xdotool
    xbindkeys
    xautolock

    # torrent
    deluge

    powerline-fonts

    # wine is not an emulator
    wine
    winetricks
    ]);

development = (with stable; [
    # general tools
    gitAndTools.gitFull
    git-crypt
    rtags
    nix-prefetch-git
    direnv
    pkgconfig

    # building
    cmake
    gnumake

    # debugging
    gdb

    # C++/C
    gcc

    # virtualization
    docker

    # python
    python3
    vagrant

    # go
    go

    # rust
    rustup

    # java
    gradle
    android-studio

    # ocaml
    #gnome2.gtksourceview
    #gnome2.gtk
    #opam
    #ocaml
    #coq
    #m4
    #perl

    # databases
    mariadb
    mysql-workbench

    # editors (and plugin stuff)
    python36Packages.neovim
    ycmd
    mono
    nodejs
    openjdk
    clang

    # networking
    wireshark
    curlFull
    openssl
    traceroute

    # virtualisation
    qemu
    vde2
    ]);

in
{
    environment.systemPackages =
        base ++
        extra ++
        development ++
        [];

    nixpkgs.config.allowUnfree = true;

    fonts = {
        enableCoreFonts = true;
        enableFontDir = true;
        enableGhostscriptFonts = true;
        fontconfig.enable = true;

        fonts = (with pkgs; [
            liberation_ttf
            libertine
            freefont_ttf
            dejavu_fonts
            iosevka
            source-code-pro
            siji
            opensans-ttf
            noto-fonts
            inconsolata
            font-awesome-ttf

            #nerdfonts
            siji
            terminus_font
            hack-font
            powerline-fonts
        ]);
    };

# Overrides
    nixpkgs.config.packageOverrides = pkgs: rec {
        # Enable some support that should be enabled by default. :S
        # https://github.com/NixOS/nixpkgs/blob/fde2012519999145c541547bce310f327080e997/pkgs/applications/misc/polybar/default.nix#L32
        polybar = pkgs.polybar.override {
            i3GapsSupport = true;
            #githubSupport = true;
            #iwSupport = true;
            mpdSupport = true;
        };

        # I only need the one true font
        nerdfonts = pkgs.nerdfonts.override {
            withFonts = "DejaVu";
        };

        # https://github.com/NixOS/nixpkgs/commit/f2d7f573af9063a3a484c80e426490e5093afe32
        neovim = pkgs.neovim.override {
            withPython3 = true;
        };
    };
}

