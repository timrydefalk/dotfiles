return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            -- https://github.com/nvim-neotest/neotest?tab=readme-ov-file#supported-runners
            "Issafalcon/neotest-dotnet"
        },
        event = "LspAttach",
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-dotnet")({
                        dap = {
                            args = { justMyCode = false },
                            adapter_name = "netcoredbg"
                        },
                        dotnet_additional_args = {
                            "--verbosity normal"
                        },
                        discovery_root = "solution"
                    })
                }
            })
        end
    },
}
