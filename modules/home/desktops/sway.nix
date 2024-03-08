{ pkgs, lib, ... }:

{
  imports = [
    ./sway/alacritty.nix
    ./sway/waybar.nix
    ./sway/wofi.nix
    ./sway/mako.nix
    ./sway/swaylock.nix
  ];

  home.packages = with pkgs; [ grim slurp pavucontrol brightnessctl ];

  programs.foot.enable = false;
  programs.foot.server.enable = false;

  wayland.windowManager.sway = {
    enable = true;

    config = {
      modifier = "Mod4";

      terminal = "alacritty";

      bars = [{ command = "${pkgs.waybar}/bin/waybar"; }];

      menu = "wofi --show=drun --lines=10 --prompt=''";

      input."type:keyboard" = { xkb_options = "compose:ralt"; };

      fonts = {
        names = [ "Iosevka" ];
        size = 9.0;
      };

      keybindings = lib.mkOptionDefault {
        "XF86AudioRaiseVolume" =
          "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" =
          "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86MonBrightnessUp" = "exec brightnessctl -q set 10%+";
        "XF86MonBrightnessDown" = "exec brightnessctl -q set 10%-";

        "Mod4+Shift+e" = ''mode "$mode_system"'';
      };

      window.border = 1;

      startup = [
        { command = "alacritty --class alacritty-ws1"; }
        { command = "firefox -P alx"; }
        { command = "firefox -P alx-360"; }
        { command = "emacsclient"; }
        { command = "mako"; }
        { command = "1password"; }
        { command = "spotify"; }
      ];

      assigns = {
        "1" = [{ app_id = "alacritty-ws1"; }];
        "2" = [{ app_id = "emacs"; }];
        "3" = [{ app_id = "firefox"; }];
        "4" = [{ instance = "1password"; }];
        "5" = [{ instance = "spotify"; }];
      };
    };

    extraConfig = ''
      seat * xcursor_theme Adwaita 24

      # TODO
      output HDMI-A-1 scale 2
      output eDP-1 disable

      set $mode_system System: (l) lock, (e) logout, (s) suspend, (r) reboot, (S) shutdown
      mode "$mode_system" {
          bindsym l exec ${pkgs.swaylock}/bin/swaylock, mode "default"
          bindsym e exit
          bindsym s exec --no-startup-id systemctl suspend, mode "default"
          bindsym r exec --no-startup-id systemctl reboot, mode "default"
          bindsym Shift+s exec --no-startup-id systemctl poweroff -i, mode "default"

          # return to default mode
          bindsym Return mode "default"
          bindsym Escape mode "default"
      }
    '';

    extraSessionCommands = ''
      export NIXOS_OZONE_WL="1"
      export XDG_CURRENT_DESKTOP=sway
      export GDK_BACKEND=wayland
      export MOZ_ENABLE_WAYLAND=1
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export QT_AUTO_SCREEN_SCALE_FACTOR="1"
    '';
  };

  services.gnome-keyring.enable = true;

  services.swayidle = {
    enable = true;
    systemdTarget = "sway-session.target";
    timeouts = [{
      timeout = 500;
      command = "${pkgs.swaylock}/bin/swaylock -fF";
    }];
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock";
      }
      {
        event = "lock";
        command = "${pkgs.swaylock}/bin/swaylock";
      }
    ];
  };
}
