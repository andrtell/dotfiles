hi clear
let g:colors_name = 'simple_rick'

let s:t_Co = &t_Co

hi! Yellow  guifg=#dbbc7f
hi! Blue    guifg=#7faccb
hi! Green   guifg=#a7c080
hi! Red     guifg=#e67e80
hi! RedRev  guibg=#953c3e guifg=#e0e0e0
hi! RedUL   guifg=#e67880 gui=underline guisp=#e67e80
hi! Silver  guifg=#aaaa9e
hi! Brown   guifg=#ca9a80
hi! Black   guifg=#4b565c
hi! Magenta guifg=#d699b6
hi! Cyan    guifg=#83c092

hi! Bold    gui=bold

" hi! Text    guifg=#d3c6aa guibg=none gui=none
hi! Text    guifg=#d5c9ae guibg=none gui=none
hi! TextRev guibg=#21272c guifg=#d3c6aa gui=none

hi! Comment guifg=#8a8a80 guibg=NONE gui=bold cterm=bold

hi! link @punctuation.special Comment

hi! link @symbol Text
hi! link Normal Text
hi! link Directory Text
hi! link EndOfBuffer Text
hi! link ModeMsg Text 
hi! link MoreMsg Text 
hi! link Question Text 
hi! link SpecialKey Text 
hi! link SignColumn TextRev
hi! link Constant Text 
hi! link Statement Text
hi! link Identifier Text 
hi! link Special Text
hi! link Type Text
hi! link PreProc Text
hi! link Function Text
hi! link Constant Text
hi! link Type Text

" hi Search        guifg=#cdcdcd   guibg=#545451   gui=none
hi Search guibg=#b09c00 guifg=#202020 gui=none
hi! link IncSearch Search 
hi! link PMenu Normal
hi! link PMenuSel Search

hi! link Terminal Normal
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link MessageWindow Pmenu
hi! link PopupNotification Todo
hi! link Boolean Constant
hi! link Character Constant
hi! link Conditional Statement
hi! link Define PreProc
hi! link Debug Special
hi! link Delimiter Special
hi! link Exception Statement
hi! link Float Number
hi! link Function Identifier
hi! link Include PreProc
hi! link Keyword Statement
hi! link Label Statement
hi! link Macro PreProc
hi! link Number Text
hi! link Operator Statement
hi! link PreCondit PreProc
hi! link Repeat Statement
hi! link SpecialChar Special
hi! link SpecialComment Special
hi! link StorageClass Type
hi! link String Text
hi! link Structure Type
hi! link Tag Special
hi! link Typedef Type
hi! link lCursor Cursor
hi! link debugBreakpoint ModeMsg
hi! link debugPC CursorLine
hi! link MatchParen Blue

hi! link DiffAdd Green
hi! link DiffChange Blue
hi! link DiffDelete Red
hi! link DiffText Yellow
" hi DiffAdd guifg=#00af00 guibg=#080808 gui=none cterm=none
" hi DiffChange guifg=#87afd7 guibg=#080808 gui=none cterm=none
" hi DiffDelete guifg=#d75f5f guibg=#080808 gui=none cterm=none
" hi DiffText guifg=#d787d7 guibg=#080808 gui=none cterm=none

hi ColorColumn guifg=NONE guibg=#1c1c1c gui=NONE cterm=NONE
hi Conceal guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi Cursor guifg=NONE guibg=NONE gui=reverse ctermfg=NONE ctermbg=NONE cterm=reverse
hi CursorColumn guifg=NONE guibg=#303030 gui=NONE cterm=NONE
hi CursorLine guifg=NONE guibg=#303030 gui=NONE cterm=NONE
hi CursorLineNr guifg=#cdcdcd guibg=#303030 gui=NONE cterm=NONE
hi FoldColumn guifg=#707070 guibg=NONE gui=NONE cterm=NONE
hi Folded guifg=#707070 guibg=#080808 gui=NONE cterm=NONE
hi LineNr guifg=#444444 guibg=NONE gui=NONE cterm=NONE
" hi Pmenu guifg=#080808 guibg=#87afd7 gui=NONE cterm=NONE
hi PmenuSbar guifg=#cdcdcd guibg=#707070 gui=NONE cterm=NONE
" hi PmenuSel guifg=#080808 guibg=#d787d7 gui=NONE cterm=NONE
hi PmenuThumb guifg=#cdcdcd guibg=#d787d7 gui=NONE cterm=NONE
hi QuickFixLine guifg=#d787d7 guibg=#080808 gui=reverse cterm=reverse
hi SpellBad guifg=#d7005f guibg=NONE guisp=#d7005f gui=undercurl cterm=underline
hi SpellCap guifg=#0087d7 guibg=NONE guisp=#0087d7 gui=undercurl cterm=underline
hi SpellLocal guifg=#d787d7 guibg=NONE guisp=#d787d7 gui=undercurl cterm=underline
hi SpellRare guifg=#00afaf guibg=NONE guisp=#00afaf gui=undercurl cterm=underline
hi TabLine guifg=#707070 guibg=#080808 gui=reverse cterm=reverse
hi TabLineFill guifg=#cdcdcd guibg=NONE gui=NONE cterm=NONE
hi TabLineSel guifg=#080808 guibg=#cdcdcd gui=bold cterm=bold
hi Title guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi WarningMsg guifg=#cdcdcd guibg=NONE gui=NONE cterm=NONE
hi WildMenu guifg=#00afff guibg=#080808 gui=bold cterm=bold
hi Error guifg=#ff005f guibg=#080808 gui=bold,reverse cterm=bold,reverse
hi Ignore guifg=#cdcdcd guibg=NONE gui=NONE cterm=NONE
hi Todo guifg=#00ffaf guibg=NONE gui=bold,reverse cterm=bold,reverse
hi Underlined guifg=#cdcdcd guibg=NONE gui=underline cterm=underline
hi CursorIM guifg=#080808 guibg=#afff00 gui=NONE cterm=NONE
hi ToolbarLine guifg=NONE guibg=#080808 gui=NONE cterm=NONE
hi ToolbarButton guifg=#cdcdcd guibg=#080808 gui=bold cterm=bold


" LIGTHSPEED

hi! LightspeedGreyWash guifg=none guibg=none
hi! link LightspeedLabel           Red
hi! link LightspeedShortcut        Red
hi! link LightspeedUniqueChar      Normal
hi! link LightspeedUnlabeledMatch  Red

" FZF

hi! FzfInvisible guifg=#424648   guibg=#424648

hi! link fzf1 FzfInvisible
hi! link fzf2 FzfInvisible
hi! link fzf3 FzfInvisible

" NvimTree

hi! link NvimTreeFolderIcon        Normal
hi! link NvimTreeFolderName        Normal
hi! link NvimTreeOpenedFolderName  Normal
hi! link NvimTreeOpenedFile        Underlined
hi! link NvimTreeRootFolder        Normal
hi! link NvimTreeSpecialFile       Normal
hi! link NvimTreeExecFile          Normal
hi! link NvimTreeFileNew           Normal
hi! link NvimTreeFileRenamed       Normal
hi! link NvimTreeFileStaged        Normal
hi! link NvimTreeImageFile         Normal
hi! link NvimTreeEmptyFolderName   Normal

hi! NvimTreeWindowPicker guibg=#424648

hi! link NvimTreeGitDeleted       Red
hi! link NvimTreeGitDirty         Blue
hi! link NvimTreeGitNew           Green

hi! Visual        guifg=none   guibg=#403c3a   gui=none
hi! VertSplit     guifg=#323c41   guibg=none      gui=none

hi! link StatusLine     Silver
hi! link StatusLineNC   Black

hi! link ErrorMsg RedRev
hi! link Error Red

hi! link DiagnosticError Red
hi! link DiagnosticWarn Yellow
hi! link DiagnosticInfo Blue
hi! DiagnosticUnderlineError   guifg=none gui=none guisp=#e67e80
hi! DiagnosticUnderlineWarn    guifg=none gui=none guisp=#dbbc7f
hi! DiagnosticUnderlineInfo    guifg=none gui=none guisp=#7faccb
