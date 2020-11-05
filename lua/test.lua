local T = {}

T.test = function(name) 
  local buf = tostring(vim.uri_from_bufnr(0))
  local buf2 = string.match(buf, '.*/(.-)$');
  -- local lines = vim.api.nvim_buf_get_lines(0, 1, 6, false);

  print((buf2 or 'nothing') .. ': ' .. name)

  -- for i, l in pairs(lines) do 
  --   print(buf .. ':' .. i .. ':' .. ' ', l)
  -- end
  -- print(string.match(buf, '.*/(.-)$'))
end

return T 

