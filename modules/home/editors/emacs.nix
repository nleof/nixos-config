{ pkgs, ... }:

{
  home.file.".config/doom/".source = ../../../config/doom;

  home.file.".config/doom/".onChange = ''
    if [[ ! -f "$HOME/.config/emacs/bin/doom" ]]
    then
      git clone --depth 1 https://github.com/doomemacs/doomemacs $HOME/.config/emacs
    fi
    $HOME/.config/emacs/bin/doom sync -u
  '';

  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
    extraPackages = epkgs:
      with epkgs; [
        vterm
        all-the-icons-nerd-fonts
        pdf-tools
      ];
  };
}
