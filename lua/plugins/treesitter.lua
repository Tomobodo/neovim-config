return {
  'nvim-treesitter/nvim-treesitter',
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensute_installed = { "c", "lua", "vim", "vimdoc", "javascript", "typescript", "rust", "html", "jsx", "tsx", "c++" },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true }
    })
  end
}
