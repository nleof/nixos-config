{
  services.mako = {
    enable = true;
    font = "Iosevka";
    backgroundColor = "#d4eaf3";
    textColor = "#232323";
    borderColor = "#004fc0";
    defaultTimeout = 5000;
    ignoreTimeout = true;

    extraConfig = ''
      [mode=away]
      default-timeout=0
      ignore-timeout=1

      [mode=do-not-disturb]
      invisible=1
    '';
  };
}
