-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

vim.cmd 'colorscheme torte'

vim.opt.guifont = { 'Iosevka Nerd Font Mono', ':h13' }

-- Make sure we set a title for the window.
vim.opt.title = true

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = false
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Netrw options
vim.g.netrw_liststyle = 1 -- show timestamps in listing
vim.g.netrw_maxfilenamelen = 55 -- max chars to show in a filename

-- Number of spaces that a <Tab> in the file counts for
vim.opt.tabstop = 2
-- Number of spaces to use for each step of (auto)indent
vim.opt.shiftwidth = 2
-- Use spaces instead of tabs
vim.opt.expandtab = true

-- use glab executable to lint
vim.cmd 'autocmd BufWritePost *.gitlab-ci.yml !glab ci lint %'

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- Check if 'rg' (Ripgrep) is executable
if vim.fn.executable 'rg' == 1 then
  vim.opt.grepprg = 'rg --vimgrep --smart-case --hidden'
  vim.opt.grepformat = '%f:%l:%c:%m'
end

vim.api.nvim_set_hl(0, 'TabLine', { bg = '#262626', fg = '#608B4E', ctermbg = 235, ctermfg = 65 })
vim.api.nvim_set_hl(0, 'TabLineSel', { bg = '#608B4E', fg = '#262626', ctermbg = 65, ctermfg = 235 })
vim.api.nvim_set_hl(0, 'TabLineFill', { bg = '#3C3C3C', fg = '#608B4E', ctermbg = 237, ctermfg = 65 })

-- This makes highlights disappear as soon as you press any movement key.
vim.on_key(function(char)
  if vim.fn.mode() == 'n' then
    local new_hlsearch = vim.tbl_contains({ '<CR>', 'n', 'N', '*', '#', '?', '/' }, vim.fn.keytrans(char))
    if vim.opt.hlsearch:get() ~= new_hlsearch then
      vim.opt.hlsearch = new_hlsearch
    end
  end
end, vim.api.nvim_create_namespace 'auto_hlsearch')

if vim.g.neovide then
  -- register autocommand callbacks to cleverly toggle
  -- relative numbers when scrolling, .. this works
  -- around the issue with frames dropped in neovide
  -- when scrolling quickly with relative numbering on
  vim.api.nvim_create_autocmd('WinScrolled', {
    callback = function()
      if vim.o.relativenumber then
        vim.cmd 'set norelativenumber'
      end
    end,
  })

  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    callback = function()
      if not vim.o.relativenumber then
        vim.cmd 'set relativenumber'
      end
    end,
  })
end

-- vim: ts=2 sts=2 sw=2 et
