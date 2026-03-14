{ pkgs, ... }:
let
  aiScript = pkgs.writeShellScript "lg-ai" ''
    ACTION="$1"
    case "$ACTION" in
      commit)
        PROMPT="You are in a git repository. Stage all changes, review the diff, write a conventional commit message, and commit. Just execute the commands."
        ;;
      multi)
        PROMPT="You are in a git repository. Review all changes. Group them into logical atomic commits. For each group: stage the relevant files, write a conventional commit message, and commit. Just execute the commands."
        ;;
      push)
        PROMPT="You are in a git repository. Stage all changes, review the diff, write a conventional commit message, commit, and push. Just execute the commands."
        ;;
      pr)
        PROMPT="You are in a git repository. Stage all changes, review the diff, write a conventional commit message, commit, push, and create a GitHub PR with 'gh pr create' using a descriptive title and body. Just execute the commands."
        ;;
      *)
        terminal-notifier -title "lazygit" -message "unknown action: $ACTION" -sound Basso
        exit 1
        ;;
    esac
    if claude -p "$PROMPT" --allowedTools "Bash" > "/tmp/lg-ai-$ACTION.log" 2>&1; then
      terminal-notifier -title "lazygit" -message "ai $ACTION done" -sound Blow
    else
      terminal-notifier -title "lazygit" -message "ai $ACTION failed" -sound Basso
    fi
  '';
in
{
  home.packages = with pkgs; [
    git-worktree-runner
  ];

  catppuccin.lazygit.enable = true;
  catppuccin.delta.enable = true;

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      dark = true;
      side-by-side = true;
      line-numbers = true;
      syntax-highlighting = true;
      navigate = true;
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      disableStartupPopups = true;
      promptToReturnFromSubprocess = false;
      os = {
        editPreset = "nvim";
        editInTerminal = true;
        edit = "if test -n \"$NVIM\"; nvim --server $NVIM --remote-send '<C-\\><C-n><cmd>close<cr>' && nvim --server $NVIM --remote {{filename}}; else; nvim {{filename}}; end";
      };
      git = {
        overrideGpg = true;
        pagers = [
          { pager = "delta --dark --paging=never"; }
        ];
      };
      customCommands = [
        {
          key = "C";
          description = "AI git actions";
          command = "nohup ${aiScript} '{{.Form.Action}}' > /dev/null 2>&1 &";
          context = "files";
          prompts = [
            {
              type = "menu";
              title = "AI Action";
              key = "Action";
              options = [
                {
                  name = "Auto commit";
                  description = "Stage all, commit";
                  value = "commit";
                }
                {
                  name = "Auto multi-commit";
                  description = "Split into logical commits";
                  value = "multi";
                }
                {
                  name = "Auto commit & push";
                  description = "Stage all, commit, push";
                  value = "push";
                }
                {
                  name = "Auto commit, push & PR";
                  description = "Stage all, commit, push, create PR";
                  value = "pr";
                }
              ];
            }
          ];
        }
      ];
    };
  };
}
