return {
    {
        "andythigpen/nvim-coverage",
        version = "*",
        event = "LspAttach",
        config = function()
            require("coverage").setup({
                auto_reload = true,
            })
        end,
    },
}
