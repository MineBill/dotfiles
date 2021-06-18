# vim:ft=nix
# vim:sw=2
{config, pkgs, ...}:
{
  programs.alacritty = {
    enable = true;
    settings = {
      font.size = 14;
      font.normal.family = "Caskaydia Cove Nerd Font";
      background_opacity = 0.9;
    };
  };
}
