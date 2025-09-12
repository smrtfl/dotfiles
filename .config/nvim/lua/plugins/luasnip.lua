return {
  'L3MON4D3/LuaSnip',
  -- follow latest release.
  version = 'v2.4',
  -- install jsregexp (optional!).
  build = 'make install_jsregexp',
  config = function()
    require('luasnip.loaders.from_lua').load { paths = { '/Users/pavlo.nikulin/.config/nvim/snippets/' } }
  end,
}
