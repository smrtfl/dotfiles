local luasnip = require 'luasnip'
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

return {
  s('for', {
    t { 'for', '  _ <- ' },
    i(1, ''),
    t { '', 'yield ' },
    i(2, '()'),
  }),
}
