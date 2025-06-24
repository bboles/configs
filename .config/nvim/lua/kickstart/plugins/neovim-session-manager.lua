return {
  {
    'Shatur/neovim-session-manager',
    config = function()
      require('session_manager').setup {
        -- Default configuration (modify as needed)
        autoload_mode = require('session_manager.config').AutoloadMode.Disabled, -- or .CurrentDir or .LastSession
        autosave_last_session = true,
        autosave_ignore_not_normal = true,
        autosave_only_in_session = false,
      }
    end,
    dependencies = { 'nvim-lua/plenary.nvim' }, -- Required dependency
  },
}
