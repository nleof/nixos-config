{ pkgs, ... }:

{
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  documentation = {
    doc.enable = false;
    info.enable = false;
    man.enable = true;
    nixos.enable = false;
  };

  boot.tmp.cleanOnBoot = true;

  services.irqbalance.enable = true;

  programs.mtr.enable = true;

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    htop
    jq
    tree
    patch
    unzip
    whois
    ldns # drill
    netcat
    ripgrep
    whois
    gnumake
    pwgen
    tldr
    fd
    (aspellWithDicts (dicts: with dicts; [ en fr ]))
    (hunspellWithDicts (with hunspellDicts; [ en-us fr-any ]))
  ];
}
