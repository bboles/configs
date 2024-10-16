return {
  'stevearc/oil.nvim',
  config = function()
    require('oil').setup {
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
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
}
