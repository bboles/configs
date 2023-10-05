local M = {
  "shumphrey/fugitive-gitlab.vim",
}

M.config = function()
  vim.g.fugitive_gitlab_domains = {
    ['ssh://gitlab.tylersup.com:8022'] = 'https://gitlab.tylersup.com/'
  }
end

return M
