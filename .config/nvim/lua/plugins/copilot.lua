return {
    -- {
    --     "zbirenbaum/copilot.lua",
    --     cmd = "Copilot",
    --     event = "InsertEnter",
    --     config = function()
    --         require("copilot").setup({
    --             panel = {
    --                 enabled = false,
    --             },
    --             suggestion = {
    --                 enabled = false,
    --             },
    --             filetypes = {
    --                 sh     = function()
    --                     if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
    --                         -- disable for .env files
    --                         return false
    --                     end
    --                     return true
    --                 end,
    --                 cs     = true,
    --                 lua    = true,
    --                 python = true,
    --                 ["*"]  = false
    --             },
    --             copilot_node_command = "node", -- Node.js version must be > 18.x
    --             server_opts_overrides = {},
    --         })
    --     end,
    -- },
    {
        "github/copilot.vim",
        cmd = "Copilot",
        event = "BufWinEnter",
        init = function()
            vim.g.copilot_no_maps = true
        end,
        config = function()
            -- Block the normal Copilot suggestions
            vim.api.nvim_create_augroup("github_copilot", { clear = true })
            vim.api.nvim_create_autocmd({ "FileType", "BufUnload" }, {
                group = "github_copilot",
                callback = function(args)
                    vim.fn["copilot#On" .. args.event]()
                end,
            })
            vim.fn["copilot#OnFileType"]()
        end,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        event = "VeryLazy",
        dependencies = {
            { "github/copilot.vim" },
            -- { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim" },
        },
        build = "make tiktoken", -- Only on MacOS or Linux
        opts = {
            -- See Configuration section for options
        },
    },
}
