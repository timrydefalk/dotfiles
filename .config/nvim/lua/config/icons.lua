local M = {}

M.git = {
    Added     = " ",
    Commit    = "󰜘 ",
    Ignored   = "󰈉 ",
    Modified  = " ",
    Removed   = " ",
    Renamed   = "󰁕 ",
    Staged    = "● ",
    Unmerged  = " ",
    Untracked = " ",
}

M.files = {
    Directory     = "󰉋 ",
    DirectoryOpen = "󰝰 ",
    File          = "󰈔 ",
}

M.diagnostics = {
    Error = " ",
    Hint  = " ",
    Info  = " ",
    Warn  = " ",
}

M.ui = {
    Collapsed  = " ",
    Disabled   = " ",
    Enabled    = " ",
    Expanded   = " ",
    Selected   = "󰄵 ",
    Unselected = "󰄱 ",
}

M.debugger = {
    Stopped = { "", "DiagnosticWarn", "DapStoppedLine" },
    Breakpoint = " ",
    BreakpointCondition = " ",
    BreakpointRejected = { " ", "DiagnosticError" },
    LogPoint = ".>",
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
