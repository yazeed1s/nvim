-- import mason plugin safely
local mason_status, mason = pcall(require, "mason")
if not mason_status then
  return
end

-- import mason-lspconfig plugin safely
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
  return
end

-- import mason-null-ls plugin safely
local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
  return
end

-- require("mason").setup()
-- enable mason
mason.setup()

mason_lspconfig.setup({
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
})

mason_null_ls.setup({
	ensure_installed = {
		"haml_lint",
		"rustfmt",
		"goimports",
		"google_java_format",
		"prettier",
		"clang-format",
		"gofumpt",
		"golines",
		"lua_format",
		"luacheck",
	},
	automatic_installation = true,
})
