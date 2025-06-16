return {
  'ThePrimeagen/harpoon',

  config = function()
    local mark = require 'harpoon.mark'
    local ui = require 'harpoon.ui'

    vim.keymap.set('n', '<leader>ha', mark.add_file, { desc = '[H]arpoon [A]dd' })
    vim.keymap.set('n', '<leader>hh', ui.toggle_quick_menu, { desc = '[H]arpoon menu' })

    vim.keymap.set('n', '<M-1>', function()
      ui.nav_file(1)
    end)
    vim.keymap.set('n', '<M-2>', function()
      ui.nav_file(2)
    end)
    vim.keymap.set('n', '<M-3>', function()
      ui.nav_file(3)
    end)
    vim.keymap.set('n', '<M-4>', function()
      ui.nav_file(4)
    end)
    vim.keymap.set('n', '<M-5>', function()
      ui.nav_file(5)
    end)
  end,
}
