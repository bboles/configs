return {
  "folke/nvim-notify",
  config = function()
    require("notify").setup {
      stages = 'fade_in_slide_out',
    }
    vim.notify = require("notify")
  end
}