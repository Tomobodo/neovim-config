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

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- lsp
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufopts = { noremap = true, silent = true }
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client.supports_method('textDocument/rename') then
      vim.keymap.set('n', '<leader>rr', vim.lsp.buf.rename, bufopts)
    end

    if client.supports_method('textDocument/declaration') then
      vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, bufopts)
    end

    if client.supports_method('textDocument/definition') then
      vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, bufopts)
    end

    if client.supports_method('textdocument/hover') then
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    end

    if client.supports_method('textdocument/signature_help') then
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    end

    if client.supports_method('textDocument/implementation') then
      vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, bufopts)
    end

    if client.supports_method('textDocument/code_action') then
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    end

    if client.supports_method('textDocument/references') then
      vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, bufopts)
    end

    if client.supports_method('textDocument/format') then
      vim.keymap.set('n', '<leader>rf', vim.lsp.buf.format, bufopts)
    end
  end
})
