return {
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "folke/snacks.nvim",
        },
        event = "VeryLazy",
        opts = {
            cmdline = {
                enabled = true,
            },
            messages = {
                enabled = true,
            },
            popup_menu = {
                enabled = false,
            },
            presets = {
                long_message_to_split = true
            },
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                },
                hover = { enabled = false },
                signature = { enabled = false },
            },
        },
    },
}
