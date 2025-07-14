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
        opts = {
            -- For formatters or linters respectively
            -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins
            --
            -- linters -> represent diagnostics in null-ls
            -- formatters -> represent formatting in null-ls
            --
            -- currently not added: hover, completion and code_actions from null-ls
            linters = { "hadolint", "actionlint" },
            formatters = { "black", "yamlfmt" },
            servers = {
                lua_ls = {}, -- configuration provided via lazydev.nvim
                bashls = {},
                pyright = {},
                roslyn = {
                    on_attach = function(_, _) -- client, bufnr
                        vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
                            pattern = "*",
                            callback = function()
                                local clients = vim.lsp.get_clients { name = "roslyn" }
                                if not clients or #clients == 0 then
                                    return
                                end

                                local buffers = vim.lsp.get_buffers_by_client_id(clients[1].id)
                                for _, buf in ipairs(buffers) do
                                    vim.lsp.util._refresh("textDocument/diagnostic", { bufnr = buf })
                                    vim.lsp.codelens.refresh()
                                end
                            end,
                        })
                    end,
                    settings = {
                        -- https://github.com/dotnet/vscode-csharp/blob/main/test/lsptoolshost/unitTests/configurationMiddleware.test.ts
                        -- look for the ones which don"t have `vsCodeConfiguration: null`
                        ["csharp|completion"] = {
                            dotnet_show_completion_items_from_unimported_namespaces = true,
                            dotnet_provide_regex_completions = true,
                            dotnet_show_name_completion_suggestions = true,
                        },
                        ["csharp|symbol_search"] = {
                            dotnet_search_reference_assemblies = true,
                        },
                        ["csharp|inlay_hints"] = {
                            csharp_enable_inlay_hints_for_implicit_object_creation = true,
                            csharp_enable_inlay_hints_for_implicit_variable_types = true,

                            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
                            csharp_enable_inlay_hints_for_types = true,
                            dotnet_enable_inlay_hints_for_indexer_parameters = true,
                            dotnet_enable_inlay_hints_for_literal_parameters = true,
                            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
                            dotnet_enable_inlay_hints_for_other_parameters = true,
                            dotnet_enable_inlay_hints_for_parameters = true,
                            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
                            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
                            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
                        },
                        ["csharp|code_lens"] = {
                            dotnet_enable_references_code_lens = true,
                            dotnet_enable_tests_code_lens = true,
                        },
                        ["csharp|background_analysis"] = {
                            dotnet_analyzer_diagnostics_scope = "fullSolution",
                            dotnet_compiler_diagnostics_scope = "fullSolution"
                        }
                    },
                }
            }
        },
        config = function(_, opts)
            local icons = require("config.icons")
            local utils = require("utils")
            local lsp_lines = require("lsp_lines")
            local actions_preview = require("actions-preview")
            local mason_lsp = require("mason-lspconfig")
            local mason_tool_installer = require("mason-tool-installer")
            local null_ls = require("null-ls")

            mason_tool_installer.setup({
                ensure_installed = utils.merge_arrays(
                    utils.get_keys_from_table(opts.servers),
                    opts.linters,
                    opts.formatters
                )
            })

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
                sources = sources
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
