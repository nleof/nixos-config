{
  imports = [
    ./tty/fish.nix
    ./tty/starship.nix
    ./tty/git.nix
    ./tty/direnv.nix
    ./tty/zellij.nix
    ./tty/ssh.nix

    ./editors/emacs.nix
    ./editors/vim.nix

    ./dev/azure.nix
    ./dev/shell.nix
    ./dev/kubernetes.nix
    ./dev/nix.nix

    ./media/vlc.nix
    ./media/mpc.nix
    ./media/spotify.nix
    ./media/steam.nix
    ./media/signal.nix

    ./browsers/firefox.nix
    ./browsers/chromium.nix

    ./desktops/gnome.nix
    ./desktops/sway.nix
  ];
}