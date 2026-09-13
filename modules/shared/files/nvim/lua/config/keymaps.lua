-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local map = vim.keymap.set

-- ESLint fix keymap
map("n", "<leader>ce", "<cmd>EslintFixAll<cr>", { desc = "ESLint Fix All" })
map("n", "<leader>gl", function()
  Snacks.lazygit.log()
end, { desc = "Lazygit (git log)" })
map("n", "<leader>gL", function()
  Snacks.lazygit.log_file()
end, { desc = "Lazygit (git log file)" })

map("n", "<S-tab>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<C-tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })

map("n", "gb", "<cmd>BufferLinePick<cr>", { desc = "Buffer Pick" })
map("n", "gB", "<cmd>BufferLinePickClose<cr>", { desc = "Buffer Pick Close" })

map("n", "<leader>tc", "<cmd>CourseMode<cr>", { desc = "Disable completion for coursework" })

map("n", "<F5>", function()
  if vim.bo.filetype ~= "c" then
    vim.notify("F5: open a C file first", vim.log.levels.INFO)
    return
  end
  vim.cmd.write()
  local output = vim.fn.tempname()
  local source = vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
  local executable = vim.fn.shellescape(output)
  local command = "cc -std=c99 -Wall -Wextra -Werror -pedantic -g "
    .. source
    .. " -o "
    .. executable
    .. " && "
    .. executable
  vim.cmd("botright 12new")
  vim.fn.termopen({ "/bin/sh", "-c", command }, {
    on_exit = function()
      vim.fn.delete(output)
    end,
  })
end, { desc = "Compile and run C file" })
