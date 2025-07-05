------------------------------------------------------------
-- ╔╗╔╔═╗╔═╗╦  ╦╦╔╦╗
-- ║║║║╣ ║ ║╚╗╔╝║║║║
-- ╝╚╝╚═╝╚═╝ ╚╝ ╩╩ ╩
------------------------------------------------------------                 

------------------------------------------------------------
-- HELPERS
------------------------------------------------------------

local i = function(l, r, opts)
	vim.keymap.set("i", l, r, opts or {}) 
end

local n = function(l, r, opts) 
	vim.keymap.set("n", l, r, opts or {}) 
end

local hi = function (group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

------------------------------------------------------------
-- AUTOCOMMANDS
------------------------------------------------------------

vim.api.nvim_create_augroup("ALL", {clear=true})

local create_autocmd = vim.api.nvim_create_autocmd
local clear_autocmds = vim.api.nvim_clear_autocmds

------------------------------------------------------------
-- OPTIONS
------------------------------------------------------------

do
	local o = vim.opt

	o.breakindent = true
	o.background  = "light"
	o.cursorline  = false
	o.gdefault    = true
	o.laststatus  = 3
	o.mouse       = "a"
	o.number      = false
	o.scrolloff   = 21
	o.shortmess   = "Ita" 
	o.showcmd     = false
	o.showmode    = false
	o.signcolumn  = "yes:1"
	o.smartcase   = true
	o.ignorecase  = true
	o.swapfile    = false
	o.timeoutlen  = 300
	o.updatetime  = 250
	o.statusline  = " %f %m%r %= %{&filetype} | %n | %{&fenc} | %3l : %2c  "

	vim.schedule(function()
		o.clipboard = "unnamedplus"
	end)
end


------------------------------------------------------------
-- KEYS
------------------------------------------------------------

do
	local g = vim.g

	g.mapleader = "\\"
	g.maplocalleader = ","

	i("jk", "<esc>")

	n("<bs>",      ":nohl<cr>")
	n("*",         "g*")
	n("-",         ":Ex<cr>")
	n("<c-h>",     "<c-w><c-h>")
	n("<c-l>",     "<c-w><c-l>")
	n("<c-j>",     "<c-w><c-j>")
	n("<c-k>",     "<c-w><c-k>")
	n("<c-up>",    ":resize +2<cr>")
	n("<c-down>",  ":resize -2<cr>")
	n("<c-left>",  ":vertical resize -2<cr>")
	n("<c-right>", ":vertical resize +2<cr>")
	n("<S-h>",     ":bprevious<cr>")
	n("<S-l>",     ":bnext<cr>")
	n("s",         "<Plug>(leap)")
	n("S",         "<Plug>(leap-from-window)")
	-- n("\\",        ":NvimTreeToggle<CR>")
	n("]d", function () vim.diagnostic.goto_next {float=false} end)
	n("[d", function () vim.diagnostic.goto_prev {float=false} end)
end

------------------------------------------------------------
-- LAZY BOOTSTRAP
------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

------------------------------------------------------------
-- LAZY
------------------------------------------------------------

require("lazy").setup({
	ui = {
		border = "double",
	},
	checker = { enabled = false },
	spec = {
		'mhinz/vim-sayonara', 
		{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
		{"neovim/nvim-lspconfig"},
		{"ggandor/leap.nvim"},
        {"Olical/conjure"},
	}
})

------------------------------------------------------------
-- CONJURE
------------------------------------------------------------

do
    local g = vim.g

    g['conjure#filetype#scheme'] = 'conjure.client.guile.socket'
    g['conjure#client#guile#socket#pipename'] = "/home/tell/tmp/guile/.guile-repl-socket"

end

------------------------------------------------------------
-- TREESITTER
------------------------------------------------------------

local config = require("nvim-treesitter.configs")

config.setup({
  ensure_installed = {"lua", "javascript", "ada"},
  highlight = { enable = true },
  indent = { enable = false }
})

------------------------------------------------------------
-- NETRW
------------------------------------------------------------

do
	local g = vim.g

	g.netrw_banner = 0
	g.netrw_keepdir = 0
	g.netrw_list_hide="\\(^\\|\\s\\s\\)\\zs\\.\\S\\+"

	create_autocmd("filetype", {
		pattern="netrw",
		group="ALL",
		callback=function ()
			local opt = { silent=true, buffer=true, remap=true }
			n("<esc>", ":Sayonara!<cr>",  opt)
			n("h",     "-",               opt)
			n("l",     "<cr>",            opt)
			n(".",     "gh",              opt)
			n("H",     "h",               opt)
		end,
	})
end

------------------------------------------------------------
-- COLORS
------------------------------------------------------------

do
	local hsv = require('hsv')

	function grey(v) return hsv(0, 0, v) end

	function invisible(col) return {fg = col, bg = col } end

	function fg (col) return {fg = col} end
	function bg (col) return {bg = col} end

	black = hsv(0, 0, 0.110)
	white = hsv(0, 0, 0.96)

	local fill = {
		white = hsv(0, 0, 0.97),
		yellow = hsv(0.16, 0.20, 0.93),
	}

	local text = {
		blue = hsv(0.59, 0.82, 0.47),
		green = hsv(0.36, 0.91, 0.425),
		orange = hsv(0.08, 0.73, 0.57),
		purple = hsv(0.84, 0.54, 0.61),
		red = hsv(0, 0.665, 0.59),
	}

	local theme = {
		vim = {
			[bg(grey(0.825))] = {
				'PMenuSel'
			},
			[fg(grey(0.825))] = {
				'winseparator',
				'floatborder',
            },
			[bg(grey(0.912))] = {
				'visual', 
				'visualnos',
			},
			[bg(grey(0.89))] = {
				'PMenu',
				'statusline',
			},
			[{bg=none}] = {
				'PmenuMatch', 
				'PMenuMatchSel'
			},
			[invisible(white)] = {
				'endofbuffer'
			},
			[bg(fill.yellow)] = {
				'matchparen',
			},
			[{ bg = grey(0.89), fg = black }] = {
                'LeapLabel',
			},
			[bg(fill.yellow)] = {
				'cursearch', 
				'incsearch', 
				'search'
			},
		},
		lazy = {
			[bg(grey(0.87))] = {
				'LazyButtonActive',
			},
			[bg(grey(0.948))] = {
				'LazyButton',
				'LazySpecial',
				'LazyH1'
			}
		},
		netrw = {
			[fg(text.blue)] = {
				'NetrwClassify'
			}
		},
        code = {
			[fg(grey(0.525))] = {
				'comment',
				'@comment',
			},
        },
        bash = {
			[fg(text.blue)] = {
				'@string.bash',
			},
			[fg(text.red)] = {
				'@variable.bash',
				'@variable.builtin.bash',
				'@constant.bash',
			},
        },
        lua = {
			[fg(text.blue)] = {
				'@string.lua',
				'@string.escape.lua',
			},
			[fg(text.green)] = {
				'@boolean.lua',
			},
			[fg(text.red)] = {
				'@number.lua',
			},
			[{fg = text.green, bold = true}] = {
				'@keyword.lua',
				'@keyword.conditional.bash',
				'@keyword.conditional.lua',
				'@keyword.function.lua',
				'@keyword.operator.lua',
				'@keyword.repeat.bash',
				'@keyword.repeat.lua',
				'@keyword.return.lua',
			},
        },
        scheme = {
			[{fg = text.green, bold = true}] = {
                '@function.builtin.scheme',
                '@keyword.scheme',
                '@keyword.conditional.scheme',
			},
			[{fg = text.green, bold = false}] = {
                '@operator.scheme',
			},
			[fg(text.blue)] = {
				'@string.scheme',
			},
			[fg(text.green)] = {
				'@boolean.scheme',
			},
			[fg(text.red)] = {
				'@number.scheme',
			},
			-- [fg(grey(0.3))] = {
			-- 	'@punctuation.bracket.scheme',
			-- },
        },
        c = {
			[{fg = text.green, bold = true}] = {
                '@keyword.import.c',
                '@keyword.modifier.c',
                '@keyword.return.c',
                '@keyword.conditional.c',
			},
			[{fg = text.purple, bold = true}] = {
                '@type.builtin.c',
			},
			[fg(text.blue)] = {
				'@string.c',
			},
			[fg(text.red)] = {
				'@number.c',
			},
        },
        gleam = {
			[{fg = text.green, bold = true}] = {
				'@keyword.gleam',
				'@keyword.conditional.gleam',
				'@keyword.modifier.gleam',
				'@keyword.import.gleam',
				'@keyword.function.gleam',
				'@keyword.exception.gleam',
			},
			[{fg = text.blue, bold = true }] = {
				'@string.gleam',
			},
			[{fg = text.red }] = {
				'@number.gleam',
			},
			[{fg = text.purple, bold = true }] = {
				'@type.gleam',
			},
			[{fg = text.orange, bold = true}] = {
				'@function.call.gleam',
			},
        },
	}

	function clear_hl ()
		for hg, _ in pairs(vim.api.nvim_get_hl(0, {})) do
			if type(hg) == "string" then
				hi(hg, {fg = black, bg = white})
			end
		end
	end

	function set_hl ()
		for _, hl_category in pairs(theme) do
			for hl_config, hl_list in pairs(hl_category) do
				for _, hl_group in ipairs(hl_list) do
					hi(hl_group, hl_config)
				end
			end
		end
	end

	create_autocmd("colorscheme", {
		group="ALL",
		pattern='default',
		callback=function () 
            clear_hl()
			set_hl()
		end
	})

    vim.cmd("colorscheme default")
end

-- -- 	-- tiny
-- -- 	hi("TinyInlineDiagnosticVirtualTextError", {bg="#f0f0f1"})
-- -- 	hi("TinyInlineDiagnosticVirtualTextWarn", {bg="#f0f0f1"})
-- -- 	hi("TinyInlineDiagnosticVirtualTextHint", {bg="#f0f0f1"})
-- -- 	hi("TinyInlineDiagnosticVirtualTextArrow", {fg="#efeff1"})
-- -- 	-- diagnostic
-- -- 	hi("DiagnosticUnderlineError", {underline=true, sp="#F00000"})
-- -- 	hi("DiagnosticUnderlineWarn",  {underline=true, sp="#FF0000"})
-- -- 	hi("DiagnosticUnderlineInfo",  {underline=true, sp="#FF0000"})
-- -- 	hi("DiagnosticUnderlineHint",  {underline=true, sp="#FF0000"}) 
-- -- 	hi("DiagnosticUnnecessary",    {underline=true, sp="#FF0000"}) 
-- -- 	hi("DiagnosticDeprecated",     {underline=true, sp="#FF0000"})
-- -- 	hi("DiagnosticFloatingError",  {fg="#030303"})
-- -- 	hi("DiagnosticError",          {bg="#fbe5e5"})
-- -- 	hi("DiagnosticWarn",           {bg="#fbe5e5"})
-- --
-- -- 	-- hi("SnippetTabStop", {bg="#faf2d8"}) 
-- -- end
--
