local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup(
    "plugins",
    {
        defaults = {
            lazy = false,
        },
        install = {
            missing = true,
            colorscheme = { "tokyonight-moon" },
        },
        ui = {
            border = "single"
        },
        performance = {
            rtp = {
                disabled_plugins = {
                },
            }
        },
        git = {
            url_format = "https://github.com/%s"
        }
    }
)

