return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },

	config = function()
		local lualine = require("lualine")
		lualine.setup({
			options = {
				icons_enabled = true,
				theme = "catppuccin-mocha",
				always_divide_middle = true,
				-- globalstatus = true,
				section_separators = {
					left = "",
					right = "",
				},
				-- component_separators = {
				-- 	left = "",
				-- 	right = "",
				-- },
				disabled_filetupes = {
					statusline = {},
					winbar = {},
					NvimTree = {},
				},
			},
			extensions = {
				"nvim-tree",
				"lazy",
				"fzf",
				"mason",
				"nvim-dap-ui",
				"toggleterm",
			},
		})
	end,
}
