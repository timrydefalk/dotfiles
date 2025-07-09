return {
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {
            modes = { char = { jump_labels = function(_) return vim.v.count == 0 end } },
        },
    }
}
