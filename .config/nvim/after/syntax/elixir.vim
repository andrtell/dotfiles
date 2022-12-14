syn clear
syn case match

syn match elixirDoc '@doc\w*'
syn match elixirDoc '@moduledoc\w*'

syn match elixirComment '#.*' contains=elixirTodo
syn keyword elixirTodo FIXME NOTE TODO OPTIMIZE XXX HACK contained

" syn match elixirComment '^\s*#[^{"].*'
" syn match elixirComment '^\s*#.*'

syn keyword elixirDocAttribute '@doc' '@moduledoc'

syn region elixirDocString matchgroup=elixirDocSigilDelimiter  start="\%(@\w*doc\(\s\|(\)\+\)\@<=\~[Ss]\z(/\|\"\|'\||\)" end="\z1" skip="\\\\\|\\\z1" contains=@elixirDocStringContained fold keepend

syn region elixirDocString matchgroup=elixirDocSigilDelimiter  start="\%(@\w*doc\(\s\|(\)\+\)\@<=\~[Ss]{"                end="}"   skip="\\\\\|\\}"   contains=@elixirDocStringContained fold keepend

syn region elixirDocString matchgroup=elixirDocSigilDelimiter  start="\%(@\w*doc\(\s\|(\)\+\)\@<=\~[Ss]<"                end=">"   skip="\\\\\|\\>"   contains=@elixirDocStringContained fold keepend

syn region elixirDocString matchgroup=elixirDocSigilDelimiter  start="\%(@\w*doc\(\s\|(\)\+\)\@<=\~[Ss]\["               end="\]"  skip="\\\\\|\\\]"  contains=@elixirDocStringContained fold keepend

syn region elixirDocString matchgroup=elixirDocSigilDelimiter  start="\%(@\w*doc\(\s\|(\)\+\)\@<=\~[Ss]("                end=")"   skip="\\\\\|\\)"   contains=@elixirDocStringContained fold keepend

syn region elixirDocString matchgroup=elixirDocStringDelimiter start=+\%(@\w*doc\(\s\|(\)\+\)\@<=\z("\)+                 end=+\z1+ skip=+\\\\\|\\\z1+ contains=@elixirDocStringContained      keepend

syn region elixirDocString matchgroup=elixirDocStringDelimiter start=+\%(@\w*doc\(\s\|(\)\+\)\@<=\z("""\)+               end=+^\s*\z1+                contains=@elixirDocStringContained fold keepend

syn region elixirDocString matchgroup=elixirDocSigilDelimiter  start=+\%(@\w*doc\(\s\|(\)\+\)\@<=\~[Ss]\z('''\)+         end=+^\s*\z1+                contains=@elixirDocStringContained fold keepend

syn region elixirDocString matchgroup=elixirDocSigilDelimiter  start=+\%(@\w*doc\(\s\|(\)\+\)\@<=\~[Ss]\z("""\)+         end=+^\s*\z1+                contains=@elixirDocStringContained fold keepend


syn sync minlines=2000
