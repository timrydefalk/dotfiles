return {
    {
        "saghen/blink.cmp",
        -- optional: provides snippets for the snippet source
        dependencies = {
            "fang2hou/blink-copilot",
            "rafamadriz/friendly-snippets",
            "MahanRahmati/blink-nerdfont.nvim",
            "archie-judd/blink-cmp-words",
            "moyiz/blink-emoji.nvim",
        },
        version = '1.*',

        ---@module "blink.cmp"
        ---@type blink.cmp.Config
        opts = {
            -- "default" (recommended) for mappings similar to built-in completions (C-y to accept)
            -- "super-tab" for mappings similar to vscode (tab to accept)
            -- "enter" for enter to accept
            -- "none" for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { preset = "default", },

            appearance = {
                -- "mono" (default) for "Nerd Font Mono" or "normal" for "Nerd Font"
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = "mono"
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
                },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 150,
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
                            pointer_symbols = { "!", "&", "^" },
                        },
                    },

                    dictionary = {
                        name = "blink-cmp-words",
                        module = "blink-cmp-words.dictionary",
                        opts = {
                            dictionary_search_threshold = 3,
                            score_offset = 15,
                            pointer_symbols = { "!", "&", "^" },
                        },
                    },
                },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" }
        },

        opts_extend = { "sources.default" }
    }
}
