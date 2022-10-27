if not vim.g.vscode then
  local theme_name = "github-theme"
  local status, theme = pcall(require, theme_name)

  if not status then
    vim.notify("colorscheme " .. theme_name .. " not found")
    return
  end

  theme.setup({
    -- theme_style = "light",
    function_style = "italic",
    sidebars = {"qf", "vista_kind", "terminal", "packer"},
    -- Change the "hint" color to the "orange" color, and make the "error" color bright red
    colors = {hint = "orange", error = "#ff0000"},

    -- Overwrite the highlight groups
    overrides = function(c)
      return {
        htmlTag = {fg = c.red, bg = "#282c34", sp = c.hint, style = "underline"},
        DiagnosticHint = {link = "LspDiagnosticsDefaultHint"},
        -- this will remove the highlight groups
        TSField = {},
      }
    end,
  })
end
