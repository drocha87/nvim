return {
	"rebelot/kanagawa.nvim",
	-- "folke/tokyonight.nvim",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		require("kanagawa").setup({
			commentStyle = { italic = true },
			transparent = false,
			terminalColors = true,
			theme = "wave",
			background = { -- map the value of 'background' option to a theme
				dark = "wave", -- try "dragon" !
				light = "lotus",
			},
		})
		-- load the colorscheme here
		-- vim.cmd([[colorscheme tokyonight]])
		vim.opt.background = "light"
		vim.cmd([[colorscheme kanagawa]])
	end,
}
