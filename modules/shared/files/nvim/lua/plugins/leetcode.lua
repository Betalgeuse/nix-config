return {
  {
    "kawre/leetcode.nvim",
    cmd = "Leet",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      lang = "c",
      plugins = {
        non_standalone = true,
      },
      picker = {
        provider = "fzf-lua",
      },
    },
    keys = {
      { "<leader>ll", "<cmd>Leet<cr>", desc = "LeetCode" },
      { "<leader>lr", "<cmd>Leet run<cr>", desc = "Run LeetCode tests" },
      { "<leader>ls", "<cmd>Leet submit<cr>", desc = "Submit LeetCode solution" },
    },
  },
}
