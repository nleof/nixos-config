{
  programs.alacritty = {
    enable = true;
    settings = {
      env = { "TERM" = "xterm-256color"; };

      font = {
        size = 13.0;

        normal.family = "Iosevka";
        bold.family = "Iosevka";
        italic.family = "Iosevka";
      };

      # ef-light colors
      colors = {
        normal = {
          black = "#eaefef";
          red = "#c42d2f";
          green = "#008a00";
          yellow = "#aa6100";
          blue = "#004fc0";
          magenta = "#aa44c5";
          cyan = "#1f6fbf";
          white = "#232323";
        };
        bright = {
          black = "#b5b8b8";
          red = "#cf2f4f";
          green = "#00845f";
          yellow = "#996c4f";
          blue = "#065fff";
          magenta = "#7f5ae0";
          cyan = "#007a85";
          white = "#66657f";
        };
        cursor = {
          cursor = "#0055bb";
          text = "#fcffff";
        };
        primary = {
          background = "#fcffff";
          foreground = "#232323";
        };
        selection = {
          background = "#d4eaf3";
          text = "#232323";
        };
      };
    };
  };
}
