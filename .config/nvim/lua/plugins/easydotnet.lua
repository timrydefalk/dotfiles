return {
    -- {
    --     'ionide/Ionide-vim',
    --     ft = { 'fsharp' },
    -- },
    {
        "GustavEikaas/easy-dotnet.nvim",
        dependencies = { "nvim-lua/plenary.nvim", 'folke/snacks.nvim', },
        --event = "LspAttach",
        ft = { "cs" },
        build = ":Dotnet _server update",
        cmd = "Dotnet",
        config = function()
            local dotnet = require("easy-dotnet")

            -- Options are not required
            dotnet.setup({
                --Optional function to return the path for the dotnet sdk (e.g C:/ProgramFiles/dotnet/sdk/8.0.0)
                -- easy-dotnet will resolve the path automatically if this argument is omitted, for a performance improvement you can add a function that returns a hardcoded string
                -- You should define this function to return a hardcoded path for a performance improvement 🚀
                get_sdk_path = function()
                    -- Example for windows
                    -- return "C:/Program Files/dotnet/sdk/8.0.100/"
                    return "/usr/share/dotnet/sdk/9.0.308"
                end,
                lsp = {
                    enabled = true,
                    roslynator_enabled = true,
                    config = {
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
                },
                ---@type TestRunnerOptions
                test_runner = {
                    ---@type "split" | "vsplit" | "float" | "buf"
                    viewmode = "float",
                    ---@type number|nil
                    vsplit_width = nil,
                    ---@type string|nil "topleft" | "topright"
                    vsplit_pos = nil,
                    enable_buffer_test_execution = true, --Experimental, run tests directly from buffer
                    noBuild = true,
                    icons = {
                        passed = "",
                        skipped = "",
                        failed = "",
                        success = "",
                        reload = "",
                        test = "",
                        sln = "󰘐",
                        project = "󰘐",
                        dir = "",
                        package = "",
                    },
                    mappings = {
                        run_test_from_buffer = { lhs = "<leader>r", desc = "run test from buffer" },
                        peek_stack_trace_from_buffer = { lhs = "<leader>p", desc = "peek stack trace from buffer" },
                        filter_failed_tests = { lhs = "<leader>fe", desc = "filter failed tests" },
                        debug_test = { lhs = "<leader>d", desc = "debug test" },
                        debug_test_from_buffer = { lhs = "<leader>d", desc = "run test from buffer" },
                        go_to_file = { lhs = "g", desc = "go to file" },
                        run_all = { lhs = "<leader>R", desc = "run all tests" },
                        run = { lhs = "<leader>r", desc = "run test" },
                        peek_stacktrace = { lhs = "<leader>p", desc = "peek stacktrace of failed test" },
                        expand = { lhs = "o", desc = "expand" },
                        expand_node = { lhs = "E", desc = "expand node" },
                        expand_all = { lhs = "-", desc = "expand all" },
                        collapse_all = { lhs = "W", desc = "collapse all" },
                        close = { lhs = "q", desc = "close testrunner" },
                        refresh_testrunner = { lhs = "<C-r>", desc = "refresh testrunner" }
                    },
                    --- Optional table of extra args e.g "--blame crash"
                    additional_args = {}
                },
                new = {
                    project = {
                        prefix = "sln" -- "sln" | "none"
                    }
                },
                ---@param action "test" | "restore" | "build" | "run"
                terminal = function(path, action, args)
                    local commands = {
                        run = function()
                            return string.format("dotnet run --project %s %s", path, args)
                        end,
                        test = function()
                            return string.format("dotnet test %s %s", path, args)
                        end,
                        restore = function()
                            return string.format("dotnet restore %s %s", path, args)
                        end,
                        build = function()
                            return string.format("dotnet build %s %s", path, args)
                        end,
                        watch = function()
                            return string.format("dotnet watch --project %s %s", path, args)
                        end
                    }

                    local command = commands[action]() .. "\r"
                    vim.cmd("vsplit")
                    vim.cmd("term " .. command)
                end,
                csproj_mappings = true,
                fsproj_mappings = true,
                auto_bootstrap_namespace = {
                    --block_scoped, file_scoped
                    type = "file_scoped",
                    enabled = true
                },
                -- choose which picker to use with the plugin
                -- possible values are "telescope" | "fzf" | "snacks" | "basic"
                -- if no picker is specified, the plugin will determine
                -- the available one automatically with this priority:
                -- telescope -> fzf -> snacks ->  basic
                picker = "snacks",
                background_scanning = true,
                notifications = {
                    --Set this to false if you have configured lualine to avoid double logging
                    handler = function(start_event)
                        local spinner = require("easy-dotnet.ui-modules.spinner").new()
                        spinner:start_spinner(start_event.job.name)
                        ---@param finished_event JobEvent
                        return function(finished_event)
                            spinner:stop_spinner(finished_event.result.text, finished_event.result.level)
                        end
                    end,
                },
            })

            -- Example command
            vim.api.nvim_create_user_command('Secrets', function()
                dotnet.secrets()
            end, {})

            -- Example keybinding
            vim.keymap.set("n", "<C-p>", function()
                dotnet.run_project()
            end)
        end
    }
}
