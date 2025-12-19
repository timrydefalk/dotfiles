return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                panel = {
                    enabled = false,
                },
                suggestion = {
                    enabled = false,
                },
                filetypes = {
                    sh     = function()
                        if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
                            -- disable for .env files
                            return false
                        end
                        return true
                    end,
                    cs     = true,
                    lua    = true,
                    python = true,
                    ["*"]  = false
                },
                copilot_node_command = "node", -- Node.js version must be > 18.x
                server_opts_overrides = {},
            })
        end,
    },
    -- {
    --     "CopilotC-Nvim/CopilotChat.nvim",
    --     event = "VeryLazy",
    --     dependencies = {
    --         { "zbirenbaum/copilot.lua" },
    --         -- { "nvim-lua/plenary.nvim" },
    --     },
    --     build = "make tiktoken", -- Only on MacOS or Linux
    --     opts = {
    --         -- See Configuration section for options
    --     },
    -- },
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "ravitemer/mcphub.nvim",
        },
        build = "npm install -g mcp-hub@latest",
        opts = {
            opts = {
                log_level = "DEBUG", -- or "TRACE"
            },
            strategies = {
                chat = {
                    adapter = "copilot",
                },
                inline = {
                    adapter = "copilot",
                },
                cmd = {
                    adapter = "copilot",
                },
            },
            extensions = {
                mcphub = {
                    callback = "mcphub.extensions.codecompanion",
                    opts = {
                        make_vars = true,
                        make_slash_commands = true,
                        show_result_in_chat = true
                    }
                }
            }
        },
    },
    {
        "ravitemer/mcphub.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        build = "npm install -g mcp-hub@latest",
        config = function()
            require("mcphub").setup()
        end
    }
}
