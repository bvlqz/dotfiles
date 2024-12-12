-- Enable line numbers
vim.opt.number = true

-- Enable relative line numbers
vim.opt.relativenumber = true

-- Indents
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- No line wrap
vim.opt.wrap = false

-- No backups
vim.opt.swapfile = false
vim.opt.backup = false
-- UndoTree to have access to long running undos
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Incremental Search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Other
vim.opt.colorcolumn = "80"

