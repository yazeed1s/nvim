local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP =
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

packer.init({
	max_jobs = 50,
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
		prompt_border = "rounded",
	},
})

return packer.startup(function(use)
	use("wbthomason/packer.nvim")
     use("nvim-lua/plenary.nvim")
	-- Go useful cmds
	use({
		"ray-x/go.nvim",
		config = function()
			require("go").setup()
		end,
	})
    use('nvim-lualine/lualine.nvim')
	-- use("ray-x/guihua.lua")
	-- use("kyazdani42/nvim-web-devicons")
	-- Lua
	use("preservim/nerdtree")
	use("shadowofseaice/yabs.nvim")
	use("rebelot/kanagawa.nvim")
	use("AlexvZyl/nordic.nvim")
	use({
		"folke/trouble.nvim",
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
					close = "q", -- close the list
					cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
					refresh = "r", -- manually refresh
					jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
					open_split = { "<c-x>" }, -- open buffer in new split
					open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
					open_tab = { "<c-t>" }, -- open buffer in new tab
					jump_close = { "o" }, -- jump to the diagnostic and close the list
					toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
					toggle_preview = "P", -- toggle auto_preview
					hover = "K", -- opens a small popup with the full multiline message
					preview = "p", -- preview the diagnostic location
					close_folds = { "zM", "zm" }, -- close all folds
					open_folds = { "zR", "zr" }, -- open all folds
					toggle_fold = { "zA", "za" }, -- toggle fold of current file
					previous = "k", -- previous item
					next = "j", -- next item
				},
				indent_lines = true, -- add an indent guide below the fold icons
				auto_open = false, -- automatically open the list when you have diagnostics
				auto_close = false, -- automatically close the list when you have no diagnostics
				auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
				auto_fold = false, -- automatically fold a file trouble list at creation
				auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
				signs = {
					-- icons / text used for a diagnostic
					error = "",
					warning = "",
					hint = "",
					information = "",
					other = "﫠",
				},
				use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
			})
		end,
	})
	-- status line (disabled for now)
	-- use({
	-- 	"nvim-lualine/lualine.nvim",
	-- 	requires = { "kyazdani42/nvim-web-devicons", opt = true },
	-- })
	-- telescope -> file & text seraching
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" }, { "kdheepak/lazygit.nvim" } },
	})
	-- Comment
	use("numToStr/Comment.nvim")
	-- Quickfix
	-- use({ "akinsho/bufferline.nvim", requires = "nvim-tree/nvim-web-devicons" })
	-- colorscheme
	use("Yazeed1s/oh-lucy.nvim")
	use("sainnhe/everforest")
	use("sainnhe/gruvbox-material")
	use("shaunsingh/nord.nvim")

	-- Syntax/Treesitter
	use("nvim-treesitter/nvim-treesitter", "nvim-treesitter/playground")
	-- use("nvim-treesitter/nvim-treesitter-textobjects")
	use("windwp/nvim-autopairs")
	-- indent lines
	use("lukas-reineke/indent-blankline.nvim")
	-- file manager
	-- none
	-- LSP
    -- managing & installing lsp servers, linters & formatters
    use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
    use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig
    -- configuring lsp servers
    use("neovim/nvim-lspconfig") -- easily configure language servers
    use("hrsh7th/cmp-nvim-lsp") -- for autocompletion

     -- formatting & linting
    use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
    use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

	use("simrat39/symbols-outline.nvim")
	-- hints
	use("lvimuser/lsp-inlayhints.nvim")
	--
	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({})
		end,
	})
  --   use {
  -- 'VonHeikemen/lsp-zero.nvim',
  -- branch = 'v2.x',
  -- requires = {
  --       -- LSP Support
  --       {'neovim/nvim-lspconfig'},             -- Required
  --       {                                      -- Optional
  --       'williamboman/mason.nvim',
  --       run = function()
  --           pcall(vim.cmd, 'MasonUpdate')
  --       end,
  --       },
  --       {'williamboman/mason-lspconfig.nvim'}, -- Optional
  --
  --       -- Autocompletion
  --       {'hrsh7th/nvim-cmp'},     -- Required
  --       {'hrsh7th/cmp-nvim-lsp'}, -- Required
  --       {'L3MON4D3/LuaSnip'},     -- Required
  --       }
  --   }
	-- nvim-cmp
	-- Completion
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-emoji")
	use("hrsh7th/cmp-nvim-lua")

	-- tabs
	-- use({
	-- 	"crispgm/nvim-tabline",
	-- 	config = function()
	-- 		require("tabline").setup({
	-- 			show_index = true, -- show tab index
	-- 			show_modify = true, -- show buffer modification indicator
	-- 			show_icon = false, -- show file extension icon
	-- 			modify_indicator = "[+]", -- modify indicator
	-- 			no_name = "No name", -- no name buffer name
	-- 			brackets = { "[", "]" }, -- file name brackets surrounding
	-- 		})
	-- 	end,
	-- })
	-- git
	use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
	-- use("f-person/git-blame.nvim")

	-- Key table
	use("folke/which-key.nvim")
	-- Snippet
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use
	-- lsp progress
	use({
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({
				text = {
					spinner = "dots_toggle", -- animation shown when tasks are ongoing
					done = "✔", -- character shown when all tasks are complete
					commenced = "Started", -- message shown when task starts
					completed = "Completed", -- message shown when task completes
				},
				align = {
					bottom = true, -- align fidgets along bottom edge of buffer
					right = true, -- align fidgets along right edge of buffer
				},
				timer = {
					spinner_rate = 125, -- frame rate of spinner animation, in ms
					fidget_decay = 2000, -- how long to keep around empty fidget, in ms
					task_decay = 1000, -- how long to keep around completed task, in ms
				},
				window = {
					relative = "win", -- where to anchor, either "win" or "editor"
					blend = 100, -- &winblend for the window
					zindex = nil, -- the zindex value for the window
					border = "none", -- style of border for the fidget window
				},
				fmt = {
					leftpad = true, -- right-justify text in fidget box
					stack_upwards = true, -- list of tasks grows upwards
					max_width = 0, -- maximum width of the fidget box
					-- function to format fidget title
					fidget = function(fidget_name, spinner)
						return string.format("%s %s", spinner, fidget_name)
					end,
					-- function to format each task line
					task = function(task_name, message, percentage)
						return string.format(
							"%s%s [%s]",
							message,
							percentage and string.format(" (%s%%)", percentage) or "",
							task_name
						)
					end,
				},
			})
		end,
	})
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
