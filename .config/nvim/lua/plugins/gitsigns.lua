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
        },
    },
}
