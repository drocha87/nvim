return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.1",
	-- or                              , branch = '0.1.1',
	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		require("telescope").setup({
			pickers = {
				buffers = {
					ignore_current_buffer = true,
					sort_mru = true,
				},
			},
		})
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, {})
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
	end,
}
