return {
  'https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim.git',
  event = { 'BufReadPre', 'BufNewFile' },
  -- Activate when a supported filetype is open
  -- ft = {
  --   'c',
  --   'cpp',
  --   'cs',
  --   'go',
  --   'java',
  --   'javascript',
  --   'javascriptreact',
  --   'kotlin',
  --   'lua',
  --   'markdown',
  --   'objc',
  --   'objcpp',
  --   'php',
  --   'python',
  --   'ruby',
  --   'rust',
  --   'scala',
  --   'sql',
  --   'swift',
  --   'terraform',
  --   'typescript',
  --   'typescriptreact',
  --   'sh',
  --   'html',
  --   'css',
  -- },
  cond = function()
    -- Only activate if token is present in environment variable.
    -- Remove this line to use the interactive workflow.
    return vim.env.GITLAB_TOKEN ~= nil and vim.env.GITLAB_TOKEN ~= ''
  end,
  opts = {
    statusline = {
      enabled = true,
    },
    code_suggestions = {
      -- For the full list of default languages, see the 'auto_filetypes' array in
      -- https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim/-/blob/main/lua/gitlab/config/defaults.lua
      auto_filetypes = {
        'c',
        'cpp',
        'csharp',
        'go',
        'java',
        'javascript',
        'javascriptreact',
        'kotlin',
        'lua',
        'markdown',
        'objective-c',
        'objective-cpp',
        'php',
        'python',
        'ruby',
        'rust',
        'scala',
        'sql',
        'swift',
        'terraform',
        'typescript',
        'typescriptreact',
        'sh',
        'html',
        'css',
      },
      ghost_text = {
        enabled = false, -- ghost text is an experimental feature
        toggle_enabled = '<M-t>',
        accept_suggestion = '<M-a>',
        clear_suggestions = '<M-c>',
        stream = true,
      },
    },
  },
}
