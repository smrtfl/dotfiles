return {
  'lervag/vimtex',
  -- tag = "v2.15", -- uncomment to pin to a specific release
  lazy = false,
  init = function()
    vim.g.vimtex_compiler_method = 'latexmk'
    vim.g.vimtex_compiler_latexmk = {
      out_dir = 'build',
      aux_dir = 'aux',
      callback = 1,
      continuous = 1,
      executable = 'latexmk',
      options = {
        '-xelatex',
        '-interaction=nonstopmode',
        '-synctex=1',
        '-pvc',
      },
    }
    vim.g.vimtex_compiler_latexmk_engines = {
      ['_'] = '-xelatex',
    }

    vim.g.vimtex_view_method = 'skim'
    vim.g.vimtex_view_skim_sync = 1
  end,
}
