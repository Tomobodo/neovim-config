return {
	"neovim/nvim-lspconfig",
	event = "VeryLazy",
	config = function()
		local util = vim.lsp.util
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- CMAKE
		vim.lsp.config.cmake = {
			capabilities = capabilities,
			filetypes = {
				"cmake",
			},
			init_options = {
				buildDirectory = "build",
			},
			root_markers = { "CMakeLists.txt", "CMakePresets.json", "CTestConfig.cmake", "build", "cmake" },
			single_file_support = true,
			cmd = { "cmake-language-server" },
		}

		vim.lsp.enable({ "cmake" })

		-- C / CPP
		vim.lsp.clangd = {
			capabilities = capabilities,
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
				"--query-driver=/usr/bin/clang++-21,/usr/bin/g++,/usr/bin/c++",
			},
		}

		vim.lsp.enable({ "clangd" })

		-- Rust
		vim.lsp.config.rust_analyzer = {
			settings = {
				["rust-analyzer"] = {
					diagnostics = {
						enable = false,
					},
				},
			},
		}

		vim.lsp.enable({ "rust_analyzer" })

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
			on_attach = function(client, bufnr)
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					command = "EslintFixAll",
				})
			end,
		}

		vim.lsp.enable({ "esling" })

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
