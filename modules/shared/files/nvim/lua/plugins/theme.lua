return {
  {
    "catppuccin/nvim",
    opts = {
      transparent_background = true,
    },
  },
  {
    "xero/evangelion.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("evangelion").setup({ transparent = true })
      vim.cmd.colorscheme("evangelion")
    end,
  },
}
