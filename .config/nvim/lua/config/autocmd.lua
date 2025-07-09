local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local line_toggle = augroup("line_toggle", { clear = true })

autocmd("LspAttach", {
    callback = function()
        require("config.keybinds").lsp()
    end,
})

autocmd(
    "InsertLeave",
    {
        callback = function()
            vim.wo.relativenumber = true
        end,
        group = line_toggle
    }
)
autocmd(
    "InsertEnter",
    {
        callback = function()
            vim.wo.relativenumber = false
        end,
        group = line_toggle
    }
)
-- faster updating through autoread
autocmd(
    { "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" },
    {
        callback = function()
            if vim.fn.mode() ~= "c" and vim.bo.filetype ~= "vim" then
                vim.api.nvim_command("checktime")
            end
        end,
    }
)

autocmd(
    "CursorMoved",
    {
        callback = function()
            if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
                vim.schedule(function() vim.cmd.nohlsearch() end)
            end
        end,
        group = augroup("auto_hlsearch", { clear = true }),
    }
)
