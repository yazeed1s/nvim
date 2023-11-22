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
