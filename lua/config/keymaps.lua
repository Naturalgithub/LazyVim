-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

keymap.set("i", "jj", "<Esc>")

-- 设置 J 键向下跳 5 行
vim.api.nvim_set_keymap("n", "J", "5j", { noremap = true })

-- 设置 K 键向上跳 5 行
vim.api.nvim_set_keymap("n", "K", "5k", { noremap = true })

-- 设置 H 键跳到行首
vim.api.nvim_set_keymap("n", "H", "^", { noremap = true })

-- 设置 L 键跳到行尾
vim.api.nvim_set_keymap("n", "L", "$", { noremap = true })

--打开终端后自动进入插入模式 start
local term_mode = vim.api.nvim_create_augroup("TERM_MODE", {clear = true})
vim.api.nvim_create_autocmd({"TermOpen"}, {
    pattern = "*",
    group = term_mode,
    command = [[normal i]]
})
-- - 打开终端后自动进入插入模式end 

if vim.g.vscode then
  -- VSCode extension
  -- 切换行注释
  vim.cmd("nnoremap gc <Cmd>call VSCodeNotify('editor.action.commentLine')<CR>")
  -- 切换块注释
  vim.cmd("nnoremap gC <Cmd>call VSCodeNotify('editor.action.blockComment')<CR>")
  -- 展开所有折叠
  vim.cmd("nnoremap zR <Cmd>call VSCodeNotify('editor.unfoldAll')<CR>")
  -- 关闭所有折叠
  vim.cmd("nnoremap zM <Cmd>call VSCodeNotify('editor.foldAll')<CR>")
  -- 展开当下折叠
  vim.cmd("nnoremap zo <Cmd>call VSCodeNotify('editor.unfold')<CR>")
  -- 关闭当下折叠
  vim.cmd("nnoremap zc <Cmd>call VSCodeNotify('editor.fold')<CR>")
  -- 切换当下折叠
  vim.cmd("nnoremap za <Cmd>call VSCodeNotify('editor.toggleFold')<CR>")
  -- 转到文件中上一个问题
  vim.cmd("nnoremap g[ <Cmd>call VSCodeNotify('editor.action.marker.prevInFiles')<CR>")
  -- 转到文件中下一个问题
  vim.cmd("nnoremap g] <Cmd>call VSCodeNotify('editor.action.marker.nextInFiles')<CR>")

  -- 用H替换掉^
  vim.cmd("noremap H ^")
  -- 用L替换掉$
  vim.cmd("noremap L $")
  -- 使用vscode的undo替换nvim的undo
  vim.cmd("nnoremap u <Cmd>call VSCodeNotify('undo')<CR>")
  -- 防止在上下移动时展开折叠
  local function moveCursor(direction)
    if (vim.fn.reg_recording() == '' and vim.fn.reg_executing() == '') then
        return ('g' .. direction)
    else
        return direction
    end
  end

  vim.keymap.set('n', 'k', function()
      return moveCursor('k')
  end, { expr = true, remap = true })
  vim.keymap.set('n', 'j', function()
      return moveCursor('j')
  end, { expr = true, remap = true })

  -- 判断是否是否有im-select
  if vim.fn.executable("im-select") then
    vim.cmd([[
        augroup AutoImSelect
        autocmd!
        autocmd InsertLeave * call system('im-select com.apple.keylayout.ABC')
        augroup END
    ]])
  end
 
else
  -- ordinary Neovim

  -- 添加普通 Neovim 的映射或设置
end
