require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require('mason-lspconfig').setup({
    -- A list of servers to automatically install if they're not already installed
    ensure_installed = { 'pylsp',
                         'lua_ls',
                         'awk_ls',
                         'bashls',
                         'docker_compose_language_service',
                         'dockerls',
                         'dotls',
                         'jsonls',
                         'salt_ls',
                         'sqlls',
                         'terraformls',
                         'vimls',
                         'yamlls' },
})
