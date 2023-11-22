-- +-------------------------------------------------+
-- | A | B | C                             X | Y | Z |
-- +-------------------------------------------------+
-- insert -> insert mode, normal -> normal mode, visual -> visual mode
local custom_16 = require("lualine.themes.base16")
-- Change the background of lualine_c section for normal mode
custom_16.normal.c.bg = "#1A191E"
custom_16.normal.b.bg = "#1A191E"
--custom_16.normal.a.bg = '#8BB8D0'
custom_16.normal.c.fg = "#695F69"
custom_16.normal.b.fg = "#695F69"
custom_16.insert.b.fg = "#695F69"
custom_16.insert.b.bg = "#1A191E"
custom_16.visual.b.bg = "#1A191E"
custom_16.insert.b.fg = "#695F69"
custom_16.visual.b.fg = "#695F69"
custom_16.insert.a.bg = "#A896BE"
-- +-------------------------------------------------+
-- | A | B | C                             X | Y | Z |
-- +-------------------------------------------------+
-- insert -> insert mode, normal -> normal mode, visual -> visual mode
local custom = require("lualine.themes.gruvbox")
-- custom.normal.c.bg = "none"
-- custom.insert.c.bg = "none"
-- custom.visual.c.bg = "none"
-- custom.insert.c.fg = "#928374"
-- custom.normal.c.fg = "#928374"
-- custom.visual.c.fg = "#928374"
-- custom.insert.b.bg = "none"
-- custom.normal.b.bg = "none"
-- custom.visual.b.bg = "none"
-- custom.insert.b.fg = "#ea6962"
-- custom.normal.b.fg = "#ea6962"
-- custom.normal.a.bg = "none"
-- custom.normal.a.fg = "#d5c4a1"
-- custom.visual.b.fg = "#ea6962"
-- custom.insert.a.fg = "#83a598"
-- custom.visual.a.fg = "#d3869b"
-- custom.insert.a.bg = "none"
-- custom.visual.a.bg = "none"

custom.normal.c.bg = "#282828"
custom.insert.c.bg = "#282828"
custom.visual.c.bg = "#282828"
custom.insert.c.fg = "#928374"
custom.normal.c.fg = "#928374"
custom.visual.c.fg = "#928374"
custom.insert.b.bg = "#282828"
custom.normal.b.bg = "#282828"
custom.visual.b.bg = "#282828"
custom.insert.b.fg = "#d4be98"
custom.normal.b.fg = "#d4be98"
custom.visual.b.fg = "#d4be98"
custom.insert.a.bg = "#282828"
custom.normal.a.bg = "#282828"
custom.visual.a.bg = "#282828"
custom.insert.a.fg = "#83a598"
custom.visual.a.fg = "#d3869b"
custom.normal.a.fg = "#928374"

require("lualine").setup({

	options = {
		icons_enabled = true,
		-- theme = custom_16,
		-- thene = "everforest",
		theme = custom,
		-- theme = "base16",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = {
			{
				"filename",
				file_status = true,
				newfile_status = true,
				path = 3,
				-- 0: Just the filename
				-- 1: Relative path
				-- 2: Absolute path
				-- 3: Absolute path, with tilde as the home directory
				shorting_target = 80,
				symbols = {
					modified = "[+]",
					readonly = "[-]",
					unnamed = "[No Name]",
					newfile = "[New]",
				},
			},
		},

		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
