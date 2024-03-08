{ pkgs, ... }: {
  programs.chromium = {
    enable = true;
    commandLineArgs = [
      "--gtk-version=4"
      "--ozone-platform=wayland"
      "--disable-features=WaylandFractionalScaleV1"
    ];
    dictionaries = [ pkgs.hunspellDictsChromium.en_US ];
  };
}
