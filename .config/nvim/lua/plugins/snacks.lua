local icons = require("config.icons")
local keybinds = require("config.keybinds")

return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile      = { enabled = false },
            dashboard    = { enabled = false },
            explorer     = { enabled = true },
            indent       = { enabled = true },
            input        = { enabled = true },
            picker       = {
                enabled = true,
                sources = {
                    explorer = {
                        auto_close = true,
                        layout = {
                            preset = "default",
                            preview = true
                        },
                        win = {
                            list = {
                                keys = {
                                    ["A"] = "explorer_add_dotnet",
                                },
                            },
                        },
                        actions = {
                            explorer_add_dotnet = function(picker)
                                local dir = picker:dir()
                                local tree = require("snacks.explorer.tree")
                                local actions = require("snacks.explorer.actions")
                                local easydotnet = require("easy-dotnet")

                                easydotnet.create_new_item(dir, function(item_path)
                                    tree:open(dir)
                                    tree:refresh(dir)
                                    actions.update(picker, { target = item_path })
                                end)
                            end,
                        },
                    },
                    command_history = {
                        layout = {
                            preset = "default",
                            preview = false
                        }
                    }
                },
                icons = {
                    files = {
                        enabled = true,
                        dir = icons.files.Directory,
                        dir_open = icons.files.DirectoryOpen,
                        file = icons.files.File,
                    },
                    ui = {
                        selected   = icons.ui.Selected,
                        unselected = icons.ui.Unselected,
                    },
                    git = {
                        enabled   = true,
                        commit    = icons.git.Commit,
                        staged    = icons.git.Staged,
                        added     = icons.git.Added,
                        deleted   = icons.git.Removed,
                        ignored   = icons.git.Ignored,
                        modified  = icons.git.Modified,
                        renamed   = icons.git.Renamed,
                        unmerged  = icons.git.Unmerged,
                        untracked = icons.git.Untracked,
                    },
                    diagnostics = {
                        Error = icons.diagnostics.Error,
                        Warn  = icons.diagnostics.Warn,
                        Hint  = icons.diagnostics.Hint,
                        Info  = icons.diagnostics.Info,
                    },
                    lsp = {
                        enabled = icons.ui.Enabled,
                        disabled = icons.ui.Disabled,
                    },
                    kinds = icons.kinds,
                },
                win = {
                    input = {
                        keys = keybinds.snacks_picker_input()
                    },
                    list = {
                        keys = keybinds.snacks_picker_list()
                    },
                    preview = {
                        keys = keybinds.snacks_picker_preview()
                    },
                }
            },
            notifier     = { enabled = true },
            quickfile    = { enabled = true },
            scope        = { enabled = true },
            scroll       = { enabled = true },
            statuscolumn = { enabled = true },
            terminal     = {
                win = {
                    position  = "float",
                    border    = "rounded",
                    title     = "Terminal",
                    title_pos = "center",
                    bo        = {
                        filetype = "snacks_terminal",
                    },
                    wo        = {},
                    keys      = {
                        q = "hide",
                        gf = function(self)
                            local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
                            if f == "" then
                                Snacks.notify.warn("No file under cursor")
                            else
                                self:hide()
                                vim.schedule(function()
                                    vim.cmd("e " .. f)
                                end)
                            end
                        end,
                        term_normal = {
                            "<esc>",
                            function(self)
                                vim.cmd("stopinsert")
                                -- self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
                                -- if self.esc_timer:is_active() then
                                --     self.esc_timer:stop()
                                --     vim.cmd("stopinsert")
                                -- else
                                --     self.esc_timer:start(200, 0, function() end)
                                --     return "<esc>"
                                -- end
                            end,
                            mode = "t",
                            expr = true,
                            desc = "Double escape to normal mode",
                        },
                    },
                },
                shell = "bash",

            },
            words        = { enabled = true },
        },
    }
}
