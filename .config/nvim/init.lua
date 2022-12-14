-- Lua 
c = vim.cmd
f = vim.fn
g = vim.g
o = vim.opt

-- Functions
function k(mode, lhs, rhs, opts)
  vim.api.nvim_set_keymap(mode, lhs, rhs, {noremap = true, silent = true})
end

function aug(group, commands)
  c('augroup ' .. group)
  c 'autocmd!'
  for _, cmd in ipairs(commands) do
    c('autocmd ' .. cmd)
  end
  c 'augroup END'
end

function git_root()
  root = f.system('git rev-parse --show-toplevel 2> /dev/null')
  if root == '' then
    return f.getcwd()
  end
  return string.gsub(root, '\n', '')
end

function _G.autosave()
  if 1 == vim.api.nvim_eval('&modified') then
    c 'update'
  end
end

function _G.make_statusline(wnr)
  active = wnr == f.winnr()
  width  = vim.api.nvim_win_get_width(f.win_getid(wnr))
  bnr    = f.winbufnr(wnr)
  bname  = f.bufname(bnr)
  if bname == "NvimTree_1" then
    return string.rep("—", width)
  end
  bname  = bname == "" and "NO NAME" or bname
  bname  = " " .. bname .. " "
  bft    = vim.api.nvim_buf_get_option(bnr, 'filetype')
  bft    = bft == "" and "NONE" or bft
  bft    = " " .. string.upper(bft) .. " "
  if active then
    filler = string.rep("—", width - #bname - #bft - 18)
    return  "——"    ..  -- 2
    bname   ..
    "——"    ..  -- 2
    filler  ..
    "——"    ..  -- 2
    " %4l " ..  -- 6
    "——"    ..  -- 2
    bft     ..
    "————"      -- 4
  else
    return string.rep("—", width)
  end
end

function _G.refresh_statusline()
  for n = 1,f.winnr('$'),1 do
    f.setwinvar(n, '&statusline', _G.make_statusline(n))
  end
end

function _G.make_tabline()
  nums = { [0] = 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII' }
  current = f.tabpagenr()
  s = "%="
  for n = 1,f.tabpagenr('$'),1 do
    if n == current then
      s = s .. '%#TabLineSel#'
    else
      s = s .. '%#TabLine#'
    end
    s = s .. ' ' .. nums[(n - 1) % 7] .. ' '
  end
  s = s .. '%#TabLineFill#%T'
  return s
end

function template_cmd(dir)
  find = string.format([[find %s -type f -not -path "*/.git/*" -mindepth 2 -printf "%s/%%P\n"]], dir, dir)
  return string.format(":call fzf#run(fzf#wrap({'source': '%s', 'sink': '.-1read'}))<cr>", find)
end

-- Packer
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use {
      'L3MON4D3/LuaSnip',
      'alvan/vim-closetag',
      'ggandor/lightspeed.nvim',
      'junegunn/fzf',
      'junegunn/fzf.vim',
      'kyazdani42/nvim-tree.lua',
      'mattn/emmet-vim',
      'mhinz/vim-sayonara',
      'tpope/vim-commentary',
      'neovim/nvim-lspconfig',
      'github/copilot.vim',
      'tpope/vim-unimpaired',
      'tpope/vim-fugitive',
      'nvim-treesitter/nvim-treesitter-refactor',
  }
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        icons = false,
        fold_open = "v",
        fold_closed = ">",
        indent_lines = false,
        signs = {
            error = "E",
            warning = "W",
            hint = "H",
            information = "I"
        },
        use_diagnostic_signs = false
      }
    end
  }
  use {
      'lewis6991/gitsigns.nvim',
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }
  use {
    'nvim-treesitter/playground',
  }
  use {
    'andrtell/sp-plain-vim',
  }
end)

-- Options
o.backup        = false
o.cmdheight     = 2
o.clipboard     = 'unnamedplus'
o.completeopt   = 'menu,longest'
o.expandtab     = true
o.ignorecase    = true
o.mouse         = 'a'
o.shiftwidth    = 2
o.shortmess     = "filnxtToOFIc"
o.showcmd       = false
o.showmode      = false
o.signcolumn    = 'yes'
o.smartcase     = true
o.swapfile      = false
o.tabstop       = 2
o.termguicolors = true
o.undodir       = f.stdpath('data') .. '/undo'
o.undofile      = true
o.updatetime    = 50
o.writebackup   = false
o.gdefault      = true

o.statusline="%{%v:lua.make_statusline()%}"
o.tabline="%!v:lua.make_tabline()"

c [[set fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾]]

-- Keys
k('n', 'gx', ':!xdg-open <c-r><c-a><cr>')

k('i', 'jk', '<esc>')
k('n', '<C-h>', '<C-w>h')
k('n', '<C-j>', '<C-w>j')
k('n', '<C-k>', '<C-w>k')
k('n', '<C-l>', '<C-w>l')
k('n', '<bs>', ':nohl<cr>')
k('n', 'j', 'gj')
k('n', 'k', 'gk')
k('n', '<space>0', ':execute \'Files\' $HOME<cr>')
k('n', '<space>f', ':execute \'Files\' v:lua.git_root()<cr>')
k('n', '<space>`', ':Sayonara!<cr>')
k('n', '<space>~', ':qall!<cr>')

k('n', '\\', ':NvimTreeToggle<CR>')
k('n', '<space><space>', ':NvimTreeFindFile<CR>')

k('n', '<space>t', template_cmd(os.getenv("TEMPLATES_DIR")))
c [[imap <silent><expr> <C-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '']]

k('n', '<F10>',
  [[:echo "hi<" . ]] ..
  [[ synIDattr(synID(line("."),col("."),1),"name") . ]] ..
  [[ '> trans<' . ]] ..
  [[ synIDattr(synID(line("."),col("."),0),"name") . ]] ..
  [[ "> lo<" . ]] ..
  [[ synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ]] ..
  [[ ">" ]] ..
  [[ <CR>]])

-- Auto-commands
aug('autosave', {'CursorHold * silent! call v:lua.autosave()'})
aug('statusline', { 'VimEnter,WinEnter,BufWinEnter * call v:lua.refresh_statusline()' })

-- LSP

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space><space>', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- Diagnostic signs

vim.diagnostic.config({
  virtual_text = false
})

f.sign_define('DiagnosticSignWarn', { text = '-', texthl = 'DiagnosticSignWarn' })
f.sign_define('DiagnosticSignError', { text = '✕', texthl = 'DiagnosticSignError' })

require'lspconfig'.elixirls.setup{
    cmd = { "/home/tell/repo/other/elixir-ls/rel/language_server.sh" };
}

-- Filetypes

c [[autocmd Filetype zig setlocal shiftwidth=4 tabstop=4]]
c [[autocmd Filetype asm setlocal shiftwidth=8 tabstop=8]]

-- Commentry

c [[autocmd FileType zig setlocal commentstring=//\ %s]]

-- FZF

vim.env.FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
g.fzf_layout = { window = 'enew' }
g.fzf_preview_window = {}
g.fzf_colors = {
  ['bg'] = {'bg', 'Normal'},
  ['bg+'] = {'bg', 'Visual'},
  ['border'] = {'fg', 'Normal'},
  ['fg'] = {'fg', 'Normal'},
  ['fg+'] = {'fg', 'Normal'},
  ['gutter'] = {'bg', 'Normal'},
  ['header'] = {'fg', 'Normal'},
  ['hl'] = {'fg', 'Green'},
  ['hl+'] = {'fg', 'Red'},
  ['info'] = {'bg', 'Normal'},
  ['pointer'] = {'fg', 'Red'},
  ['prompt'] = {'fg', 'Normal'},
  ['query'] = {'fg', 'Normal'},
  ['spinner'] = {'bg', 'Normal'},
}

-- Ligthspeed
require'lightspeed'.setup {
    jump_to_unique_chars = false,
    ignore_case = true
}

-- LuaSnippets
require('snippets/elixir')

-- NvimTree
require("nvim-tree").setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  update_focused_file = {
    enable = false,
    update_cwd = false,
    ignore_list = {},
  },
  view = {
    width = '210',
    hide_root_folder = false,
    side = 'right',
    mappings = {
      custom_only = false,
      list = {}
    },
    number = false,
    relativenumber = false,
    signcolumn = "yes"
  },
  renderer = {
    add_trailing = true,
    highlight_git = false,
    icons = {
      git_placement = "after",
      show = {
        file = false,
        folder = false,
        folder_arrow = false,
        git = true,
      },
      glyphs = {
        git = {
          unstaged = "~",
          staged = "^",
          unmerged = "u",
          renamed = "r",
          untracked = "?",
          deleted = "-",
          ignored = "i",
        },
      },
    }
  },
  trash = {
    cmd = "trash",
    require_confirm = true
  },
}

-- Treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "elixir", "lua" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = {},

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "scss", "css", "lua" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    -- disable = function(lang, buf)
    --     local max_filesize = 100 * 1024 -- 100 KB
    --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --     if ok and stats and stats.size > max_filesize then
    --         return true
    --     end
    -- end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- GitSigns         
require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '⎯', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
}

-- Copilot
c [[imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")]]
g.copilot_no_tab_map = true


c 'colorscheme simple_rick'
