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
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'json',
      callback = function(ev)
        vim.bo[ev.buf].formatexpr = ''
        vim.bo[ev.buf].formatprg = 'jq'
      end,
    })

    require('rest-nvim').setup {
      request = {
        skip_ssl_verification = true,
      },
    }

    vim.keymap.set('n', '<leader>ro', '<cmd>Rest open<CR>', { desc = '[R]EST [O]pen' })
    vim.keymap.set('n', '<leader>rr', '<cmd>Rest run<CR>', { desc = '[R]EST [R]un' })
    vim.keymap.set('n', '<leader>rl', '<cmd>Rest run<CR>', { desc = '[R]EST [L]ast' })
    vim.keymap.set('n', '<leader>re', function()
      require('telescope').extensions.rest.select_env()
    end, { desc = '[R]EST [E]nv' })
  end,
}
