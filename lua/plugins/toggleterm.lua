return {
  'akinsho/toggleterm.nvim',
  version = "*",
  opts = {
    size = 16,
    shade_terminals = true,
    start_in_insert = true,
    auto_scroll = true,
    winbar = {
      enabled = false,
      name_formatter = function(term)
        return term.name
      end
    }
  },
}
