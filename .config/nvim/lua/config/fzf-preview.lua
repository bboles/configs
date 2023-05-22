vim.g.fzf_preview_command = 'bat'
vim.g.fzf_preview_default_fzf_options = {
  ['--reverse'] = true,
  ['--preview-window'] = 'wrap',
  ['--bind'] = 'ctrl-n:down,ctrl-p:up,ctrl-f:page-down,ctrl-b:page-up,ctrl-a:toggle-all'
}
vim.g.fzf_preview_use_dev_icons = 1


vim.api.nvim_set_keymap('n', '<Leader>f', ':<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>', { silent = true })
vim.api.nvim_set_keymap('x', '<Leader>f', ':<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>', { silent = true })

vim.api.nvim_set_keymap('n', '<Leader>p', ':<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>gs', ':<C-u>CocCommand fzf-preview.GitStatus<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ga', ':<C-u>CocCommand fzf-preview.GitActions<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>b', ':<C-u>CocCommand fzf-preview.Buffers<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>B', ':<C-u>CocCommand fzf-preview.AllBuffers<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>o', ':<C-u>CocCommand fzf-preview.FromResources buffer project_mru<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader><C-o>', ':<C-u>CocCommand fzf-preview.Jumps<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>g;', ':<C-u>CocCommand fzf-preview.Changes<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>/', ':<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="\'"<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>*', ':<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="\'"<C-r>=expand(\'<cword>\')<CR>"<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>gr', ':<C-u>CocCommand fzf-preview.ProjectGrep<Space>', {})
vim.api.nvim_set_keymap('x', '<Leader>gr', '"sy:CocCommand   fzf-preview.ProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, \'\\n\', \'\', \'g\'), \'/\', \'\\\\/\', \'g\')<CR>"', {})
vim.api.nvim_set_keymap('n', '<Leader>t', ':<C-u>CocCommand fzf-preview.BufferTags<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>q', ':<C-u>CocCommand fzf-preview.QuickFix<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>l', ':<C-u>CocCommand fzf-preview.LocationList<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>:', ':<C-u>CocCommand fzf-preview.CommandPalette<CR>', { silent = true })
