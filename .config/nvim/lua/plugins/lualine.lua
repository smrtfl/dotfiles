return {
  'nvim-lualine/lualine.nvim',

  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
    local clients_lsp = function()
      local clients = vim.lsp.get_clients()

      if next(clients) == nil then
        return ''
      end

      local active_clients = {}

      for _, client in pairs(clients) do
        if vim.lsp.buf_is_attached(vim.api.nvim_get_current_buf(), client.id) then
          table.insert(active_clients, client.name)
        end
      end

      return next(active_clients) and ' ' .. table.concat(active_clients, ' | ') or ''
    end

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'onedark',
        section_separators = { left = ' ', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = {},
      },
      sections = {
        lualine_a = {
          {
            'mode',
            padding = { left = 1, right = 1 },
          },
        },
        lualine_b = {
          {
            'filetype',
            icon_only = true,
            padding = { left = 0, right = 0 },
          },
          {
            'filename',
            symbols = {
              modified = '[+]',
              readonly = '[-]',
              unnamed = '[No Name]',
              newfile = '[New]',
            },
            padding = { left = 0, right = 1 },
          },
        },
        lualine_c = {
          {
            'branch',
            icon = '',
          },
          {
            'diff',
            symbols = { added = ' ', modified = ' ', removed = ' ' },
            colored = true,
          },
        },
        lualine_x = {
          {
            'diagnostics',
            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
            update_in_insert = true,
          },
        },
        lualine_y = { clients_lsp },
        lualine_z = {
          { 'location' },
        },
      },
      inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
      },
      tabline = {},
      extensions = { 'nvim-tree', 'mason', 'lazy', 'nvim-dap-ui' },
    }
  end,
}
