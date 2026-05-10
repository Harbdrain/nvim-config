local colorscheme = "vague"

local ok = pcall(vim.cmd.colorscheme, colorscheme)
if not ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!", vim.log.levels.WARN)
  vim.cmd.colorscheme("catppuccin")
end
