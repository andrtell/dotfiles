local git_root = function()
	local dir = vim.fn.system("git rev-parse --show-toplevel 2> /dev/null")
	if dir == "" then
		return vim.fn.getcwd()
	end
	return (string.gsub(dir, "\n", ""))
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.smartintend = true

vim.opt.background = "light"
vim.opt.backup = false
vim.opt.breakindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 1
vim.opt.dir = "/tmp"
vim.opt.expandtab = true
vim.opt.fileencoding = "utf-8"
vim.opt.gdefault = true
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.laststatus = 3
vim.opt.list = false
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.pumheight = 10
vim.opt.scrolloff = 10
vim.opt.shiftwidth = 4
vim.opt.shortmess = "IFc"
vim.opt.showcmd = false
vim.opt.showmode = false
vim.opt.signcolumn = "yes:1"
vim.opt.smartcase = true
vim.opt.softtabstop = 4
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.writebackup = false

vim.opt.statusline = " %f %m %r %w %= Ln %l, Col %c  %{&fileencoding?&fileencoding:&encoding}  "

vim.bo.errorformat = [[
    %E%f:%l:%c: %trror: %m,%-Z%p^,%+C%.%#
    %D%*a: Entering directory [`']%f
    %X%*a: Leaving directory [`']%f
    %-G%.%#
]]

local map = function(mode, key, action)
	vim.keymap.set(mode, key, action, { silent = true, noremap = true })
end

map("i", "jk", "<ESC>")
map("t", "<Esc><Esc>", "<C-\\><C-n>")
map("n", "<BS>", ":nohl<CR>")

map("n", "<leader>f", function()
	vim.cmd({ cmd = "Files", args = { git_root() } })
end)

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

map("n", "<D-j>", ":m .+1<CR>==")
map("n", "<D-k>", ":m .-2<CR>==")
map("v", "<D-j>", ":m '>+1<CR>gv=gv")
map("v", "<D-k>", ":m '<-2<CR>gv=gv")

map("n", "<space>]", vim.cmd.bnext)
map("n", "<space>[", vim.cmd.bprev)

-- map("n", "\\", ":NvimTreeToggle<CR>")

map("n", "<C-]>", function()
	return pcall(vim.cmd.cnext)
end)

map("n", "<C-[>", function()
	return pcall(vim.cmd.cprev)
end)

map("n", "<F10>", function()
	if package.loaded["vim.treesitter"] then
		vim.cmd("Inspect")
	end
end)

map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)

map("n", "<leader>e", vim.diagnostic.open_float)
map("n", "<leader>q", vim.diagnostic.setloclist)

map("n", "<C-\\>", function()
	local qf_exists = false
	for _, win in pairs(vim.fn.getwininfo()) do
		if win["quickfix"] == 1 then
			qf_exists = true
		end
	end
	if qf_exists == true then
		vim.cmd.cclose()
		return
	end
	if not vim.tbl_isempty(vim.fn.getqflist()) then
		vim.cmd.copen()
	else
		print("Quickfix list is Empty!")
	end
end)

vim.diagnostic.config({
	virtual_text = false,
	float = { border = "rounded" },
	underline = true,
	signs = true,
})

-- vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus = false})]])

vim.cmd([[sign define DiagnosticSignError text=e texthl=DiagnosticSignError linehl= numhl=]])
vim.cmd([[sign define DiagnosticSignWarn text=w texthl=DiagnosticSignWarn linehl= numhl=]])
vim.cmd([[sign define DiagnosticSignInfo text=i texthl=DiagnosticSignInfo linehl= numhl=]])
vim.cmd([[sign define DiagnosticSignHint text=h texthl=DiagnosticSignHint linehl= numhl=]])

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"colorama",
		dir = "/home/tell/repo/colorama",
		dependencies = {
			"rktjmp/lush.nvim",
		},
		config = function()
			vim.cmd.colorscheme("colorama")
		end,
	},
	{
		"echasnovski/mini.nvim",
		version = nil,
		config = function()
			require("mini.tabline").setup({
				tabpage_section = "right",
			})
		end,
	},
	{
		"stevearc/oil.nvim",
		opts = {
			keymaps = {
				["<Esc>"] = { callback = "actions.close", mode = "n" },
			},
			view_options = {
				show_hidden = false,
			},
			win_options = {
				signcolumn = "yes",
			},
		},
		keys = {
			{ "-", "<CMD>Oil<CR>" },
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = " ▎" },
				change = { text = " ▎" },
				delete = { text = " ▎" },
				topdelete = { text = " ▎" },
				changedelete = { text = " ▎" },
				untracked = { text = " ▎" },
			},
		},
	},
	{
		"nvim-autopairs",
	},
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").create_default_mappings()
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			vim.g.nvim_tree_add_trailing = 1
			require("nvim-tree").setup({
				hijack_cursor = true,
				filesystem_watchers = { enable = true },
				update_focused_file = {
					enable = true,
				},
				filters = {
					dotfiles = true,
					git_ignored = false,
				},
				renderer = {
					root_folder_label = false,
					add_trailing = true,
					icons = {
						git_placement = "after",
						show = {
							file = false,
							folder = false,
							folder_arrow = false,
							git = true,
							modified = false,
						},

						glyphs = {
							git = {
								unstaged = "¬s",
								staged = "s",
								unmerged = "¬m",
								renamed = "r",
								untracked = "n",
								deleted = "d",
								ignored = " ",
							},
						},
					},
				},
				view = {
					side = "right",
					width = "180",
				},
			})
		end,
	},
	{
		"junegunn/fzf.vim",
		dependencies = { "junegunn/fzf" },
		config = function()
			vim.g.fzf_layout = { window = "enew" }
			vim.g.fzf_preview_window = {}
			vim.env.FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
			vim.g.fzf_colors = {
				["bg"] = { "bg", "Normal" },
				["bg+"] = { "bg", "Visual" },
				["border"] = { "fg", "Normal" },
				["fg"] = { "fg", "Normal" },
				["fg+"] = { "fg", "Normal" },
				["gutter"] = { "bg", "Normal" },
				["header"] = { "fg", "Normal" },
				["hl"] = { "fg", "Normal" },
				["hl+"] = { "fg", "Normal" },
				["info"] = { "bg", "Normal" },
				["pointer"] = { "fg", "Normal" },
				["prompt"] = { "fg", "Normal" },
				["query"] = { "fg", "Normal" },
				["spinner"] = { "bg", "Normal" },
			}
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			notify_on_error = false,
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { { "prettierd", "prettier" }, { "eslint_d", "eslint" } },
				typescript = { { "prettierd", "prettier" }, { "eslint_d", "eslint" } },
			},
		},
	},
	{
		"numToStr/Comment.nvim",
		opts = {},
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					return "make install_jsregexp"
				end)(),
			},
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
		},
		config = function()
			-- See `:help cmp`
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local comp_window = cmp.config.window.bordered()
			local lspkind = require("lspkind")
			comp_window.scrollbar = false
			luasnip.config.setup({
				history = false,
			})
			require("luasnip.loaders.from_vscode").lazy_load()
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				experimental = { ghost_text = true },
				completion = { completeopt = "menu,menuone,noinsert" },
				-- For an understanding of why these mappings were
				-- chosen, you will need to read `:help ins-completion`
				--
				-- No, but seriously. Please read `:help ins-completion`, it is really good!
				window = {
					completion = comp_window,
					documentation = cmp.config.window.bordered(),
					winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
					col_offset = -3,
					side_padding = 0,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-y>"] = cmp.mapping.confirm({
						select = true,
						cmp.ConfirmBehavior.Insert,
					}, { "i", "c" }),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<C-e>"] = cmp.mapping.close(),
					["<C-k>"] = cmp.mapping(function(fallback)
						if luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-j>"] = cmp.mapping(function(fallback)
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lua" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "buffer", option = { keyword_length = 5 } },
				},
				formatting = {
					format = lspkind.cmp_format({
						with_text = true,
						menu = {
							buffer = "[buf]",
							nvim_lsp = "[LSP]",
							nvim_lua = "[api]",
							path = "[path]",
							luasnip = "[snip]",
						},
					}),
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local mapb = function(keys, func)
						vim.keymap.set("n", keys, func, { buffer = event.buf })
					end
					-- Jump to the definition of the word under your cursor.
					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-T>.
					mapb("gd", vim.lsp.buf.definition)

					-- Find references for the word under your cursor.
					mapb("gr", vim.lsp.buf.references)

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					mapb("gI", vim.lsp.buf.implementation)

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					mapb("<leader>D", vim.lsp.buf.type_definition)

					-- Fuzzy find all the symbols in your current document.
					--  Symbols are things like variables, functions, types, etc.
					-- map("<leader>ds", require("telescope.builtin").lsp_document_symbols)

					-- Fuzzy find all the symbols in your current workspace
					--  Similar to document symbols, except searches over your whole project.
					-- map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols)

					-- Rename the variable under your cursor
					--  Most Language Servers support renaming across files, etc.
					mapb("<leader>rn", vim.lsp.buf.rename)

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					mapb("<leader>ca", vim.lsp.buf.code_action)

					-- Opens a popup that displays documentation about the word under your cursor
					--  See `:help K` for why this keymap
					mapb("K", vim.lsp.buf.hover)

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header
					mapb("gD", vim.lsp.buf.declaration)

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP Specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
			local servers = {
				-- clangd = {},
				-- gopls = {},
				-- pyright = {},
				-- rust_analyzer = {},
				-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
				--
				-- Some languages (like typescript) have entire language plugins that can be useful:
				--    https://github.com/pmizio/typescript-tools.nvim
				--
				-- But for many setups, the LSP (`tsserver`) will work just fine
				-- tsserver = {},
				--
				elixirls = {},
				lua_ls = {
					-- cmd = {...},
					-- filetypes { ...},
					-- capabilities = {},
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							workspace = {
								checkThirdParty = false,
								-- Tells lua_ls where to find all the Lua files that you have loaded
								-- for your neovim configuration.
								library = {
									"${3rd}/luv/library",
									unpack(vim.api.nvim_get_runtime_file("", true)),
								},
								-- If lua_ls is really slow on your computer, you can try this instead:
								-- library = { vim.env.VIMRUNTIME },
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
			}

			-- Ensure the servers and tools above are installed
			--  To check the current status of installed tools and/or manually install
			--  other tools, you can run
			--    :Mason
			--
			--  You can press `g?` for help in this menu
			require("mason").setup()

			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						require("lspconfig")[server_name].setup({
							cmd = server.cmd,
							settings = server.settings,
							filetypes = server.filetypes,
							-- This handles overriding only values explicitly passed
							-- by the server configuration above. Useful when disabling
							-- certain features of an LSP (for example, turning off formatting for tsserver)
							capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {}),
						})
					end,
				},
			})
		end,
	},
})
