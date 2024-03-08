{ pkgs, ... }:

{
  home.packages = with pkgs; [ git-crypt git-lfs ];

  programs.git = {
    enable = true;
    aliases = {
      co = "checkout";
      st = "status";
      ls = "ls-files";
      lola = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
    };
    includes = [
      {
        condition = "gitdir:~/dev/github/";
        contents = {
          user = {
            name = "Alexandre Leroux";
            email = "8794280+nleof@users.noreply.github.com";
            signingkey = "~/.ssh/nleof";
          };
        };
      }
      {
        condition = "gitdir:~/dev/360/";
        contents = {
          user = {
            name = "Alexandre Leroux";
            email = "alexandre.leroux@360learning.com";
            signingkey = "~/.ssh/360learning";
          };
        };
      }
      {
        condition = "gitdir:~/dev/personal/";
        contents = {
          user = {
            name = "Alexandre Leroux";
            email = "alexandre@yawp.fr";
            signingkey = "~/.ssh/nleof";
          };
        };
      }
    ];
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "vi";
      commit.gpgsign = true;
      gpg.format = "ssh";
      branch = {
        autoSetupMerge = true;
        autoSetupRebase = "always";
      };
      pull.rebase = true;
      push.autoSetupRemote = true;
      url."ssh://git@github.com/nleof".insteadOf = "https://github.com/nleof";
      url."ssh://git@github.com/360Learning".insteadOf =
        "https://github.com/360Learning";
      url."ssh://git@gitlab.com/nleof".insteadOf = "https://gitlab.com/nleof";
    };
  };
}
