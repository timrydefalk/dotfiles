return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
            "jay-babu/mason-null-ls.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
            "aznhe21/actions-preview.nvim",
            "saghen/blink.cmp",
            "seblyng/roslyn.nvim",
            "nvimtools/none-ls.nvim",
        },
        event = { "BufReadPre", "BufNewFile" },
        config = function(_, _)
            local opts = require("config.lsp")
            local icons = require("config.icons")
            local lsp_lines = require("lsp_lines")
            local actions_preview = require("actions-preview")
            local mason_lsp = require("mason-lspconfig")
            local null_ls = require("null-ls")

            mason_lsp.setup({
                ensure_installed = {},
                automatic_enable = { exclude = { "lua_ls" } }
            })

            lsp_lines.setup({})
            actions_preview.setup({ backend = "snacks" })

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            for server, config in pairs(opts.servers) do
                -- passing config.capabilities to blink.cmp merges with the capabilities in your
                -- `opts[server].capabilities, if you"ve defined it
                config.capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

                if server == "roslyn" then
                    config.capabilities.textDocument.diagnostic.dynamicRegistration = true
                end

                if not vim.tbl_isempty(config) then
                    vim.lsp.config(server, config)
                end

                if server == "roslyn" then
                    require("roslyn").setup({})
                else
                    vim.lsp.enable(server)
                end
            end

            local sources = {}

            for _, formatters in pairs(opts.formatters) do
                local formatter = null_ls.builtins.formatting[formatters]
                if formatter then
                    table.insert(sources, formatter)
                end
            end

            for _, linter in pairs(opts.linters) do
                local diagnostic = null_ls.builtins.diagnostics[linter]
                if diagnostic then
                    table.insert(sources, diagnostic)
                end
            end

            null_ls.setup({
                sources = sources,
            })

            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
                        [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
                        [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
                        [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
                    },
                    linehl = {
                        [vim.diagnostic.severity.ERROR] = "Error",
                        [vim.diagnostic.severity.WARN] = "Warn",
                        [vim.diagnostic.severity.INFO] = "Info",
                        [vim.diagnostic.severity.HINT] = "Hint",
                    },
                },
                update_in_insert = false,
                underline = true,
                severity_sort = true,
                virtual_text = { severity = { min = vim.diagnostic.severity.ERROR } },
                virtual_lines = { only_current_line = true }
            })
        end
    },
}
