function file_picker(cmd)
  return function()
    local items = vim.tbl_map(function(file)
      return { filename = file, lnum = 1 }
    end, vim.fn.systemlist(cmd))

    vim.fn.setqflist({}, 'r', {
      title = cmd .. ': ' .. #items .. ' results.',
      items = items,
    })

    if vim.fn.getqflist({ size = 0 }).size > 0 then
      vim.cmd('copen')
    else
      vim.notify("No files found")
    end
  end
end

function rg_picker()
  local query = vim.fn.input('rg: ')
  if query ~= '' then
    local lines = vim.fn.systemlist('rg --vimgrep --smart-case ' .. vim.fn.shellescape(query))
    vim.fn.setqflist({}, 'r', { title = 'rg: ' .. query, lines = lines })
    if vim.fn.getqflist({ size = 0 }).size > 0 then
      vim.cmd('copen')
    else
      vim.notify('No matches for: ' .. query)
    end
  end
end

vim.keymap.set('n', '<leader>f', ":find ")
-- vim.keymap.set('n', '<leader>f', file_picker('git ls-files'))
vim.keymap.set('n', '<leader>F', file_picker('fdfind --type file'))
vim.keymap.set('n', '<leader>/', rg_picker)
-- vim.keymap.set('n', '<leader>F', file_picker('fdfind --type file'))
