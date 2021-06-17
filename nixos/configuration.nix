# vim:ft=nix
# vim:sw=2
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ];
  nixpkgs.config.allowUnfree = true;
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

# Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "pandora"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Set your time zone.
  time.timeZone = "Europe/Athens";

# The global useDHCP flag is deprecated, therefore explicitly set to false here.
# Per-interface useDHCP will be mandatory in the future, so this generated config
# replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp5s0.useDHCP = true;

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

# Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    windowManager.bspwm.enable = true;
    displayManager = {
      defaultSession = "none+bspwm";
    };
    autoRepeatDelay = 250;
    autoRepeatInterval = 35;
    videoDrivers = [ "nvidia" "intel" ];
    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
        accelSpeed = "0.3";
      };
    };
    # config = ''
    #   Section "InputClass"
    #     Identifier "mouse accel"
    #     Driver "libinput"
    #     MatchIsPointer "on"
    #     Option "AccelProfile" "0, 1"
    #     Option "AccelSpeed" "0.2"
    #   EndSection
    # '';
  };

  programs.ssh.startAgent = true;

# Configure keymap in X11
# services.xserver.layout = "us";
# services.xserver.xkbOptions = "eurosign:e";

# Enable CUPS to print documents.
# services.printing.enable = true;

# Enable sound.
# sound.enable = true;
# hardware.pulseaudio.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

# Enable touchpad support (enabled default in most desktopManager).
# services.xserver.libinput.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.minebill = {
    isNormalUser = true;
    initialPassword = "password";
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  # programs.bash.promptInit = ''eval "$(starship init bash)"'';
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [
        "vi-mode"
        "git"
      ];
    };
    autosuggestions.enable = true;
    syntaxHighlighting = {
      enable = true;
    };
    promptInit = ''eval "$(starship init zsh)"'';
  };

# List packages installed in system profile. To search, run:
# $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
      wget
      git
      alacritty
      firefox
      starship
      keepassxc
      zsh
  ];

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
# services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

