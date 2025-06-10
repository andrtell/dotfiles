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
	o.background  = "dark"
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

	g.mapleader = " "
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
	install = { colorscheme = { "default" } },
	checker = { enabled = true },
	spec = {
		'mhinz/vim-sayonara', 
		{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
		{"neovim/nvim-lspconfig"},
		{
			'moonbit-community/moonbit.nvim',
			ft = { 'moonbit' },
			opts = {
				-- optionally disable the treesitter integration
				treesitter =  {
					enabled = true,
					-- Set false to disable automatic installation and updating of parsers.
					auto_install = true
				},
				-- configure the language server integration
				-- set `lsp = false` to disable the language server integration
				lsp = {
					-- provide an `on_attach` function to run when the language server starts
					on_attach = function(client, bufnr) end,
					-- provide client capabilities to pass to the language server
					capabilities = vim.lsp.protocol.make_client_capabilities(),
				}
			},
		}
	}
})

------------------------------------------------------------
-- TREESITTER
------------------------------------------------------------

local config = require("nvim-treesitter.configs")

config.setup({
  ensure_installed = {"lua", "javascript", "moonbit"},
  highlight = { enable = true },
  indent = { enable = true }
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

			hi("CursorLine", {bg="#efefef"})
			hi("NetrwDir", {bg="none"})
			hi("NetrwExe", {bg="none"})
			hi("NetrwClassify", {fg="#008080"})
		end,
	})
end

------------------------------------------------------------
-- COLORS
------------------------------------------------------------

do
	local hsv = require('hsv')

	function grey(v) return hsv(0, 0, v) end

	local text = {
		black = hsv(0, 0, 0.13),
		red = hsv(0, 0.745, 0.595),
		green = hsv(0.35, 0.92, 0.385),
		blue = hsv(0.66, 0.785, 0.60),
		purple = hsv(0.83, 0.7, 0.46),
	}

	local fill = {
		white = hsv(0, 0, 0.996),
		blue = hsv(0.55, 0.1, 0.97),
		yellow = hsv(0.14, 0.19, 0.985), -- '#faf2d8'
	}

	function fg (col) return {fg = col} end
	function bg (col) return {bg = col} end

	function invisible(col) return {fg = col, bg = col } end

	local theme = {
		vim = {
			[fg(grey(0.90))] = {
				'winseparator',
				'floatborder'
			},
			[bg(grey(0.875))] = {
				'PMenuSel'
			},
			[bg(grey(0.90))] = {
				'statusline',
			},
			[bg(grey(0.948))] = {
				'visual', 
				'visualnos',
				'PMenu'
			},
			[invisible(fill.white)] = {
				'endofbuffer'
			},
			[bg(fill.blue)] = {
				'matchparen'
			},
			[bg(fill.yellow)] = {
				'cursearch', 
				'incsearch', 
				'search'
			},
			[{bg=none}] = {
				'PmenuMatch', 
				'PMenuMatchSel'
			}
		},
		code = {
			[fg(grey(0.62))] = { -- "#9c9ea3"
				'comment',
				'@comment'
			}
		},
		lua = {
			[fg(text.red)] = {
				'@number.lua'
			},
			[fg(text.green)] = {
				'@string.lua',
				'@string.escape.lua',
			},
			[fg(text.blue)] = {
				'@keyword.conditional.lua',
				'@keyword.function.lua',
				'@keyword.lua',
				'@keyword.operator.lua',
				'@keyword.repeat.lua',
				'@keyword.return.lua',
			}
		},
		moonbit = {
			[fg(text.green)] = {
				'@string.moonbit',
			},
			[fg(text.blue)] = {
				'@keyword.modifier.moonbit',
				'@keyword.function.moonbit',
			},
			[fg(text.red)] = {
				'@type.moonbit',
				'@type.builtin.moonbit',
			}
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
		}
	}

	function clear_hl ()
		for hg, _ in pairs(vim.api.nvim_get_hl(0, {})) do
			if type(hg) == "string" then
				hi(hg, {fg = text.black, bg = fill.white})
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

-- local set_highlights = function() 
	-- 	-- tiny
	-- 	hi("TinyInlineDiagnosticVirtualTextError", {bg="#f0f0f1"})
	-- 	hi("TinyInlineDiagnosticVirtualTextWarn", {bg="#f0f0f1"})
	-- 	hi("TinyInlineDiagnosticVirtualTextHint", {bg="#f0f0f1"})
	-- 	hi("TinyInlineDiagnosticVirtualTextArrow", {fg="#efeff1"})
	--
	-- 	-- leap
	-- 	hi("LeapLabelPrimary",         {bg="#fadffa"})
	--
	-- 	-- diagnostic
	-- 	hi("DiagnosticUnderlineError", {underline=true, sp="#F00000"})
	-- 	hi("DiagnosticUnderlineWarn",  {underline=true, sp="#FF0000"})
	-- 	hi("DiagnosticUnderlineInfo",  {underline=true, sp="#FF0000"})
	-- 	hi("DiagnosticUnderlineHint",  {underline=true, sp="#FF0000"}) 
	-- 	hi("DiagnosticUnnecessary",    {underline=true, sp="#FF0000"}) 
	-- 	hi("DiagnosticDeprecated",     {underline=true, sp="#FF0000"})
	-- 	hi("DiagnosticFloatingError",  {fg="#030303"})
	-- 	hi("DiagnosticError",          {bg="#fbe5e5"})
	-- 	hi("DiagnosticWarn",           {bg="#fbe5e5"})
	--
	-- 	-- hi("SnippetTabStop", {bg="#faf2d8"}) 
	-- end

	-- set_highlights()

	-- end

