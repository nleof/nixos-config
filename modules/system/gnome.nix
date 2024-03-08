{ pkgs, ... }:

{
  services.xserver.desktopManager.gnome.enable = true;

  # gnome indexing service
  services.gnome.tracker-miners.enable = false;
  services.gnome.tracker.enable = false;
  environment.gnome.excludePackages =
    (with pkgs; [ snapshot gnome-photos gnome-tour ]) ++ (with pkgs.gnome; [
      gnome-music
      gnome-maps
      gnome-contacts
      gnome-characters
      gnome-weather
      gnome-clocks
      epiphany # web browser
      geary # email reader
      # totem # video player # used for thumbnails
      yelp # gnome help
    ]);

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnomeExtensions.tiling-assistant
  ];
}
