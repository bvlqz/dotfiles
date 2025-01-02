-- Platform-specific settings
local uname = vim.loop.os_uname()
local is_windows = uname.sysname == "Windows_NT"
local is_mac = uname.sysname == "Darwin"
local is_linux = uname.sysname == "Linux"

-- Common settings
vim.opt.number = true -- Enable line numbers
vim.opt.relativenumber = true -- Enable relative line numbers

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Disable line wrap
vim.opt.wrap = false

-- Disable swap and backup files
vim.opt.swapfile = false
vim.opt.backup = false

-- Enable undofile for persistent undo
vim.opt.undofile = true
-- Platform specific UndoTree settings: Long running undos
if is_windows then
    print("Setting up UndoTree for Windows")
    vim.opt.undodir = os.getenv("APPDATA") .. "\\nvim\\undodir"

elseif is_mac or is_linux then
    print("Setting up UndoTree for Mac/Linux")
    vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
end

-- Incremental search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Highlight column at 80 characters
vim.opt.colorcolumn = "80"