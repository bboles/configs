local M = {
  'lukas-reineke/indent-blankline.nvim',
  tag = 'v2.20.8',
}

M.config = function()
  vim.opt.termguicolors = true
  vim.cmd [[highlight IndentBlanklineIndent1 guifg=#78383E gui=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent2 guifg=#8C7549 gui=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent3 guifg=#415433 gui=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent4 guifg=#255157 gui=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent5 guifg=#2E5473 gui=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent6 guifg=#563361 gui=nocombine]]

  require('indent_blankline').setup {
    space_char_blankline = ' ',
    char_list = { '|', '¦', '┆', '┊' },
    char_highlight_list = {
      'IndentBlanklineIndent1',
      'IndentBlanklineIndent2',
      'IndentBlanklineIndent3',
      'IndentBlanklineIndent4',
      'IndentBlanklineIndent5',
      'IndentBlanklineIndent6',
    },
  }
end

return M
