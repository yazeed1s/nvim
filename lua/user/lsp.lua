local status, nvim_lsp = pcall(require, "lspconfig")
if not status then
	return
end

local protocol = require("vim.lsp.protocol")

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
local enable_format_on_save = function(_, bufnr)
	vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = augroup_format,
		buffer = bufnr,
		callback = function()
			vim.lsp.buf.format({ bufnr = bufnr })
		end,
	})
end

-- local on_attach = function(client, bufnr)
-- 	local function buf_set_keymap(...)
-- 		vim.api.nvim_buf_set_keymap(bufnr, ...)
-- 	end
--
-- 	--local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
-- 	--buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
--
-- 	-- Mappings.
-- 	local opts = { noremap = true, silent = true }
--
-- 	buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
-- 	buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
-- 	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
-- 	buf_set_keymap("n", "gk", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
-- 	vim.api.nvim_create_autocmd("CursorHold", {
-- 		buffer = bufnr,
-- 		callback = function()
-- 			local opts_ = {
-- 				focusable = false,
-- 				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
-- 				border = "rounded",
-- 				source = "always",
-- 				prefix = " ",
-- 				scope = "cursor",
-- 			}
-- 			vim.diagnostic.open_float(nil, opts_)
-- 		end,
-- 	})
-- end

protocol.CompletionItemKind = {
	"", -- Text
	"", -- Method
	"", -- Function
	"", -- Constructor
	"", -- Field
	"", -- Variable
	"", -- Class
	"ﰮ", -- Interface
	"", -- Module
	"", -- Property
	"", -- Unit
	"", -- Value
	"", -- Enum
	"", -- Keyword
	"﬌", -- Snippet
	"", -- Color
	"", -- File
	"", -- Reference
	"", -- Folder
	"", -- EnumMember
	"", -- Constant
	"", -- Struct
	"", -- Event
	"ﬦ", -- Operator
	"", -- TypeParameter
}

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	update_in_insert = false,
	virtual_text = { spacing = 4, prefix = "!!" },
	severity_sort = true,
})

vim.o.updatetime = 250
vim.cmd([[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])

local signs = { Error = ">>", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
	virtual_text = {
		prefix = "!!",
	},
	update_in_insert = true,
	float = {
		source = "always", -- Or "if_many"
	},
})
-- local opts = { noremap = true, silent = true }
-- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
-- vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
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

function goimports(timeoutms)
	local context = { source = { organizeImports = true } }
	vim.validate({ context = { context, "t", true } })

	local params = vim.lsp.util.make_range_params()
	params.context = context

	-- See the implementation of the textDocument/codeAction callback
	-- (lua/vim/lsp/handler.lua) for how to do this properly.
	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
	if not result or next(result) == nil then
		return
	end
	local actions = result[1].result
	if not actions then
		return
	end
	local action = actions[1]

	-- textDocument/codeAction can return either Command[] or CodeAction[]. If it
	-- is a CodeAction, it can have either an edit, a command or both. Edits
	-- should be executed first.
	if action.edit or type(action.command) == "table" then
		if action.edit then
			vim.lsp.util.apply_workspace_edit(action.edit)
		end
		if type(action.command) == "table" then
			vim.lsp.buf.execute_command(action.command)
		end
	else
		vim.lsp.buf.execute_command(action)
	end
end

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

-- require("lspconfig").efm.setup({
-- 	init_options = { documentFormatting = true },
-- 	filetypes = { "lua" },
-- 	settings = {
-- 		rootMarkers = { ".git/" },
-- 		languages = {
-- 			lua = {
-- 				{
-- 					formatCommand = "lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=150 --break-after-table-lb",
-- 					formatStdin = true,
-- 				},
-- 			},
-- 		},
-- 	},
-- })

-- USER = vim.fn.expand("$USER")

-- local sumneko_root_path = "/Users/yazeed_1/lua-language-server/bin"
-- local sumneko_binary = "/Users/yazeed_1/lua-language-server/bin/lua-language-server"

-- if vim.fn.has("mac") == 1 then
-- 	sumneko_root_path = "/Users/" .. USER .. "~/lua-language-server"
-- 	sumneko_binary = "/Users/" .. USER .. "~/lua-language-server/bin/macOS/lua-language-server"
-- elseif vim.fn.has("unix") == 1 then
-- 	sumneko_root_path = "/home/" .. USER .. "~/lua-language-server"
-- 	sumneko_binary = "/home/" .. USER .. "~/lua-language-server/bin/Linux/lua-language-server"
-- else
-- 	print("Unsupported system for sumneko")
-- end

-- require("lspconfig").sumneko_lua.setup({
-- 	cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
-- 	settings = {
-- 		Lua = {
-- 			runtime = {
-- 				version = "LuaJIT",
-- 				path = vim.split(package.path, ";"),
-- 			},
-- 			diagnostics = {
-- 				globals = { "vim" },
-- 			},
-- 			workspace = {
-- 				library = {
-- 					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
-- 					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
-- 				},
-- 			},
-- 		},
-- 	},
-- })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "sh",
	callback = function()
		vim.lsp.start({
			name = "bash-language-server",
			cmd = { "bash-language-server", "start" },
		})
	end,
})
