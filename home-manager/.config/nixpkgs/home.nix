# vim:ft=nix
# vim:sw=2
{ config, pkgs, ... }:
{
  imports = [
    ./polybar.nix
    ./alacritty.nix
    ./zsh.nix
    ./autorandr.nix
  ];
# Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  home.username = "minebill";
  home.homeDirectory = "/home/${config.home.username}";
  home.sessionPath = [
    "/home/${config.home.username}/.local/bin"
  ];

  # Enable installed fonts
  fonts.fontconfig.enable = true;
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
             url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
             }))
  ];

  home.packages = with pkgs; [
    htop neovim-nightly rofi
    noto-fonts zsh discord steam
    nerdfonts gimp sweet
  ];

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
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
