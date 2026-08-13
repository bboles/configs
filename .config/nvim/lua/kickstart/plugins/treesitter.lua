-- NOTE: nvim-treesitter's `main` branch is a plain parser installer: it does
-- *not* provide the old `highlight`/`indent`/`auto_install` modules. Highlighting
-- and folding come from Neovim itself (`:help treesitter-highlight`), so we wire
-- them up with a FileType autocommand below.

-- Parsers that should always be installed.
local ensure_installed = {
  'bash',
  'c',
  'diff',
  'dockerfile',
  'gitcommit',
  'go',
  'gomod',
  'gosum',
  'hcl',
  'html',
  'json',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'python',
  'query',
  'terraform',
  'toml',
  'vim',
  'vimdoc',
  'yaml',
}

-- Filetypes that also want Vim's regex syntax on top of treesitter.
local additional_vim_regex_highlighting = { ruby = true }

-- Filetypes that should keep Vim's indent rules (treesitter indent is experimental).
local disable_treesitter_indent = { ruby = true }

return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local ts = require 'nvim-treesitter'
      local ts_config = require 'nvim-treesitter.config'

      ts.setup {
        install_dir = vim.fs.joinpath(vim.fn.stdpath 'data', 'site'),
      }

      -- Install anything missing in the background (no-op when up to date).
      local installed = {}
      for _, lang in ipairs(ts_config.get_installed 'parsers') do
        installed[lang] = true
      end
      local missing = vim.tbl_filter(function(lang)
        return not installed[lang]
      end, ensure_installed)
      if #missing > 0 then
        ts.install(missing)
      end

      local function start(buf, lang)
        if not vim.api.nvim_buf_is_valid(buf) then
          return
        end
        if not pcall(vim.treesitter.start, buf, lang) then
          return
        end
        if additional_vim_regex_highlighting[lang] then
          vim.bo[buf].syntax = 'on'
        end
        if not disable_treesitter_indent[lang] then
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
        -- Treesitter based folding, opt in by uncommenting:
        -- vim.wo[0][0].foldmethod = 'expr'
        -- vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      end

      local installing = {} ---@type table<string, boolean>

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('kickstart-treesitter', { clear = true }),
        callback = function(args)
          -- Handles compound filetypes such as `yaml.ghaction` (see lua/filetypes.lua).
          local lang = vim.treesitter.language.get_lang(args.match)
          if not lang then
            return
          end

          -- Parser already available (installed or shipped with Neovim).
          -- NOTE: `language.add()` returns nil + err instead of throwing.
          local ok, loaded = pcall(vim.treesitter.language.add, lang)
          if ok and loaded then
            start(args.buf, lang)
            return
          end

          -- Otherwise behave like the old `auto_install = true`.
          if installing[lang] or not vim.list_contains(ts_config.get_available(), lang) then
            return
          end
          installing[lang] = true
          ts.install(lang):await(function()
            vim.schedule(function()
              installing[lang] = nil
              start(args.buf, lang)
            end)
          end)
        end,
      })

      -- There are additional treesitter plugins that you can use to interact
      -- with treesitter. You should go explore a few and see what interests you:
      --
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
