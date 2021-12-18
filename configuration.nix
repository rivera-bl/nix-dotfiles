# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiInstallAsRemovable = true;
    efiSupport = true;
  };

  networking = {
    hostName = "nixos";
    useDHCP = false;

    interfaces = {
      enp0s31f6.useDHCP = true;
      wlp0s20f3.useDHCP = true;
    };

    wireless = {
      enable = true;
      interfaces = [ "wlp0s20f3" ];
      networks = {
        LARVAS = {
          pskRaw = "995283ad39e2805aa3b2632e0dc57fc151699ae3a27e5c9a397b3cd3cc331ce4";
        };
      };
    };
  };

  time.timeZone = "America/Santiago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    # font = "Lat2-Terminus16";
    # keyMap = "la-latin1";
    useXkbConfig = true; # so the caps:swap works on tty
  };

  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;
      libinput.enable = true; # Enable touchpad support (enabled default in most desktopManager).
      xkbOptions = "caps:swapescape";
      displayManager.startx.enable = true; # don't start the graphical interface
    };

    openssh = {
      enable = true;
    };
  };

  # Configure keymap in X11
  # services.xserver.layout = "us";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.atlas = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
  ];

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
