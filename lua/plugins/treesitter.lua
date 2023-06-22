return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require("nvim-treesitter.configs").setup({
			highlight = {
				enable = true,
			},
			ensure_installed = {
				"javascript",
				"typescript",
				"svelte",
				"css",
				"json",
				"lua",
			},
		})
	end,
}
