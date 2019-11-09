# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
    imports =
    [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
            (import ./packages.nix {inherit config pkgs lib; })
    ];

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Enable libvirt
    boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
    virtualisation.libvirtd.enable = true;

    boot.cleanTmpDir = true;

    networking.hostName = "ThinkingPad"; # Define your hostname.
    #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networking.networkmanager.enable = true;

    networking.localCommands =
        ''
          ${pkgs.vde2}/bin/vde_switch -tap tap0 -mod 660 -group kvm -daemon
          ip addr add 10.0.2.1/24 dev tap0
          ip link set dev tap0 up
          ${pkgs.procps}/sbin/sysctl -w net.ipv4.ip_forward=1
          ${pkgs.iptables}/sbin/iptables -t nat -A POSTROUTING -s 10.0.2.0/24 -j MASQUERADE
        '';

    # Select internationalisation properties.
    #i18n = {
    #  consoleFont = "Lat2-Terminus16";
    #  consoleKeyMap = "sv-latin1";
    #  defaultLocale = "en_US.UTF-8";
    #};

    # Set your time zone.
    time.timeZone = "Europe/Stockholm";

    # programs.bash.enableCompletion = true;
    # programs.mtr.enable = true;
    # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # Enable CUPS to print documents.
    # services.printing.enable = true;

    # Enable sound.
    sound.enable = true;
    hardware.pulseaudio.enable = true;

    # Enable the X11 windowing system.
    services.xserver = {
        enable = true;
        autorun = true;
        layout = "se";

        desktopManager = {
            default = "none";
            xterm.enable = false;
        };

        windowManager = {
            i3 = {
                enable = true;
                package = pkgs.i3-gaps;
            };
            default = "i3";
        };

        displayManager.lightdm = {
            enable = true;
        };

        autoRepeatDelay = 300;
        autoRepeatInterval = 35;

        #windowManager.bspwm.enable = true;
        #windowManager.default = "bspwm";
        #windowManager.bspwm.configFile = "/home/curious/.config/bspwm/bspwmrc";
        #windowManager.bspwm.sxhkd.configFile = "/home/curious/.config/sxhkd/sxhkdrc";

        #displayManager.auto = {
        #   enable = true;
        #   user = "user";
        #};

        #     displayManager.slim = {
        #        enable = false;
        #        user = "curious";
        #	autoLogin = false;
        #     };
    };
    # services.xserver.layout = "us";
    # services.xserver.xkbOptions = "eurosign:e";

    # Enable touchpad support.
    services.xserver.libinput.enable = true;


    programs = {
        zsh = {
            enableCompletion = true;
            enable = true;
        };

        light.enable = true;
        command-not-found.enable = true;
    };

    environment = {
        variables.EDITOR = "vim";
    };

    #systemd.user.services.lock = {
    #    enable = true;
    #    description = "i3lock daemon";
    #    before = "sleep.target";
    #    serviceConfig = {
    #        Type = "simple";
    #        User = "curious";
    #        ExecStart = "/home/curious/.config/i3/lock.sh";
    #    };
    #    wantedBy = [ "sleep.target" "suspend.target" "default.target" ];
    #};
    services.mysql.package = pkgs.mariadb;
    services.mysql.enable = true;
    systemd.services.lock.enable = true;

    # Enable the KDE Desktop Environment.
    # services.xserver.displayManager.sddm.enable = true;
    # services.xserver.desktopManager.plasma5.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    # users.extraUsers.guest = {
    #   isNormalUser = true;
    #   uid = 1000;
    # };

    # Enable docker
    virtualisation.docker.enable = true;

    # This value determines the NixOS release with which your system is to be
    # compatible, in order to avoid breaking some software such as database
    # servers. You should change this only after NixOS release notes say you
    # should.
    system.stateVersion = "18.03"; # Did you read the comment?

        users.extraUsers.curious = {
            isNormalUser = true;
            uid = 1000;
            extraGroups = [ "wheel" "networkmanager" "docker" ];
            createHome = true;
            home = "/home/curious";
            shell = "/run/current-system/sw/bin/zsh";
        };
}

