return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    -- Recommended for better prompt input, and required to use `opencode.nvim`'s embedded terminal — otherwise optional
    { 'folke/snacks.nvim', opts = { input = { enabled = true } } },
  },
  config = function()
    local opencode = require 'opencode'

    vim.g.opencode_opts = {
      -- Your configuration, if any — see `lua/opencode/config.lua`
    }

    -- Required for `opts.auto_reload`
    vim.opt.autoread = true

    -- Recommended keymaps
    vim.keymap.set('n', '<leader>ot', function()
      opencode.toggle()
    end, { desc = '[O]pencode [T]oggle' })

    vim.keymap.set('n', '<leader>oA', function()
      opencode.ask()
    end, { desc = '[O]pencode [A]ask' })

    vim.keymap.set('n', '<leader>oa', function()
      opencode.ask '@cursor: '
    end, { desc = '[O]pencode ask [A]bout at cursor' })

    vim.keymap.set('v', '<leader>oa', function()
      opencode.ask '@selection: '
    end, { desc = '[O]pencode ask [A]bout selection' })

    vim.keymap.set('n', '<leader>on', function()
      opencode.command 'session_new'
    end, { desc = '[O]pencode [N]ew session' })

    vim.keymap.set('n', '<leader>oy', function()
      opencode.command 'messages_copy'
    end, { desc = '[O]pencode [Y]ank last response' })

    vim.keymap.set('t', '<M-u>', function()
      opencode.command 'messages_half_page_up'
    end, { desc = 'opencode messages half page up' })

    vim.keymap.set('t', '<M-d>', function()
      opencode.command 'messages_half_page_down'
    end, { desc = 'opencode messages half page down' })

    vim.keymap.set({ 'n', 'v' }, '<leader>op', function()
      opencode.select()
    end, { desc = '[O]pencode [P]rompt' })

    -- custom prompt
    vim.keymap.set('n', '<leader>oe', function()
      require('opencode').prompt 'Explain @cursor and its context'
    end, { desc = '[O]pencode [E]xplain' })

    vim.keymap.set('v', '<leader>oe', function()
      require('opencode').prompt 'Explain @selection and its context'
    end, { desc = '[O]pencode [E]xplain' })
  end,
}

-- return {
--   'sudo-tee/opencode.nvim',
--   config = function()
--     require('opencode')
--     vim.g.opencode_opts = {}
--   end,
--   dependencies = {
--     'nvim-lua/plenary.nvim',
--     {
--       'MeanderingProgrammer/render-markdown.nvim',
--       opts = {
--         anti_conceal = { enabled = false },
--         file_types = { 'markdown', 'opencode_output' },
--       },
--       ft = { 'markdown', 'Avante', 'copilot-chat', 'opencode_output' },
--     },
--     -- Optional, for file mentions and commands completion, pick only one
--     'saghen/blink.cmp',
--     -- 'hrsh7th/nvim-cmp',
--
--     -- Optional, for file mentions picker, pick only one
--     'folke/snacks.nvim',
--     -- 'nvim-telescope/telescope.nvim',
--     -- 'ibhagwan/fzf-lua',
--     -- 'nvim_mini/mini.nvim',
--   },
-- }
