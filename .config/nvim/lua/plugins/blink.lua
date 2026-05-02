return {
    {
        "saghen/blink.cmp",
        -- optional: provides snippets for the snippet source
        dependencies = {
            "fang2hou/blink-copilot",
            "MahanRahmati/blink-nerdfont.nvim",
            "archie-judd/blink-cmp-words",
            "moyiz/blink-emoji.nvim",
            "saghen/blink.lib",
            {
                'L3MON4D3/LuaSnip',
                build = "make install_jsregexp",
                version = 'v2.*',
            },
            {
                "rafamadriz/friendly-snippets",
                after = "LuaSnip",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                end
            }
        },
        build = function() require('blink.cmp').build():wait(60000) end,
        -- build = 'cargo build --release',
        -- version = '1.*',

        config = function(_, opts)
            -- HACK: Some blink community sources depend on the old v1 lib that blink shipped
            -- with. Shim in the new `blink.lib` and functions that those community sources need
            -- from the v1 stuff until they're updated.
            package.loaded["blink.cmp.lib.async"] = (function()
                local task = require("blink.lib.task")
                task.empty = task.resolve
                task.on_completion = task.on_resolve
                task.on_failure = task.on_reject
                task.task = task
                return task
            end)()

            require("blink.cmp").setup(opts)
        end,

        ---@module "blink.cmp"
        ---@type blink.cmp.Config
        opts = {
            keymap = require("config.keybinds").blink_autocomplete(),

            appearance = {
                -- "mono" (default) for "Nerd Font Mono" or "normal" for "Nerd Font"
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = "mono"
            },

            snippets = {
                preset = "luasnip"
            },

            signature = {
                enabled = true,
                window = { border = "rounded", show_documentation = false }
            },

            cmdline = {
                enabled = true,
                completion = { menu = { auto_show = true } },
            },

            completion = {
                menu = {
                    auto_show = true,
                    border = "rounded",
                    -- nvim-cmp style menu
                    draw = {
                        columns = {
                            { "label",     "label_description", gap = 1 },
                            { "kind_icon", "kind",              gap = 1 },
                        },
                    },
                },
                documentation = {
                    auto_show = true,
                    window = { border = "rounded" },
                },
            },

            sources = {
                default = { "copilot", "lsp", "path", "snippets", "buffer", "cmdline", "nerdfont", "emoji" },
                per_filetype = {
                    lua = { inherit_defaults = true, 'lazydev' },
                    text = { "dictionary", "thesaurus" },
                    markdown = { "dictionary", "thesaurus" },
                    gitcommit = { "dictionary", "thesaurus" },
                    xml = { inherit_defaults = true, "easy-dotnet" },
                },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 150,
                    },

                    ["easy-dotnet"] = {
                        name = "easy-dotnet",
                        enabled = true,
                        module = "easy-dotnet.completion.blink",
                        score_offset = 100,
                        async = true,
                    },

                    copilot = {
                        name = "copilot",
                        module = "blink-copilot",
                        score_offset = 100,
                        async = true,
                    },

                    nerdfont = {
                        module = "blink-nerdfont",
                        name = "Nerd Fonts",
                        score_offset = 10,
                        opts = { insert = true },
                    },

                    emoji = {
                        module = "blink-emoji",
                        name = "Emoji",
                        score_offset = 10,
                        opts = {
                            insert = true,
                        },
                    },

                    thesaurus = {
                        name = "blink-cmp-words",
                        module = "blink-cmp-words.thesaurus",
                        opts = {
                            score_offset = 15,
                            -- Default is as below ("antonyms", "similar to" and "also see").
                            definition_pointers = { "!", "&", "^" },
                        },
                    },

                    dictionary = {
                        name = "blink-cmp-words",
                        module = "blink-cmp-words.dictionary",
                        opts = {
                            dictionary_search_threshold = 3,
                            score_offset = 15,
                            definition_pointers = { "!", "&", "^" },
                        },
                    },
                },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" }
        },

        opts_extend = { "sources.default" }
    }
}
