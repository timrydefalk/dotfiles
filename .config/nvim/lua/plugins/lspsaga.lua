return {
    {
        "nvimdev/lspsaga.nvim",
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
            { "nvim-treesitter/nvim-treesitter" }
        },
        event = "LspAttach",
        config = function()
            vim.api.nvim_set_hl(0, "SagaLightBulb", { fg = "#e0af68" })

            require("lspsaga").setup({})
        end,
    },
}
