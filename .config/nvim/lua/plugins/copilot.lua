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
                    rust   = true,
                    typescript = true,
                    lua    = true,
                    python = true,
                    yaml   = true,
                    bash   = true,
                    ["*"]  = false
                },
                copilot_node_command = "node",
                server_opts_overrides = {},
            })
        end,
    },
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "ravitemer/mcphub.nvim",
        },
        opts = {
            opts = {
                log_level = "DEBUG", -- or "TRACE"
            },
            adapters = {
                http = {
                    copilot = function()
                        return require("codecompanion.adapters").extend("copilot", {
                            schema = {
                                model = {
                                    default = "claude-sonnet-4.6",
                                },
                            },
                        })
                    end,
                }
            },
            interactions = {
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
        },
    },
}
