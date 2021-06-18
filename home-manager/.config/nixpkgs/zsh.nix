# vim:ft=nix
# vim:sw=2
{congig, pkgs, ...}:
{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    localVariables = {
      ZVM_VI_INSERT_ESCAPE_BINDKEY = "fd";
      ZVM_READKEY_ENGINE = "\${ZVM_READKEY_ENGINE_ZLE}";
      ZVM_CURSOR_STYLE_ENABLED = false;
    };
    shellGlobalAliases = {
      homebuild = "home-manager switch";
      systembuild = "sudo nixos-rebuild -I nixos-config=~/.dotfiles/nixos/configuration.nix";
    };
    plugins = [
    {
      name = "zsh-vi-mode";
      src = pkgs.fetchFromGitHub {
        owner = "jeffreytse";
        repo = "zsh-vi-mode";
        rev = "v0.8.4";
        sha256 = "0a1rvc03rl66v8rgzvxpq0vw55hxn5b9dkmhdqghvi2f4dvi8fzx";
      };
    }
    ];
    enableAutosuggestions = true;
    enableCompletion = true;
  };
}
