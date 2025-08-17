return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {
      sort = {
        sorter = 'case_sensitive',
      },
      view = {
        width = 40,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
        git_ignored = false,
      },
    }

    vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'File [E]xplorer' })
    vim.keymap.set('n', '<leader>fe', '<cmd>NvimTreeFindFile<CR>', { desc = '[F]ind file in [E]xplorer' })
  end,
}
