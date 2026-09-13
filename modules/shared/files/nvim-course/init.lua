vim.opt.loadplugins = false
vim.opt.exrc = false
vim.opt.modeline = false

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.completefunc = ""
vim.opt.omnifunc = ""
vim.opt.thesaurusfunc = ""
vim.opt.dictionary = ""

vim.keymap.set("i", "<C-n>", "<Nop>")
vim.keymap.set("i", "<C-p>", "<Nop>")
vim.keymap.set("i", "<C-x>", "<Nop>")
vim.keymap.set("i", "<C-Space>", "<Nop>")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.scrolloff = 5
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.mouse = ""
vim.opt.makeprg = "make"

vim.cmd("syntax enable")
vim.cmd("filetype indent on")
vim.cmd.colorscheme("habamax")

vim.opt.statusline = " COURSE | %f %m %= %l:%c "

vim.api.nvim_create_user_command("CourseCheck", function()
	local ai_commands = vim.tbl_filter(function(name)
		return name:match("^Prt") or name:match("^Claude") or name:match("^Copilot")
	end, vim.tbl_keys(vim.api.nvim_get_commands({})))

	local checks = {
		{ "plugins", not vim.o.loadplugins },
		{ "completion functions", vim.o.completefunc == "" and vim.o.omnifunc == "" },
		{ "AI commands", #ai_commands == 0 },
		{ "Ctrl-N completion", vim.fn.maparg("<C-n>", "i") == "<Nop>" },
		{ "Ctrl-P completion", vim.fn.maparg("<C-p>", "i") == "<Nop>" },
		{ "Ctrl-X completion", vim.fn.maparg("<C-x>", "i") == "<Nop>" },
	}

	for _, check in ipairs(checks) do
		print((check[2] and "PASS" or "FAIL") .. " | " .. check[1])
	end
end, {})

vim.schedule(function()
	vim.notify("COURSE MODE: plugins, AI, and completion are disabled")
end)
