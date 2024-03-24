{ pkgs, ... }:

{
  imports = [
    ./default.nix
    ./gnome.nix
    ./sway.nix
    ./samba.nix
    ./tailscale.nix
    ./prometheus.nix
  ];

  security.allowSimultaneousMultithreading = true;
  security.forcePageTableIsolation = false;

  services.xserver.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];
  services.xserver.displayManager.gdm.enable = true;

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "alx" ];
  };

  environment.systemPackages = with pkgs; [ pritunl-client ];
}
