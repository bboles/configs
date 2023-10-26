local M = {
  "ellisonleao/glow.nvim",
  config = true,
  cmd = "Glow"
}

M.config = function()
  require('glow').setup({
    install_path = "/opt/homebrew/bin/glow",
  })
end

return M
