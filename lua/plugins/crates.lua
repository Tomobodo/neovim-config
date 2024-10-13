return {
	"saecki/crates.nvim",
	tag = "stable",
	event = "VeryLazy",
	config = function()
		require("crates").setup()
	end,
}
