local lazypath = vim.fn.stdpath('data') .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)


require("lazy").setup('plugins')
-- {
--   'junegunn/fzf',
--   { 'neoclide/coc.nvim', branch = 'release', config = [[require('config.coc')]] },
--   'ryanoasis/vim-devicons',
--   { 'lukas-reineke/indent-blankline.nvim', config = [[require('config.indent-blankline')]] },
--   { 'ibhagwan/fzf-lua',
--       requires = { 'nvim-tree/nvim-web-devicons' },
--       config = [[require('config.fzf-lua')]]
--   },
--   -- Git things.
--   'tpope/vim-fugitive',
--   'tpope/vim-rhubarb',
--   { 'shumphrey/fugitive-gitlab.vim', config = [[require('config.fugitive-gitlab')]] },
--   -- Python things.
--   'psf/black',
--   -- Status line.
--   { 'nvim-lualine/lualine.nvim',
--     requires = { 'nvim-tree/nvim-web-devicons', opt = true },
--     config = [[require('config.lualine')]]
--   },
--   'mbbill/undotree',
--   'sindrets/diffview.nvim',
-- }
