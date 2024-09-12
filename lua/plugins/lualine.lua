local catppuccin_mocha = {
  bg       = "#1E1E2E",
  fg       = "#CDD6F4",
  yellow   = "#F9E2AF",
  cyan     = "#7fdbca",
  darkblue = "#89B4FA",
  green    = "#A6E3A1",
  orange   = "#e3d18a",
  violet   = "#a9a1e1",
  magenta  = "#ae81ff",
  blue     = "#89B4FA",
  red      = "#F38BA8",
}

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      options = {
        theme = "catppuccin",
        globalstatus = true,
        -- disabled_filetypes = { 'NvimTree' }
      }
    })
  end
}
