return {
  'rest-nvim/rest.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, 'http')
    end,
  },
  config = function()
    vim.keymap.set('n', '<leader>ro', '<cmd>Rest open<CR>', { desc = '[R]est [O]pen' })
    vim.keymap.set('n', '<leader>rr', '<cmd>Rest run<CR>', { desc = '[R]est [R]un' })
    vim.keymap.set('n', '<leader>rl', '<cmd>Rest run<CR>', { desc = '[R]est [L]ast' })
    vim.keymap.set('n', '<leader>re', function()
      require('telescope').extensions.rest.select_env()
    end, { desc = '[R]est [E]nv' })
  end,
}
