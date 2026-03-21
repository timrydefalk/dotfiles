return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            {"nvim-treesitter/nvim-treesitter-textobjects", branch = "master" },
        },
        branch = "master",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("nvim-treesitter.configs").setup({
                highlight = {
                    enable = true
                },
                indent = {
                    enable = true
                },
                ensure_installed = {
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "diff",
                    "bash",
                    "regex",
                },
                auto_install = true,
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["coc"] = { query = "@class.outer", desc = "Select outer part of a class" },
                            ["cic"] = { query = "@class.inner", desc = "Select inner part of a class" },
                            ["cof"] = { query = "@function.outer", desc = "Select outer part of a function" },
                            ["cif"] = { query = "@function.inner", desc = "Select inner part of a function" },
                            ["cob"] = { query = "@block.outer", desc = "Select outer part of a block" },
                            ["cib"] = { query = "@block.inner", desc = "Select inner part of a block" },
                            ["cop"] = { query = "@parameter.outer", desc = "Select outer part of a parameter" },
                            ["cip"] = { query = "@parameter.inner", desc = "Select inner part of a parameter" },
                        },
                        -- You can choose the select mode (default is charwise "v")
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg "@function.inner"
                        -- * method: eg "v" or "o"
                        -- and should return the mode ("v", "V", or "<c-v>") or a table
                        -- mapping query_strings to modes.
                        selection_modes = {
                            -- ["@parameter.outer"] = "v", -- charwise
                            -- ["@function.outer"] = "V",  -- linewise
                            -- ["@class.outer"] = "<c-v>", -- blockwise
                        },
                        -- If you set this to `true` (default is `false`) then any textobject is
                        -- extended to include preceding or succeeding whitespace. Succeeding
                        -- whitespace has priority in order to act similarly to eg the built-in
                        -- `ap`.
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg "@function.inner"
                        -- * selection_mode: eg "v"
                        -- and should return true or false
                        include_surrounding_whitespace = false,
                    },
                },
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = { "BufReadPost", "BufNewFile" },
        branch = "master",
        opts = {
            max_lines = 3
        }
    },
}
