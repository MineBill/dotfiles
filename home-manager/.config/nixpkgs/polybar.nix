# vim:ft=nix
# vim:sw=2
{config, pkgs, ...}:
{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      githubSupport = true;
      mpdSupport = true;
      pulseSupport = true;
    };
    settings = {
      "bar/main" = {
        monitor = "$\{env:MONITOR:HDMI-0\}";
        width = "100%";
        height = 25;
        fixed-center = true;
        bottom = true;
        wm-restack = "bspwm";
        enable-ipc = true;
        cursor-click = "pointer";
        cursor-scroll = "ns-resize";
        modules-left = "bspwm";
        modules-center = "mpd";
        modules-right = "filesystem pulseaudio xkeyboard cpu eth date";
        font = [
          "\"Noto Sans Mono:size=10;2\""
        ];
        background = "#aa010101";
        margin.top = 0;
        margin.bottom = 0;
        line.size = 2;
        line.color = "#f00";
        module.margin.left = 0;
        module.margin.right = 1;
        tray = {
          position = "right";
          padding = 2;
          background = "#010101";
        };
      };
      "module/cpu" = {
        type = "internal/cpu";
        interval = 2;
        label = "[CPU:%percentage:2%]";
      };
      "module/xkeyboard" = {
        type = "internal/xkeyboard";
        blacklist-0 = "num lock";
      };
      "module/filesystem" = {
        type = "internal/fs";
        interval = 25;
        mount-0  = "/";
        label-mounted = "[%{F#0a81f5}%mountpoint%%{F-}: %percentage_used%%]";
        label-unmounted = "%mountpoint% not mainted";
      };
      "module/bspwm" = {
        type = "internal/bspwm";
        label-focused = {
          text = "%index%";
          underline = "#bb2222";
          padding = 1;
        };
        label-occupied = {
          text = "%index%";
          padding = 1;
        };
        label-urgent = {
          text = "%index%!";
          background = "#bb2222";
          padding = 1;
        };
        label-empty = {
          text = "%index%";
          foreground = "#222222";
          padding = 1;
        };
        label-seperator = "|";
      };
      "module/mpd" = {
        type = "internal/mpd";
        format = "<label-song>  <icon-prev> <icon-stop> <toggle> <icon-next>";
        icon-prev = "PR";
        icon-stop = "S";
        icon-play = "PL";
        icon-pause = "PA";
        icon-next = "N";
      };
      "module/eth" = {
        type = "internal/network";
        interface = "enp5s0";
        interval = 3.0;
        format-connected = {
          underline = "#55aa55";
        };
        label.connected = {
          text = "[IP:%local_ip%]";
        };
        format-disconnected = {
          text = "DISCONNECTED";
          foreground = "#dd2222";
        };
      };
      "module/date" = {
        type = "internal/date";
        internal = 5;
        date = "%Y-%m-%d";
        time = "%H:%M";
        label = "%date%  %time%";
      };
      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        format-volume = "[VOL:%percentage%]";
        lable-muted = "MUTED";
      };
    };
    script = "polybar main &";
  };

}
