------------------
----[general]-----
------------------
-- Options
vim.opt.backup = false                     -- creates a backup file
vim.opt.clipboard = "unnamedplus"          -- allows neovim to access the system clipboard
vim.opt.colorcolumn = "99999"              -- fixes indentline for now
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.conceallevel = 0                   -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"             -- the encoding written to a file
vim.opt.foldmethod = "manual"              -- folding set to "expr" for treesitter based folding
vim.opt.hidden = true                      -- required to keep multiple buffers and open multiple buffers
vim.opt.hlsearch = true                    -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                  -- ignore case in search patterns
vim.opt.mouse = "a"                        -- allow the mouse to be used in neovim
vim.opt.smartcase = true                   -- smart case
vim.opt.smartindent = true                 -- make indenting smarter again
vim.opt.splitbelow = true                  -- force all horizontal splits to go below current window
vim.opt.splitright = true                  -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false                   -- creates a swapfile
vim.opt.termguicolors = true               -- set term gui colors (most terminals support this)
-- vim.o.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 200                   -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.title = true                       -- set the title of window to the value of the titlestring
vim.opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
vim.opt.updatetime = 300                   -- faster completion
vim.opt.writebackup = false                -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
vim.opt.expandtab = true                   -- convert tabs to spaces
vim.opt.shiftwidth = 4                     -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4                        -- insert 2 spaces for a tab
vim.opt.cursorline = true                  -- highlight the current line
vim.opt.number = true                      -- set numbered lines
vim.opt.relativenumber = true              -- set relative numbered lines
vim.opt.numberwidth = 4                    -- set number column width to 2 {default 4}
vim.opt.wrap = false                       -- display lines as one long line
vim.opt.spelllang = "en"
vim.opt.syntax = "on"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.g.mapleader = " "
vim.opt.guifont = "JetbrainsMono Nerd Font Mono:h13"
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
-- vim.g.loaded_netrwSettings = 1
-- vim.g.loaded_netrwFileHandlers = 1
vim.opt.termguicolors = true
vim.cmd([[
	" Disable all blinking:
	:set guicursor+=a:blinkon0
	" Remove previous setting:
	:set guicursor-=a:blinkon0
	" Restore default setting:
	:set guicursor&
]])

---------------------
----[lazy.nvim]------
---------------------
-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git', 'clone', '--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git', '--branch=stable', -- latest stable release
		lazypath
	}
end
vim.opt.rtp:prepend(lazypath)

-- Install packages
require('lazy').setup({

	{ 'numToStr/Comment.nvim',   opts = {} }, { 'Yazeed1s/oh-lucy.nvim' },
	{ 'sainnhe/everforest' },
	{ 'sainnhe/gruvbox-material' },
	{
		'nvim-telescope/telescope.nvim',
		requires = { { 'nvim-lua/plenary.nvim' },
			{ 'kdheepak/lazygit.nvim' },
		}
	},

	{
		'folke/trouble.nvim',
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				position = "bottom", -- position of the list can be: bottom, top, left, right
				height = 7, -- height of the trouble list when position is top or bottom
				width = 50, -- width of the list when position is left or right
				icons = true, -- use devicons for filenames
				mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
				fold_open = "", -- icon used for open folds
				fold_closed = "", -- icon used for closed folds
				group = true, -- group results by file
				padding = true, -- add an extra new line on top of the list
				action_keys = { -- key mappings for actions in the trouble list
					-- map to {} to remove a mapping, for example:
					-- close = {},
					close = "q",       -- close the list
					cancel = "<esc>",  -- cancel the preview and get back to your last window / buffer / cursor
					refresh = "r",     -- manually refresh
					jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
					open_split = { "<c-x>" }, -- open buffer in new split
					open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
					open_tab = { "<c-t>" }, -- open buffer in new tab
					jump_close = { "o" }, -- jump to the diagnostic and close the list
					toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
					toggle_preview = "P", -- toggle auto_preview
					hover = "K",       -- opens a small popup with the full multiline message
					preview = "p",     -- preview the diagnostic location
					close_folds = { "zM", "zm" }, -- close all folds
					open_folds = { "zR", "zr" }, -- open all folds
					toggle_fold = { "zA", "za" }, -- toggle fold of current file
					previous = "k",    -- previous item
					next = "j"         -- next item
				},
				indent_lines = true,   -- add an indent guide below the fold icons
				auto_open = false,     -- automatically open the list when you have diagnostics
				auto_close = false,    -- automatically close the list when you have no diagnostics
				auto_preview = true,   -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
				auto_fold = false,     -- automatically fold a file trouble list at creation
				auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
				signs = {
					-- icons / text used for a diagnostic
					error = "",
					warning = "",
					hint = "",
					information = "",
					other = "﫠"
				},
				use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
			})
		end
	},
	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
		build = ':TSUpdate'
	},
	{ 'windwp/nvim-autopairs' },
	{
		-- Add indentation guides even on blank lines
		'lukas-reineke/indent-blankline.nvim',
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help ibl`
		main = 'ibl',
		opts = {}
	}, -- Fuzzy Finder (files, lsp, etc)
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
				cond = function()
					return vim.fn.executable 'make' == 1
				end
			}
		}
	},

	{
		'folke/which-key.nvim', opts = {},
	},

	{
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		'lewis6991/gitsigns.nvim',
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' }
			},
			on_attach = function(bufnr)
				vim.keymap.set('n', '<leader>hp',
					require('gitsigns').preview_hunk,
					{ buffer = bufnr, desc = 'Preview git hunk' })
				-- don't override the built-in and fugitive keymaps
				local gs = package.loaded.gitsigns
				vim.keymap.set({ 'n', 'v' }, ']c', function()
					if vim.wo.diff then return ']c' end
					vim.schedule(function() gs.next_hunk() end)
					return '<Ignore>'
				end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
				vim.keymap.set({ 'n', 'v' }, '[c', function()
					if vim.wo.diff then return '[c' end
					vim.schedule(function() gs.prev_hunk() end)
					return '<Ignore>'
				end, {
					expr = true,
					buffer = bufnr,
					desc = 'Jump to previous hunk'
				})
			end
		},
	},




	{
		-- Autocompletion
		'hrsh7th/nvim-cmp',
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
			-- Adds LSP completion capabilities
			'hrsh7th/cmp-nvim-lsp',
			-- Adds a number of user-friendly snippets
			'rafamadriz/friendly-snippets',
			'hrsh7th/cmp-buffer', -- buffer completions
			'hrsh7th/cmp-path', -- path completions
			'hrsh7th/cmp-cmdline', -- cmdline completions
			'hrsh7th/cmp-emoji',
			'hrsh7th/cmp-nvim-lua',
		},
	},

	{
		-- LSP Configuration & Plugins
		'neovim/nvim-lspconfig',
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
		},
	},

	{ 'windwp/nvim-autopairs' },
	-- indent lines
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }
})


---------------------
----[keymaps]--------
---------------------
local key_map = vim.api.nvim_set_keymap
key_map("i", "jj", "<Esc>", { noremap = false })
key_map("n", "<leader>q", ":q<CR>", { noremap = true, silent = true })
key_map("n", "<leader>w", ":w<CR>", { noremap = true })
-- key_map("n", "<leader>e", [[<Cmd>NvimTreeToggle<CR>]], { noremap = true, silent = true })
-- key_map("n", "<leader>e", [[<Cmd>Lex<CR>]], { noremap = true, silent = true })
-- key_map("n", "<leader>e", [[<Cmd>Lex<CR>]], { noremap = true, silent = true })
key_map("n", "<leader>e", [[<Cmd>Explore<CR>]], { noremap = true, silent = true })
key_map("n", "<leader>;", [[<Cmd>BufferLinePick<CR>]], { noremap = true, silent = true })
key_map("n", "<leader>m", "[[<Cmd>cd %:p:h<CR>:pwd<CR>]]", { noremap = true, silent = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- key_map("n", "<leader>{", "ysiW`", { noremap = false })
-- key_map("n", '<leader>"', 'ysiW"', { noremap = false })
-- key_map("n", "<leader>'", "BBYSIw'", { NOREMAP = FALSE })
-- disable arrow
vim.cmd([[
cnoremap <Down> <Nop>
cnoremap <Left> <Nop>
cnoremap <Right> <Nop>
cnoremap <Up> <Nop>

inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>

nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>

vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
vnoremap <Up> <Nop>
]])

vim.cmd([[
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>
]])

vim.cmd([[
" Jump to the N buffer (by index) according to :ls buffer list
" where N is NOT the buffer number but the INDEX in such list
" NOTE: it does not include terminal buffers
nnoremap <Leader>1 :lua require("nvim-smartbufs").goto_buffer(1)<CR>
nnoremap <Leader>2 :lua require("nvim-smartbufs").goto_buffer(2)<CR>
nnoremap <Leader>3 :lua require("nvim-smartbufs").goto_buffer(3)<CR>
nnoremap <Leader>4 :lua require("nvim-smartbufs").goto_buffer(4)<CR>
nnoremap <Leader>5 :lua require("nvim-smartbufs").goto_buffer(5)<CR>
nnoremap <Leader>6 :lua require("nvim-smartbufs").goto_buffer(6)<CR>
nnoremap <Leader>7 :lua require("nvim-smartbufs").goto_buffer(7)<CR>
nnoremap <Leader>8 :lua require("nvim-smartbufs").goto_buffer(8)<CR>
nnoremap <Leader>9 :lua require("nvim-smartbufs").goto_buffer(9)<CR>

" Improved :bnext :bprev behavior (without considering terminal buffers)
nnoremap <Right> :lua require("nvim-smartbufs").goto_next_buffer()<CR>
nnoremap <Left> :lua require("nvim-smartbufs").goto_prev_buffer()<CR>

" Delete current buffer and goes back to the previous one
nnoremap <Leader>c :lua require("nvim-smartbufs").close_current_buffer()<CR>

" Delete the N buffer according to :ls buffer list
nnoremap <Leader>c1 :lua require("nvim-smartbufs").close_buffer(1)<CR>
nnoremap <Leader>c2 :lua require("nvim-smartbufs").close_buffer(2)<CR>
nnoremap <Leader>c3 :lua require("nvim-smartbufs").close_buffer(3)<CR>
nnoremap <Leader>c4 :lua require("nvim-smartbufs").close_buffer(4)<CR>
nnoremap <Leader>q5 :lua require("nvim-smartbufs").close_buffer(5)<CR>
nnoremap <Leader>c6 :lua require("nvim-smartbufs").close_buffer(6)<CR>
nnoremap <Leader>c7 :lua require("nvim-smartbufs").close_buffer(7)<CR>
nnoremap <Leader>c8 :lua require("nvim-smartbufs").close_buffer(8)<CR>
nnoremap <Leader>c9 :lua require("nvim-smartbufs").close_buffer(9)<CR>
]])


--- [[theme]] ---
vim.cmd([[
" Available values: 'hard', 'medium'(default), 'soft'
let g:gruvbox_material_background = 'hard'
colorscheme gruvbox-material
]])
-- vim.cmd([[colorscheme minimal-base16]])
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
-- vim.api.nvim_set_hl(0, "Folded", { bg = "none" })
vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
-- vim.api.nvim_set_hl(0, "SpecialKey", { bg = "none" })
-- vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
-- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
	defaults = {
		-- prompt_prefix = icons.ui.Telescope .. " ",
		selection_caret = "-> ",
		path_display = { "smart" },
		file_ignore_patterns = {
			".git/",
			"target/",
			"docs/",
			"vendor/*",
			"%.lock",
			"__pycache__/*",
			"%.sqlite3",
			"%.ipynb",
			"node_modules/*",
			-- "%.jpg",
			-- "%.jpeg",
			-- "%.png",
			"%.svg",
			"%.otf",
			"%.ttf",
			"%.webp",
			".dart_tool/",
			".github/",
			".gradle/",
			".idea/",
			".settings/",
			".vscode/",
			"__pycache__/",
			"build/",
			"env/",
			"gradle/",
			"node_modules/",
			"%.pdb",
			"%.dll",
			"%.class",
			"%.exe",
			"%.cache",
			"%.ico",
			"%.pdf",
			"%.dylib",
			"%.jar",
			"%.docx",
			"%.met",
			"smalljre_*/*",
			".vale/",
			"%.burp",
			"%.mp4",
			"%.mkv",
			"%.rar",
			"%.zip",
			"%.7z",
			"%.tar",
			"%.bz2",
			"%.epub",
			"%.flac",
			"%.tar.gz",
		},

		mappings = {
			-- i = {
			-- 	["<C-n>"] = actions.cycle_history_next,
			-- 	["<C-p>"] = actions.cycle_history_prev,

			-- 	["<C-j>"] = actions.move_selection_next,
			-- 	["<C-k>"] = actions.move_selection_previous,

			-- 	["<C-b>"] = actions.results_scrolling_up,
			-- 	["<C-f>"] = actions.results_scrolling_down,

			-- 	["<C-c>"] = actions.close,

			-- 	["<Down>"] = actions.move_selection_next,
			-- 	["<Up>"] = actions.move_selection_previous,

			-- 	["<CR>"] = actions.select_default,
			-- 	["<C-s>"] = actions.select_horizontal,
			-- 	["<C-v>"] = actions.select_vertical,
			-- 	["<C-t>"] = actions.select_tab,

			-- 	["<c-d>"] = require("telescope.actions").delete_buffer,
			-- 	-- ["<C-u>"] = actions.preview_scrolling_up,
			-- 	-- ["<C-d>"] = actions.preview_scrolling_down,
			-- 	-- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
			-- 	["<Tab>"] = actions.close,
			-- 	["<S-Tab>"] = actions.close,
			-- 	-- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
			-- 	["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
			-- 	["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
			-- 	["<C-l>"] = actions.complete_tag,
			-- 	["<C-h>"] = actions.which_key, -- keys from pressing <C-h>
			-- 	["<esc>"] = actions.close,
			-- },
			-- n = {
			-- 	["<esc>"] = actions.close,
			-- 	["<CR>"] = actions.select_default,
			-- 	["<C-x>"] = actions.select_horizontal,
			-- 	["<C-v>"] = actions.select_vertical,
			-- 	["<C-t>"] = actions.select_tab,
			-- 	["<C-b>"] = actions.results_scrolling_up,
			-- 	["<C-f>"] = actions.results_scrolling_down,
			-- 	["<Tab>"] = actions.close,
			-- 	["<S-Tab>"] = actions.close,
			-- 	-- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
			-- 	-- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
			-- 	["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
			-- 	["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
			-- 	["j"] = actions.move_selection_next,
			-- 	["k"] = actions.move_selection_previous,
			-- 	["H"] = actions.move_to_top,
			-- 	["M"] = actions.move_to_middle,
			-- 	["L"] = actions.move_to_bottom,
			-- 	["q"] = actions.close,
			-- 	["dd"] = require("telescope.actions").delete_buffer,
			-- 	["s"] = actions.select_horizontal,
			-- 	["v"] = actions.select_vertical,
			-- 	["t"] = actions.select_tab,
			-- 	["<Down>"] = actions.move_selection_next,
			-- 	["<Up>"] = actions.move_selection_previous,
			-- 	["gg"] = actions.move_to_top,
			-- 	["G"] = actions.move_to_bottom,
			-- 	["<C-u>"] = actions.preview_scrolling_up,
			-- 	["<C-d>"] = actions.preview_scrolling_down,
			-- 	["<PageUp>"] = actions.results_scrolling_up,
			-- 	["<PageDown>"] = actions.results_scrolling_down,
			-- 	["?"] = actions.which_key,
			-- },
		},
	},
	pickers = {
		live_grep = {
			theme = "ivy",
		},
		grep_string = {
			theme = "ivy",
		},
		find_files = {
			theme = "dropdown",
			previewer = false,
		},
		buffers = {
			theme = "ivy",
			previewer = false,
			initial_mode = "normal",
			layout_config = {
				height = 7,
			},
		},
		planets = {
			show_pluto = true,
			show_moon = true,
		},
		colorscheme = {
			-- enable_preview = true,
		},
		lsp_references = {
			theme = "dropdown",
			initial_mode = "normal",
		},
		lsp_definitions = {
			theme = "dropdown",
			initial_mode = "normal",
		},
		lsp_declarations = {
			theme = "dropdown",
			initial_mode = "normal",
		},
		lsp_implementations = {
			theme = "dropdown",
			initial_mode = "normal",
		},
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
	},
}


-- document existing key chains
local setup = {
	plugins = {
		marks = true,
		registers = true,
		spelling = {
			enabled = true,
			suggestions = 20,
		},
		presets = {
			operators = false,
			motions = false,
			text_objects = false,
			windows = true,
			nav = true,
			z = true,
			g = true,
		},
	},
	-- operators = { gc = "Comments" },
	key_labels = {
		-- ["<space>"] = "SPC",
		["<leader>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»",
		separator = "➜",
		group = "+",
	},
	popup_mappings = {
		scroll_down = "<c-d>",
		scroll_up = "<c-u>",
	},
	window = {
		border = "single",  -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3,              -- spacing between columns
		align = "center",         -- align columns left, center or right
	},
	ignore_missing = true,
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
	show_help = false,
	-- triggers = "auto",
	-- triggers = {"<leader>"},
	triggers_blacklist = {
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

local opts = {
	mode = "n",
	prefix = "<leader>",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = true,
}

local m_opts = {
	mode = "n",
	prefix = "m",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = true,
}

local mappings = {
	-- ["1"] = "which_key_ignore",
	-- a = { "<cmd>:CodeActionMenu<cr>", "Code Action" },
	b = { "<cmd>Telescope buffers<cr>", "Buffers" },
	-- e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
	-- v = { "<cmd>vsplit<cr>", "vsplit" },
	-- h = { "<cmd>split<cr>", "split" },
	-- h = { "<cmd>nohlsearch<CR>", "No HL" },
	-- q = { '<cmd>lua require("user.functions").smart_quit()<CR>', "Quit" },
	["/"] = { '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', "Comment" },
	-- ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
	c = { "<cmd>bdelete<CR>", "Close Buffer" },
	-- :lua require'lir.float'.toggle()
	-- ["f"] = {
	--   "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
	--   "Find files",
	-- },
	-- ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
	-- P = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
	-- ["R"] = { '<cmd>lua require("renamer").rename()<cr>', "Rename" },
	-- ["z"] = { "<cmd>ZenMode<cr>", "Zen" },
	-- ["gy"] = "Link",

	p = {
		name = "Packer",
		c = { "<cmd>PackerCompile<cr>", "Compile" },
		i = { "<cmd>PackerInstall<cr>", "Install" },
		s = { "<cmd>PackerSync<cr>", "Sync" },
		S = { "<cmd>PackerStatus<cr>", "Status" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
	},
	s = {
		name = "Split",
		s = { "<cmd>split<cr>", "HSplit" },
		v = { "<cmd>vsplit<cr>", "VSplit" },
	},
	x = {
		name = "Troubles",
		t = { "<cmd>TroubleToggle<cr>", "Trouble toggle" },
		c = { "<cmd>TroubleClose<cr>", "Trouble close" },
		r = { "<cmd>TroubleRefresh<cr>", "Trouble refresh" },
		w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Trouble toggle ws" },
		d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Trouble toggle dd" },
		-- l = { "<cmd>TroubleToggle loclist<cr>", "Trouble toggle loclist" },
		q = { "<cmd>TroubleToggle quickfix<cr>", "Trouble toggle quick fix" },
		-- r = { "<cmd>TroubleToggle lsp_references<cr>", "Trouble toggle ref" },
	},
	-- nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
	-- nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
	-- require("dapui").open()
	-- require("dapui").close()
	-- require("dapui").toggle()
	f = {
		name = "Find",
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		f = { "<cmd>Telescope find_files<cr>", "Find files" },
		t = { "<cmd>Telescope live_grep<cr>", "Find Text" },
		s = { "<cmd>Telescope grep_string<cr>", "Find String" },
		h = { "<cmd>Telescope help_tags<cr>", "Help" },
		H = { "<cmd>Telescope highlights<cr>", "Highlights" },
		l = { "<cmd>Telescope resume<cr>", "Last Search" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
	},
	g = {
		name = "Git",
		g = { "<cmd>:LazyGit<CR>", "Lazygit" },
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		l = { "<cmd>GitBlameToggle<cr>", "Blame" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Diff",
		},
	},
	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		-- c = { "<cmd>lua require('user.lsp').server_capabilities()<cr>", "Get Capabilities" },
		d = { "<cmd>TroubleToggle<cr>", "Diagnostics" },
		w = {
			"<cmd>Telescope lsp_workspace_diagnostics<cr>",
			"Workspace Diagnostics",
		},
		f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
		F = { "<cmd>LspToggleAutoFormat<cr>", "Toggle Autoformat" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		h = { "<cmd>lua require('lsp-inlayhints').toggle()<cr>", "Toggle Hints" },
		I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
		j = {
			"<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
			"Next Diagnostic",
		},
		k = {
			"<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
			"Prev Diagnostic",
		},
		v = { "<cmd>lua require('lsp_lines').toggle()<cr>", "Virtual Text" },
		l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		o = { "<cmd>SymbolsOutline<cr>", "Outline" },
		q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		R = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
	},
	-- s = {
	--   name = "Surround",
	--   ["."] = { "<cmd>lua require('surround').repeat_last()<cr>", "Repeat" },
	--   a = { "<cmd>lua require('surround').surround_add(true)<cr>", "Add" },
	--   d = { "<cmd>lua require('surround').surround_delete()<cr>", "Delete" },
	--   r = { "<cmd>lua require('surround').surround_replace()<cr>", "Replace" },
	--   q = { "<cmd>lua require('surround').toggle_quotes()<cr>", "Quotes" },
	--   b = { "<cmd>lua require('surround').toggle_brackets()<cr>", "Brackets" },
	-- },
	-- T = {
	-- 	name = "Treesitter",
	-- 	h = { "<cmd>TSHighlightCapturesUnderCursor<cr>", "Highlight" },
	-- 	p = { "<cmd>TSPlaygroundToggle<cr>", "Playground" },
	-- 	r = { "<cmd>TSToggle rainbow<cr>", "Rainbow" },
	-- },
	-- z = {
	--   name = "Zen",
	--   z = { "<cmd>TZAtaraxis<cr>", "Zen" },
	--   m = { "<cmd>TZMinimalist<cr>", "Minimal" },
	--   n = { "<cmd>TZNarrow<cr>", "Narrow" },
	--   f = { "<cmd>TZFocus<cr>", "Focus" },
	-- },
}

local vopts = {
	mode = "v",
	prefix = "<leader>",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = true,
}
local vmappings = {
	["/"] = { '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', "Comment" },
	s = { "<esc><cmd>'<,'>SnipRun<cr>", "Run range" },
	-- z = { "<cmd>TZNarrow<cr>", "Narrow" },
}

require('which-key').setup(setup)
require('which-key').register(mappings, opts)
require('which-key').register(vmappings, vopts)
require('which-key').register(m_mappings, m_opts)


-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup(
	{
		ensure_installed = {
			"clangd",
			"rust_analyzer",
			"gopls",
			"tsserver",
			"cssls",
			"jsonls",
			"lua_ls",
			"html",
			"eslint",
			"jdtls",
			"svelte",
			"eslint",
			"html"

		},
		automatic_installation = true,
	}
)

local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "gk", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "td", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<space>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
end


local lsp_flags = {
	debounce_text_changes = 150,
}

require("lspconfig")["pyright"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

-- require("lspconfig")["lua_ls"].setup({
-- 	on_attach = on_attach,
-- 	flags = lsp_flags,
-- })
--

require("lspconfig")["tsserver"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})
require("lspconfig")["rust_analyzer"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	settings = {
		["rust-analyzer"] = {
			assist = {
				importEnforceGranularity = true,
				importPrefix = "crate",
			},
			cargo = {
				allFeatures = true,
			},
			checkOnSave = {
				-- default: `cargo check`
				command = "clippy",
			},
		},
		inlayHints = {
			lifetimeElisionHints = {
				enable = true,
				useParameterNames = true,
			},
		},
	},
})
require("lspconfig")["clangd"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

local util = require("lspconfig/util")

require("lspconfig")["gopls"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	cmd = { "gopls", "serve" },
	filetypes = { "go", "gomod" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			analyses = {
				nilness = true,
				unusedparams = true,
				unusedwrite = true,
				useany = true,
				shadow = true,
			},
			experimentalPostfixCompletions = true,
			gofumpt = true,
			staticcheck = true,
			usePlaceholders = true,
		},
	},
})

-- function goimports(timeoutms)
-- 	local context = { source = { organizeImports = true } }
-- 	vim.validate({ context = { context, "t", true } })

-- 	local params = vim.lsp.util.make_range_params()
-- 	params.context = context

-- 	-- See the implementation of the textDocument/codeAction callback
-- 	-- (lua/vim/lsp/handler.lua) for how to do this properly.
-- 	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
-- 	if not result or next(result) == nil then
-- 		return
-- 	end
-- 	local actions = result[1].result
-- 	if not actions then
-- 		return
-- 	end
-- 	local action = actions[1]

-- 	-- textDocument/codeAction can return either Command[] or CodeAction[]. If it
-- 	-- is a CodeAction, it can have either an edit, a command or both. Edits
-- 	-- should be executed first.
-- 	if action.edit or type(action.command) == "table" then
-- 		if action.edit then
-- 			vim.lsp.util.apply_workspace_edit(action.edit)
-- 		end
-- 		if type(action.command) == "table" then
-- 			vim.lsp.buf.execute_command(action.command)
-- 		end
-- 	else
-- 		vim.lsp.buf.execute_command(action)
-- 	end
-- end

require("lspconfig")["jdtls"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

require("lspconfig")["eslint"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

require("lspconfig")["html"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

require("lspconfig")["cssls"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

require("lspconfig")["jsonls"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

require("lspconfig")["html"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})


require('nvim-treesitter.configs').setup({
	ensure_installed = { "go", "c", "lua", "rust", "bash", "vim" },
	sync_install = false,
	ignore_install = { "" },
	matchup = {
		enable = true,
		disable_virtual_text = true,
		disable = { "html" },
		-- include_match_words = false
	},
	highlight = {
		-- use_languagetree = true,
		enable = true,
		-- disable = { "css", "html" },
		-- disable = { "css", "markdown" },
		-- disable = { "markdown" },
		-- additional_vim_regex_highlighting = true,
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = true, disable = { "python", "css", "rust" } },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	autotag = {
		enable = true,
		disable = { "xml", "markdown" },
	},
	rainbow = {
		enable = false,
		extended_mode = false,
	},
	playground = {
		enable = true,
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["at"] = "@class.outer",
				["it"] = "@class.inner",
				["ac"] = "@call.outer",
				["ic"] = "@call.inner",
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
				["ai"] = "@conditional.outer",
				["ii"] = "@conditional.inner",
				["a/"] = "@comment.outer",
				["i/"] = "@comment.inner",
				["ab"] = "@block.outer",
				["ib"] = "@block.inner",
				["as"] = "@statement.outer",
				["is"] = "@scopename.inner",
				["aA"] = "@attribute.outer",
				["iA"] = "@attribute.inner",
				["aF"] = "@frame.outer",
				["iF"] = "@frame.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>."] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>,"] = "@parameter.inner",
			},
		},
	},
})
-- [[ Configure nvim-cmp ]]
-- See `:help cmp`

local cmp = require 'cmp'
local luasnip = require 'luasnip'

local buffer_fts = {
	"markdown",
	"toml",
	"yaml",
	"json",
}

local function contains(t, value)
	for _, v in pairs(t) do
		if v == value then
			return true
		end
	end
	return false
end

local compare = require("cmp.config.compare")

-- local check_backspace = function()
--   local col = vim.fn.col "." - 1
--   return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
-- end

local check_backspace = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- local icons = require("user.icons")

-- local kind_icons = icons.kind

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })
vim.api.nvim_set_hl(0, "CmpItemKindCrate", { fg = "#F64D00" })

vim.g.cmp_active = true

cmp.setup({
	enabled = function()
		local buftype = vim.api.nvim_buf_get_option(0, "buftype")
		if buftype == "prompt" then
			return false
		end
		return vim.g.cmp_active
	end,
	preselect = cmp.PreselectMode.None,
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
		["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<m-o>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-c>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<m-j>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<m-k>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<m-c>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<S-CR>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<Right>"] = cmp.mapping.confirm({ select = false }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.jumpable(1) then
				luasnip.jump(1)
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif check_backspace() then
				-- cmp.complete()
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	}),
	sources = {
		{ name = "crates",   group_index = 1 },
		{
			name = "nvim_lsp",
			filter = function(entry, ctx)
				local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
				if kind == "Snippet" and ctx.prev_context.filetype == "java" then
					return true
				end

				if kind == "Text" then
					return true
				end
			end,
			group_index = 2,
		},
		{ name = "nvim_lua", group_index = 2 },
		{ name = "luasnip",  group_index = 2 },
		{
			name = "buffer",
			group_index = 2,
			filter = function(entry, ctx)
				if not contains(buffer_fts, ctx.prev_context.filetype) then
					return true
				end
			end,
		},
		-- { name = "cmp_tabnine", group_index = 2 },
		{ name = "path",           group_index = 2 },
		{ name = "emoji",          group_index = 2 },
		{ name = "lab.quick_data", keyword_length = 4, group_index = 2 },
	},
	sorting = {
		priority_weight = 2,
		comparators = {
			-- require("copilot_cmp.comparators").prioritize,
			-- require("copilot_cmp.comparators").score,
			compare.offset,
			compare.exact,
			-- compare.scopes,
			compare.score,
			compare.recently_used,
			compare.locality,
			-- compare.kind,
			compare.sort_text,
			compare.length,
			compare.order,
			-- require("copilot_cmp.comparators").prioritize,
			-- require("copilot_cmp.comparators").score,
		},
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		-- documentation = true,
		documentation = {
			border = "rounded",
			winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
		},
		completion = {
			border = "rounded",
			winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
		},
	},
	experimental = {
		ghost_text = true,
	},
})


function git_branch_n()
	local git_branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
	if git_branch ~= "" then
		return " " .. git_branch .. " "
	else
		return " " .. "[null]" .. " "
	end
end

function getPath()
	local path = vim.fn.expand("%:F")
	if string.len(path) < 25 then
		return "%F"
	else
		return "%f"
	end
end

vim.o.statusline = "%f %m %r %B %{luaeval('git_branch_n()')} %= %y [%{&fileformat}] %l/%L %p%%"

vim.cmd([[
let g:netrw_liststyle=1
" let g:netrw_localcopydircmd = 'cp -r'
]])

require('nvim-autopairs').setup({
	check_ts = true,
	ts_config = { lua = { "string", "source" }, javascript = { "string", "template_string" }, java = false },
	disable_filetype = { "TelescopePrompt", "spectre_panel" },
	fast_wrap = {
		map = "<M-e>",
		chars = { "{", "[", "(", '"', "'" },
		pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
		offset = 0,
		end_key = "$",
		keys = "qwertyuiopzxcvbnmasdfghjkl",
		check_comma = true,
		highlight = "PmenuSel",
		highlight_grey = "LineNr",
	},
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp_status_ok, cmp = pcall(require, "cmp")

if not cmp_status_ok then
	return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
vim.g.indent_blankline_filetype_exclude = {
	"help",
	"startify",
	"dashboard",
	"packer",
	"neogitstatus",
	"NvimTree",
	"Trouble",
	"text",
}


require('ibl').setup({
	indent = {char = ":" },
	whitespace = {
		remove_blankline_trail = false,
	},
	scope = { enabled = false },
})

require('gitsigns').setup({
	signs = {
		add = { hl = "GitSignsAdd", text = "", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
		change = { hl = "GitSignsChange", text = "<<", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
		delete = { hl = "GitSignsDelete", text = "", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		topdelete = { hl = "GitSignsDelete", text = "", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		changedelete = { hl = "GitSignsChange", text = "<<", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
	},
	signcolumn = true,
	numhl = false,
	linehl = false,
	word_diff = false,
	watch_gitdir = {
		interval = 1000,
		follow_files = true,
	},
	attach_to_untracked = true,
	current_line_blame = false,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol",
		delay = 1000,
		ignore_whitespace = false,
	},
	current_line_blame_formatter_opts = {
		relative_time = false,
	},
	current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil,
	max_file_length = 40000,
	preview_config = {
		border = "rounded",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
	yadm = {
		enable = false,
	},
})

-- vim: set ts=4 sts=4 sw=4 et :
