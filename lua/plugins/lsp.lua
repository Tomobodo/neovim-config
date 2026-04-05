return {
	"neovim/nvim-lspconfig",
	event = "VeryLazy",
	config = function()
		local util = vim.lsp.util
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- CMAKE
		vim.lsp.config.neocmake = {
			capabilities = capabilities,
			filetypes = { "cmake" },
			root_markers = { "CMakeLists.txt", "CMakePresets.json", "CTestConfig.cmake", "build", "cmake" },
			single_file_support = true,
			cmd = { "neocmakelsp", "stdio" },
		}

		vim.lsp.enable({ "neocmake" })

		-- C / CPP
		vim.lsp.config.clangd = {
			capabilities = vim.tbl_deep_extend("force", capabilities, {
				textDocument = {
					completion = {
						editsNearCursor = true,
					},
				},
				offsetEncoding = { "utf-8", "utf-16" },
			}),
			on_init = function(client, init_result)
				if init_result.offsetEncoding then
					client.offset_encoding = init_result.offsetEncoding
				end
			end,
			root_markers = {
				".clangd",
				".clang-tidy",
				".clang-format",
				"compile_commands.json",
				"compile_flags.txt",
				"configure.ac",
			},
			filetypes = {
				"c",
				"cpp",
				"cc",
				"mpp",
				"ixx",
			},
			single_file_support = true,
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--clang-tidy-checks=*",
				"--query-driver=/usr/bin/clang++,/usr/bin/g++,/usr/bin/c++",
				"--completion-style=detailed",
				"--cross-file-rename",
				"--header-insertion=iwyu",
				"--all-scopes-completion",
			},
		}

		vim.lsp.enable({ "clangd" })

		-- Lua
		vim.lsp.config.lua_ls = {
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
		}

		vim.lsp.enable({ "lua_ls" })

		-- Typescript
		vim.lsp.config.ts_ls = {
			capabilities = capabilities,
		}

		vim.lsp.enable({ "ts_ls" })

		vim.lsp.config.eslint = {
			capabilities = capabilities,
		}

		vim.lsp.enable({ "eslint" })

		-- CSS, SCSS
		vim.lsp.config.cssls = {
			capabilities = capabilities,
		}

		vim.lsp.enable({ "cssls" })

		-- JSON
		vim.lsp.config.jsonls = {
			capabilities = capabilities,
		}

		vim.lsp.enable({ "jsonls" })

		-- PHP
		vim.lsp.config.phpactor = {
			capabilities = capabilities,
		}

		vim.lsp.enable({ "phpactor" })

		-- ZIG
		vim.lsp.config.zls = {
			capabilities = capabilities,
		}

		vim.lsp.enable({ "zls" })
	end,
}
