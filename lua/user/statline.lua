local fn = vim.fn
local api = vim.api

local set_hl = function(group, options)
	local bg = options.bg == nil and "" or "guibg=" .. options.bg
	local fg = options.fg == nil and "" or "guifg=" .. options.fg
	local gui = options.gui == nil and "" or "gui=" .. options.gui

	vim.cmd(string.format("hi %s %s %s %s", group, bg, fg, gui))
end

local highlights = {
	{ "StatusLine", { fg = "#1A191E", bg = "#7B717C" } },
	{ "StatusLineNC", { fg = "#1A191E", bg = "#7B717C" } },
	{ "Mode", { bg = "#8BB8D0", fg = "#1D2021", gui = "bold" } },
	{ "LineCol", { bg = "#1A191E", fg = "#7B717C", gui = "bold" } },
	{ "Git", { bg = "#1A191E", fg = "#7B717C" } },
	{ "Filetype", { bg = "#1A191E", fg = "#FF7DA3" } },
	{ "Filename", { bg = "#1A191E", fg = "#7B717C" } },
	{ "ModeAlt", { bg = "#1A191E", fg = "#928374" } },
	{ "GitAlt", { bg = "#1A191E", fg = "#1A191E" } },
	{ "LineColAlt", { bg = "#1A191E", fg = "#928374" } },
	{ "FiletypeAlt", { bg = "#1A191E", fg = "#1A191E" } },
}

for _, highlight in ipairs(highlights) do
	set_hl(highlight[1], highlight[2])
end

local M = {}

local active_sep = "blank"

M.separators = {
	arrow = { "", "" },
	rounded = { "", "" },
	blank = { "", "" },
}

M.colors = {
	active = "%#StatusLine#",
	inactive = "%#StatuslineNC#",
	mode = "%#Mode#",
	mode_alt = "%#ModeAlt#",
	git = "%#Git#",
	git_alt = "%#GitAlt#",
	filetype = "%#Filetype#",
	filetype_alt = "%#FiletypeAlt#",
	line_col = "%#LineCol#",
	line_col_alt = "%#LineColAlt#",
}

M.trunc_width = setmetatable({
	mode = 80,
	git_status = 90,
	filename = 140,
	line_col = 60,
}, {
	__index = function()
		return 80
	end,
})

M.is_truncated = function(_, width)
	local current_width = api.nvim_win_get_width(0)
	return current_width < width
end

M.modes = setmetatable({
	["n"] = { "Normal", "N" },
	["no"] = { "N·Pending", "N·P" },
	["v"] = { "Visual", "V" },
	["V"] = { "V·Line", "V·L" },
	[""] = { "V·Block", "V·B" }, -- this is not ^V, but it's , they're different
	["s"] = { "Select", "S" },
	["S"] = { "S·Line", "S·L" },
	[""] = { "S·Block", "S·B" }, -- same with this one, it's not ^S but it's 
	["i"] = { "Insert", "I" },
	["ic"] = { "Insert", "I" },
	["R"] = { "Replace", "R" },
	["Rv"] = { "V·Replace", "V·R" },
	["c"] = { "Command", "C" },
	["cv"] = { "Vim·Ex ", "V·E" },
	["ce"] = { "Ex ", "E" },
	["r"] = { "Prompt ", "P" },
	["rm"] = { "More ", "M" },
	["r?"] = { "Confirm ", "C" },
	["!"] = { "Shell ", "S" },
	["t"] = { "Terminal ", "T" },
}, {
	__index = function()
		return { "Unknown", "U" } -- handle edge cases
	end,
})

M.get_current_mode = function(self)
	local current_mode = api.nvim_get_mode().mode
	if self:is_truncated(self.trunc_width.mode) then
		return string.format(" %s ", self.modes[current_mode][2]):upper()
	end
	return string.format(" %s ", self.modes[current_mode][1]):upper()
end

M.get_git_status = function(self)
	local signs = vim.b.gitsigns_status_dict or { head = "", added = 0, changed = 0, removed = 0 }
	local is_head_empty = signs.head ~= ""
	if self:is_truncated(self.trunc_width.git_status) then
		return is_head_empty and string.format("  %s ", signs.head or "") or ""
	end
	return is_head_empty
			and string.format(" +%s ~%s -%s |  %s ", signs.added, signs.changed, signs.removed, signs.head)
		or ""
end

M.get_filename = function(self)
	if self:is_truncated(self.trunc_width.filename) then
		return " %<%f "
	end
	return " %<%F "
end

M.get_filetype = function()
	local file_name, file_ext = fn.expand("%:t"), fn.expand("%:e")
	local icon = require("nvim-web-devicons").get_icon(file_name, file_ext, { default = true })
	local filetype = vim.bo.filetype
	if filetype == "" then
		return ""
	end
	return string.format(" %s %s ", icon, filetype):lower()
end

M.get_line_col = function(self)
	if self:is_truncated(self.trunc_width.line_col) then
		return " %l:%c "
	end
	return " Ln %l, Col %c "
end

M.set_active = function(self)
	local colors = self.colors
	local mode = colors.mode .. self:get_current_mode()
	local mode_alt = colors.mode_alt .. self.separators[active_sep][1]
	local git = colors.git .. self:get_git_status()
	local git_alt = colors.git_alt .. self.separators[active_sep][1]
	local filename = colors.inactive .. self:get_filename()
	local filetype_alt = colors.filetype_alt .. self.separators[active_sep][2]
	local filetype = colors.filetype .. self:get_filetype()
	local line_col = colors.line_col .. self:get_line_col()
	local line_col_alt = colors.line_col_alt .. self.separators[active_sep][2]
	return table.concat({
		colors.active,
		mode,
		mode_alt,
		git,
		git_alt,
		"%=",
		filename,
		"%=",
		filetype_alt,
		filetype,
		line_col_alt,
		line_col,
	})
end

M.set_inactive = function(self)
	return self.colors.inactive .. "%= %F %="
end

M.set_explorer = function(self)
	local title = self.colors.mode .. "   "
	local title_alt = self.colors.mode_alt .. self.separators[active_sep][2]
	return table.concat({ self.colors.active, title, title_alt })
end

Statusline = setmetatable(M, {
	__call = function(statusline, mode)
		if mode == "active" then
			return statusline:set_active()
		end
		if mode == "inactive" then
			return statusline:set_inactive()
		end
		if mode == "explorer" then
			return statusline:set_explorer()
		end
	end,
})
-- set statusline
-- TODO: replace this once we can define autocmd using lua
api.nvim_exec(
	[[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline('active')
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline('inactive')
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline('explorer')
  augroup END
]],
	false
)

Statusline.get_lsp_diagnostic = function(self)
	local result = {}
	local levels = {
		errors = "Error",
		warnings = "Warning",
		info = "Information",
		hints = "Hint",
	}

	for k, level in pairs(levels) do
		result[k] = vim.lsp.diagnostic.get_count(0, level)
	end

	if self:is_truncated(120) then
		return ""
	else
		return string.format(
			"| :%s :%s :%s :%s ",
			result["errors"] or 0,
			result["warnings"] or 0,
			result["info"] or 0,
			result["hints"] or 0
		)
	end
end
