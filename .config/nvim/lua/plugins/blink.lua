return {
    {
        "saghen/blink.cmp",
        -- optional: provides snippets for the snippet source
        dependencies = {
            "fang2hou/blink-copilot",
            "MahanRahmati/blink-nerdfont.nvim",
            "archie-judd/blink-cmp-words",
            "moyiz/blink-emoji.nvim",
            {
                'L3MON4D3/LuaSnip',
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
        version = '1.*',

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
                default = { "copilot", "lsp", "path", "snippets", "buffer", "cmdline" },
                per_filetype = {
                    lua = { inherit_defaults = true, 'lazydev', "nerdfont", "emoji" },
                    text = { "dictionary", "thesaurus", "emoji" },
                    markdown = { "dictionary", "thesaurus", "emoji" },
                    gitcommit = { "dictionary", "thesaurus", "emoji" },
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
