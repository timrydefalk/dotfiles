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
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        event = "VeryLazy",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim" },
        },
        build = "make tiktoken", -- Only on MacOS or Linux
        opts = {
            -- See Configuration section for options
        },
    },
}
