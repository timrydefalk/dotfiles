local M = {}
local jit = require("jit")

function M.is_linux()
    return jit.os == "Linux"
end

function M.is_mac()
    return jit.os == "OSX"
end

function M.is_windows()
    return jit.os == "Windows"
end

function M.is_floating_open()
    if vim.api.nvim_win_get_config(0).zindex then
        return true
    end

    return false
end

function M.get_keys_from_table(value)
    local keys = {}

    for key, _ in pairs(value) do
        table.insert(keys, key)
    end

    return keys
end

function M.merge_arrays(...)
    local merged = {}

    for _, array in ipairs({ ... }) do
        if type(array) == "table" then
            for _, item in ipairs(array) do
                if not vim.tbl_contains(merged, item) then
                    table.insert(merged, item)
                end
            end
        end
    end

    return merged
end

return M
