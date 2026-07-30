local M = {
  'wellle/context.vim',
  config = function()
    -- Hide the context.vim line while a Telescope window is open, then
    -- restore it once the picker closes.
    local group = vim.api.nvim_create_augroup('context_telescope', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      group = group,
      pattern = 'TelescopePrompt',
      callback = function(args)
        vim.cmd 'ContextDisable'
        vim.api.nvim_create_autocmd({ 'BufWipeout', 'BufDelete' }, {
          group = group,
          buffer = args.buf,
          once = true,
          callback = function()
            vim.cmd 'ContextEnable'
          end,
        })
      end,
    })
  end,
}

return M
