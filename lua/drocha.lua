local Diego = {}

Diego.open_tab = function()
  local pos = vim.api.nvim_win_get_cursor(0)
  local buf = vim.uri_from_bufnr(0)
  vim.api.nvim_command('tabedit ' .. buf)
  vim.api.nvim_win_set_cursor(0, pos)
end

return Diego

