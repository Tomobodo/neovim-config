return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavor = "catppuccin-mocha",
      transparent_background = true,
      integration = {
        nvimtree = true,
        treesitter = true,
        notify = false,
        mason = true
      }
    })
    vim.cmd.colorscheme "catppuccin-mocha"
  end
}
