local function rebuild_project(co, path)
    local spinner = require("easy-dotnet.ui-modules.spinner").new()
    spinner:start_spinner "Building"
    vim.fn.jobstart(string.format("dotnet build %s", path), {
        on_exit = function(_, return_code)
            if return_code == 0 then
                spinner:stop_spinner "Built successfully"
            else
                spinner:stop_spinner("Build failed with exit code " .. return_code, vim.log.levels.ERROR)
                error "Build failed"
            end
            coroutine.resume(co)
        end,
    })
    coroutine.yield()
end

return {
    -- DAP
    {
        "https://codeberg.org/mfussenegger/nvim-dap",
        dependencies = {
            "mason-org/mason.nvim",
            "jay-babu/mason-nvim-dap.nvim",
            "nvim-neotest/nvim-nio",
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text"
        },
        event = "LspAttach",
        config = function()
            local icons = require("config.icons")
            local dap = require("dap")
            local dapui = require("dapui")

            dapui.setup()

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            require('mason-nvim-dap').setup({
                ensure_installed = {},
                handlers = {}, -- sets up dap in the predefined manner
                automatic_installation = false
            })

            -- .NET specific setup using `easy-dotnet`
            require("easy-dotnet.netcoredbg").register_dap_variables_viewer() -- special variables viewer specific for .NET

            local dotnet = require("easy-dotnet")
            local debug_dll = nil

            local function ensure_dll()
                if debug_dll ~= nil then
                    return debug_dll
                end
                local dll = dotnet.get_debug_dll(true)
                debug_dll = dll
                return dll
            end

            for _, value in ipairs({ "cs", "fsharp" }) do
                dap.configurations[value] = {
                    {
                        type = "coreclr",
                        name = "Program",
                        request = "launch",
                        env = function()
                            local dll = ensure_dll()
                            local vars = dotnet.get_environment_variables(dll.project_name, dll.relative_project_path)
                            return vars or nil
                        end,
                        program = function()
                            local dll = ensure_dll()
                            local co = coroutine.running()
                            rebuild_project(co, dll.project_path)
                            return dll.relative_dll_path
                        end,
                        cwd = function()
                            local dll = ensure_dll()
                            return dll.relative_project_path
                        end
                    },
                    {
                        type = "coreclr",
                        name = "Test",
                        request = "attach",
                        processId = function()
                            local res = require("easy-dotnet").experimental.start_debugging_test_project()
                            return res.process_id
                        end
                    }
                }
            end

            -- Reset debug_dll after each terminated session
            dap.listeners.before['event_terminated']['easy-dotnet'] = function()
                debug_dll = nil
            end

            dap.adapters.coreclr = {
                type = "executable",
                command = "netcoredbg",
                args = { "--interpreter=vscode" },
            }

            require("nvim-dap-virtual-text").setup({})


            vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

            for name, sign in pairs(icons.debugger) do
                sign = type(sign) == "table" and sign or { sign }
                vim.fn.sign_define(
                    "Dap" .. name,
                    { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
                )
            end
        end
    },
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
            --"seblyng/roslyn.nvim",
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
                    --config.capabilities.textDocument.diagnostic.dynamicRegistration = true
                end

                if not vim.tbl_isempty(config) then
                    vim.lsp.config(server, config)
                end

                if server == "roslyn" then
                    --require("roslyn").setup({})
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
