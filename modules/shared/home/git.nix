{pkgs, ...}: {
  home.packages = with pkgs; [
    git-worktree-runner
  ];

  programs.lazygit = {
    enable = true;
    
    settings = {
      disableStartupPopups = true;
      os = {
        editPreset = "nvim";
        editInTerminal = true;
        edit = "if [ -n \"$NVIM\" ]; then nvim --server $NVIM --remote-send '<C-\\><C-n><cmd>close<cr>' && nvim --server $NVIM --remote {{filename}}; else nvim {{filename}}; fi";
      };
      git = {
        overrideGpg = true;
      };
    };
  };
}
