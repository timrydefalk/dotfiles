local M = {}

M.git = {
    Added     = " ",
    Modified  = " ",
    Removed   = " ",
    Untracked = " ",
    Commit    = "󰜘 ",
    Staged    = "● ",
    Ignored   = "󰈉 ",
    Renamed   = "󰁕 ",
    Unmerged  = " ",
}

M.files = {
    Directory     = "󰉋 ",
    DirectoryOpen = "󰝰 ",
    File          = "󰈔 ",
}

M.diagnostics = {
    Error = " ",
    Warn  = " ",
    Hint  = " ",
    Info  = " ",
}

M.ui = {
    Selected   = "󰄵 ",
    Unselected = "󰄱 ",
    Collapsed  = " ",
    Expanded   = " ",
    Enabled    = " ",
    Disabled   = " ",
}

M.code = {
    CodeAction = "󰌵",
}

M.kinds = {
    Array         = " ",
    Boolean       = " ",
    Class         = " ",
    Color         = " ",
    Control       = " ",
    Collapsed     = " ",
    Constant      = "󰏿 ",
    Constructor   = " ",
    Copilot       = " ",
    Enum          = " ",
    EnumMember    = " ",
    Event         = " ",
    Field         = " ",
    File          = M.files.File,
    Folder        = M.files.Directory,
    Function      = "󰡱 ",
    Interface     = " ",
    Key           = " ",
    Keyword       = " ",
    Method        = "󰡱 ",
    Macro         = " ",
    Module        = " ",
    Namespace     = "󰦮 ",
    Null          = " ",
    Number        = "󰎠 ",
    Object        = " ",
    Operator      = " ",
    Package       = " ",
    Parameter     = " ",
    Property      = " ",
    Reference     = " ",
    Snippet       = " ",
    StaticMethod  = "󰡱 ",
    String        = " ",
    Struct        = " ",
    Text          = "󰉿 ",
    TypeAlias     = " ",
    TypeParameter = " ",
    Unit          = " ",
    Unknown       = " ",
    Value         = " ",
    Variable      = "󰀫 ",
}

return M
