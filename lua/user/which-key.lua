local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

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
		border = "single", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "center", -- align columns left, center or right
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

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
which_key.register(m_mappings, m_opts)
