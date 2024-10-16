return {
  'stevearc/oil.nvim',
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
      },
      float = {
        padding = 3,
        border = 'none',
      },
      win_options = {
        winblend = 0,
      },
    }
    return {}
  end,
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
