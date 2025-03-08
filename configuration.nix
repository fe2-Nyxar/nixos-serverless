# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./Terminal.nix
    ./developement.nix
    ./modules/wireguard.nix
    ./modules/networking.nix
  ];

  # Use the systemd-boot EFI boot loader.
  /*
    boot.kernelParams = [
      "intel_iommu=on"
      "iommu=pt"
    ];
  */
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
    };
    grub = {
      efiSupport = true;
      device = "nodev";
    };
  };

  # Set your time zone.
  time.timeZone = "Africa/Casablanca";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
    #     useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.fish;
    users.ismailm9wd = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      /*
        packages = with pkgs; [
          #     tree
        ];
      */
    };
    users.baryon = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      /*
        packages = with pkgs; [
          #     tree
        ];
      */
    };
  };

  programs = {
    fish.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neovim
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  /*
    programs.command-not-found.enable = false;
    programs.nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
  */
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  /*
    virtualisation.docker = {
      # enable docker
      enable = true;
      # use docker without Root access (Rootless docker)
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  */

  nixpkgs.config.allowUnfree = true;

  # Allow experimental feature "flakes"
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
  };
  nix.optimise.automatic = true;
  nix.settings.auto-optimise-store = true;

  #NOTE: List services that you want to enable:

  # Enable firmware updates
  services.fwupd.enable = true;
  # Enable the OpenSSH daemon.
  services.logind = {
    lidSwitch = "ignore";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "ignore";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  system.stateVersion = "24.11"; # Did you read the comment?
}
