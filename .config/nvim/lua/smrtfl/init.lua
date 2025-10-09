-- File Location
function OpenFileAtLocation()
  vim.ui.input({ prompt = 'File at location: ' }, function(input)
    local file, line, col = string.match(input:gsub('^%s*(.-)%s*$', '%1'), '^(.-):?(%d*):?(%d*)$')

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
local function safe_open_terminal()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)

    if vim.bo[buf].buftype == 'terminal' then
      vim.api.nvim_set_current_win(win)
      return
    end
  end

  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd 'J'
  vim.api.nvim_win_set_height(0, 15)
  vim.api.nvim_win_set_option(0, 'winfixheight', true)
end

local function open_terminal(cmd)
  safe_open_terminal()

  if cmd then
    vim.cmd 'normal! G'

    local term_buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_chan_send(vim.b[term_buf].terminal_job_id, cmd .. '\n')
  end
end

vim.keymap.set('n', '<leader>tt', function()
  open_terminal()
end, { desc = '[T]oggle [T]erminal' })

-- Scala
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'scala', 'sbt' },
  callback = function()
    vim.keymap.set('n', '<leader>sco', function()
      open_terminal 'sbt compile'
    end, { buffer = true, desc = '[S]sbt [C]lean [C]ompile' })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'scala', 'sbt' },
  callback = function()
    vim.keymap.set('n', '<leader>scc', function()
      open_terminal 'sbt clean compile'
    end, { buffer = true, desc = '[S]sbt [C]lean [C]ompile' })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'scala', 'sbt' },
  callback = function()
    vim.keymap.set('n', '<leader>spl', function()
      open_terminal 'sbt publishLocal'
    end, { buffer = true, desc = '[S]bt [P]ublish [L]ocal' })
  end,
})

-- LTeX
vim.api.nvim_create_user_command('LtexLang', function(opts)
  for _, client in ipairs(vim.lsp.get_clients { name = 'ltex' }) do
    client.config.settings = client.config.settings or {}
    client.config.settings.ltex = client.config.settings.ltex or {}
    client.config.settings.ltex.language = opts.args

    -- Notify the server about the new settings
    client:notify('workspace/didChangeConfiguration', {
      settings = client.config.settings,
    })
  end
end, {
  nargs = 1,
  complete = function()
    return { 'en-US', 'de-DE' }
  end,
})

-- TODO: remove
-- IHK reports
local function MakeIhkReport()
  local now = os.date '*t'

  local days_since_monday = (now.wday == 1) and 6 or (now.wday - 2)
  local days_until_sunday = (now.wday == 1) and 0 or (8 - now.wday)

  local monday_time = os.time { year = now.year, month = now.month, day = now.day - days_since_monday }
  local sunday_time = os.time { year = now.year, month = now.month, day = now.day + days_until_sunday }

  local monday_str = os.date('%d-%m-%y', monday_time)
  local sunday_str = os.date('%d-%m-%y', sunday_time)
  local year_str = os.date('%Y', monday_time)
  local month_str = os.date('%B', monday_time):lower()

  local base_dir = 'reports'
  local template_filename = 'template.md'
  local template_filepath = string.format('%s/%s', base_dir, template_filename)

  local report_dir = string.format('%s/%s/%s', base_dir, year_str, month_str)
  local report_filename = string.format('%s_%s.md', monday_str, sunday_str)
  local report_filepath = string.format('%s/%s', report_dir, report_filename)

  if vim.fn.filereadable(report_filepath) ~= 0 then
    print 'Report already exists'

    vim.cmd('edit ' .. report_filepath)

    return
  end

  if vim.fn.filereadable(template_filepath) == 0 then
    print 'Template not found'
    return
  end

  vim.fn.mkdir(report_dir, 'p')

  vim.fn.writefile(vim.fn.readfile(template_filepath), report_filepath)

  local lines = vim.fn.readfile(report_filepath)
  lines[1] = string.format('# %s - %s', monday_str:gsub('-', '.'), sunday_str:gsub('-', '.'))
  vim.fn.writefile(lines, report_filepath)

  vim.cmd('edit ' .. report_filepath)
end

vim.keymap.set('n', '<leader>im', MakeIhkReport, { desc = '[I]HK [M]ake report' })

function ParseIhkReport()
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

    if line:match '^### ' then
      table.insert(result, ParseMarkdown(line))
      i = i + 1
    elseif line:match '^#+ ' then
      i = i + 1
    elseif line:match '^%*%*' then
      table.insert(result, ParseMarkdown(line))
      i = i + 1
    else
      table.insert(result, ParseMarkdown(line))
    end

    i = i + 1
  end

  vim.fn.setreg('+', table.concat(result, '\n'))
end

vim.keymap.set('n', '<leader>ip', ParseIhkReport, { desc = '[I]HK [P]arse report' })
