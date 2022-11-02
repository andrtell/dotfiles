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
      'neovim/nvim-lspconfig'
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

-- Keys
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

-- Colors
require('colors')

-- LSP

-- local on_attach = function(client, bufnr)
--   -- Enable completion triggered by <c-x><c-o>
--   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

--   -- Mappings.
--   -- See `:help vim.lsp.*` for documentation on any of the below functions
--   local bufopts = { noremap=true, silent=true, buffer=bufnr }
--   vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
--   vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
--   vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
--   vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
--   vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
--   vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
--   vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
--   vim.keymap.set('n', '<space>wl', function()
--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--   end, bufopts)
--   vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
--   vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
--   vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
--   vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
--   vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
-- end

-- on_attach = on_attach

require'lspconfig'.elixirls.setup{
    cmd = { "/home/tell/repo/other/elixir-ls/rel/language_server.sh" };
}


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
    width = '230',
    -- height = 30,
    hide_root_folder = false,
    side = 'right',
    -- auto_resize = true,
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
    icons = {
      show = {
        file = false,
        folder = false,
        folder_arrow = false,
        git = false,
      }
    }
  },
  trash = {
    cmd = "trash",
    require_confirm = true
  },
}
