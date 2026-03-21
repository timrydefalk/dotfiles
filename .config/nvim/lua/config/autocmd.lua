local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local line_toggle = augroup("line_toggle", { clear = true })
local lsp_formatting = augroup("lsp_formatting", {})

autocmd("LspAttach", {
    callback = function(args)
        require("config.keybinds").lsp()

        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        -- autocmd("BufWritePre", {
        --     group = lsp_formatting,
        --     callback = function(args)
        --         if client:supports_method('textDocument/formatting') and vim.bo.filetype ~= "dockerfile" then
        --             for bufnr, _ in pairs(client.attached_buffers) do
        --                 if bufnr == args.buf then
        --                     vim.lsp.buf.format({
        --                         bufnr = bufnr,
        --                         async = false,
        --                     })
        --                     return
        --                 end
        --             end
        --         end
        --     end,
        -- })
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

autocmd(
    "BufEnter",
    {
        callback = function()
            if vim.bo.buftype ~= "" then
                return
            end

            local nvim_config_path = vim.env.HOME .. "/.config/nvim"
            local new_cwd_path = vim.fn.fnamemodify(
                vim.fn.finddir(".git", ".;"),
                ":h"
            ) or vim.env.HOME

            if new_cwd_path == vim.fn.getcwd() then
                return
            end

            if vim.fn.expand("%:p:h"):find("^" .. nvim_config_path) ~= nil then
                new_cwd_path = nvim_config_path
            end

            if new_cwd_path ~= "." then
                print("Changing cwd: ", new_cwd_path)
                vim.api.nvim_set_current_dir(new_cwd_path)
            end

             --vim.treesitter.start()
        end
    }
)
