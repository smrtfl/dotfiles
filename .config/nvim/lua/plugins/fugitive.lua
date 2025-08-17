return {
  'tpope/vim-fugitive',
  config = function()
    -- gst
    -- ga
    -- gca
    -- gl
    -- gp
    -- gP (force with lease)

    -- gco
    -- gcB

    -- grhs HEAD~1
    -- grhh
    -- grst

    -- gwt
    -- gwtls
    -- gwta
    -- gwtrm

    -- gsta
    -- gstaa

    -- glg

    -- vim.keymap.set('n', '<leader>gst', ':Git<CR>', { noremap = true, desc = '[G]it [ST]atus' })
    -- vim.keymap.set('n', '<leader>ga', ':Git add ', { noremap = true, desc = '[G]it [A]dd ' })
    -- vim.keymap.set('n', '<leader>gA', ':Git add .<CR>', { noremap = true, desc = '[G]it [A]dd all' })
    -- vim.keymap.set('n', '<leader>gl', ':Git pull <CR>', { noremap = true, desc = '[G]it [P]ull' })
    -- vim.keymap.set('n', '<leader>gp', ':Git push --quiet <CR>', { noremap = true, desc = '[G]it [P]ush' })
    -- vim.keymap.set('n', '<leader>gc', ':Git commit -qam "', { noremap = true, desc = 'git commit -am' })
    -- vim.keymap.set('n', '<leader>gb', ':Git blame', { noremap = true, desc = 'git commit -am' })
  end,
}
