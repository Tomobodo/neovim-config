return {
	"mhartington/formatter.nvim",
	event = "VeryLazy",
	config = function()
		local util = require("formatter.util")
		local default = require("formatter.defaults")

		require("formatter").setup({
			logging = true,
			log_level = vim.log.levels.WARN,
			filetype = {
				asm = {
					require("formatter.filetypes.asm").asmfmt,
				},
				lua = {
					require("formatter.filetypes.lua").stylua,
				},
				-- cmake = {
				-- 	require("formatter.filetypes.cmake").cmakeformat,
				-- },
				c = {
					require("formatter.filetypes.c").clangformat,
				},
				cpp = {
					require("formatter.filetypes.cpp").clangformat,
				},
				rust = {
					require("formatter.filetypes.rust").rustfmt,
				},
				sh = {
					require("formatter.filetypes.sh").shfmt,
				},
				-- web
				json = {
					require("formatter.filetypes.json").prettier,
				},
				html = {
					require("formatter.filetypes.html").prettier,
				},
				css = {
					require("formatter.filetypes.css").prettier,
				},
				scss = {
					util.withl(default.prettier, "scss"),
				},
				javascriptreact = {
					require("formatter.filetypes.javascriptreact").prettier,
				},
				javascript = {
					require("formatter.filetypes.javascript").prettier,
				},
				typescriptreact = {
					require("formatter.filetypes.typescriptreact").prettier,
				},
				typescript = {
					require("formatter.filetypes.typescript").prettier,
				},
				php = {
					require("formatter.filetypes.php").phpcbf,
				},
				-- any
				["*"] = {
					require("formatter.filetypes.any").remove_trailing_whitespace,
				},
			},
		})
	end,
}
