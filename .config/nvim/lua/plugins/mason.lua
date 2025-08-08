return {
    {
        "mason-org/mason.nvim",
        lazy = false,
        opts = {
            ui = {
                border = "rounded",
            },
            registries = {
                "github:mason-org/mason-registry",
                "github:Crashdummyy/mason-registry",
            },
        }
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
            "jay-babu/mason-null-ls.nvim",
        },
        lazy = false,
        config = function()
            local opts = require("config.lsp")
            local utils = require("utils")

            require("mason-tool-installer").setup({
                ensure_installed = utils.merge_arrays(
                    utils.get_keys_from_table(opts.servers),
                    opts.linters,
                    opts.formatters,
                    opts.debuggers,
                    opts.dependencies
                )
            })
        end
    },
}
