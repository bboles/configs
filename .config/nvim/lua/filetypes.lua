-- [[ Custom filetype detection ]]
-- See `:help vim.filetype.add()`

-- GitHub Actions files are yaml, but they have their own schema, keywords and
-- expression syntax. Give them the compound filetype `yaml.ghaction` so that
-- everything yaml keeps working (syntax, treesitter, yamlls, indent) while
-- ghaction specific ftplugins/snippets/schemas can hook in on top of it.
-- GitLab CI files get the same treatment via `yaml.gitlab` (a filetype yamlls
-- already knows about).
vim.filetype.add {
  filename = {
    ['.gitlab-ci.yml'] = 'yaml.gitlab',
    ['.gitlab-ci.yaml'] = 'yaml.gitlab',
  },
  pattern = {
    -- .github/workflows/*.yml|yaml
    ['.*/%.github/workflows/.*%.ya?ml'] = 'yaml.ghaction',
    -- composite/local actions: .github/actions/<name>/action.yml
    ['.*/%.github/actions/.*/action%.ya?ml'] = 'yaml.ghaction',
    -- action.yml at the root of an action repository
    ['.*/action%.ya?ml'] = 'yaml.ghaction',
    -- pipeline fragments pulled in via `include:`
    ['.*/%.gitlab/ci/.*%.ya?ml'] = 'yaml.gitlab',
    ['.*/ci/.*%.ya?ml'] = 'yaml.gitlab',
    ['.*%.gitlab%-ci%.ya?ml'] = 'yaml.gitlab',
  },
}

-- Treesitter resolves the parser from the *whole* filetype string, so tell it
-- which parser these compound filetypes use.
vim.treesitter.language.register('yaml', { 'yaml.ghaction', 'yaml.gitlab' })
