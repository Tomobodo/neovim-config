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
							local editor_width = vim.o.columns
							local editor_height = vim.o.lines
							local min_width = 60
							local min_height = 20

							local width = math.max(min_width, math.floor(editor_width * 0.3))
							local height = math.max(min_height, math.floor(editor_height * 0.4))

							return {
								relative = "editor",
								border = "rounded",
								width = width,
								height = height,
								row = math.floor((editor_height - height) / 2),
								col = math.floor((editor_width - width) / 2),
							}
						end,
					},
				},
			})
		end,
	},
}
