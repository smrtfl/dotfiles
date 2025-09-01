local fg = '#00ff00'
local bg = '#000000'
local matrix_enabled = false

local function override_telescope()
  local telescope_groups = {
    'TelescopePromptPrefix',
    'TelescopePromptNormal',
    'TelescopePromptTitle',
    'TelescopePromptBorder',
    'TelescopeResultsTitle',
    'TelescopeResultsNormal',
    'TelescopeResultsBorder',
    'TelescopePreviewTitle',
    'TelescopePreviewNormal',
    'TelescopePreviewBorder',
  }

  for _, group in ipairs(telescope_groups) do
    vim.api.nvim_set_hl(0, group, { fg = fg, bg = bg })
  end
end

local function override_colors()
  for name, attrs in pairs(vim.api.nvim_get_hl(0, {})) do
    local new_attrs = vim.tbl_extend('force', {}, attrs)
    if new_attrs.fg then
      new_attrs.fg = fg
    end
    if new_attrs.bg then
      new_attrs.bg = bg
    end
    vim.api.nvim_set_hl(0, name, new_attrs)
  end

  vim.api.nvim_set_hl(0, 'Visual', { bg = '#222222' })
  vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#002200' })
  vim.api.nvim_set_hl(0, 'StatusLine', { fg = fg, bg = bg })
  vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = fg, bg = '#111111' })
  override_telescope()
end

local function reset_colors()
  vim.cmd 'highlight clear'
  vim.cmd 'colorscheme default'
  require('lualine').setup {
    options = {
      theme = 'onedark',
    },
  }
  require('onedark').load()
end

local function enable_matrix()
  vim.cmd 'highlight clear'

  matrix_enabled = true
  override_colors()
  require('lualine').setup {
    options = {
      theme = {
        normal = { a = {}, b = {}, c = {} },
        insert = { a = {}, b = {}, c = {} },
        visual = { a = {}, b = {}, c = {} },
        replace = { a = {}, b = {}, c = {} },
        command = { a = {}, b = {}, c = {} },
        inactive = { a = {}, b = {}, c = {} },
      },
    },
  }
  require('ibl').setup { enabled = false }
  print 'Welcome, Neo.'
end

local function disable_matrix()
  matrix_enabled = false
  reset_colors()
  require('ibl').setup { enabled = false }
  print 'Exited the Matrix.'
end

local function toggle_matrix()
  if matrix_enabled then
    disable_matrix()
  else
    enable_matrix()
  end
end

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    if matrix_enabled then
      vim.schedule(override_colors)
    end
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'TelescopeLoad',
  callback = function()
    if matrix_enabled then
      override_colors()
    end
  end,
})

vim.api.nvim_set_keymap('n', '<leader>x', '<cmd>lua ToggleMatrix()<CR>', { desc = 'Matri[X]', noremap = true, silent = true })

_G.ToggleMatrix = toggle_matrix
