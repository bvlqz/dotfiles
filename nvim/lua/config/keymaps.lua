-- lua/config/keymaps.lua

-- Telescope key mappings
local builtin = require('telescope.builtin')

-- Project File
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
-- Fuzzy Find, Just git files
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'All file Search' })
-- Grep
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({
        search = vim.fn.input('Grep String > ')
    })
end)

-- Undo Tree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Undo Tree' })

-- File explorer
vim.keymap.set('n', '<leader>e', ':Neotree<CR>', { desc = 'Open Netrw' })

-- fzf-lua key mappings
vim.keymap.set('n', '<leader>ff', require('fzf-lua').files, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fb', require('fzf-lua').buffers, { desc = 'Find Buffers' })
vim.keymap.set('n', '<leader>fl', require('fzf-lua').lines, { desc = 'Find Lines' })
vim.keymap.set('n', '<leader>fg', require('fzf-lua').grep, { desc = 'Grep Search' })
vim.keymap.set('n', '<leader>gf', require('fzf-lua').git_files, { desc = 'Git Files' })