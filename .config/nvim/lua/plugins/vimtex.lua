return {
  'lervag/vimtex',
  lazy = false,
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration
    vim.g.vimtex_view_method = 'skim'
    vim.g.vimtex_compiler_method = 'latexmk'
    vim.g.vimtex_compiler_latexmk = {
      out_dir = 'build',
      aux_dir = 'aux',
      callback = 1,
      continuous = 1,
      executable = 'latexmk',
      options = {
        '-pdf',
        '-xelatex',
        '-interaction=nonstopmode',
        '-synctex=1',
        '-pvc',
      },
    }
  end,
}
