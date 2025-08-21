return {
  'scalameta/nvim-metals',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'mfussenegger/nvim-dap',
      config = function(self, opts)
        -- Debug settings if you're using nvim-dap
        local dap = require 'dap'

        dap.configurations.scala = {
          {
            type = 'scala',
            request = 'launch',
            name = 'RunOrTest',
            metals = {
              runType = 'runOrTestFile',
              --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
            },
          },
          {
            type = 'scala',
            request = 'launch',
            name = 'Test Target',
            metals = {
              runType = 'testTarget',
            },
          },
        }
      end,
    },
    'rcarriga/nvim-dap-ui',
    {
      'j-hui/fidget.nvim',
      opts = {},
    },
  },
  ft = { 'scala', 'sbt' }, -- 'java'?
  opts = function()
    local metals_config = require('metals').bare_config()

    -- Example of settings
    metals_config.settings = {
      showImplicitArguments = true,
      excludedPackages = { 'akka.actor.typed.javadsl', 'com.github.swagger.akka.javadsl' },
    }

    -- *READ THIS*
    -- I *highly* recommend setting statusBarProvider to either "off" or "on"
    --
    -- "off" will enable LSP progress notifications by Metals and you'll need
    -- to ensure you have a plugin like fidget.nvim installed to handle them.
    --
    -- "on" will enable the custom Metals status extension and you *have* to have
    -- a have settings to capture this in your statusline or else you'll not see
    -- any messages from metals. There is more info in the help docs about this
    metals_config.init_options.statusBarProvider = 'off'

    -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
    metals_config.capabilities = require('cmp_nvim_lsp').default_capabilities()

    metals_config.on_attach = function(client, bufnr)
      require('metals').setup_dap()
      require('dapui').setup()
    end

    vim.keymap.set('n', '<leader>mw', function()
      require('metals').hover_worksheet()
    end, { desc = '[M]etals [W]orksheet' })

    vim.keymap.set('n', '<leader>mc', function()
      require('telescope').extensions.metals.commands()
    end, { desc = '[M]etals [C]ommands' })

    -- DAP
    vim.keymap.set('n', '<leader>dc', function()
      require('dap').continue()
    end)

    vim.keymap.set('n', '<leader>dr', function()
      require('dap').repl.toggle()
    end)

    vim.keymap.set('n', '<leader>dK', function()
      require('dap.ui.widgets').hover()
    end)

    vim.keymap.set('n', '<leader>dt', function()
      require('dap').toggle_breakpoint()
    end)

    vim.keymap.set('n', '<leader>dso', function()
      require('dap').step_over()
    end)

    vim.keymap.set('n', '<leader>dsi', function()
      require('dap').step_into()
    end)

    vim.keymap.set('n', '<leader>dl', function()
      require('dap').run_last()
    end)

    return metals_config
  end,
  config = function(self, metals_config)
    local nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      pattern = self.ft,
      callback = function()
        require('metals').initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end,
}
