local icons = require("config.icons")

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
            bigfile      = { enabled = false },
            dashboard    = { enabled = false },
            explorer     = { enabled = true },
            indent       = { enabled = true },
            input        = { enabled = true },
            picker       = {
                enabled = true,
                sources = {
                    explorer = {
                        auto_close = true,
                        layout = {
                            preset = "default",
                            preview = true
                        }
                    },
                    command_history = {
                        layout = {
                            preset = "default",
                            preview = false
                        }
                    }
                },
                icons = {
                    files = {
                        enabled = true,
                        dir = icons.files.Directory,
                        dir_open = icons.files.DirectoryOpen,
                        file = icons.files.File,
                    },
                    -- keymaps = {
                    --     nowait = "󰓅 "
                    -- },
                    -- tree = {
                    --     vertical = "│ ",
                    --     middle   = "├╴",
                    --     last     = "└╴",
                    -- },
                    -- undo = {
                    --     saved = " ",
                    -- },
                    ui = {
                        -- live       = "󰐰 ",
                        -- hidden     = "h",
                        -- ignored    = "i",
                        -- follow     = "f",
                        selected   = icons.ui.Selected,
                        unselected = icons.ui.Unselected,
                    },
                    git = {
                        enabled   = true,
                        commit    = icons.git.Commit,
                        staged    = icons.git.Staged,
                        added     = icons.git.Added,
                        deleted   = icons.git.Removed,
                        ignored   = icons.git.Ignored,
                        modified  = icons.git.Modified,
                        renamed   = icons.git.Renamed,
                        unmerged  = icons.git.Unmerged,
                        untracked = icons.git.Untracked,
                    },
                    diagnostics = {
                        Error = icons.diagnostics.Error,
                        Warn  = icons.diagnostics.Warn,
                        Hint  = icons.diagnostics.Hint,
                        Info  = icons.diagnostics.Info,
                    },
                    lsp = {
                        -- unavailable = "",
                        enabled = icons.ui.Enabled,
                        disabled = icons.ui.Disabled,
                        -- attached = "󰖩 "
                    },
                    --kinds = icons.kinds,
                },
            },
            notifier     = { enabled = true },
            quickfile    = { enabled = true },
            scope        = { enabled = true },
            scroll       = { enabled = true },
            statuscolumn = { enabled = true },
            terminal     = {
                win = {
                    position  = "float",
                    border    = "rounded",
                    title     = "Terminal",
                    title_pos = "center"
                },
                shell = "bash"
            },
            words        = { enabled = true },
        },
    }
}
