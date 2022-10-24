-- Lua 
c = vim.cmd

-- Colors
c 'hi! Blue    guifg=#7fbbb3'
c 'hi! Red     guifg=#e67e80'
c 'hi! Yellow  guifg=#dbbc7f'
c 'hi! Green   guifg=#a7c080'
c 'hi! Silver  guifg=#aaaa9e'
c 'hi! Brown   guifg=#ca9a80'
c 'hi! Black   guifg=#4b565c'
c 'hi! Magenta guifg=#d699b6'
c 'hi! Cyan    guifg=#83c092'
c 'hi! White   guifg=#d3c6aa'
c 'hi! Normal  guifg=#d3c6aa'
c 'hi! Gray    guifg=#9a9a90'

-- Vim
c 'hi! link Error          Red'
c 'hi! link ErrorMsg       Red'
c 'hi! link SignColumn     Normal'
c 'hi! link StatusLine     Silver'
c 'hi! link StatusLineNC   Black'
c 'hi! link VertSplit      Black'
c 'hi! link MoreMsg        Green'
c 'hi! link Question       Green'
c 'hi! link NonText        Blue'
c 'hi! link DiagnosticError           Red'
c 'hi! link DiagnosticUnderlineError  Normal'

c 'hi! ColorColumn   guifg=none      guibg=#293640   gui=none'
c 'hi! EndOfBuffer   guifg=#2b3339   guibg=none      gui=none'
c 'hi! IncSearch     guifg=#d3c6aa   guibg=#545451   gui=none'
c 'hi! MatchParen    guifg=none      guibg=#636363   gui=none'
c 'hi! PMenu         guifg=none      guibg=#4e4e4e   gui=none'
c 'hi! PMenuSel      guifg=none      guibg=#5e5e5e   gui=none'
c 'hi! Search        guifg=#d3c6aa   guibg=#545451   gui=none'
c 'hi! TabLine       guifg=#859289   guibg=none      gui=none'
c 'hi! TabLineFill   guifg=#d3c6aa   guibg=none      gui=none'
c 'hi! TabLineSel    guifg=#d3c6aa   guibg=none      gui=none'
c 'hi! Underline     guifg=none      guibg=none      gui=underline'
c 'hi! VertSplit     guifg=#323c41   guibg=none      gui=none'
c 'hi! Visual        guifg=#d3c6aa   guibg=#424c51   gui=none'

-- FZF
c 'hi! FzfInvisible guifg=#424648   guibg=#424648'

c 'hi! link fzf1 FzfInvisible'
c 'hi! link fzf2 FzfInvisible'
c 'hi! link fzf3 FzfInvisible'

-- Lightspeed
c 'hi! LightspeedGreyWash guifg=none guibg=none'
c 'hi! link LightspeedLabel           Red'
c 'hi! link LightspeedShortcut        Red'
c 'hi! link LightspeedUniqueChar      Normal'
c 'hi! link LightspeedUnlabeledMatch  Red'

-- Vim syntax
c 'hi! link vimComment Gray'

-- Lua syntax
c 'hi! link luaComment Gray'

-- Elixir syntax
c 'hi! link elixirComment Gray'
c 'hi! link elixirDocString Gray'

-- Css syntax
c 'hi! link cssComment Gray'

-- (BA)SH syntax
c 'hi! link shComment Gray'

-- YAML syntax
c 'hi! link yamlComment Gray'

-- JS syntax
c 'hi! link javascriptComment Gray'

-- Typescript syntax
c 'hi! link typescriptComment Gray'

-- HTML syntax
c 'hi! link htmlComment Gray'

-- NvimTree
c 'hi! link NvimTreeFolderIcon        Normal'
c 'hi! link NvimTreeFolderName        Normal'
c 'hi! link NvimTreeOpenedFolderName  Normal'
c 'hi! link NvimTreeOpenedFile        Underlined'
c 'hi! link NvimTreeRootFolder        Normal'
c 'hi! link NvimTreeSpecialFile       Normal'
c 'hi! link NvimTreeExecFile          Normal'
c 'hi! link NvimTreeFileNew           Normal'
c 'hi! link NvimTreeFileRenamed       Normal'
c 'hi! link NvimTreeFileStaged        Normal'
c 'hi! link NvimTreeImageFile         Normal'
c 'hi! link NvimTreeEmptyFolderName   Normal'
