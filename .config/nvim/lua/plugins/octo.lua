return {
    {
        "pwntester/octo.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "folke/snacks.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        after = "snacks.nvim",
        cmd = "Octo",
        config = function()
            require("octo").setup({
                picker = "snacks"
            })
        end
    },
}
