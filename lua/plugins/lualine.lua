return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		local lualine = require("lualine")
		lualine.setup({
			options = {
				icons_enabled = true,
				theme = "catppuccin",
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
