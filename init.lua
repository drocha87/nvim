vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 30
vim.opt.showmode = false
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.clipboard = "unnamedplus"
vim.opt.spelllang = { "en", "pt", "es" }

-- Highlight on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "VonHeikemen/lsp-zero.nvim",        branch = "dev-v3" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },

	-- LSP Support
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
		},
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "L3MON4D3/LuaSnip" },
		},
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	{
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("telescope").load_extension("lazygit")
			vim.keymap.set("n", "<leader>g", "<cmd>:LazyGit<cr>", {})
		end,
	},

	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	"tpope/vim-surround",

	{
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
	},

	{
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
	},

	{
		"rebelot/kanagawa.nvim",
		-- "folke/tokyonight.nvim",
		lazy = false,  -- make sure we load this during startup if it is your main colorscheme
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
	},
})

local lsp = require("lsp-zero").preset({})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
end)

require("mason").setup({})
require("mason-lspconfig").setup({
	-- Replace the language servers listed here
	-- with the ones you want to install
	ensure_installed = { "tsserver", "clangd" },
	handlers = { lsp.default_setup },
	-- config = {
	-- 	clangd = {
	-- 		language_version = "c++20",
	-- 	},
	-- },
})

require("lsp-zero").extend_cmp()
local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()

cmp.setup({
	preselect = "item",
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	},
	mapping = {
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<Tab>"] = cmp_action.tab_complete(),
		["<S-Tab>"] = cmp_action.select_prev_or_fallback(),
	},
})

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.code_actions.gomodifytags,
		null_ls.builtins.formatting.gofmt,
		null_ls.builtins.formatting.goimports,

		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.formatting.stylua,
		-- null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.formatting.prettier.with({
			extra_filetypes = { "svelte", "toml", "html", "mjml" },
		}),
		null_ls.builtins.completion.spell,
	},

	-- you can reuse a shared lspconfig on_attach callback here
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					-- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
					vim.lsp.buf.format({ bufnr = bufnr, async = false })
				end,
			})
		end
	end,
})

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		-- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		-- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		-- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		-- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		-- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
		-- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
		-- vim.keymap.set("n", "<space>wl", function()
		-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		-- end, opts)
		-- vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
		-- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		-- vim.keymap.set("n", "<space>f", function()
		-- 	vim.lsp.buf.format({ async = true })
		-- end, opts)
	end,
})

vim.keymap.set("n", "<leader>l", "<cmd>:Lazy<cr>", {})
vim.keymap.set("n", "<F12>", "<cmd>:silent! set spell!<cr>", {})

-- Treat .mjml files as HTML
vim.cmd([[
  au BufRead,BufNewFile *.mjml set filetype=html
]])
