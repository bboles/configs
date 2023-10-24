vim.cmd('colorscheme torte')

vim.opt.clipboard = 'unnamedplus'   -- use system clipboard 
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.mouse = 'a'                 -- allow the mouse to be used in Nvim
vim.g.netrw_liststyle = 1           -- show timestamps in listing
vim.g.netrw_maxfilenamelen = 55
vim.opt.scrolloff = 8
vim.opt.termguicolors = true

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
-- vim.opt.colorcolumn = "80"

-- Searching
vim.opt.incsearch = true            -- search as characters are entered
vim.opt.hlsearch = true             -- highlight matches
vim.opt.ignorecase = false          -- don't ignore case in searches by default

-- This makes highlights disappear as soon as you press any movement key.
vim.on_key(function(char)
  if vim.fn.mode() == "n" then
    local new_hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
    if vim.opt.hlsearch:get() ~= new_hlsearch then vim.opt.hlsearch = new_hlsearch end
  end
end, vim.api.nvim_create_namespace "auto_hlsearch")

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

-- Lint on save of .gitlab-ci.yml.
vim.cmd('autocmd BufWritePost *.gitlab-ci.yml !glab ci lint %')


function create_session_with_git_branch()
  -- Get current git branch
  local git_branch = vim.fn.system('git rev-parse --abbrev-ref HEAD 2>/dev/null')
  git_branch = string.gsub(git_branch, "\n", "")

  -- Check if currently on a git branch
  if git_branch ~= "" then
    -- Convert '/' to '_'
    git_branch = string.gsub(git_branch, "/", "_")

    -- Save the session file with .vim extension
    local session_file = git_branch .. '.vim'
    vim.cmd('mksession! ' .. session_file)
    vim.notify('Created session: ' .. session_file, 'info')
  else
    vim.notify('Not currently on a git branch', 'warn')
  end
end
