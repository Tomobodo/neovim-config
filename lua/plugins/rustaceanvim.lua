return {
	{
		"mrcjkb/rustaceanvim",
		verion = "^5",
		lazy = false,
		config = function()
			local executors = require("rustaceanvim.executors")
			vim.g.rustaceanvim = {
				tools = {
					executor = executors.toggleterm,
				},
				terminal = {
					direction = "horizontal",
				},
				server = {
					on_attach = function(client, bufnr)
						-- keymap
						vim.keymap.set("n", "<c-r>", function()
							vim.cmd("wa")
							vim.cmd.RustLsp("run")
						end, { noremap = true, desc = "Run rust target" })
						vim.keymap.set("n", "<c-d>", function()
							vim.cmd("wa")
							vim.cmd.RustLsp("debug")
						end, { noremap = true, desc = "Debug rust target" })
						vim.keymap.set("n", "<c-b>", function()
							vim.cmd("wa")
							vim.cmd.RustLsp("flyCheck")
						end, { noremap = true, desc = "Build" })
					end,
				},
			}
		end,
	},
}
