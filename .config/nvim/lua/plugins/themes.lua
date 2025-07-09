return {
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme tokyonight-moon]])
            -- Override FlashLabel highlight group for better legibility
            vim.api.nvim_set_hl(0, "FlashLabel", { bg = "#ff007c", fg = "#59002b", bold = true })
        end
    },
}
