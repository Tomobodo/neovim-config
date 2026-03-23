return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"c",
			"cpp",
			"cmake",
			"lua",
			"vim",
			"vimdoc",
			"javascript",
			"typescript",
			"rust",
			"html",
			"php",
		},
		sync_install = false,
		highlight = { enable = true },
		indent = { enable = true },
	},
}
