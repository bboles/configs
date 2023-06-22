require('fzf-lua').setup {
  'fzf-native',
  fzf_opts = {
    ['--preview-window'] = 'down'
  }
}

vim.api.nvim_set_keymap('n', '<Leader>F', ':FzfLua files<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>f', ':FzfLua grep_project<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>G', ':FzfLua git_files<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>l', ':FzfLua lgrep_curbuf<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>h', ':FzfLua oldfiles<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>:', ':FzfLua command_history<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>/', ':FzfLua search_history<CR>', { silent = true })
