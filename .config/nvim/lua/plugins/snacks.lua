return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = false },
            dashboard = { enabled = false },
            explorer = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            picker = {
                enabled = true,
                sources = {
                    explorer = {
                        auto_close = true,
                        layout = { preset = "default", preview = true }
                    },
                    command_history = {
                        layout = { preset = "default", preview = false }
                    }
                }
            },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            terminal = { win = { position = "float", border = "rounded", title = "Terminal", title_pos = "center" }, shell = "bash" },
            words = { enabled = true },
        },
    }
}
