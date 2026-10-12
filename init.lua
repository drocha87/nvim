vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.termguicolors = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.smartindent = true
vim.o.breakindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.undofile = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"
vim.o.updatetime = 250
vim.o.timeoutlen = 500
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
-- Faster completion
vim.o.completeopt = "menu,menuone,noselect"
vim.cmd("set path+=**")
vim.o.wildmenu = true

vim.g.mapleader = ' '
vim.keymap.set('n', '<esc><esc>', '<cmd>nohlsearch<cr>')

vim.cmd.colorscheme = "slate"

require("pickers")
require("tsitter")
require("lsp")

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function()
    vim.keymap.set('n', 'q', '<cmd>cclose<CR>', {
      buffer = true,
      silent = true,
    })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lf',
  callback = function()
    vim.keymap.set('n', 'q', '<cmd>lclose<CR>', {
      buffer = true,
      silent = true,
    })
  end,
})

vim.keymap.set('c', '<down>', function()
  if vim.fn.pumvisible() == 1 then return '<c-n>' end
  return '<down>'
end, { expr = true })

vim.keymap.set('c', '<up>', function()
  if vim.fn.pumvisible() == 1 then return '<c-p>' end
  return '<up>'
end, { expr = true })
