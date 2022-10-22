local ls = require("luasnip")

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

local function copy(args)
	return args[1]
end

ls.add_snippets('elixir', {
  s('defm', {
    t('defmodule '), i(1), t(' do'),
    t({'', '  '}),
    t({'', '  '}), i(2),
    t({'', 'end'})
  }),
  s('defmt', {
    t('defmodule '), i(1), t(' do'),
    t({'', '  use ExUnit.Case, async: true'}),
    t({'', '  '}),
    t({'', '  '}), i(2),
    t({'', 'end'})
  }),
  s('test', {
    t('test "'), i(1), t('" do'),
    t({'', '  '}), i(2),
    t({'', 'end'})
  }),
  s('setup', {
    t('setup do'),
    t({'', '  '}), i(2),
    t({'', 'end'})
  }),
  s('mdoc', {
    t('@moduledoc """'),
    t({'', '  '}), i(1),
    t({'', '"""'})
  }),
  s('mdocf', {
    t('@moduledoc false')
  }),
  s('doc', {
    t('@doc """'),
    t({''}), i(1),
    t({'', '"""'})
  }),
  s('def', {
    t('def '), i(1), t(' do'),
    t({'', '  '}), i(2),
    t({'', 'end'})
  }),
  s('defdo', {
    t('def '), i(1), t(', do: '), i(2)
  }),
  s('receive', {
    t('receive do'),
    t({'', '  '}), i(2),
    t({'', 'end'})
  }),
  s('randb', {
    t(':crypto.strong_rand_bytes('), i(1), t(')')
  }),
  s('rands', {
    t(':crypto.strong_rand_bytes('), i(1), t(') |> Base.url_encode64 |> binary_part(0, '), rep(1), t(')')
  }),
  s('implt', {
    t('@impl true')
  }),  
  s('case', {
    t('case '), i(1), t(' do'),
    t({'', '  '}), i(2),
    t({'', 'end'})
  })
})
