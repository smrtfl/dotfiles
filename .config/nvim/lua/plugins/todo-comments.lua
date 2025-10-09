return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    signs = false,
    keywords = {
      FIXME = {
        icon = ' ', -- icon used for the sign, and in search results
        color = 'error', -- can be a hex color, or a named color (see below)
        alt = { 'FixMe' }, -- a set of other keywords that all map to this FIX keywords
        -- signs = false, -- configure signs for some keywords individually
      },
      TODO = { icon = ' ', color = 'info', alt = { 'ToDo' } },
      WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
      -- HACK = { icon = ' ', color = 'warning' },
      -- PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
      -- NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
      -- TEST = { icon = '⏲ ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
    },
  },
}
