return {
  'tamton-aquib/duck.nvim',
  config = function()
    vim.keymap.set('n', '<leader>dd', function()
      -- require('duck').hatch '🦫'
      require('duck').hatch()
    end, { desc = '[D]uck [D]uck' })
    vim.keymap.set('n', '<leader>dk', function()
      require('duck').cook()
    end, { desc = '[D]uck coo[K]' })
    vim.keymap.set('n', '<leader>da', function()
      require('duck').cook_all()
    end, { desc = '[D]uck cook [A]ll' })
  end,
}
