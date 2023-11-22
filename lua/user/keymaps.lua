-- keymaps
local key_map = vim.api.nvim_set_keymap

key_map("i", "jj", "<Esc>", { noremap = false })
key_map("n", "<leader>q", ":q<CR>", { noremap = true, silent = true })
key_map("n", "<leader>w", ":w<CR>", { noremap = true })
-- key_map("n", "<leader>e", [[<Cmd>NvimTreeToggle<CR>]], { noremap = true, silent = true })
-- key_map("n", "<leader>e", [[<Cmd>Lex<CR>]], { noremap = true, silent = true })

-- key_map("n", "<leader>e", [[<Cmd>Lex<CR>]], { noremap = true, silent = true })

key_map("n", "<leader>e", [[<Cmd>NERDTreeToggle<CR>]], { noremap = true, silent = true })
key_map("n", "<leader>;", [[<Cmd>BufferLinePick<CR>]], { noremap = true, silent = true })
key_map("n", "<leader>m", "[[<Cmd>cd %:p:h<CR>:pwd<CR>]]", { noremap = true, silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- key_map("n", "<leader>{", "ysiW`", { noremap = false })
-- key_map("n", '<leader>"', 'ysiW"', { noremap = false })
-- key_map("n", "<leader>'", "BBYSIw'", { NOREMAP = FALSE })
--
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
