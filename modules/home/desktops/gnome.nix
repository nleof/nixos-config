{ pkgs, ... }:

{
  # dconf watch /
  dconf.settings = {
    "system/locale" = { region = "fr_FR.UTF-8"; };
    "org/gnome/system/location" = { enabled = true; };
    "org/gnome/shell" = {
      favorite-apps = [
        "org.gnome.Console.desktop"
        "emacs.desktop"
        "firefox.desktop"
        "spotify.desktop"
        "1password.desktop"
        "org.gnome.Nautilus.desktop"
      ];
    };
    "org/gnome/desktop/privacy" = {
      remember-recent-files = false;
      remove-old-trash-files = true;
      remove-old-temp-files = true;
      old-files-age = 1;
    };
    "org/gnome/desktop/search-providers" = { disable-external = true; };
    "org/gnome/desktop/interface" = {
      # color-scheme = "prefer-dark";
      # gtk-theme = "Adwaita-dark";
      color-scheme = "default";
      gtk-theme = "Adwaita";
      enable-hot-corners = true;
    };
    "org/gnome/desktop/session" = { idle-delay = 600; };
    "org/gnome/mutter" = {
      edge-tiling = true;
      dynamic-workspaces = true;
    };
    "org/gnome/Console" = { theme = "auto"; };
    # "org/gnome/nautilus/preferences" = { show-image-thumbnails = "always"; };
    "org/gnome/desktop/interface" = { "monospace-font-name" = "Iosevka 13"; };
    "org/gnome/desktop/input-sources" = {
      "xkb-options" =
        [ "terminate:ctrl_alt_bksp" "lv3:lalt_switch" "compose:rctrl" ];
    };
  };
}
