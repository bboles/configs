return {
  'stevearc/oil.nvim',
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },

  config = function()
    require('oil').setup {
      default_file_explorer = true,
      columns = {
        'icon',
        'permissions',
        'size',
        'mtime',
      },
      view_options = {
        show_hidden = true,
        sort = {
          { 'type', 'desc' },
          { 'name', 'asc' },
        },
      },
      float = {
        padding = 3,
        border = 'none',
      },
      win_options = {
        winblend = 0,
      },
    }
  end,
}
