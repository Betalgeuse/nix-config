-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function is_system_programming_file()
  local file = vim.api.nvim_buf_get_name(0)
  return file:find("/System programming/", 1, true) ~= nil
end

local function set_completion(enabled)
  if enabled then
    vim.b.completion = nil
  else
    vim.b.completion = false
  end
  pcall(function()
    require("blink.cmp").hide()
  end)
  vim.notify("Completion: " .. (enabled and "ON" or "OFF"))
end

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    if is_system_programming_file() then
      vim.b.completion = false
    end
  end,
})

vim.api.nvim_create_user_command("CourseMode", function(opts)
  if opts.bang and is_system_programming_file() then
    vim.notify("Completion stays OFF for system programming files", vim.log.levels.WARN)
    return
  end
  set_completion(opts.bang)
end, { bang = true })
