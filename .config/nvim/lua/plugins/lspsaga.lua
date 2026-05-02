return {
    {
        "nvimdev/lspsaga.nvim",
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
            --{ "nvim-treesitter/nvim-treesitter" }
        },
        event = "LspAttach",
        config = function()
            local icons = require("config.icons")
            vim.api.nvim_set_hl(0, "SagaLightBulb", { fg = "#e0af68" })

            require("lspsaga").setup({
                custom_kind = { String = { "s " } },
                ui = {
                    expand = icons.ui.Collapsed,
                    collapse = icons.ui.Expanded,
                    code_action = icons.code.CodeAction,
                    kind = {
                        Array = { icons.kinds.Array, "LspKindArray" },
                        Boolean = { icons.kinds.Boolean, "LspKindBoolean" },
                        Class = { icons.kinds.Class, "LspKindClass" },
                        Constant = { icons.kinds.Constant, "LspKindConstant" },
                        Constructor = { icons.kinds.Constructor, "LspKindConstructor" },
                        Enum = { icons.kinds.Enum, "LspKindEnum" },
                        EnumMember = { icons.kinds.EnumMember, "LspKindEnumMember" },
                        Event = { icons.kinds.Event, "LspKindEvent" },
                        Field = { icons.kinds.Field, "LspKindField" },
                        File = { icons.kinds.File, "LspKindFile" },
                        Folder = { icons.kinds.Folder, "LspKindFolder" },
                        Function = { icons.kinds.Function, "LspKindFunction" },
                        Interface = { icons.kinds.Interface, "LspKindInterface" },
                        Key = { icons.kinds.Key, "LspKindKey" },
                        Macro = { icons.kinds.Macro, "LspKindMacro" },
                        Method = { icons.kinds.Method, "LspKindMethod" },
                        Module = { icons.kinds.Module, "LspKindModule" },
                        Namespace = { icons.kinds.Namespace, "LspKindNamespace" },
                        Null = { icons.kinds.Null, "LspKindNull" },
                        Number = { icons.kinds.Number, "LspKindNumber" },
                        Object = { icons.kinds.Object, "LspKindObject" },
                        Operator = { icons.kinds.Operator, "LspKindOperator" },
                        Package = { icons.kinds.Package, "LspKindPackage" },
                        Parameter = { icons.kinds.Parameter, "LspKindParameter" },
                        Property = { icons.kinds.Property, "LspKindProperty" },
                        Snippet = { icons.kinds.Snippet, "LspKindSnippet" },
                        StaticMethod = { icons.kinds.StaticMethod, "LspKindStaticMethod" },
                        String = { icons.kinds.String, "LspKindString" },
                        Struct = { icons.kinds.Struct, "LspKindStruct" },
                        Text = { icons.kinds.Text, "LspKindText" },
                        TypeAlias = { icons.kinds.TypeAlias, "LspKindTypeAlias" },
                        TypeParameter = { icons.kinds.TypeParameter, "LspKindTypeParameter" },
                        Unit = { icons.kinds.Unit, "LspKindUnit" },
                        Value = { icons.kinds.Value, "LspKindValue" },
                        Variable = { icons.kinds.Variable, "LspKindVariable" },
                    }
                }
            })
        end,
    },
}
