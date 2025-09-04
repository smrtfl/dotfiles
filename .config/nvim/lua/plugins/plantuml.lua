return {
  'weirongxu/plantuml-previewer.vim',
  dependencies = { 'tyru/open-browser.vim' },
  ft = { 'plantuml' },
  config = function()
    vim.g['plantuml_previewer#plantuml_jar_path'] = '/tmp/plantuml.jar'
    vim.g['plantuml_previewer#save_format'] = 'svg'
  end,
}
