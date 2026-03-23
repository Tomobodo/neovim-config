return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({
				filters = {
					dotfiles = false,
					git_ignored = false,
				},
				view = {
					side = "left",
					preserve_window_proportions = true,
					width = 45,
					float = {
						enable = true,
						quit_on_focus_loss = true,
						open_win_config = function()
							return {
								relative = "editor",
								border = "rounded",
								width = 45,
								height = vim.o.lines - 3,
								row = 0,
								col = 0,
							}
						end,
					},
				},
			})
		end,
	},
}
