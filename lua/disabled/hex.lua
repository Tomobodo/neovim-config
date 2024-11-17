return {
	"ArcaneSpecs/HexEditor.nvim",
	event = "VeryLazy",
	config = function()
		require("HexEditor").setup()
	end,
}
