local M = {}

local map = vim.keymap.set

local action_allowed_for_filetype = function()
    return vim.bo.filetype == "sagaoutline"
        or vim.bo.filetype == "sagafinder"
        or vim.bo.filetype == "sagarename"
        or vim.bo.filetype == "mason"
        or vim.bo.filetype == "prompt"
        or vim.bo.filetype == "neotest-summary"
        or vim.bo.filetype == "snacks-input"
        or vim.bo.filetype == "easy-dotnet"
end
-- v - visual/select
-- x - visual
-- s - select
-- t - terminal
-- i - insert
-- c - command
-- o - operator pending
--
function M.common()
    -- Remove frustrations
    map("n", "dd", "\"_dd", { desc = "Delete - Line", noremap = true, silent = true })
    map("n", "x", "\"_x", { desc = "Delete - Character", noremap = true, silent = true })
    map("v", "d", "\"_d", { desc = "Delete - Selection", noremap = true, silent = true })
    map("v", "<Del>", "\"_<Del>", { desc = "Delete - Selection", noremap = true, silent = true })
    map("n", "q:", "<NOP>", { desc = "", noremap = true, silent = true })

    -- Don't be a scrub
    map(
        { "n", "x", "i" },
        "<Up>",
        function()
            if action_allowed_for_filetype() and vim.v.count == 0 then
                vim.cmd("norm! k")
            end

            if vim.v.count > 0 and vim.fn.mode() ~= "i" then
                vim.cmd(string.format("norm! %sk", vim.v.count))
            end
        end,
        { noremap = true, silent = true }
    )
    map(
        { "n", "x", "i" },
        "<Down>",
        function()
            if action_allowed_for_filetype() and vim.v.count == 0 then
                vim.cmd("norm! j")
            end

            if vim.v.count > 0 and vim.fn.mode() ~= "i" then
                vim.cmd(string.format("norm! %sj", vim.v.count))
            end
        end,
        { noremap = true, silent = true }
    )
    map(
        { "n", "x", "i" },
        "<Left>",
        function()
            if action_allowed_for_filetype() and vim.v.count == 0 then
                vim.cmd("norm! h")
            end

            if vim.v.count > 0 and vim.fn.mode() ~= "i" then
                vim.cmd(string.format("norm! %sh", vim.v.count))
            end
        end,
        { noremap = true, silent = true }
    )
    map(
        { "n", "x", "i" },
        "<Right>",
        function()
            if action_allowed_for_filetype() and vim.v.count == 0 then
                vim.cmd("norm! l")
            end

            if vim.v.count > 0 and vim.fn.mode() ~= "i" then
                vim.cmd(string.format("norm! %sl", vim.v.count))
            end
        end,
        { noremap = true, silent = true }
    )
    map(
        { "n", "x" },
        "k",
        function()
            if action_allowed_for_filetype() and vim.v.count == 0 then
                vim.cmd("norm! k")
            end

            if vim.v.count > 0 then
                vim.cmd(string.format("norm! %sk", vim.v.count))
            end
        end,
        { noremap = true, silent = true }
    )
    map(
        { "n", "x" },
        "j",
        function()
            if action_allowed_for_filetype() and vim.v.count == 0 then
                vim.cmd("norm! j")
            end

            if vim.v.count > 0 then
                vim.cmd(string.format("norm! %sj", vim.v.count))
            end
        end,
        { noremap = true, silent = true }
    )
    map(
        { "n", "x", },
        "h",
        function()
            if action_allowed_for_filetype() and vim.v.count == 0 then
                vim.cmd("norm! h")
            end

            if vim.v.count > 0 then
                vim.cmd(string.format("norm! %sh", vim.v.count))
            end
        end,
        { noremap = true, silent = true }
    )
    map(
        { "n", "x" },
        "l",
        function()
            if action_allowed_for_filetype() and vim.v.count == 0 then
                vim.cmd("norm! l")
            end

            if vim.v.count > 0 then
                vim.cmd(string.format("norm! %sl", vim.v.count))
            end
        end,
        { noremap = true, silent = true }
    )

    -- Split navigation
    map("n", "<C-Up>", "<C-w><Up>", { desc = "Split - Navigate Up", noremap = true, silent = true })
    map("n", "<C-Down>", "<C-w><Down>", { desc = "Split - Navigate Down", noremap = true, silent = true })
    map("n", "<C-Right>", "<C-w><Right>", { desc = "Split - Navigate Right", noremap = true, silent = true })
    map("n", "<C-Left>", "<C-w><Left>", { desc = "Split - Navigate Left", noremap = true, silent = true })

    -- Split sizing
    map("n", "<M-Up>", "<C-w>+", { desc = "Split - Increase Height", noremap = true, silent = true })
    map("n", "<M-Down>", "<C-w>-", { desc = "Split - Decrease Height", noremap = true, silent = true })
    map("n", "<M-Left>", "<C-w><", { desc = "Split - Increase Width", noremap = true, silent = true })
    map("n", "<M-Right>", "<C-w>>", { desc = "Split - Decrease Width", noremap = true, silent = true })

    -- File system interactions
    map("n", "<leader>e", function() Snacks.explorer() end,
        { desc = "Files - Explorer", noremap = true, silent = true })
    map("n", "<leader>fe", function() Snacks.explorer() end,
        { desc = "Files - Explorer", noremap = true, silent = true })
    map("n", "<leader>ff", function() Snacks.picker.files() end,
        { desc = "Files - Find", noremap = true, silent = true })
    map("n", "<leader>fs", function() Snacks.picker.smart() end,
        { desc = "Files - Find Smart", noremap = true, silent = true })
    map("n", "<leader>fg", function() Snacks.picker.grep() end,
        { desc = "Files - Search", noremap = true, silent = true })
    map("n", "<leader>fc", function() Snacks.picker.grep_word() end,
        { desc = "Files - Search Word", noremap = true, silent = true })

    -- Buffer interactions
    map("n", "<leader>u", function() Snacks.picker.buffers() end,
        { desc = "Buffers - Explorer", noremap = true, silent = true })
    map("n", "<leader>be", function() Snacks.picker.buffers() end,
        { desc = "Buffers - Explorer", noremap = true, silent = true })
    map("n", "<leader>bg", function() Snacks.picker.grep_buffers() end,
        { desc = "Buffers - Search", noremap = true, silent = true })
    map("n", "<leader>bu", function() Snacks.picker.undo() end,
        { desc = "Buffers - Undo List", noremap = true, silent = true })
    map("n", "<leader>bc", function() Snacks.bufdelete() end,
        { desc = "Buffers - Close (Keep Layout)", noremap = true, silent = true })
    map("n", "<leader>bq", "<CMD>bd<CR>",
        { desc = "Buffers - Close Current", noremap = true, silent = true })

    -- Text Navigation/Selection
    map({ "n", "x", "o" }, "s", function() require("flash").jump() end,
        { desc = "Flash - Jump", noremap = true, silent = true })
    map({ "n", "x", "o" }, "S", function() require("flash").treesitter() end,
        { desc = "Flash - Treesitter", noremap = true, silent = true })
    map("o", "r", function() require("flash").remote() end,
        { desc = "Flash - Remote", noremap = true, silent = true })
    map({ "x", "o" }, "R", function() require("flash").treesitter_search() end,
        { desc = "Flash - Treesitter Search", noremap = true, silent = true })

    -- Text Interactions
    map('v', '<leader>ss', ":'<,'>!sort<CR>",
        { desc = "Sort - Alphabetically", noremap = true, silent = true })
    map('v', '<leader>Ss', ":'<,'>!sort -r<CR>",
        { desc = "Sort - Alphabetically (Reverse)", noremap = true, silent = true })
    map('v', '<leader>sn', ":'<,'>!sort -n<CR>",
        { desc = "Sort - Numerically", noremap = true, silent = true })
    map('v', '<leader>Sn', ":'<,'>!sort -nr<CR>",
        { desc = "Sort - Numerically (Reverse)", noremap = true, silent = true })

    -- Command line
    map("n", "<leader>qc", function() Snacks.picker.commands() end,
        { desc = "Command Line - Search", noremap = true, silent = true })
    map("n", "<leader>qh", function() Snacks.picker.command_history() end,
        { desc = "Command Line - Search History", noremap = true, silent = true })


    -- Zen
    map("n", "<leader>z", function() Snacks.zen() end,
        { desc = "Zen - Toggle", noremap = true, silent = true })

    -- Terminal
    map("n", "<leader>tt", function() Snacks.terminal.toggle() end,
        { desc = "Terminal - Toggle", noremap = true, silent = true })
    --map("t", "<ESC>", "<C-\\><C-n>", { noremap = true, silent = true })
    --map("t", "<ESC>", "<ESC><ESC>", { noremap = true, silent = true })

    -- Git
    map("n", "<leader>gb", function() Snacks.git.blame_line() end,
        { desc = "Git - Blame Line", noremap = true, silent = true })
end

function M.lsp()
    -- vim.lsp
    map("n", "<leader>cf", function() vim.lsp.buf.format() end,
        { desc = "LSP - Format", noremap = true, silent = true })

    -- Snacks
    map("n", "<leader>cg", function() Snacks.picker.lsp_definitions() end,
        { desc = "LSP - Go To Definition", noremap = true, silent = true })
    map("n", "<leader>cG", function() Snacks.picker.lsp_implementations() end,
        { desc = "LSP - Go To Implementation", noremap = true, silent = true })
    map("n", "<leader>ct", function() Snacks.picker.lsp_type_definitions() end,
        { desc = "LSP - Type Definition", noremap = true, silent = true })
    map("n", "<leader>cs", function() Snacks.picker.lsp_symbols() end,
        { desc = "LSP - Symbols", noremap = true, silent = true })
    map("n", "<leader>cws", function() Snacks.picker.lsp_workspace_symbols() end,
        { desc = "LSP - Symbols", noremap = true, silent = true })

    -- Actions-preview
    map("n", "<leader>ca", function() require("actions-preview").code_actions() end,
        { desc = "LSP - Code Actions", noremap = true, silent = true })

    -- Lspsaga
    map("n", "<leader>cr", "<CMD>Lspsaga rename<CR>",
        { desc = "LSP - Rename Under Cursor", noremap = true, silent = true })
    map("n", "<leader>cff", "<CMD>Lspsaga finder<CR>",
        { desc = "LSP - Find References", noremap = true, silent = true })
    map("n", "<leader>ch", "<CMD>Lspsaga hover_doc<CR>",
        { desc = "LSP - Documentation", noremap = true, silent = true })
    map("n", "<leader>co", "<CMD>Lspsaga outline<CR>",
        { desc = "LSP - Outline", noremap = true, silent = true })
    map("n", "<leader>cd", "<CMD>Lspsaga show_line_diagnostics<CR>",
        { desc = "LSP - Show Line Diagnostics", noremap = true, silent = true })
    map("n", "<leader>cD", function() require("lsp_lines").toggle() end,
        { desc = "LSP - Toggle Diagnostics", noremap = true, silent = true })

    -- Neogen
    map("n", "<leader>cn", function() require("neogen").generate() end,
        { desc = "LSP - Generate Documentation", noremap = true, silent = true })
    map("n", "<leader>cN", function() require("neogen").generate({ type = "func" }) end,
        { desc = "LSP - Generate Documentation (Function)", noremap = true, silent = true })
    map("n", "<leader>cC", function() require("neogen").generate({ type = "class" }) end,
        { desc = "LSP - Generate Documentation (Class)", noremap = true, silent = true })

    -- Repl
    map("n", "<leader>cR",
        function()
            if vim.bo.filetype == "cs" then
                Snacks.terminal.toggle("csharprepl")
            elseif vim.bo.filetype == "py" then
                Snacks.terminal.toggle("python3")
            elseif vim.bo.filetype == "lua" then
                Snacks.terminal.toggle("croissant")
            end
        end,
        { desc = "Terminal - REPL", noremap = true, silent = true })
end

function M.blink_autocomplete()
    return {
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'cancel', 'fallback' },
        ['<C-y>'] = { 'select_and_accept' },

        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
        ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

        ['<Tab>'] = { 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

        ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
    }
end

function M.snacks_picker_input()
    return {
        -- to close the picker on ESC instead of going to normal mode,
        -- add the following keymap to your config
        -- ["<Esc>"] = { "close", mode = { "n", "i" } },
        ["/"] = "toggle_focus",
        ["<C-Down>"] = { "history_forward", mode = { "i", "n" } },
        ["<C-Up>"] = { "history_back", mode = { "i", "n" } },
        ["<C-c>"] = { "cancel", mode = "i" },
        ["<C-w>"] = { "<c-s-w>", mode = { "i" }, expr = true, desc = "delete word" },
        ["<CR>"] = { "confirm", mode = { "n", "i" } },
        ["<Down>"] = { "list_down", mode = { "i", "n" } },
        ["<Esc>"] = "cancel",
        ["<S-CR>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
        ["<S-Tab>"] = { "select_and_prev", mode = { "i", "n" } },
        ["<Tab>"] = { "select_and_next", mode = { "i", "n" } },
        ["<Up>"] = { "list_up", mode = { "i", "n" } },
        ["<a-d>"] = { "inspect", mode = { "n", "i" } },
        ["<a-f>"] = { "toggle_follow", mode = { "i", "n" } },
        ["<a-h>"] = { "toggle_hidden", mode = { "i", "n" } },
        ["<a-i>"] = { "toggle_ignored", mode = { "i", "n" } },
        ["<a-m>"] = { "toggle_maximize", mode = { "i", "n" } },
        ["<a-p>"] = { "toggle_preview", mode = { "i", "n" } },
        ["<a-w>"] = { "cycle_win", mode = { "i", "n" } },
        ["<c-a>"] = { "select_all", mode = { "n", "i" } },
        ["<c-b>"] = { "preview_scroll_up", mode = { "i", "n" } },
        ["<c-d>"] = { "list_scroll_down", mode = { "i", "n" } },
        ["<c-f>"] = { "preview_scroll_down", mode = { "i", "n" } },
        ["<c-g>"] = { "toggle_live", mode = { "i", "n" } },
        ["<c-j>"] = { "list_down", mode = { "i", "n" } },
        ["<c-k>"] = { "list_up", mode = { "i", "n" } },
        ["<c-n>"] = { "list_down", mode = { "i", "n" } },
        ["<c-p>"] = { "list_up", mode = { "i", "n" } },
        ["<c-q>"] = { "qflist", mode = { "i", "n" } },
        ["<c-s>"] = { "edit_split", mode = { "i", "n" } },
        ["<c-t>"] = { "tab", mode = { "n", "i" } },
        ["<c-u>"] = { "list_scroll_up", mode = { "i", "n" } },
        ["<c-v>"] = { "edit_vsplit", mode = { "i", "n" } },
        ["<c-r>#"] = { "insert_alt", mode = "i" },
        ["<c-r>%"] = { "insert_filename", mode = "i" },
        ["<c-r><c-a>"] = { "insert_cWORD", mode = "i" },
        ["<c-r><c-f>"] = { "insert_file", mode = "i" },
        ["<c-r><c-l>"] = { "insert_line", mode = "i" },
        ["<c-r><c-p>"] = { "insert_file_full", mode = "i" },
        ["<c-r><c-w>"] = { "insert_cword", mode = "i" },
        ["<c-w>H"] = "layout_left",
        ["<c-w>J"] = "layout_bottom",
        ["<c-w>K"] = "layout_top",
        ["<c-w>L"] = "layout_right",
        ["?"] = "toggle_help_input",
        ["G"] = "list_bottom",
        ["gg"] = "list_top",
        ["j"] = "list_down",
        ["k"] = "list_up",
        ["q"] = "close",
    }
end

function M.snacks_picker_list()
    return {
        ["/"] = "toggle_focus",
        ["<2-LeftMouse>"] = "confirm",
        ["<CR>"] = "confirm",
        ["<Down>"] = "list_down",
        ["<Esc>"] = "cancel",
        ["<S-CR>"] = { { "pick_win", "jump" } },
        ["<S-Tab>"] = { "select_and_prev", mode = { "n", "x" } },
        ["<Tab>"] = { "select_and_next", mode = { "n", "x" } },
        ["<Up>"] = "list_up",
        ["<a-d>"] = "inspect",
        ["<a-f>"] = "toggle_follow",
        ["<a-h>"] = "toggle_hidden",
        ["<a-i>"] = "toggle_ignored",
        ["<a-m>"] = "toggle_maximize",
        ["<a-p>"] = "toggle_preview",
        ["<a-w>"] = "cycle_win",
        ["<c-a>"] = "select_all",
        ["<c-b>"] = "preview_scroll_up",
        ["<c-d>"] = "list_scroll_down",
        ["<c-f>"] = "preview_scroll_down",
        ["<c-j>"] = "list_down",
        ["<c-k>"] = "list_up",
        ["<c-n>"] = "list_down",
        ["<c-p>"] = "list_up",
        ["<c-q>"] = "qflist",
        ["<c-s>"] = "edit_split",
        ["<c-t>"] = "tab",
        ["<c-u>"] = "list_scroll_up",
        ["<c-v>"] = "edit_vsplit",
        ["<c-w>H"] = "layout_left",
        ["<c-w>J"] = "layout_bottom",
        ["<c-w>K"] = "layout_top",
        ["<c-w>L"] = "layout_right",
        ["?"] = "toggle_help_list",
        ["G"] = "list_bottom",
        ["gg"] = "list_top",
        ["i"] = "focus_input",
        ["j"] = "list_down",
        ["k"] = "list_up",
        ["q"] = "close",
        ["zb"] = "list_scroll_bottom",
        ["zt"] = "list_scroll_top",
        ["zz"] = "list_scroll_center",
    }
end

function M.snacks_picker_preview()
    return {
        ["<Esc>"] = "cancel",
        ["q"] = "close",
        ["i"] = "focus_input",
        ["<a-w>"] = "cycle_win",
    }
end

return M
