local M = {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
}

M.config = function()
  require('telescope').setup({
    -- Use "dropdown" theme for all pickers.
    defaults = require('telescope.themes').get_dropdown {
      initial_mode = "normal",
      -- Width is 80% of screen.
      layout_config = {
        width = 0.8
      },
    },
    pickers = {
      live_grep = {
        initial_mode = "insert"
      },
      grep_string = {
        initial_mode = "insert"
      },
    },
  })

  vim.api.nvim_set_keymap('n', '<Leader>fF', ':Telescope find_files<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<Leader>ff', ':Telescope git_files<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<Leader>fG', ':Telescope grep_string<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<Leader>fg', ':Telescope live_grep<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<Leader>fb', ':Telescope buffers<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<Leader>fh', ':Telescope help_tags<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<Leader>fm', ':Telescope man_pages<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<Leader>f?', ':Telescope keymaps<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<Leader>fB', ':Telescope git_branches<CR>', { silent = true })
  vim.api.nvim_set_keymap('n', '<Leader>fs', ':Telescope git_stash<CR>', { silent = true })
end


return M
