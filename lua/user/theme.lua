-- vim.cmd([[colorscheme oh-lucy-evening]])
-- vim.cmd([[
-- " set termguicolors
-- let g:everforest_background = 'hard'
-- colorscheme everforest
-- ]])
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
