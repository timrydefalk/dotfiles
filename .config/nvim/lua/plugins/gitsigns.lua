local icons = require("config.icons")

return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            debug_mode = true,
            current_line_blame = true,
            current_line_blame_opts = {
                ignore_whitespace = true,
            },
            signs = {
                add          = { text = icons.git.Added },
                change       = { text = icons.git.Modified },
                delete       = { text = icons.git.Removed },
                topdelete    = { text = icons.git.Removed },
                changedelete = { text = icons.git.Modified },
                untracked    = { text = icons.git.Untracked },
            },
            signs_staged = {
                add          = { text = icons.git.Added },
                change       = { text = icons.git.Modified },
                delete       = { text = icons.git.Removed },
                topdelete    = { text = icons.git.Removed },
                changedelete = { text = icons.git.Modified },
            },
        },
    },
}
