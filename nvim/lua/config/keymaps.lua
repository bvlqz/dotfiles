vim.g.mapleader = " "
-- While in normal mode, if I press <leader>pv it will execute vim.cmd.Ex command
-- proyect view
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Project View" })

-- Telescope
local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>pf", telescope.find_files, { desc = "Project Find" })
vim.keymap.set("n", "<leader>ps", function()
    telescope.grep_string({ search = vim.fn.input("grep > ") })
end, { desc = "Project Search" })

vim.keymap.set("n", "<leader>pg", function()
    require('telescope.builtin').live_grep()
end, { desc = "Project Grep" })

-- UndoTree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undo Tree Toggle" })

-- Ctrl + D (Half page jump Down) to leave the cursor centered on screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- Ctrl + U (Half page jump Up) to leave the cursor centered on screen
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Search terms to stay in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Yank to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y", { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "Yank line to system clipboard" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "Yank to system clipboard" })

-- Do not enter Ex Mode - Never :)
vim.keymap.set("n", "Q", "<nop>")

-- Replace current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Select/Replace Word on Cursor" })

-- LSP
