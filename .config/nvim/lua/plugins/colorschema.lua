-- onedark
return {
  'navarasu/onedark.nvim',
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require('onedark').setup {
      style = 'warmer',
    }
    -- Enable theme
    require('onedark').load()
  end,
}

-- kanagawa
-- return {
--   'rebelot/kanagawa.nvim',
--   priority = 1000, -- make sure to load this before all the other start plugins
--   config = function()
--     vim.cmd 'colorscheme kanagawa-dragon'
--   end,
-- }
