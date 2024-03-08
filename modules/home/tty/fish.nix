{ pkgs, ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      l = "ls -alh";
      k = "kubectl";
    };

    interactiveShellInit = ''
      set fish_greeting
      set -g fish_key_bindings fish_hybrid_key_bindings

      if test -z "$SSH_ENV"
          set -xg SSH_ENV $HOME/.ssh/environment
      end
    '';

    functions = {
      fish_hybrid_key_bindings = {
        description =
          "Vi-style bindings that inherit emacs-style bindings in all modes";
        body = ''
          for mode in default insert visual
              fish_default_key_bindings -M $mode
          end
          fish_vi_key_bindings --no-erase
        '';
      };

      __ssh_agent_is_started = {
        description = "check if ssh agent is already started";
        body = ''
          if begin; test -f $SSH_ENV; and test -z "$SSH_AGENT_PID"; end
            source $SSH_ENV > /dev/null
          end

          if begin; test -z "$SSH_AGENT_PID"; and test -z "$SSH_CONNECTION"; end
            return 1
          end

          ssh-add -l > /dev/null 2>&1
          if test $status -eq 2
            return 1
          end
        '';
      };
    };

    plugins = [{
      name = "z";
      src = pkgs.fetchFromGitHub {
        owner = "jethrokuan";
        repo = "z";
        rev = "ddeb28a7b6a1f0ec6dae40c636e5ca4908ad160a";
        sha256 = "0c5i7sdrsp0q3vbziqzdyqn4fmp235ax4mn4zslrswvn8g3fvdyh";
      };
    }];
  };
}
