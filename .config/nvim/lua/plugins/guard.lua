return {
    {
        "nvimdev/guard.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvimdev/guard-collection",
        },
        config = function()
            vim.g.guard_config = {
                fmt_on_save = true,
                lsp_as_default_formatter = true,
                save_on_fmt = false,
                auto_lint = false,
                lint_interval = 500,
            }
        end,
    }
}
