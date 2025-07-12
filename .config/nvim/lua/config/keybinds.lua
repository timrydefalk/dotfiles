local M = {}

local map = vim.keymap.set

local action_allowed_for_filetype = function()
    return vim.bo.filetype == "sagaoutline"
        or vim.bo.filetype == "sagafinder"
        or vim.bo.filetype == "sagarename"
        or vim.bo.filetype == "mason"
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
        { desc = "Buffers - Explorer", noremap = true, silent = true })
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

    -- command line
    map("n", "<leader>qc", function() Snacks.picker.commands() end,
        { desc = "Command Line - Search", noremap = true, silent = true })
    map("n", "<leader>qh", function() Snacks.picker.command_history() end,
        { desc = "Command Line - Search History", noremap = true, silent = true })


    -- Zen
    map("n", "<leader>z", function() Snacks.zen() end,
        { desc = "Zen - Toggle", noremap = true, silent = true })

    -- Terminal
    map("n", "<leader>tt", function() Snacks.terminal() end,
        { desc = "Terminal - Toggle", noremap = true, silent = true })
    --map("t", "<ESC>", "<C-\\><C-n>", { noremap = true, silent = true })
    map("t", "<ESC>", "<ESC><ESC>", { noremap = true, silent = true })
end

function M.git()
    -- git
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
    map("n", "<leader>ci", function() Snacks.picker.lsp_implementations() end,
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
end

return M
