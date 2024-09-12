require("config.lazy")
require("config.keymap")

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
