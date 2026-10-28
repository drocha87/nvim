local display_diagnostics = false

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    -- if client:supports_method('textDocument/implementation') then
    --   -- Create a keymap for vim.lsp.buf.implementation ...
    -- end

    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    if client:supports_method('textDocument/completion') then
      -- Optional: trigger autocompletion on EVERY keypress. May be slow!
      -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      -- client.server_capabilities.completionProvider.triggerCharacters = chars

      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end

    -- Auto-format ("lint") on save.
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
    local opts = { buffer = ev.buf }
    local mappings = {
      ["gd"] = vim.lsp.buf.definition,
      ["gD"] = vim.lsp.buf.declaration,
      ["gr"] = vim.lsp.buf.references,
      ["gi"] = vim.lsp.buf.implementation,
      ["K"] = vim.lsp.buf.hover,

      ["<leader>rn"] = vim.lsp.buf.rename,
      ["<leader>ca"] = vim.lsp.buf.code_action,
    }

    for key, action in pairs(mappings) do
      vim.keymap.set("n", key, action, opts)
    end

    vim.keymap.set("n", "<f12>", function()
      vim.lsp.buf.format()
    end, opts)

    vim.diagnostic.config({
      virtual_text = display_diagnostics,
      underline = display_diagnostics,
      signs = false,
      severity_sort = true,
    })
    vim.keymap.set("n", "<f8>", function()
      display_diagnostics = not display_diagnostics
      vim.diagnostic.config({
        virtual_text = display_diagnostics,
        underline = display_diagnostics,
      })
    end)
    vim.keymap.set('n', '<leader>D', function()
      vim.diagnostic.setqflist()
      vim.cmd('copen')
    end, { desc = 'Diagnostics to quickfix' })
    vim.keymap.set('n', '<leader>d', function()
      vim.diagnostic.setloclist()
      vim.cmd('lopen')
    end, { desc = 'Diagnostics to location list' })
  end,
})

vim.pack.add {
  { src = 'https://github.com/neovim/nvim-lspconfig' },
}

vim.lsp.enable('lua_ls')

vim.lsp.enable('gopls')

vim.lsp.enable('tsc')

-- npm install [-g] @biomejs/biome
vim.lsp.enable('biome')

-- npm install -g @olrtg/emmet-language-server
vim.lsp.enable('emmet_language_server')

-- npm install [-g] svelte-language-server
vim.lsp.enable('svelte')

-- npm install -g @astrojs/language-server
vim.lsp.enable('astro')

-- npm install -g typescript@<version> typescript-language-server
-- npm install [-g] @biomejs/biome

-- npm install -g @olrtg/emmet-language-server
-- npm install -g svelte-language-server
-- npm install -g @astrojs/language-server

-- vim.lsp.config['lua_ls'] = {
--   cmd = { 'lua-language-server' },
--   filetypes = { 'lua' },
--   root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
--   settings = {
--     Lua = {
--       runtime = {
--         version = 'LuaJIT',
--       }
--     }
--   }
-- }
--
-- vim.lsp.config['gopls'] = {
--   cmd = { 'gopls' },
--   filetypes = { 'go' },
--   root_markers = { { 'go.mod' }, '.git' },
--   settings = {
--     gopls = {
--       gofumpt = true,
--       staticcheck = true,
--     },
--   }
-- }
-- vim.lsp.enable('gopls')
--
-- vim.lsp.config['ts_ls'] = {
--   cmd = { 'typescript-language-server', '--stdio' },
--   filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
--   root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
-- }
-- vim.lsp.enable('ts_ls')
--
-- vim.lsp.config['svelte'] = {
--   cmd = { 'svelteserver', '--stdio' },
--   filetypes = { 'svelte' },
--   root_markers = { 'svelte.config.js', 'svelte.config.ts', 'package.json', '.git' },
-- }
-- vim.lsp.enable('svelte')
