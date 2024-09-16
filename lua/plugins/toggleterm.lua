return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
		size = 16,
		shade_terminals = true,
		start_in_insert = true,
		auto_scroll = true,
		shell = vim.o.shell,
		winbar = {
			enabled = false,
			name_formatter = function(term)
				return term.name
			end,
		},
		float_opts = {
			width = function()
				return math.min(vim.o.columns, math.max(80, math.ceil(vim.o.columns * 0.5)))
			end,
			height = function()
				return math.min(vim.o.lines, math.max(10, math.ceil(vim.o.lines * 0.33)))
			end,
		},
	},
}
