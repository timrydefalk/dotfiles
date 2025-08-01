return {
    {
        "danymat/neogen",
        dependencies = {
            {
                'L3MON4D3/LuaSnip',
                version = 'v2.*',
            }
        },
        event = "LspAttach",
        opts = {
            snippet_engine = "luasnip",
            enabled = true,
            languages = {
                cs = {
                    template = {
                        annotation_convention = "xmldoc"
                    }
                }
            },
        }
    }
}
