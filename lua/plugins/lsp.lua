return {
	"neovim/nvim-lspconfig",
	event = "VeryLazy",
	config = function()
		local lspconfig = require("lspconfig")
		local util = lspconfig.util
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- CMAKE
		lspconfig.cmake.setup({
			capabilities = capabilities,
			filetypes = {
				"cmake",
			},
			init_options = {
				buildDirectory = "build",
			},
			root_dir = util.root_pattern("CMakePresets.json", "CTestConfig.cmake", "build", "cmake"),
			single_file_support = true,
			cmd = { "cmake-language-server" },
		})

		-- C / CPP
		lspconfig.clangd.setup({
			capabilities = capabilities,
			root_dir = util.root_pattern(
				".clangd",
				".clang-tidy",
				".clang-format",
				"compile_commands.json",
				"CMakeLists.txt"
			),
			single_file_support = true,
			cmd = { "clangd" },
		})

		-- Lua
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			on_init = function(client)
				local path = client.workspace_folders[1].name
				if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
					return
				end

				client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
					runtime = {
						version = "LuaJIT",
					},
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
						},
					},
				})
			end,
			settings = {
				Lua = {},
			},
		})

		-- Typescript
		lspconfig.ts_ls.setup({
			capabilities = capabilities,
		})

		lspconfig.eslint.setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					command = "EslintFixAll",
				})
			end,
		})

		-- CSS, SCSS
		lspconfig.cssls.setup({
			capabilities = capabilities,
		})

		-- JSON
		lspconfig.jsonls.setup({
			capabilities = capabilities,
		})

		-- PHP
		lspconfig.phpactor.setup({
			capabilities = capabilities,
		})
	end,
}
