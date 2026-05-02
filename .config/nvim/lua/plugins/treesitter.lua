return {
    {
        "romus204/tree-sitter-manager.nvim",
        dependencies = {}, -- tree-sitter CLI must be installed system-wide
        config = function()
            require("tree-sitter-manager").setup({
                -- Default Options
                ensure_installed = {
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "yaml",
                    "bash",
                    "regex",
                },
                border = "rounded",
                auto_install = true,
                highlight = true,
                -- languages = {}, -- override or add new parser sources
                -- parser_dir = vim.fn.stdpath("data") .. "/site/parser",
                -- query_dir = vim.fn.stdpath("data") .. "/site/queries",
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        init = function()
            -- Disable entire built-in ftplugin mappings to avoid conflicts.
            -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
            vim.g.no_plugin_maps = true

            -- Or, disable per filetype (add as you like)
            -- vim.g.no_python_maps = true
            -- vim.g.no_ruby_maps = true
            -- vim.g.no_rust_maps = true
            -- vim.g.no_go_maps = true
        end,
        opts = {
            select = {
                lookahead = true,
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
        }
    }
}
