require('fzf-lua').setup {
  'fzf-native',
  keymap = {
    fzf = {
      ["ctrl-z"] = "abort",
      ["ctrl-f"] = "half-page-down",
      ["ctrl-b"] = "half-page-up",
      ["ctrl-a"] = "beginning-of-line",
      ["ctrl-e"] = "end-of-line",
      ["alt-a"]  = "toggle-all",
      -- Only valid with fzf previewers (bat/cat/git/etc)
      ["f3"]     = "toggle-preview-wrap",
      ["f4"]     = "toggle-preview",
      ["ctrl-d"] = "preview-page-down",
      ["ctrl-u"] = "preview-page-up",
      ["ctrl-q"] = "select-all+accept",
    },
  },
  fzf_opts = {['--preview-window'] = 'down'}
}

vim.api.nvim_set_keymap('n', '<Leader>F', ':FzfLua files<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>f', ':FzfLua grep_project<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>G', ':FzfLua git_files<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>l', ':FzfLua lgrep_curbuf<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>h', ':FzfLua oldfiles<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>:', ':FzfLua command_history<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>/', ':FzfLua search_history<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>m', ':FzfLua man_pages<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>k', ':FzfLua keymaps<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>b', ':FzfLua buffers<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>?', ':FzfLua help_tags<CR>', { silent = true })
