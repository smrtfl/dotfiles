return {
  'tpope/vim-fugitive',
  config = function()
    vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', { noremap = true, desc = '[G]it [B]lame' })
    vim.keymap.set('n', '<leader>gd', ':Gvdiffsplit<CR>', { noremap = true, desc = '[G]it [D]iff' })
    vim.keymap.set('n', '<leader>gp', ':Git add -p %<CR>', { noremap = true, desc = '[G]it [P]atch' })
    vim.keymap.set('n', '<leader>grm', ':Git rebase -i origin/main<CR>', { noremap = true, desc = '[G]it [R]ebase onto [M]ain' })
  end,
}
