return {
    -- For formatters or linters respectively
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins
    --
    -- linters -> represent diagnostics in null-ls
    -- formatters -> represent formatting in null-ls
    --
    -- currently not added: hover, completion and code_actions from null-ls
    linters = {
        "hadolint",
        "actionlint",
    },
    formatters = {
        "black",
        "yamlfmt",
    },
    -- any tools you can install through Mason that are needed for others. E.g. bashls needs shellcheck.
    dependencies = {
        "shellcheck", -- for bashls
        "shfmt"       -- for bashls
    },
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

                        local client = assert(vim.lsp.get_client_by_id(clients[1].id))
                        local buffers = vim.lsp.get_buffers_by_client_id(clients[1].id)

                        for _, buf in ipairs(buffers) do
                            local params = { textDocument = vim.lsp.util.make_text_document_params(buf) }
                            client:request("textDocument/diagnostic", params, nil, buf)
                            vim.lsp.codelens.refresh()
                        end
                    end,
                })
            end,
            settings = {
                -- https://github.com/dotnet/vscode-csharp/blob/main/test/lsptoolshost/unitTests/configurationMiddleware.test.ts
                -- look for the ones which don't have `vsCodeConfiguration: null`
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
}
