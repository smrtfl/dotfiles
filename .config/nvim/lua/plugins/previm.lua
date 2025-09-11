return {
  'previm/previm',
  ft = { 'plantuml' },
  dependencies = {
    {
      'aklt/plantuml-syntax',
      ft = { 'plantuml' },
    },
    'tyru/open-browser.vim',
  },
  config = function()
    -- vim.g.previm_open_cmd = 'firefox';
    -- vim.g.previm_open_cmd = '/shared/$USER/Applications/chromium/chrome'
    vim.g.previm_enable_realtime = 0
    -- vim.g.previm_disable_default_css = 1
    -- vim.g.previm_custom_css_path = vim.fn.stdpath 'config' .. '/css/previm-gh-dark.css'
    -- local hljs_ghdark_css = 'highlight-gh-dark.css'
    -- vim.g.previm_extra_libraries = {
    --   {
    --     name = 'highlight-gh-dark',
    --     files = {
    --       {
    --         type = 'css',
    --         -- must use previm jailed path due to chrome running in firejail
    --         path = '_/css/lib/highlight-gh-dark.css',
    --       },
    --     },
    --   },
    -- }
    -- Copy our custom code highlight css to the jailbreak folder
    -- if
    --   not vim.loop.fs_copyfile(
    --     vim.fn.stdpath 'config' .. '/css/' .. hljs_ghdark_css,
    --     vim.fn.stdpath 'data' .. '/lazy/previm/preview/_/css/lib/' .. hljs_ghdark_css
    --   )
    -- then
    --   require('utils').warn(string.format("Unable to copy '%s' to previm jail.", hljs_ghdark_css))
    -- end
    -- clear cache every time we open neovim
    vim.fn['previm#wipe_cache']()

    vim.keymap.set('n', '<leader>po', ':PrevimOpen<CR>', { desc = '[P]revim [O]pen' })
    vim.keymap.set('n', '<leader>pr', ':PrevimRefresh<CR>', { desc = '[P]revim [R]efresh' })
  end,
}
