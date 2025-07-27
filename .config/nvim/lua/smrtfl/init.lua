-- File Location
function OpenFileAtLocation()
  vim.ui.input({ prompt = 'File location: ' }, function(input)
    local file, line, col = string.match(input or '', '^(.-):?(%d*):?(%d*)$')

    file = file ~= '' and file or nil
    line = line ~= '' and tonumber(line) or nil
    col = col ~= '' and tonumber(col) or nil

    if not file and not line and not col then
      print 'Invalid format. Use [file][:line[:col]]'
      return
    end

    if file then
      file = vim.fn.expand(file)
      vim.cmd.edit(file)
    end

    vim.fn.cursor(line or 1, col or 1)
  end)
end

vim.keymap.set('n', '<leader>fl', OpenFileAtLocation, { desc = '[F]ile in [L]ocation' })

-- Terminal
vim.keymap.set('n', '<leader>tt', function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd 'J'
  vim.api.nvim_win_set_height(0, 15)
end, { desc = '[T]oggle [T]erminal' })

-- TODO: remove
-- IHK Berichtsheft
function ParseIhkBerichtsheft()
  function ParseMarkdown(md)
    local parsed = md:gsub('^#+ ', ''):gsub('%*%*(.-)%*%*', '%1'):gsub('%*(.-)%*', '%1'):gsub('__(.-)__', '%1'):gsub('_(.-)_', '%1'):gsub('`(.-)`', '%1')
    return parsed
  end

  if vim.bo.filetype ~= 'markdown' then
    return
  end

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local result = {}
  local i = 1

  while i <= #lines do
    local line = lines[i]

    if line:match '^### .+' and i < #lines - 1 then
      local merged = lines[i + 1]:match '^---[- ]*$' and line or table.concat({ line, lines[i + 1] }, '\n')

      table.insert(result, ParseMarkdown(merged))

      i = i + 1
    elseif not line:match '^---[- ]*$' then
      table.insert(result, ParseMarkdown(line))
    end

    i = i + 1
  end

  vim.fn.setreg('+', table.concat(result, '\n'))
end

vim.keymap.set('n', '<leader>pi', ParseIhkBerichtsheft, { desc = '[P]arse [I]HK' })
