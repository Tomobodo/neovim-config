require("config.lazy")
require("config.keymap")

-- shell
vim.opt.shell = "zsh"
vim.opt.shellcmdflag = "-c"
-- vim.opt.shellslash = true

-- swap
vim.opt.swapfile = false

-- search
vim.opt.wildignore = "*/node_modules/*"

-- fold
vim.o.foldcolumn = '0'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- tabs
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

-- rendering
vim.opt.termguicolors = true

-- clipboard
vim.opt.clipboard = "unnamedplus"

-- diagnostic
vim.opt.signcolumn = "yes"
vim.diagnostic.config({
  signs = true,
  update_in_insert = true,
})
