local fg = '#00ff00'
local bg = '#000000'
local override_enabled = false

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

local function override_telescope()
  for _, group in ipairs(telescope_groups) do
    vim.api.nvim_set_hl(0, group, { fg = fg, bg = bg })
  end
end

local function OverrideColors()
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

local function ResetColors()
  vim.cmd 'highlight clear'
  vim.cmd 'colorscheme default'
  require('lualine').setup {
    options = {
      theme = 'onedark',
    },
  }
  require('onedark').load()
end

local function EnableOverride()
  vim.cmd 'highlight clear'

  override_enabled = true
  OverrideColors()
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
  print 'Color override enabled'
end

local function DisableOverride()
  override_enabled = false
  ResetColors()
  print 'Color override disabled'
end

local function ToggleOverride()
  if override_enabled then
    DisableOverride()
  else
    EnableOverride()
  end
end

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    if override_enabled then
      vim.schedule(OverrideColors)
    end
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'TelescopeLoad',
  callback = function()
    if override_enabled then
      OverrideColors()
    end
  end,
})

vim.api.nvim_set_keymap('n', '<leader>m', '<cmd>lua ToggleOverride()<CR>', { desc = '[M]atrix', noremap = true, silent = true })

_G.ToggleOverride = ToggleOverride
