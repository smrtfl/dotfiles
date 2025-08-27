return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }

    vim.keymap.set('n', '<leader>du', function()
      dapui.toggle()
    end, { desc = '[D]AP [U]I' })

    vim.keymap.set('n', '<leader>db', function()
      dap.toggle_breakpoint()
    end, { desc = '[D]AP [B]reakpoint' })

    vim.keymap.set('n', '<leader>dc', function()
      dap.continue()
    end, { desc = '[D]AP [C]ontinue' })

    vim.keymap.set('n', '<leader>dr', function()
      dap.repl.toggle()
    end, { desc = '[D]AP [R]EPL' })

    vim.keymap.set('n', '<leader>dK', function()
      require('dap.ui.widgets').hover()
    end, { desc = '[D]AP hover' })

    vim.keymap.set('n', '<leader>dso', function()
      dap.step_over()
    end, { desc = '[D]AP [S]tep [O]ver' })

    vim.keymap.set('n', '<leader>dsi', function()
      dap.step_into()
    end, { desc = '[D]AP [S]tep [I]nto' })

    vim.keymap.set('n', '<leader>dl', function()
      dap.run_last()
    end, { desc = '[D]AP run [L]ast' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup()
    -- dapui.setup {
    --   -- Set icons to characters that are more likely to work in every terminal.
    --   --    Feel free to remove or use ones that you like more! :)
    --   --    Don't feel like these are good choices.
    --   icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    --   controls = {
    --     icons = {
    --       pause = '⏸',
    --       play = '▶',
    --       step_into = '⏎',
    --       step_over = '⏭',
    --       step_out = '⏮',
    --       step_back = 'b',
    --       run_last = '▶▶',
    --       terminate = '⏹',
    --       disconnect = '⏏',
    --     },
    --   },
    -- }

    -- Change breakpoint icons
    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    local breakpoint_icons = vim.g.have_nerd_font
        and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
      or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end

    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end

    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end

    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    -- Kotlin
    dap.adapters.kotlin = {
      type = 'executable',
      command = 'kotlin-debug-adapter',
      options = { auto_continue_if_many_stopped = false },
    }

    dap.configurations.kotlin = {
      {
        type = 'kotlin',
        request = 'launch',
        name = 'This file',
        -- may differ, when in doubt, whatever your project structure may be,
        -- it has to correspond to the class file located at `build/classes/`
        -- and of course you have to build before you debug
        mainClass = function()
          local root = vim.fs.find('src', { path = vim.uv.cwd(), upward = true, stop = vim.env.HOME })[1] or ''
          local fname = vim.api.nvim_buf_get_name(0)
          -- src/main/kotlin/websearch/Main.kt -> websearch.MainKt
          return fname:gsub(root, ''):gsub('main/kotlin/', ''):gsub('.kt', 'Kt'):gsub('/', '.'):sub(2, -1)
        end,
        projectRoot = '${workspaceFolder}',
        jsonLogFile = '',
        enableJsonLogging = false,
      },
      {
        -- Use this for unit tests
        -- First, run
        -- ./gradlew --info cleanTest test --debug-jvm
        -- then attach the debugger to it
        type = 'kotlin',
        request = 'attach',
        name = 'Attach to debugging session',
        port = 5005,
        args = {},
        projectRoot = vim.fn.getcwd,
        hostName = 'localhost',
        timeout = 2000,
      },
    }

    -- Scala
    dap.configurations.scala = {
      {
        type = 'scala',
        request = 'launch',
        name = 'Run or Test',
        metals = {
          runType = 'runOrTestFile',
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
      {
        type = 'scala',
        request = 'attach',
        name = 'Attach to Localhost',
        hostName = 'localhost',
        port = 5005,
        buildTarget = 'root',
      },
    }
  end,
}
