{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 36;

        modules-left = [ "sway/workspaces" "sway/mode" ];
        modules-center = [ ];
        modules-right = [ "battery" "pulseaudio" "clock" "tray" ];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{index}: {name}";
        };

        "sway/mode" = { format = ''<span style="italic">{}</span>''; };

        tray = { spacing = 10; };

        battery = {
          states = {
            good = 100;
            warning = 50;
            critical = 15;
          };
          format-time = "{H}h{M}";
          format = "{icon} {capacity}% ({time})";
          format-full = "{icon} {capacity}%";
          format-good = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-icons = [ "" "" "" "" "" ];
          tooltip = false;
        };

        pulseaudio = {
          scroll-step = 5;
          format = "{icon} {volume}%";
          format-icons = {
            headphone = "";
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";
        };

        clock = {
          interval = 1;
          format = " {:%d/%m %H:%M:%S}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
        };
      };
    };

    style = ''
      * {
          /* `otf-font-awesome` is required to be installed for icons */
          font-family: "Iosevka", "Font Awesome 6 Free";
      }

      window#waybar {
          background-color: #fcffff;
          transition-property: background-color;
          transition-duration: .5s;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      #workspaces button {
          padding: 0 10px;
          color: #232323;
          /* Avoid rounded borders under each workspace name */
          border: none;
          border-radius: 0;
      }

      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      #workspaces button:hover {
          background: #d4eaf3;
          box-shadow: inherit;
          text-shadow: inherit;
      }

      #workspaces button.focused {
          background-color: #d4eaf3;
          color: #232323;
      }

      #workspaces button.urgent {
          background-color: #c42d2f;
      }

      #mode {
          background-color: #eee8d5;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #custom-media,
      #tray,
      #mode,
      #idle_inhibitor,
      #mpd {
          padding: 0 5px;
          color: #232323;
      }

      #window,
      #workspaces {
          margin: 0 4px;
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
          margin-left: 0;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
          margin-right: 0;
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background-color: #c42d2f;
      }

      @keyframes blink {
          to {
              background-color: #ffffff;
              color: #000000;
          }
      }

      #battery.critical:not(.charging) {
          background-color: #c42d2f;
          color: #ffffff;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }
    '';
  };
}
