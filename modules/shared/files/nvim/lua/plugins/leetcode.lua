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
      theme = {
        normal = { fg = "#c8bfd8" },
      },
    },
    keys = {
      { "<leader>ll", "<cmd>Leet<cr>", desc = "LeetCode" },
      {
        "<leader>li",
        function()
          local session = vim.fn.inputsecret("LEETCODE_SESSION: ")
          if session == "" then
            return
          end
          local csrf = vim.fn.inputsecret("csrftoken: ")
          if csrf == "" then
            return
          end
          local value = ("LEETCODE_SESSION=%s; csrftoken=%s;"):format(session, csrf)
          local err = require("leetcode.cache.cookie").set(value)
          vim.notify(err and ("LeetCode login failed: " .. err) or "LeetCode login successful")
        end,
        desc = "Log in to LeetCode",
      },
      { "<leader>lr", "<cmd>Leet run<cr>", desc = "Run LeetCode tests" },
      { "<leader>ls", "<cmd>Leet submit<cr>", desc = "Submit LeetCode solution" },
    },
  },
}
