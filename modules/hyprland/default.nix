{ ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;

    systemd.enable = true;

    settings = {
      "$mod" = "Super";

      exec-once = [
        "kitty"
        "librewolf"
        "vesktop"
      ];

      monitor = [
        "HDMI-A-2, 2560x1440@74.97, 0x0, 1"
      ];
      input = {
        kb_layout = "us";
        follow_mouse = true;
        sensitivity = 0.1;
        force_no_accel = true;
      };

      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "GMB_BACKEND,nvidia-drm"
        "XDG_SESSION_TYPE,wayland"

        #"XCURSOR_THEME,Bibata-Modern-Ice"
        #"XCURSOR_SIZE,24"
      ];

      misc = {
        vrr = false;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = false;
      };

      xwayland = {
        force_zero_scaling = true;
      };

      cursor = {
        no_hardware_cursors = true;
      };

      animations = {
        enabled = true;
        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "linear, 1, 1, 1, 1"
        ];

        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 12, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "border, 1, 1, linear"
          "borderangle, 1, 30, linear, loop"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
        ];

      };
      general = {
        gaps_in = 3;
        gaps_out = 3;
        border_size = 2;
        "col.active_border" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
        "col.inactive_border" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
        layout = "dwindle";
        resize_on_border = true;
      };

      group = {
        "col.border_active" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
        "col.border_inactive" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
        "col.border_locked_active" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
        "col.border_locked_inactive" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
      };

      decoration = {
        rounding = 10;
        drop_shadow = false;
        dim_special = 0.3;

        blur = {
          enabled = true;
          size = 6;
          passes = 3;
          new_optimizations = true;
          ignore_opacity = true;
          xray = false;
          special = true;
        };
      };

      windowrulev2 = [
        "opacity 0.90 0.90, class:^(librewolf)$"
        "opacity 0.90 0.90, class:^(org\\.prismlauncher\\.PrismLauncher)$"
        "opacity 0.90 0.90, class:^(Rofi)$"
        "opacity 0.80 0.80, class:^(kitty)$"
        "opacity 0.80 0.80, class:^(vesktop)$"

      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      "$vol_show" = ''notify-send -a "t2" -r 91190 -t 800 "$(wpctl get-volume @DEFAULT_AUDIO_SINK@)"'';

      bindl = [
        ", XF86AudioMute, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 0 && $vol_show"
      ];

      bindel = [
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%- && $vol_show"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+ && $vol_show"
      ];

      bind =
        [
          "$mod+Shift, W, togglefloating"
          "$mod+Shift, F, fullscreen"
          "$mod, T, exec, kitty"
          "$mod, C, exec, librewolf"
          "$mod, Q, killactive"
          "$mod, Super_L, exec, pkill -x rofi || rofi -show run"
          '', Print, exec, grim -g "$(slurp -d)" - | wl-copy''
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (
            builtins.genList (
              i:
              let
                ws = i + 1;
              in
              [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            ) 9
          )
        );
    };
  };
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
