vim.cmd('colorscheme torte')

vim.opt.clipboard = 'unnamedplus'   -- use system clipboard 
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.mouse = 'a'                 -- allow the mouse to be used in Nvim
vim.g.netrw_liststyle = 1           -- show timestamps in listing

-- Tab
vim.opt.tabstop = 2                 -- number of visual spaces per TAB
vim.opt.softtabstop = 2             -- number of spacesin tab when editing
vim.opt.shiftwidth = 2              -- insert 4 spaces on a tab
vim.opt.expandtab = true            -- tabs are spaces, mainly because of python

-- UI config
vim.opt.number = true               -- show absolute number
vim.opt.relativenumber = true       -- add numbers to each line on the left side
vim.opt.cursorline = true           -- highlight cursor line underneath the cursor horizontally
vim.opt.splitbelow = false          -- open new vertical split top
vim.opt.splitright = true           -- open new horizontal splits right
vim.opt.termguicolors = true        -- enable 24-bit RGB color in the TUI

-- Searching
vim.opt.incsearch = true            -- search as characters are entered
vim.opt.hlsearch = true             -- highlight matches
vim.opt.ignorecase = true           -- ignore case in searches by default
vim.opt.smartcase = true            -- but make it case sensitive if an uppercase is entered

-- These bits cause a message to be displayed if the file is modified outside of nvim.
if vim.g.CheckUpdateStarted == nil then
    vim.g.CheckUpdateStarted = 1
    vim.fn.timer_start(1, function()
        vim.cmd('silent! checktime')
        vim.fn.timer_start(1000, function()
            CheckUpdate(timer)
        end)
    end)
end
function CheckUpdate(timer)
    vim.cmd('silent! checktime')
    vim.fn.timer_start(1000, function()
        CheckUpdate(timer)
    end)
end
