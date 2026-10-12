-- apt install tree-sitter-cli
vim.pack.add({
  'https://github.com/nvim-treesitter/nvim-treesitter',
})

tsitter = require('nvim-treesitter')
tsitter.setup {
  install_dir = vim.fn.stdpath('data') .. '/site'
}
tsitter.install {
  'go',
  'javascript',
  'typescript',
  'svelte',
  'astro',
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'svelte' },
  callback = function() vim.treesitter.start() end,
})
