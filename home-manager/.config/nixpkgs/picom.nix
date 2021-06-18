# vim:ft=nix
# vim:sw=2
{config, pkgs, ...}:
{
  services.picom = {
    enable = true;
    blur = true;
    refreshRate = 144;
    backend = "glx";
    vSync = true;
    experimentalBackends = true;
    extraOptions = ''
      blur:
      {
        method = "box";
        size = 10;
        strength = 20;
      }
    '';
  };
}
