# vim:ft=nix
# vim:sw=2
{ config, pkgs, ... }:

{
# Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

# Home Manager needs a bit of information about you and the
# paths it should manage.
  home.username = "minebill";
  home.homeDirectory = "/home/minebill";

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
             url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
             }))
  ];

  home.packages = with pkgs; [
    htop neovim-nightly rofi
    noto-fonts zsh
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      font.size = 14;
      font.normal.family = "Noto Sans Mono";
    };
  };

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

  programs.autorandr = {
    enable = true;
    profiles = {
      "home" = {
        fingerprint = {
          HDMI-0 = "00ffffffffffff004c2d900f37345743261d010380351e782a2fada4544799260f474abfef8081c0810081809500a9c0b300714f0101023a801871382d40582c450014302100001e000000fd0030901eaa23000a202020202020000000fc004c433234524735300a20202020000000ff0048345a4d3930353534310a2020018902032ef14890403f1f04130312230907078301000067030c001000803c67d85dc401468000681a00000101309000047480d072382d40102c458014302100001e5a8780a070384d403020350014302100001a011d007251d01e206e28550014302100001e0474801871382d40582c450014302100001e00000000000000000063";
        };
        config = {
          "HDMI-0" = {
            enable = true;
            primary = true;
            mode = "1920x1080";
            rate = "143.98";
          };
        };
      };
    };
  };

# This value determines the Home Manager release that your
# configuration is compatible with. This helps avoid breakage
# when a new Home Manager release introduces backwards
# incompatible changes.
#
# You can update Home Manager without changing this value. See
# the Home Manager release notes for a list of state version
# changes in each release.
  home.stateVersion = "21.05";
}
