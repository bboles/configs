local M = {
  'tpope/vim-rhubarb',
}

M.config = function()
  vim.g.github_enterprise_urls = { 'https://clinical-ink.ghe.com' }
end

return M
