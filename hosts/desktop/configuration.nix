{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  system.stateVersion = "23.11";

  boot.loader = {
    systemd-boot.configurationLimit = 10;
    efi.canTouchEfiVariables = true;
    grub.device = "nodev";
    grub.efiSupport = true;
    grub.enableCryptodisk = true;
  };

  boot.initrd.luks.devices = {
    crypted = {
      device = "/dev/disk/by-uuid/92069bb4-96e5-40a9-b4a4-cf10249918d0";
      preLVM = true;
    };
  };

  networking = {
    hostName = "desktop";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Paris";

  console.keyMap = "us";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "en_US.UTF-8/UTF-8" "fr_FR.UTF-8/UTF-8" ];
  };

  services.xserver.enable = true;

  # Enable sound.
  sound.enable = true;
  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.enable = true;
  services.pipewire.enable = true;

  services.openssh.enable = true;

  users.groups.alx = { gid = 1000; };
  users.users.alx = {
    uid = 1000;
    isNormalUser = true;
    shell = pkgs.fish;
    ignoreShellProgramCheck = true; # fish installed with home-manager
    group = "alx";
    extraGroups = [ "wheel" "users" ];
  };

  security.polkit.enable = true;

  fonts.packages = with pkgs; [ iosevka font-awesome ];

  nixpkgs.config.allowUnfree = true;
}
