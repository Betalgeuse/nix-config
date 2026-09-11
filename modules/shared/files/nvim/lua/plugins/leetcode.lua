local function leetcode_action(action)
  local ok, err = pcall(require("leetcode.command")[action])
  if not ok then
    vim.notify(tostring(err), vim.log.levels.ERROR)
  end
end

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
      storage = {
        home = vim.fn.expand("~/Documents/leetcode"),
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
          local config = require("leetcode.config")
          if not config.storage.cache then
            config.setup()
          end
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
      {
        "<leader>lr",
        function()
          leetcode_action("q_run")
        end,
        desc = "Run LeetCode tests",
      },
      {
        "<leader>ls",
        function()
          leetcode_action("q_submit")
        end,
        desc = "Submit LeetCode solution",
      },
    },
  },
}
