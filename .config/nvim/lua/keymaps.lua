-- define common options
local opts = {
    noremap = true,      -- non-recursive
    silent = true,       -- do not show message
}

-- Set leader key to comma.
vim.g.mapleader = ','
vim.o.timeoutlen = 3000

-----------------
-- Normal mode --
-----------------

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Netrw
vim.keymap.set('n', '-', ':Explore<CR>', {noremap = true, silent = true})

-- Paste from system clipboard
vim.keymap.set('n', '<leader>p', '"+p', {noremap = true})
vim.keymap.set('v', '<leader>p', '"+p', {noremap = true})
vim.keymap.set('n', '<D-v>', '"+p', {noremap = true})
vim.keymap.set('v', '<D-v>', '"+p', {noremap = true})
vim.keymap.set('i', '<D-v>', '<C-r>+', {noremap = true})
vim.keymap.set('c', '<D-v>', '<C-r>+', {noremap = true})

vim.api.nvim_set_keymap('n', '<F12>', ':nohlsearch<CR>:echo "Highlights Cleared!"<CR>', { silent = true })

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)
