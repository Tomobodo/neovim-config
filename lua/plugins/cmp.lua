return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
	},
	event = "VeryLazy",
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		local function split_params(s)
			local params = {}
			local depth = 0
			local current = ""
			for i = 1, #s do
				local c = s:sub(i, i)
				if c == "<" or c == "(" then
					depth = depth + 1
					current = current .. c
				elseif c == ">" or c == ")" then
					depth = depth - 1
					current = current .. c
				elseif c == "," and depth == 0 then
					table.insert(params, vim.trim(current))
					current = ""
				else
					current = current .. c
				end
			end
			if vim.trim(current) ~= "" then
				table.insert(params, vim.trim(current))
			end
			return params
		end

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			window = {},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer" },
			}),
		})

		cmp.event:on("confirm_done", function(event)
			local item = event.entry:get_completion_item()
			if (item.insertTextFormat == 1 or item.insertTextFormat == nil)
				and item.labelDetails
				and item.labelDetails.detail then
				local detail = item.labelDetails.detail
				local inner = detail:match("^%((.+)%)$")
				if inner then
					local params = split_params(inner)
					local parts = {}
					for i, param in ipairs(params) do
						table.insert(parts, "${" .. i .. ":" .. param .. "}")
					end
					luasnip.lsp_expand("(" .. table.concat(parts, ", ") .. ")")
				end
			end
		end)

		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
			matching = { disallow_symbol_nonprefix_matching = false },
		})
	end,
}
