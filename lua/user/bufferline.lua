local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

bufferline.setup({
	options = {
		numbers = "buffer_id",
		close_command = "Bdelete! %d",
		right_mouse_command = "Bdelete! %d",
		left_mouse_command = "buffer %d",
		middle_mouse_command = nil,
		indicator_style = ":",
		-- indicator_icon = "▎",
		buffer_close_icon = "",
		-- buffer_close_icon = '',
		modified_icon = ">>",
		close_icon = "",
		-- close_icon = '',
		left_trunc_marker = "",
		right_trunc_marker = "",
		-- name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
		--   -- remove extension from markdown files for example
		--   if buf.name:match('%.md') then
		--     return vim.fn.fnamemodify(buf.name, ':t:r')
		--   end
		-- end,
		max_name_length = 30,
		max_prefix_length = 30,
		tab_size = 21,
		diagnostics = false, -- | "nvim_lsp" | "coc",
		diagnostics_update_in_insert = false,
		-- diagnostics_indicator = function(count, level, diagnostics_dict, context)
		--   return "("..count..")"
		-- end,
		-- NOTE: this will be called a lot so don't do any heavy processing here
		-- custom_filter = function(buf_number)
		--   -- filter out filetypes you don't want to see
		--   if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
		--     return true
		--   end
		--   -- filter out by buffer name
		--   if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
		--     return true
		--   end
		--   -- filter out based on arbitrary rules
		--   -- e.g. filter out vim wiki buffer from tabline in your work repo
		--   if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
		--     return true
		--   end
		-- end,
		offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
		show_buffer_icons = true,
		show_buffer_close_icons = false,
		show_close_icon = false,
		show_tab_indicators = true,
		persist_buffer_sort = true,
		-- [focused and unfocused]. eg: { '|', '|' }
		separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
		enforce_regular_tabs = true,
		always_show_bufferline = true,
		-- sort_by = 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
		--   -- add custom logic
		--   return buffer_a.modified > buffer_b.modified
		-- end
	},
})
