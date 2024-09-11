-- buffers
vim.keymap.set('n', '<tab>', '<Cmd>bnext<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '<s-tab>', '<Cmd>bprev<cr>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<c-x>', '<Cmd>bdelete!<cr>', { desc = 'Delete buffer' })

-- toggleterm
vim.keymap.set('n', '<leader>h', '<Cmd>ToggleTerm<cr>', { noremap = true, desc = 'Open terminal' })
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
